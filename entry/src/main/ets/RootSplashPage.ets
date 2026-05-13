import { router } from '@kit.ArkUI';
/**
 * 页面名称在engine模块中声明为EBrowserPage
 */
import { EBrowserPage } from '@appcan/engine';
import AppCanUIInitCoordinator from './AppCanUIInitCoordinator';

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

  /**
   * 启动页出现后只订阅主应用 UI ready 事件。
   *
   * AppCan 初始化已经移到 AbilityStage / Ability 链路中，这里只负责等待成功结果并保持最小展示时间。
   * 如果 UI 初始化失败，协调器只输出错误日志，不触发跳转。
   */
  aboutToAppear() {
    // 保证至少显示一定的时间
    this.splashStartTime = new Date().getTime();
    AppCanUIInitCoordinator.getInstance().onRootUIReady(() => {
      this.routeToEntryAfterMinimumSplash();
    });
  }

  /**
   * 在 AppCan UI ready 后按最小闪屏时长延迟跳转到引擎首页。
   */
  private routeToEntryAfterMinimumSplash(): void {
    let timeout = 0;
    const displayTime = new Date().getTime() - this.splashStartTime;
    const timeDuringLeft = this.SPLASH_SHOW_DURING_TIME - displayTime;
    if (timeDuringLeft > 0) {
      timeout = timeDuringLeft;
    }
    setTimeout(() => {
      router.replaceNamedRoute({
        name: EBrowserPage.entryName
      });
    }, timeout);
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
