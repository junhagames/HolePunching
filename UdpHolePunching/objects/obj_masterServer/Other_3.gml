for (var i = 0; i < ds_list_size(player_list); i++) {
	// 모든 플레이어에게 마스터서버 종료 알리기
	var player_map = player_list[| i];
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, PACKET.MASTERSERVER_CLOSE);
	network_send_udp(socket, player_map[? "ip"], player_map[? "port"], buffer, buffer_tell(buffer));
}

for (var i = 0; i < ds_list_size(server_list); i++) {
	// 모든 게임서버에게 마스터서버 종료 알리기
	var server_map = server_list[| i];
	buffer_seek(buffer, buffer_seek_start, 0);
	buffer_write(buffer, buffer_u8, PACKET.MASTERSERVER_CLOSE);
	network_send_udp(socket, server_map[? "ip"], server_map[? "port"], buffer, buffer_tell(buffer));
}

network_destroy(socket);
buffer_delete(buffer);
ds_list_destroy(player_list);
ds_list_destroy(server_list);