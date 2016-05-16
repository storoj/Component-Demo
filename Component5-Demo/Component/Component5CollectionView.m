//
//  Component5CollectionView.m
//  Component5-Demo
//
//  Created by Alexey Storozhev on 19/04/16.
//  Copyright © 2016 Aleksey Storozhev. All rights reserved.
//

#import "Component5CollectionView.h"
#import "ComponentUtils.h"
#import "NSArray+Functional.h"
#import "UIView+ComponentController.h"

@interface LayoutBlock : NSObject

@end

@implementation LayoutBlock

@end

@interface LayoutItem : NSObject
@property (nonatomic, strong) Node *node;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) NSInteger zIndex;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSString *reuseIdentifier;
@end

@implementation LayoutItem
@end

static NSInteger BlockIdxForY(NSInteger Y, NSInteger blockHeight)
{
    NSInteger blockIdx = Y / blockHeight;
    if (blockIdx<0) {
        blockIdx--;
    }
    return blockIdx;
}

static NSDictionary *LayoutBlocksForNode(Node *node, NSInteger blockHeight)
{
    NSMutableDictionary *blocks = [NSMutableDictionary dictionary];
    NSMutableSet *(^blockWithIndex)(NSInteger) = ^NSMutableSet *(NSInteger idx) {
        NSMutableSet *set = blocks[@(idx)];
        if (!set) {
            set = [NSMutableSet set];
            blocks[@(idx)] = set;
        }
        return set;
    };
    
    NSMutableSet *(^blockForY)(NSInteger) = ^NSMutableSet *(NSInteger Y) {
        return blockWithIndex(BlockIdxForY(Y, blockHeight));
    };
    
    
    NodeSimplifyVisitorBlock(node, CGPointZero, ^(Node *node, CGPoint origin) {
        LayoutItem *item = [LayoutItem new];
        item.node = node;
        item.origin = origin;
        item.zIndex = 0;
        item.reuseIdentifier = NSStringFromClass([node.component class]);
        
        const NSInteger intY = ceilf(origin.y);
        
        [blockForY(intY) addObject:item];
    });

    return blocks;
}

static NSIndexSet *VisibleBlocks(CGRect bounds, NSInteger blockHeight)
{
    const NSInteger minY = ceilf(CGRectGetMinY(bounds));
    const NSInteger maxY = ceilf(CGRectGetMaxY(bounds));
    
    const NSInteger minIdx = BlockIdxForY(minY, blockHeight);
    const NSInteger maxIdx = BlockIdxForY(maxY, blockHeight);
    
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(minIdx, maxIdx-minIdx)];
}

const NSInteger kBlockHeight = 200;


@interface Component5CollectionView()
@property (nonatomic, strong) NSIndexSet *visibleBlockIndexes;
@property (nonatomic, strong) NSDictionary <NSNumber *, NSSet <LayoutItem *> *> *blocks;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableArray <UIView *> *> *pools;
@end

@implementation Component5CollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        _pools = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)updateNode {
    ComponentContext *ctx = [ComponentContext new];
    ctx.size = ComponentSizeMaxWidth(self.frame.size.width);
    
    _currentNode = [self.component nodeForContext:ctx];
    
    self.blocks = LayoutBlocksForNode(_currentNode, kBlockHeight);
    
    self.contentSize = _currentNode.size;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self updateNode];
}

- (void)enumerateBlockWithIndex:(NSInteger)idx block:(void(^)(LayoutItem *item))block {
    [self.blocks[@(idx)] enumerateObjectsUsingBlock:^(LayoutItem * _Nonnull obj, BOOL * _Nonnull stop) {
        block(obj);
    }];
}

- (NSMutableArray <UIView *> *)poolWithIdentifier:(NSString *)identifier {
    NSMutableArray <UIView *> *pool = _pools[identifier];
    if (!pool) {
        pool = [NSMutableArray array];
        _pools[identifier] = pool;
    }
    return pool;
}

- (UIView *)reusableViewWithIdentifier:(NSString *)identifier {
    return [[self poolWithIdentifier:identifier] lastObject];
}

- (void)detachView:(UIView *)view {
    
}

- (void)reuseView:(UIView *)view withIdentifier:(NSString *)identifier {
    [self detachView:view];
    view.hidden = YES;
    [[self poolWithIdentifier:identifier] addObject:view];
}

- (UIView *)dequeueViewWithIdentifier:(NSString *)identifier {
    NSMutableArray *pool = [self poolWithIdentifier:identifier];
    UIView *view = [pool lastObject];
    if (view) {
        [pool removeLastObject];
    }
    return view;
}

- (void)hideBlockWithIndex:(NSInteger)idx {
    [self enumerateBlockWithIndex:idx block:^(LayoutItem *item) {
        [self reuseView:item.view withIdentifier:item.reuseIdentifier];
        item.view = nil;
    }];
    
    NSLog(@"hidden %@", @(idx));
}

- (void)addBlockWithIndex:(NSInteger)idx {
    [self enumerateBlockWithIndex:idx block:^(LayoutItem *item) {
        UIView *view = [self dequeueViewWithIdentifier:item.reuseIdentifier];
        ComponentController *controller = view._vk_componentController;
        
        Node *node = item.node;
        
        if (!view) {
            Class controllerClass = [[node.component class] controllerClass];
            view = [controllerClass createView];
            controller = [(ComponentController *)[controllerClass alloc] initWithView:view];
            
            [self addSubview:view];
        }
        
        [controller updateWithNode:node];
        view.frame = (CGRect){ .origin = item.origin, .size = node.size };
        view.hidden = NO;
        
        item.view = view;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSIndexSet *updatedVisibleBlockIndexes = VisibleBlocks(self.bounds, kBlockHeight);
    
    {
        NSMutableIndexSet *hiddenSet = [self.visibleBlockIndexes mutableCopy];
        [hiddenSet removeIndexes:updatedVisibleBlockIndexes];
        
        [hiddenSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [self hideBlockWithIndex:idx];
        }];
    }
    
    {
        NSMutableIndexSet *addedSet = [updatedVisibleBlockIndexes mutableCopy];
        [addedSet removeIndexes:self.visibleBlockIndexes ?: [NSIndexSet indexSet]];
        [addedSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [self addBlockWithIndex:idx];
        }];
    }
    
    self.visibleBlockIndexes = updatedVisibleBlockIndexes;
}

@end
