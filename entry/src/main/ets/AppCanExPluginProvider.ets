import { AppCanPluginProvider, EBrowserView, EngineEventListener, EUExBase } from '@appcan/engine';
import { EUExDemo, pluginConfig as uexDemoConfig } from '@appcan/uexdemo';
import { bundleManager, Context } from '@kit.AbilityKit';

/**
 * 扩展插件实例化加载提供器
 */
export default class AppCanExPluginProvider implements AppCanPluginProvider {
  providerUniqueId(): string {
    return "AppCanExPluginProvider";
  }

  obtainPluginConfigs(context: Context): object[] {
    let plugin_configs: object[] = [];
    try {
      // 加载读取插件配置文件（已非必要，仅供测试和模拟使用）
      const pluginsProfile: Array<string> =
        bundleManager.getProfileByAbilitySync("entry", "EBrowserAbility", "appcan.metadata.extend.plugins");
      plugin_configs = JSON.parse(pluginsProfile[0])["plugins"] as object[];
    } catch (e) {
    }
    // 将插件配置逐一引用并加入到插件配置列表中
    plugin_configs = plugin_configs.concat(uexDemoConfig.plugins);
    return plugin_configs;
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
