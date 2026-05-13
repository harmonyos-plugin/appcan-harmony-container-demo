import { window } from '@kit.ArkUI';
import { EBrowserBaseAbility, BDebug, WWidgetData, BConstant } from '@appcan/engine'
import { Want } from '@kit.AbilityKit';
import AppCanUIInitCoordinator from './AppCanUIInitCoordinator';

export default class EBrowserAbility extends EBrowserBaseAbility {
  readonly LogTag: string = 'EBrowserAbility';

  /**
   * Ability 窗口创建后加载主/子应用启动页。
   *
   * 主应用 RootSplashPage 加载完成后，主窗口 UIContext 已可获取，此时通过协调器提前触发 AppCan UI 初始化。
   */
  onWindowStageCreate(windowStage: window.WindowStage): void {
    super.onWindowStageCreate(windowStage);
    // Main window is created, set main page for this ability
    BDebug.info(this.LogTag, 'Ability onWindowStageCreate');
    const want: Want = this.lastRequestWant;
    const widgetDataObject = want.parameters?.widgetData;
    const wgtResultInfoObject = want.parameters?.wgtResultInfo;
    // 主应用和子应用的闪屏页和启动逻辑不一样
    if (widgetDataObject) {
      // 携带了widgetData，则认为是启动子widget
      let widgetData: WWidgetData = widgetDataObject as WWidgetData;
      // 保存widgetData和widgetAppId到本地存储
      const storage = new LocalStorage();
      storage.setOrCreate(BConstant.LS_KEY_WIDGET_APPID, widgetData.appId);
      storage.setOrCreate(BConstant.LS_KEY_WIDGET_DATA, widgetData);
      storage.setOrCreate(BConstant.LS_KEY_WIDGET_RESULT_INFO, wgtResultInfoObject);
      windowStage.loadContent("SubSplashPage", storage, (err) => {
        if (err.code) {
          BDebug.error(this.LogTag, 'Failed to load the content. Cause: ' + JSON.stringify(err) ?? '');
          return;
        }
        BDebug.info(this.LogTag, 'Succeeded in loading the content.');
      });
    } else {
      // 没有携带widgetData，则认为是启动主widget
      windowStage.loadContent("RootSplashPage", (err) => {
        if (err.code) {
          BDebug.error(this.LogTag, 'Failed to load the content. Cause: ' + JSON.stringify(err) ?? '');
          return;
        }
        const uiContext = windowStage.getMainWindowSync().getUIContext();
        AppCanUIInitCoordinator.getInstance().startRootUIInit(uiContext);
        BDebug.info(this.LogTag, 'Succeeded in loading the content.');
      });
    }

  }
}
