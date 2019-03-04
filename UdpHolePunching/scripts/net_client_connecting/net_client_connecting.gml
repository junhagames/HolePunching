/// @description 마스터서버를 거처 게임서버에게 플레이어 정보 알리기
/// @param timeout

var timeout = argument0;

if (!isConnecting) {
	global.server_ip = get_string("[클라이언트] 접속할 게임서버 IP", "127.0.0.1");
	global.server_port = get_integer("[클라이언트] 접속할 게임서버 PORT", 2620);

	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, PACKET.CLIENT_REGISTER);
	buffer_write(buffer, buffer_string, global.server_ip);
	buffer_write(buffer, buffer_u16, global.server_port);
	buffer_write(buffer, buffer_string, hash);
	buffer_write(buffer, buffer_string, name);
	network_send_udp(socket, master_ip, master_port, buffer, buffer_tell(buffer));

	// 마스터서버 연결시간 초과
	alarm[0] = timeout;
	
	isConnecting = true;
}