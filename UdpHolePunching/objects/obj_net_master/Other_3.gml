for (var i = 0; i < ds_list_size(playerList); i++) {
	// 모든 플레이어에게 마스터서버 종료 알리기
	var playerMap = playerList[| i];
	buffer_seek(global.buffer, buffer_seek_start, 0);
	buffer_write(global.buffer, buffer_u16, COMMAND.MASTER_CLOSE);
	network_send_udp(global.socket, playerMap[? "ip"], playerMap[? "port"], global.buffer, buffer_tell(global.buffer));
}

network_destroy(global.socket);
buffer_delete(global.buffer);
ds_list_destroy(playerList);
ds_list_destroy(serverList);