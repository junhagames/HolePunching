var serverIp = "127.0.0.1";
var serverPort = 8888;

if (global.serverIp != NULL) {
	serverIp = global.serverIp;
}

if (global.serverPort != NULL) {
	serverPort = global.serverPort;
}

global.serverIp = get_string("게임서버 IP", serverIp);
global.serverPort = get_integer("게임서버 PORT", serverPort);
isServerConnected = false;

net_connectServer();

alarm[0] = global.timeout;