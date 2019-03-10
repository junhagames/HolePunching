if (global.isMasterConnected) {
	global.serverIp = get_string("게임서버 IP", "127.0.0.1");
	global.serverPort = get_integer("게임서버 PORT", 8888);

	scr_net_player_findingServer();

	obj_net_loby.alarm[2] = global.timeout;
}