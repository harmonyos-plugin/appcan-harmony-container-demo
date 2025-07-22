import { router } from '@kit.ArkUI';
/**
 * 页面名称在engine模块中声明为EBrowserPage
 */
import { AppCan, BConstant, BDebug, EBrowserPage, WgtResultInfo, WWidgetData } from '@appcan/engine';
import { common } from '@kit.AbilityKit';

import('@appcan/engine/src/main/ets/engine/pages/EBrowserPage');

@Entry
@Component
struct SubSplashPage {
  private readonly LogTag: string = 'SubSplashPage';

  /**
   * 至少显示一定的时间
   */
  private readonly SPLASH_SHOW_DURING_TIME = 1000;

  aboutToAppear() {
    BDebug.info(this.LogTag, 'SubSplashPage aboutToAppear');
    const widgetDataToStart = LocalStorage.getShared()?.prop(BConstant.LS_KEY_WIDGET_DATA)?.get() as WWidgetData;
    const wgtResultInfoFromStarter = LocalStorage.getShared()?.prop(BConstant.LS_KEY_WIDGET_RESULT_INFO)?.get() as WgtResultInfo;
    if (!widgetDataToStart) {
      BDebug.error(this.LogTag, 'SubSplashPage aboutToAppear error: not found widget data');
      return;
    }
    // 注册子widget
    AppCan.getInstance().initLoadingOtherWidget(this.getUIContext(), widgetDataToStart, wgtResultInfoFromStarter);
    setTimeout(() => {
      router.replaceNamedRoute({
        name: EBrowserPage.entryName
      });
    }, this.SPLASH_SHOW_DURING_TIME);
  }

  build() {
    Stack() {
      // TODO 一个子widget打开时的加载动画，icon+widget名称，以及一个转圈的进度条
    }
  }
}