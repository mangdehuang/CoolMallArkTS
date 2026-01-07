import { BaseViewModel } from "base";
import { OrderRepository } from "data";
import { Footprint, OrderCount } from "model";
import { RequestHelper } from "result";
import { getUserState, UserState } from "state";
import {
  CommonRoutes,
  CsRoutes,
  FeedbackRoutes,
  GoodsRoutes,
  MarketRoutes,
  OrderRoutes,
  UserRoutes,
  navigateTo
} from "navigation";
import { MeMenuItem } from "../model/MeMenuItem";

/**
 * @file 我的页面 ViewModel
 * @author Joker.X
 */
@ObservedV2
export default class MeViewModel extends BaseViewModel {
  /**
   * 全局用户状态
   */
  private readonly userState: UserState = getUserState();
  /**
   * 订单仓库
   */
  private readonly orderRepository: OrderRepository = new OrderRepository();
  /**
   * 订单统计
   */
  @Trace
  orderCount: OrderCount = new OrderCount();
  /**
   * 最近足迹列表
   */
  @Trace
  recentFootprints: Footprint[] = [];
  /**
   * 功能菜单列表
   */
  readonly primaryMenus: MeMenuItem[] = [
    {
      title: $r("app.string.coupons"),
      icon: $r("app.media.ic_coupon_fill"),
      iconColor: $r("app.color.main_coupon_icon"),
      onClick: (): void => this.toCouponPage(),
      showDivider: true
    },
    {
      title: $r("app.string.shipping_address"),
      icon: $r("app.media.ic_location_fill"),
      iconColor: $r("app.color.main_address_icon"),
      onClick: (): void => this.toAddressListPage(),
      showDivider: true
    },
    {
      title: $r("app.string.online_customer_service"),
      icon: $r("app.media.ic_service_fill"),
      iconColor: $r("app.color.main_service_icon"),
      onClick: (): void => this.toChatPage(),
      showDivider: true
    },
    {
      title: $r("app.string.feedback"),
      icon: $r("app.media.ic_creative_fill"),
      iconColor: $r("app.color.main_feedback_icon"),
      onClick: (): void => this.toFeedbackPage(),
      showDivider: true
    },
    {
      title: $r("app.string.about_us"),
      icon: $r("app.media.ic_tip_fill"),
      iconColor: $r("app.color.main_about_icon"),
      onClick: (): void => this.toAboutPage(),
      showDivider: false
    }
  ];
  /**
   * 设置菜单列表
   */
  readonly secondaryMenus: MeMenuItem[] = [
    {
      title: $r("app.string.settings"),
      icon: $r("app.media.ic_set_fill"),
      iconColor: $r("app.color.main_settings_icon"),
      onClick: (): void => this.toSettingsPage(),
      showDivider: false
    }
  ];

  /**
   * 页面出现前
   * @returns {void} 无返回值
   */
  aboutToAppear(): void {
    this.userState.refreshUserInfo();
  }

  /**
   * 用户订单统计
   * @returns {void} 无返回值
   */
  getUserOrderStatistics(): void {
    if (!this.userState.isLoggedIn()) {
      return;
    }
    RequestHelper.repository<OrderCount>(this.orderRepository.getUserOrderCount())
      .toast(false)
      .execute()
      .then((data: OrderCount): void => {
        this.orderCount = OrderCount.fromResponse(data);
      });
  }

  /**
   * 用户资料点击
   * @returns {void} 无返回值
   */
  onHeadClick(): void {
    this.toProfilePage();
  }

  /**
   * 跳转到订单列表
   * @param {number} tabIndex - 订单标签索引
   * @returns {void} 无返回值
   */
  toOrderListPage(tabIndex?: number): void {
    // TODO: 订单列表页支持 tab 参数后再传递
    navigateTo(OrderRoutes.List);
  }

  /**
   * 跳转到商品详情
   * @param {number} goodsId - 商品ID
   * @returns {void} 无返回值
   */
  toGoodsDetailPage(goodsId: number): void {
    // TODO: 商品详情页支持 goodsId 参数后再传递
    navigateTo(GoodsRoutes.Detail);
  }

  /**
   * 跳转到用户足迹
   * @returns {void} 无返回值
   */
  toUserFootprintPage(): void {
    navigateTo(UserRoutes.Footprint);
  }

  /**
   * 跳转到收货地址列表
   * @returns {void} 无返回值
   */
  toAddressListPage(): void {
    navigateTo(UserRoutes.AddressList);
  }

  /**
   * 跳转到我的优惠券
   * @returns {void} 无返回值
   */
  toCouponPage(): void {
    navigateTo(MarketRoutes.Coupon);
  }

  /**
   * 跳转到用户资料页面
   * @returns {void} 无返回值
   */
  toProfilePage(): void {
    navigateTo(UserRoutes.Profile);
  }

  /**
   * 跳转到客服聊天页面
   * @returns {void} 无返回值
   */
  toChatPage(): void {
    navigateTo(CsRoutes.Chat);
  }

  /**
   * 跳转到意见反馈页面
   * @returns {void} 无返回值
   */
  toFeedbackPage(): void {
    navigateTo(FeedbackRoutes.List);
  }

  /**
   * 跳转到关于我们页面
   * @returns {void} 无返回值
   */
  toAboutPage(): void {
    navigateTo(CommonRoutes.About);
  }

  /**
   * 跳转到设置页面
   * @returns {void} 无返回值
   */
  toSettingsPage(): void {
    navigateTo(CommonRoutes.Settings);
  }
}
