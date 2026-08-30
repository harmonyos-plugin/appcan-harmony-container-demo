window.uexOnload = function(data){
    console.log('收到页面引擎插件加载完成的回调：uexOnload: ' + data)
}

uexDemo.onFinishFirstInterface = function(data){
    console.log('收到命名回调：uexDemo.onFinishFirstInterface: ' + JSON.stringify(data))
}

function displayResult(result) {
    console.log('displayResult: ' + result);
}

function openMainPage(){
    uexDemo.openMainPage();
}

function testFirstInterface(){
    const result = window.uexDemo.testFirstInterface('abc', 123, {bbb: 'ccc'}, (data, extraInfo) => {
        console.log('收到匿名回调：anonymous function callback finish: ' + JSON.stringify(data) + ', ' + JSON.stringify(extraInfo));
        displayResult('run displayResult: ' + JSON.stringify(data))
    });
    console.log('收到return回调：testFirstInterface: ' + result);
}

function testHandleFileProtocolPath(){
    uexDemo.testHandleFileProtocolPath();
}

// Plugin View 最小测试入口：页面只负责发起添加和移除请求，实际显示效果需结合设备观察。
function addPluginView(viewCount){
    if (!window.uexDemo || typeof window.uexDemo.addPluginView !== 'function') {
        const message = 'uexDemo.addPluginView 不可用';
        console.warn(message);
        displayResult(message);
        return;
    }
    try {
        const result = window.uexDemo.addPluginView(viewCount);
        const message = '添加 Plugin View 请求结果：' + result;
        console.log(message);
        displayResult(message);
    } catch (error) {
        const message = '添加 Plugin View 调用失败：' + error;
        console.error(message);
        displayResult(message);
    }
}

function removePluginView(){
    if (!window.uexDemo || typeof window.uexDemo.removePluginView !== 'function') {
        const message = 'uexDemo.removePluginView 不可用';
        console.warn(message);
        displayResult(message);
        return;
    }
    try {
        const result = window.uexDemo.removePluginView();
        const message = '移除 Plugin View 请求结果：' + result;
        console.log(message);
        displayResult(message);
    } catch (error) {
        const message = '移除 Plugin View 调用失败：' + error;
        console.error(message);
        displayResult(message);
    }
}
