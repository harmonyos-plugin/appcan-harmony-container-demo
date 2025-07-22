import { AppCanPluginProvider, EBrowserView, EngineEventListener, EUExBase } from '@appcan/engine';
import { EUExDemo } from '@appcan/uexDemo';
import { bundleManager } from '@kit.AbilityKit';

/**
 * 扩展插件实例化加载提供器
 */
export default class AppCanExPluginProvider implements AppCanPluginProvider {
  providerUniqueId(): string {
    return "AppCanExPluginProvider";
  }

  obtainPluginConfigs(): object[] {
    // 读取插件配置文件
    const pluginsProfile: Array<string> =
      bundleManager.getProfileByAbilitySync("entry", "EBrowserAbility", "appcan.metadata.extend.plugins");
    return JSON.parse(pluginsProfile[0])["plugins"];
  }

  obtainInitializedPlugins(context: Context, brwView: EBrowserView): Map<string, EUExBase> {
    const pluginsClassMap: Map<string, EUExBase> = new Map();
    // TODO 在此声明插件实例化对象
    pluginsClassMap.set("uexDemo", new EUExDemo(context, brwView));
    return pluginsClassMap;
  }

  obtainInitializedEventListeners(): EngineEventListener[] {
    const pluginsEventListenerList: EngineEventListener[] = [];
    // TODO 在此声明插件事件监听对象
    return pluginsEventListenerList;
  }
}

