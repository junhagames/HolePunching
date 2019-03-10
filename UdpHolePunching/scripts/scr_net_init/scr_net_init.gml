#macro NULL 0

enum COMMAND {
	PLAYER_CONNECTING_MASTER,	
	PLAYER_CONNECTED_MASTER,
	
	PLAYER_FINDING_SERVER,
	PLAYER_FINDED_SERVER,
	PLAYER_FINDFAIL_SERVER,
	PLAYER_CONNECTING_SERVER,
	
	SERVER_CONNECTING_MASTER,
	SERVER_CONNECTED_MASTER,
	SERVER_CONNECTING_PLAYER,
	SERVER_CLOSE,
	
	DISCONNECT,
	MASTER_CLOSE,
}

global.socket = network_create_socket_ext(network_socket_udp, get_integer("연결할 플레이어 소켓 포트", 7777));
global.buffer = buffer_create(256, buffer_grow, 1);
global.timeout = room_speed * 4;

// 플레이어, 마스터서버 선택
var select = get_integer(string_hash_to_newline("플레이어:	{ANY}#마스터서버:	{1}"), 0);

if (select != 1) {
	global.masterIp = get_string("접속할 마스터서버 IP", "127.0.0.1");
	global.masterPort = get_integer("접속할 마스터서버 PORT", 7777);

	global.hash = scr_net_createHash(4);
	global.playerName = get_string("플레이어 닉네임", "김이박");

	global.isMasterConnected = false;
	global.isHost = false;
	
	// 클라이언트 전용
	global.serverIp = NULL;
	global.serverPort = NULL;
	
	// 게임서버 전용
	global.serverTitle = NULL;
	global.serverDescription = NULL;
	global.serverMaxPlayer = NULL;
	
	instance_create_depth(0, 0, 0, obj_net_loby);
}
else {
	with (obj_net_server_connectingMaster) {
		instance_destroy();
	}
	
	with (obj_net_player_connectingServer) {
		instance_destroy();
	}
	
	instance_create_depth(0, 0, 0, obj_net_master);
	instance_destroy();
}