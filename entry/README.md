## entry模块

可运行模块，包含入口，以及可供自定义的配置文件、合并后的插件配置和可修改代码等

## 配置文件说明

### appcan_config.json 配置详解

位置：`entry/src/main/resources/base/profile/appcan_config.json`

该配置文件是AppCan框架的核心配置文件，对应Android版本中的strings.xml配置。包含了应用级别的各种打包配置开关和服务地址配置。

#### 配置结构

```json
{
  "engineConfig": {
    "isWidgetInRawFile": false
  },
  "appStatus": {
    "isSupportWidgetPatch": false,
    "isForceInTouch": false
  },
  "appkey": "9c1c2e3-5c78-b194-b3f9-15e77f8564192",
  "tenantId": "C62A2974",
  "widgetStartupReportHost": "https://abc.com.cn:80443/v4/",
  "analyticsHost": "https://abc.com.cn:80443/analyIn/4.0/service/",
  "appstoreHost": "https://abc.com.cn:80443/v4/",
  "bindUserHost": "https://abc.com.cn:80443/gateway/"
}
```

#### 配置项详细说明

##### 1. engineConfig - 引擎配置
- **isWidgetInRawFile**: `boolean`
  - 配置widget是否存放在rawfile内，默认为false
  - 只为了保留rawfile逻辑，默认应在resfile中
  - 建议保持默认值false

##### 2. appStatus - 应用状态配置
- **isSupportWidgetPatch**: `boolean`
  - 增量更新开关
  - true: 支持widget增量更新
  - false: 不支持增量更新

- **isForceInTouch**: `boolean`
  - 强制交互模式开关，主要用于uexEMM插件
  - true: 网络/未知错误时显示错误对话框，提供重试和退出选项
  - false: 抑制错误对话框显示，适用于非关键错误场景

##### 3. 应用标识配置
- **appkey**: `string`
  - 打包配置的主应用appkey
  - 用于应用身份识别和认证
  - 需要与AppCan平台注册的应用key保持一致

- **tenantId**: `string`
  - 租户标识ID
  - 用于多租户环境下的租户识别
  - 主要用于uexEMM插件的企业移动管理功能

##### 4. 服务地址配置
这些配置主要用于uexEMM插件和相关服务的网络通信：

- **widgetStartupReportHost**: `string`
  - Widget启动上报服务地址
  - 用于应用启动时向EMM平台上报启动信息
  - 格式：`https://域名:端口/路径/`

- **analyticsHost**: `string`
  - 分析服务地址
  - 用于数据分析和统计上报
  - 格式：`https://域名:端口/analyIn/版本/service/`

- **appstoreHost**: `string`
  - 应用商店服务地址
  - 用于应用更新、下载等功能
  - 格式：`https://域名:端口/版本/`

- **bindUserHost**: `string`
  - 用户绑定服务地址
  - 用于用户认证和绑定相关功能
  - 格式：`https://域名:端口/gateway/`

#### 配置使用方式

该配置文件通过`AppCanConfigProviderImpl`类加载，在AppCan引擎初始化时读取：

1. 配置文件在应用启动时通过`bundleManager.getProfileByAbilitySync()`方法读取
2. 配置数据会传递给AppCan引擎和相关插件使用
3. uexEMM插件会使用其中的tenantId和各种Host配置进行网络通信

#### 修改配置注意事项

1. **服务地址配置**：修改各种Host地址时，确保目标服务可访问且协议正确
2. **租户配置**：tenantId需要与EMM平台的租户配置保持一致
3. **开关配置**：修改appStatus中的开关时，需要了解对应功能的影响
4. **格式要求**：保持JSON格式正确，避免语法错误导致配置加载失败

#### 与Android版本的对应关系

该配置文件对应Android版本中strings.xml的以下配置项：
- appstatus相关配置
- EMM相关的URL配置
- 应用标识相关配置

通过统一的JSON配置文件，简化了鸿蒙版本的配置管理，同时保持了与Android版本的功能兼容性。
