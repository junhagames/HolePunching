// 게임서버 종료 알리기
buffer_seek(buffer, buffer_seek_start, 0)
buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_CLOSE);
network_send_udp(socket, master_ip, master_port, buffer, buffer_tell(buffer));

network_destroy(socket);
buffer_delete(buffer);
ds_list_destroy(playerList);