import { EBrowserAbilityStageBase } from '@appcan/engine';
import { Want } from '@kit.AbilityKit';

export default class EBrowserAbilityStage extends EBrowserAbilityStageBase {

  onCreate(): void {
    // 应用HAP首次加载时触发，可以在此执行该Module的初始化操作（例如资源预加载、线程创建等）。
    super.onCreate();
  }

  /**
   * 承载widget应用的ability使用specified模式，通过该方法控制相同appId的widget可以不重复开启
   * @param want
   * @returns
   */
  onAcceptWant(want: Want): string {
    return super.onAcceptWant(want);
  }
}