import { BaseViewModel } from "base";
import { AuthRoutes, navigateTo } from "navigation";

/**
 * @file 账号登录页面 ViewModel
 * @author Joker.X
 */
@ObservedV2
export default class AccountLoginViewModel extends BaseViewModel {
  /**
   * 跳转到注册页面
   * @returns {void} 无返回值
   */
  toRegisterPage(): void {
    navigateTo(AuthRoutes.Register);
  }

  /**
   * 跳转到重置密码页面
   * @returns {void} 无返回值
   */
  toResetPasswordPage(): void {
    navigateTo(AuthRoutes.ResetPassword);
  }
}
