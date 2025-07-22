# AppCan引擎鸿蒙版

本工程是AppCan跨平台开发框架的鸿蒙OS版本实现。

## 工程结构

- `entry`模块：**应用主入口模块**。
  - 这是整个鸿蒙应用的主模块，负责应用的启动、全局配置的加载以及首页的展示。
  - 开发者可以在此模块中进行应用级别的定制，例如修改应用图标、名称、欢迎页等。
  - `entry/src/main/resources/base/profile/` 目录下存放了AppCan框架的核心配置文件，例如：
    - `appcan_config.json`: AppCan应用级别配置。
    - `appcan_internal_plugins.json`: AppCan内置插件配置。
    - `appcan_extend_plugins.json`: AppCan扩展插件配置（通常由开发者自定义）。
    - `appcan_pages.json`: AppCan页面路由配置。
- `engine`模块：**AppCan引擎核心模块**。
  - 包含了WebView封装、JS-Native通信桥、插件管理、窗口管理等核心功能。
  - **此模块的代码是框架的基石，修改时需要格外谨慎。**
- `plugins`目录：**扩展插件模块**。
  - 存放各个功能插件的独立模块，例如`uexDemo`是一个示例插件。
  - 开发者可以参照`AppCan鸿蒙插件开发指南.md`来开发自己的插件。
- `temp_ref_project`目录：**Android版AppCan源码参考工程**。
  - 此目录可以按需自行创建使用，用于存放Android平台的AppCan引擎和插件源码，仅供开发鸿蒙版本时参考对比，但不应该对此目录进行修改和git提交。
- `hvigorfile.ts`, `build-profile.json5`, `oh-package.json5`: 鸿蒙工程的构建和配置文件。

## 代码提交规范

为了保持代码库的整洁和专注，提交代码时请遵循以下原则：

1.  **核心引擎为主**: 主要提交 `engine` 模块的通用功能代码。
2.  **插件代码分离**:
    - `plugins` 目录下的 **通用插件** (`uex`开头的)可以提交。
    - `uexDemo` 作为官方示例，其代码变更可以提交。
    - **开发者个人的测试插件或业务插件不应提交到主仓库。**
3.  **配置文件分离**:
    - `entry`模块中用于测试的配置文件，如 `appcan_extend_plugins.json` 中引入的个人测试插件配置、`config.xml` 中的特定测试页面配置等，**不应提交**。
    - 每个开发者在本地进行插件测试时，应自行修改这些配置文件，并确保在提交代码前将其还原或通过 `git update-index --assume-unchanged <file>` 命令忽略跟踪。
4.  **测试用例分离**: 用于H5页面调试的HTML、JS、CSS等测试用例文件不应提交，除非是作为`uexDemo`示例的一部分。

简而言之，**提交的代码应该是对所有开发者通用的、构成AppCan引擎基础能力的部分。**

## 开发注意事项

- **开发文档**: 在开始开发前，请务必仔细阅读根目录下的 `AppCan鸿蒙开发设计不完全文档.md` 和 `AppCan鸿蒙插件开发指南.md`。
- **编码规范**:
  - 遵循ArkTS语言规范，尽量避免使用 `any` 和 `unknown` 类型。
  - 文件名和类名使用 `PascalCase` 命名法。
  - 使用2个空格进行缩进。
- **注释**: 关键逻辑和复杂函数必须添加中文注释，以提高代码可读性和可维护性。
- **参考实现**: 在实现插件功能时，应参考 `temp_ref_project` 目录中对应的Android实现，以确保接口行为和参数的兼容性。

## 调试证书配置

根目录的`signatures`目录用于存放个人调试证书。此目录已被git忽略，不会也不应提交到版本控制中。开发者可以将自己的调试证书（如`.p12`, `.cer`, `.p7b`等）放置于此，然后在`build-profile.json5`中进行相应配置。这样做可以保证更换开发机器时，证书配置保持一致，方便调试。

## 官网文档中心链接

https://newdocx.appcan.cn/