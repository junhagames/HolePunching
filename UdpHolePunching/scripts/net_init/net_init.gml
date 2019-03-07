#macro NULL 0

enum TO {
	MASTER,
	SERVER,
}

enum COMMAND {
	LOBY_CONNECTED,
	
	PLAYER_REGISTER,
	PLAYER_CONNECTING_SERVER,
	PLAYER_CONNECTED_SERVER,
	PLAYER_CONNECT_FAIL,
	
	SERVER_REGISTER,
	SERVER_CONNECTED,
	SERVER_NEWPLAYER,
	SERVER_CLOSE,
	
	DISCONNECT,
	MASTER_CLOSE,
}

/**
 * 환경설정
 */
global.socket = network_create_socket_ext(network_socket_udp, get_integer("연결할 플레이어 소켓 포트", 8888));
global.buffer = buffer_create(1, buffer_grow, 1);
global.timeout = room_speed * 4;

global.masterIp = "127.0.0.1";
global.masterPort = 7777;

global.hash = net_createHash(4);
global.playerName = get_string("플레이어 닉네임", "김이박");

global.publicIp = NULL;

global.serverTitle = NULL;
global.serverDescription = NULL;
global.serverMaxPlayer = NULL;

global.serverIp = NULL;
global.serverPort = NULL;