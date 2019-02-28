// 마스터서버를 거처 게임서버에게 연결 종료 알리기
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_u8, PACKET.CLIENT_DISCONNECT);
buffer_write(buffer, buffer_string, myname);
buffer_write(buffer, buffer_string, server_ip);
buffer_write(buffer, buffer_u16, server_port);
network_send_udp(socket, master_ip, master_port, buffer, buffer_tell(buffer));

network_destroy(socket);
buffer_delete(buffer);