for (var i = 0; i < ds_list_size(playerList); i++) {
	// 모든 플레이어에게 마스터서버 종료 알리기
	var playerMap = playerList[| i];
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, PACKET.MASTERSERVER_CLOSE);
	network_send_udp(socket, playerMap[? "ip"], playerMap[? "port"], buffer, buffer_tell(buffer));
}

for (var i = 0; i < ds_list_size(serverList); i++) {
	// 모든 게임서버에게 마스터서버 종료 알리기
	var server_map = serverList[| i];
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, PACKET.MASTERSERVER_CLOSE);
	network_send_udp(socket, server_map[? "ip"], server_map[? "port"], buffer, buffer_tell(buffer));
}

network_destroy(socket);
buffer_delete(buffer);
ds_list_destroy(playerList);
ds_list_destroy(serverList);