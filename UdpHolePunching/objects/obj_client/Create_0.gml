global.serverIp = get_string("게임서버 IP", "127.0.0.1");
global.serverPort = get_integer("게임서버 PORT", 8888);
playerList = ds_list_create();
isServerConnected = false;

net_connectServer();

alarm[0] = global.timeout;