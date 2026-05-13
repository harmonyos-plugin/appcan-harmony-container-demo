# AppCan容器工程示例代码

1. 本工程是AppCan跨平台开发框架的鸿蒙OS版本，是AppCan框架的基础工程。
2. 开发者可以使用此工程进行进一步扩展，配置AppCan引擎和插件，增加widget代码，实现自己的应用。
3. 开发者也可以使用此工程进行AppCan框架的测试，以及自定义AppCan插件的开发调试。

## uexDemo实例插件

从Git初始化clone（注意要在工程根目录运行下面命令，目的是将uexDemo插件clone到工程的`plugins`目录内）：
```
git clone https://github.com/harmonyos-plugin/appcan-plugin-demo-harmonyos ./plugins/uexDemo
```

详细说明请参考uexDemo插件仓库内的README.md

[uexDemo插件](https://github.com/harmonyos-plugin/appcan-plugin-demo-harmonyos)

## 工程结构

- `AppScope/`：应用级配置目录。
  - `AppScope/app.json5`：应用包名、版本、图标、名称等应用级元数据。
  - `AppScope/resources/base/`：应用级字符串、图标等资源。
- `entry/`：宿主容器主模块，负责应用启动、AppCan初始化、页面入口和widget资源装载。
  - 除插件注入相关配置外，本模块的大部分启动代码都与AppCan引擎初始化流程强关联；如果不了解初始化链路，不建议随意改动。
  - `entry/src/main/module.json5`：entry模块的Ability声明、首页入口、权限和AppCan元数据注册。
  - `entry/src/main/ets/`：主启动链路和初始化逻辑。
    - `EBrowserAbilityStage.ets`：HAP首次加载时初始化AppCan核心能力。
    - `EBrowserAbility.ets`：根据启动参数区分主应用和子widget启动流程。
    - `AppCanUIInitCoordinator.ets`：协调主应用UI初始化时机，避免启动页和UI初始化顺序错位。
    - `RootSplashPage.ets` / `SubSplashPage.ets`：主应用与子widget各自的启动页。
    - `AppCanConfigProviderImpl.ets`：提供AppCan应用配置。
    - `AppCanExPluginProvider.ets`：注册外部插件配置和插件实例。
    - 其中 `AppCanExPluginProvider.ets` 是插件接入的主要扩展点；除此之外，其余初始化相关 `.ets` 文件通常都与引擎启动时序直接相关，除非已经了解整体机制，否则不建议改动。
  - `entry/src/main/resources/base/profile/`：AppCan相关配置入口。
    - `appcan_config.json`：AppCan应用级配置。
    - `appcan_pages.json`：页面与路由配置。
    - `appcan_extend_plugins.json`：兼容性占位配置；新插件机制下通常不再手工维护方法清单，插件应通过各自的`plugin.config.ts`和`AppCanExPluginProvider.ets`完成注册。
    - 除扩展插件注入相关配置外，此目录下的其余配置也会参与引擎初始化和页面装载流程，修改前建议先确认影响范围。
  - `entry/src/main/resources/resfile/widget/`：默认widget资源、测试页面和前端静态资源。
    - `config.xml`：widget基础配置。
    - `index.html`：默认首页入口。
    - `js/`、`css/`、`assets/`：前端运行资源。
    - `uexDemo/`：示例插件对应的测试页面资源。
- `plugins/`：扩展插件模块目录。
  - 当前demo默认包含`plugins/uexDemo/`示例插件。
  - `plugins/uexDemo/Index.ets`：插件导出入口。
  - `plugins/uexDemo/uexDemo/plugin.config.ts`：插件对外方法声明。
  - `plugins/uexDemo/docs/`：插件开发和机制迁移文档。
- 根目录构建文件：
  - `build-profile.json5`：工程级构建配置。
  - `hvigorfile.ts`：Hvigor构建入口。
  - `oh-package.json5`：工程级依赖配置。
  - `oh-package-lock.json5`：工程级依赖锁文件。
- 自动生成目录：
  - `oh_modules/`：依赖安装产物。
  - `.hvigor/`：构建缓存和中间产物。

## 调试证书配置

1. 根目录的`signatures`目录用于存放个人调试证书。此目录已被git忽略，不会也不应提交到版本控制中。
2. 开发者可以将自己的调试证书（如`.p12`, `.cer`, `.p7b`等）放置于此，然后在`build-profile.json5`中进行相应配置。这样做可以保证更换开发机器时，证书配置保持一致，方便调试。
3. 当然，开发者也可以在调试时直接采用DevEco自动签名的方式，这里就可以忽略了。

## 官网文档中心链接

https://newdocx.appcan.cn/
