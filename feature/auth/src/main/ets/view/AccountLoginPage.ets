import { P100, SpaceVerticalMedium, SpaceVerticalSmall, SpaceVerticalXLarge, SpaceVerticalXXLarge } from "designsystem";
import { AppNavDestination, IBestButton } from "ui";
import { AnimatedAuthPage } from "../component/AnimatedAuthPage";
import { BottomNavigationRow } from "../component/BottomNavigationRow";
import { PasswordInputField } from "../component/PasswordInputField";
import { PhoneInputField } from "../component/PhoneInputField";
import { UserAgreement } from "../component/UserAgreement";
import AccountLoginViewModel from "../viewmodel/AccountLoginViewModel";

/**
 * @file 账号登录页面视图
 * @author Joker.X
 */
@ComponentV2
export struct AccountLoginPage {
  /**
   * 账号登录页面 ViewModel
   */
  @Local
  private vm: AccountLoginViewModel = new AccountLoginViewModel();
  /**
   * 账号输入
   */
  @Local
  private account: string = "";
  /**
   * 密码输入
   */
  @Local
  private password: string = "";

  /**
   * 构建账号登录页面
   * @returns {void} 无返回值
   */
  build(): void {
    AppNavDestination({
      pageBackgroundColor: $r("app.color.bg_white"),
      titleOptions: { backgroundColor: $r("app.color.bg_white") },
      viewModel: this.vm
    }) {
      this.AccountLoginContent();
    }
  }

  /**
   * 账号登录页面内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private AccountLoginContent(): void {
    AnimatedAuthPage({ title: $r("app.string.welcome_login") }) {
      PhoneInputField({
        phone: this.account,
        onPhoneChange: (value: string): void => {
          this.account = value;
        }
      });

      SpaceVerticalXXLarge();
      SpaceVerticalSmall();

      PasswordInputField({
        password: this.password,
        onPasswordChange: (value: string): void => {
          this.password = value;
        }
      });

      SpaceVerticalMedium();

      UserAgreement({
        onUserAgreementClick: (): void => {
        },
        onPrivacyPolicyClick: (): void => {
        }
      });

      SpaceVerticalXLarge();

      IBestButton({
        text: $r("app.string.login"),
        type: "primary",
        round: true,
        btnWidth: P100,
        onBtnClick: (): void => {
        }
      });

      BottomNavigationRow({
        messageText: $r("app.string.go_register"),
        actionText: $r("app.string.forgot_password"),
        divider: true,
        onCancelClick: (): void => {
          this.vm.toRegisterPage();
        },
        onActionClick: (): void => {
          this.vm.toResetPasswordPage();
        }
      });
    }
  }
}
