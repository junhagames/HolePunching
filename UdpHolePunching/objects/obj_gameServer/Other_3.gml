// 게임서버 등록 해제
buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_CLOSE);
buffer_write(buffer, buffer_string, name);
network_send_udp(listen, master_ip, master_port, buffer, buffer_tell(buffer));

network_destroy(listen);
buffer_delete(buffer);