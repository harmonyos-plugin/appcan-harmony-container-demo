import { AppCan, BDebug } from '@appcan/engine';

type RootUIReadyListener = () => void;

/**
 * AppCan UI 初始化协调器。
 *
 * 只服务 entry 主应用启动编排：允许 Ability 尽早发起 UI 初始化，同时缓存成功状态，
 * 避免 RootSplashPage 后订阅时丢失 ready 信号。
 */
export default class AppCanUIInitCoordinator {
  private static readonly TAG: string = 'AppCanUIInitCoordinator';
  private static readonly INSTANCE: AppCanUIInitCoordinator = new AppCanUIInitCoordinator();

  private rootUIInitRunning: boolean = false;
  private rootUIReady: boolean = false;
  private rootUIInitFailed: boolean = false;
  private rootUIInitErrorMessage: string = '';
  private rootUIReadyListeners: RootUIReadyListener[] = [];

  private constructor() {
  }

  public static getInstance(): AppCanUIInitCoordinator {
    return AppCanUIInitCoordinator.INSTANCE;
  }

  /**
   * 监听主应用 UI 初始化成功事件。
   *
   * 如果初始化已经成功，则异步补发 ready 信号；如果初始化失败，则保持 Splash 等待并依赖错误日志定位。
   */
  public onRootUIReady(listener: RootUIReadyListener): void {
    if (this.rootUIReady) {
      setTimeout(() => {
        listener();
      }, 0);
      return;
    }
    if (this.rootUIInitFailed) {
      BDebug.error(AppCanUIInitCoordinator.TAG, 'onRootUIReady', 'root UI init failed: ' + this.rootUIInitErrorMessage);
      return;
    }

    this.rootUIReadyListeners.push(listener);
  }

  /**
   * 发起主应用 UI 初始化。
   *
   * 这里承接原来 RootSplashPage 中依赖 UIContext 的 AppCan 初始化逻辑，并通过状态位避免重复启动。
   */
  public startRootUIInit(uiContext: UIContext): void {
    if (this.rootUIReady) {
      BDebug.info(AppCanUIInitCoordinator.TAG, 'startRootUIInit', 'root UI init already ready');
      this.notifyRootUIReady();
      return;
    }
    if (this.rootUIInitFailed) {
      BDebug.error(AppCanUIInitCoordinator.TAG, 'startRootUIInit', 'root UI init failed: ' + this.rootUIInitErrorMessage);
      return;
    }
    if (this.rootUIInitRunning) {
      BDebug.info(AppCanUIInitCoordinator.TAG, 'startRootUIInit', 'root UI init is running');
      return;
    }

    this.rootUIInitRunning = true;
    AppCan.getInstance().initUI(uiContext)
      .then(() => {
        this.rootUIInitRunning = false;
        this.rootUIReady = true;
        BDebug.info(AppCanUIInitCoordinator.TAG, 'startRootUIInit', 'root UI init success');
        this.notifyRootUIReady();
      })
      .catch((error: Error) => {
        this.rootUIInitRunning = false;
        this.rootUIInitFailed = true;
        this.rootUIInitErrorMessage = error.message;
        this.rootUIReadyListeners = [];
        BDebug.errorStackPrint(AppCanUIInitCoordinator.TAG, 'startRootUIInit failed', error);
      });
  }

  /**
   * 通知并清空 UI ready 监听器，避免同一批监听器被重复回调。
   */
  private notifyRootUIReady(): void {
    const listeners = this.rootUIReadyListeners.concat();
    this.rootUIReadyListeners = [];
    listeners.forEach((listener: RootUIReadyListener) => {
      listener();
    });
  }
}
