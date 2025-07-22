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