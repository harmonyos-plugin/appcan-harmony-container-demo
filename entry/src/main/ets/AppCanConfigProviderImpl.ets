import { AppCanConfigProvider } from '@appcan/engine';
import { bundleManager } from '@kit.AbilityKit';

/**
 * AppCan应用参数配置提供器
 */
export default class AppCanConfigProviderImpl implements AppCanConfigProvider {
  providerUniqueId(): string {
    return "AppCanConfigProviderImpl";
  }

  obtainConfig(): object {
    // 读取配置文件
    const pluginsProfile: Array<string> =
      bundleManager.getProfileByAbilitySync("entry", "EBrowserAbility", "appcan.metadata.config");
    return JSON.parse(pluginsProfile[0]);
  }
}

