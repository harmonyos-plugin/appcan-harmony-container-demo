import { AppCan, BDebug, EBrowserAbilityStageBase } from '@appcan/engine';
import { Want } from '@kit.AbilityKit';
import AppCanConfigProviderImpl from './AppCanConfigProviderImpl';
import AppCanExPluginProvider from './AppCanExPluginProvider';

export default class EBrowserAbilityStage extends EBrowserAbilityStageBase {
  private readonly LogTag: string = 'EBrowserAbilityStage';

  /**
   * HAP 首次加载时提前初始化 AppCan 核心能力。
   *
   * 此处只注册配置 provider、插件 provider 和引擎事件监听器，不触发依赖 UIContext 的窗口或 Widget 初始化。
   */
  onCreate(): void {
    // 应用HAP首次加载时触发，可以在此执行该Module的初始化操作（例如资源预加载、线程创建等）。
    super.onCreate();
    AppCan.getInstance().initCore(new AppCanConfigProviderImpl(), new AppCanExPluginProvider());
    AppCan.getInstance().abilityStageCreate(this.context);
    BDebug.info(this.LogTag, 'AppCan core init complete');
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
