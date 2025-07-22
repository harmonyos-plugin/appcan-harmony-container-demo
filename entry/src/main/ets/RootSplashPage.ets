import { router } from '@kit.ArkUI';
/**
 * 页面名称在engine模块中声明为EBrowserPage
 */
import { AppCan, EBrowserPage } from '@appcan/engine';
import AppCanConfigProviderImpl from './AppCanConfigProviderImpl';
import AppCanExPluginProvider from './AppCanExPluginProvider';

import('@appcan/engine/src/main/ets/engine/pages/EBrowserPage');

@Entry
@Component
struct RootSplashPage {
  private readonly LogTag: string = 'RootSplashPage';
  private splashStartTime: number = 0;
  /**
   * 至少显示一定的时间
   */
  private readonly SPLASH_SHOW_DURING_TIME = 1000;

  aboutToAppear() {
    // 获取到AbilityContext实例，可以从中获取windowStage来管理窗口
    const context = this.getUIContext();
    // AppCan初始化
    // 保证至少显示一定的时间
    this.splashStartTime = new Date().getTime();
    AppCan.getInstance().init(context, new AppCanConfigProviderImpl(), new AppCanExPluginProvider())
      .then(() => {
        let timeout = 0;
        let displayTime = new Date().getTime() - this.splashStartTime;
        const timeDuringLeft = this.SPLASH_SHOW_DURING_TIME - displayTime;
        if (timeDuringLeft > 0) {
          timeout = timeDuringLeft;
        }
        setTimeout(() => {
          router.replaceNamedRoute({
            name: EBrowserPage.entryName
          });
        }, timeout);
      });
  }

  build() {
    Stack() {
      // 启动图
      Image($r('app.media.startup_bg_16_9'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .hoverEffect(HoverEffect.None)
    }
  }
}