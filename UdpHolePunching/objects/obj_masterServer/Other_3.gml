for (var i = 0; i < 100; i++) {
	// 모든 게임서버에게 마스터서버 종료 알리기
	if (ds_map_find_value(server[i], "name") != "") {
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.MASTERSERVER_CLOSE);
		network_send_udp(listen, ds_map_find_value(server[i], "ip"), ds_map_find_value(server[i], "port"), buffer, buffer_tell(buffer));
	}
	
	// 모든 클라이언트에게 마스터서버 종료 알리기
    if (ds_map_find_value(player[i], "name") != "") {
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.MASTERSERVER_CLOSE);
		network_send_udp(listen, ds_map_find_value(player[i], "ip"), ds_map_find_value(player[i], "port"), buffer, buffer_tell(buffer));
	}
}

network_destroy(listen);
buffer_delete(buffer);