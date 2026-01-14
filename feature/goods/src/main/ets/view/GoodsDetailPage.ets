import { ColumnStart, P100, SpaceVerticalMedium } from "designsystem";
import { Goods } from "model";
import { navigateBack } from "navigation";
import { getWindowSafeAreaState, WindowSafeAreaState } from "state";
import { AppNavDestination, BaseNetWorkView } from "ui";
import { GoodsBanner } from "../component/GoodsBanner";
import { GoodsDetailBottomBar } from "../component/GoodsDetailBottomBar";
import { GoodsCommentsCard } from "../component/GoodsCommentsCard";
import { GoodsInfoCard } from "../component/GoodsInfoCard";
import { GoodsShippingServiceCard } from "../component/GoodsShippingServiceCard";
import GoodsDetailViewModel from "../viewmodel/GoodsDetailViewModel";
import { GoodsDetailRichHeader } from "../component/GoodsDetailRichHeader";
import { GoodsDetailRichImageItem } from "../component/GoodsDetailRichImageItem";
import { GoodsDetailTopBar } from "../component/GoodsDetailTopBar";

/**
 * @file 商品详情页面视图
 * @author Joker.X
 */
@ComponentV2
export struct GoodsDetailPage {
  /**
   * 商品详情页面 ViewModel
   */
  @Local
  private vm: GoodsDetailViewModel = new GoodsDetailViewModel();
  /**
   * 列表滚动控制器
   */
  private listScroller: Scroller = new Scroller();
  /**
   * 当前窗口安全区状态
   */
  @Param
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建商品详情页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      hideTitleBar: true,
      viewModel: this.vm,
      paddingValue: {
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      BaseNetWorkView({
        uiState: this.vm.uiState,
        onRetry: (): void => this.vm.retryRequest(),
        content: (): void => this.GoodsDetailContent()
      });
    }
  }

  /**
   * 商品详情页面内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private GoodsDetailContent() {
    Stack({ alignContent: Alignment.TopStart }) {
      ColumnStart({ fillMaxSize: true }) {
        this.GoodsDetailList();
        GoodsDetailBottomBar();
      }

      GoodsDetailTopBar({
        topBarAlpha: this.vm.topBarAlpha,
        topInset: this.windowSafeAreaState.topInset,
        onBackClick: (): void => navigateBack()
      });
    }
  }

  /**
   * 商品详情滚动列表
   * @returns {void} 无返回值
   */
  @Builder
  private GoodsDetailList(): void {
    List({ scroller: this.listScroller }) {
      ListItem() {
        GoodsBanner({
          bannerList: this.vm.data?.goodsInfo?.pics ?? [],
          autoPlay: false,
          loop: false,
          imageFit: ImageFit.Cover
        });
      }

      ListItem() {
        SpaceVerticalMedium();
      }

      ListItem() {
        GoodsInfoCard({
          goodsInfo: this.vm.data?.goodsInfo ?? new Goods(),
          coupons: this.vm.data?.coupon ?? []
        });
      }

      ListItem() {
        SpaceVerticalMedium();
      }

      ListItem() {
        GoodsShippingServiceCard();
      }

      ListItem() {
        SpaceVerticalMedium();
      }

      if (this.vm.data?.comment && this.vm.data.comment.length > 0) {
        ListItem() {
          GoodsCommentsCard({ comments: this.vm.data?.comment ?? [] });
        }

        ListItem() {
          SpaceVerticalMedium();
        }
      }

      if (this.vm.data?.goodsInfo?.contentPics && this.vm.data.goodsInfo.contentPics.length > 0) {
        ListItem() {
          GoodsDetailRichHeader();
        }

        ForEach(this.vm.data.goodsInfo.contentPics, (pic: string, index: number): void => {
          ListItem() {
            GoodsDetailRichImageItem({
              pic: pic,
              isLast: index === this.vm.data!.goodsInfo!.contentPics!.length - 1
            });
          }
        }, (pic: string, index: number): string => `${pic}-${index}`);
      }

      ListItem() {
        SpaceVerticalMedium();
      }
    }
    .layoutWeight(1)
    .width(P100)
    .height(P100)
    .onDidScroll((scrollOffset: number): void => {
      this.onScrollChanged(scrollOffset);
    });
  }

  /**
   * 列表滚动距离回调
   * @param {number} scrollOffset - 当前滚动距离
   * @returns {void} 无返回值
   */
  private onScrollChanged(scrollOffset: number): void {
    const offset = this.listScroller.currentOffset();
    if (offset) {
      this.vm.updateTopBarAlpha(scrollOffset, offset.yOffset);
    } else {
      this.vm.updateTopBarAlpha(scrollOffset);
    }
  }
}
