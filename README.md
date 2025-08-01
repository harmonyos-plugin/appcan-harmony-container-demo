# AppCan引擎鸿蒙版

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

- `entry`模块：**应用主入口模块**。
  - 这是整个鸿蒙应用的主模块，负责应用的启动、全局配置的加载以及首页的展示。
  - 开发者可以在此模块中进行应用级别的定制，例如修改应用图标、名称、欢迎页等。
  - `entry/src/main/resources/base/profile/` 目录下存放了AppCan框架的核心配置文件，例如：
    - `appcan_config.json`: AppCan应用级别配置。
    - `appcan_internal_plugins.json`: AppCan内置插件配置。
    - `appcan_extend_plugins.json`: AppCan扩展插件配置（通常由开发者自定义）。
    - `appcan_pages.json`: AppCan页面路由配置。
- `plugins`目录：**扩展插件模块**。
  - 存放各个功能插件的独立模块，例如`uexDemo`是一个示例插件。
  - 开发者可以参照`AppCan鸿蒙插件开发指南.md`来开发自己的插件。
- `hvigorfile.ts`, `build-profile.json5`, `oh-package.json5`: 鸿蒙工程的构建和配置文件。

## 调试证书配置

1. 根目录的`signatures`目录用于存放个人调试证书。此目录已被git忽略，不会也不应提交到版本控制中。
2. 开发者可以将自己的调试证书（如`.p12`, `.cer`, `.p7b`等）放置于此，然后在`build-profile.json5`中进行相应配置。这样做可以保证更换开发机器时，证书配置保持一致，方便调试。
3. 当然，开发者也可以在调试时直接采用DevEco自动签名的方式，这里就可以忽略了。

## 官网文档中心链接

https://newdocx.appcan.cn/