import { ColumnStart, P100, SpaceVerticalXXLarge } from "designsystem";

/**
 * @file 认证页面基础布局组件
 * @author Joker.X
 */
@ComponentV2
export struct AnimatedAuthPage {
  /**
   * 页面标题
   */
  @Param
  title: ResourceStr = "";
  /**
   * 是否启用淡入效果（待实现动画）
   */
  @Param
  withFadeIn: boolean = false;
  /**
   * 内容构建函数
   */
  @BuilderParam
  content: CustomBuilder;

  /**
   * 构建认证页面基础布局
   * @returns {void} 无返回值
   */
  build(): void {
    ColumnStart({
      widthValue: P100,
      fillMaxSize: true,
      paddingValue: {
        top: $r("app.float.space_vertical_large_xx"),
        left: $r("app.float.space_horizontal_large_xx"),
        right: $r("app.float.space_horizontal_large_xx")
      }
    }) {
      Text(this.title)
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor($r("app.color.text_primary"))
        .width(P100)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Clip })
        .textAlign(TextAlign.Start);

      SpaceVerticalXXLarge();
      SpaceVerticalXXLarge();

      if (this.content) {
        this.content();
      }
    }
  }
}
