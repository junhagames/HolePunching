#macro NULL 0

enum PACKET {
	GAMESERVER_REGISTER,
	GAMESERVER_NEWPLAYER,
	GAMESERVER_CLOSE,
	
	PLAYER_REGISTER,
	PLAYER_CONNECTED,
	PLAYER_CONNECTFAIL,
	PLAYER_DISCONNECT,
	
	CONNECTED,
	MASTERSERVER_CLOSE
}

global.net = id;

// 환경설정
global.timeout = room_speed * 4;
global.masterIp = "127.0.0.1";
global.masterPort = 7777;

global.socket = network_create_socket_ext(network_socket_udp, get_integer("연결할 플레이어 소켓 포트", 2620));
global.hash = net_createHash(4);
global.nickName = get_string("플레이어 닉네임", "강건마");
global.publicIp = NULL;

// 클라이언트 전용
global.serverIp = NULL;
global.serverPort = noone;