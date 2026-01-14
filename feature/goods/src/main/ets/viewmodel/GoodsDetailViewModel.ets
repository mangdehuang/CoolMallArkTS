import { BaseNetWorkViewModel } from "base";
import { GoodsRepository, PageRepository } from "data";
import { GoodsDetail, NetworkResponse } from "model";
import { getRouteParams, GoodsIdParam } from "navigation";
import { GoodsRoutes } from "navigation/src/main/ets/goods/GoodsRoutes";

/**
 * @file 商品详情页面 ViewModel
 * @author Joker.X
 */
@ObservedV2
export default class GoodsDetailViewModel extends BaseNetWorkViewModel<GoodsDetail> {
  /**
   * 顶部导航栏透明度（0-255）
   */
  @Trace
  topBarAlpha: number = 0;
  /**
   * 累计滚动距离
   */
  private totalScrollOffset: number = 0;
  /**
   * 页面仓库
   */
  private readonly pageRepository: PageRepository = new PageRepository();
  /**
   * 商品仓库
   */
  private readonly goodsRepository: GoodsRepository = new GoodsRepository();
  /**
   * 路由参数
   */
  private readonly routeParam: GoodsIdParam = getRouteParams<GoodsIdParam>(GoodsRoutes.Detail);
  /**
   * 商品 ID
   */
  private readonly goodsId: number = this.routeParam.goodsId ?? 0;

  /**
   * 请求商品详情页面数据
   * @returns {Promise<NetworkResponse<GoodsDetail>>} 商品详情
   */
  protected requestRepository(): Promise<NetworkResponse<GoodsDetail>> {
    return this.pageRepository.getGoodsDetail(this.goodsId);
  }

  /**
   * 更新顶部导航栏透明度
   * @param {number} scrollOffset - 当前滚动增量
   * @param {number | undefined} absoluteOffset - 当前滚动绝对距离
   * @returns {void} 无返回值
   */
  updateTopBarAlpha(scrollOffset: number, absoluteOffset?: number): void {
    if (absoluteOffset !== undefined) {
      this.topBarAlpha = this.clampAlpha(Math.floor(absoluteOffset));
      this.totalScrollOffset = this.topBarAlpha;
      return;
    }

    this.totalScrollOffset += scrollOffset;
    this.topBarAlpha = this.clampAlpha(Math.floor(this.totalScrollOffset));
    this.totalScrollOffset = this.topBarAlpha;
  }

  /**
   * 透明度取值修正
   * @param {number} alpha - 透明度
   * @returns {number} 修正后的透明度
   */
  private clampAlpha(alpha: number): number {
    if (alpha < 0) {
      return 0;
    }
    if (alpha > 255) {
      return 255;
    }
    return alpha;
  }
}
