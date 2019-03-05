// 플레이어 게임종료 알리기
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_u8, PACKET.PLAYER_DISCONNECT);
network_send_udp(global.masterSocket, global.masterIp, global.masterPort, buffer, buffer_tell(buffer));

buffer_delete(buffer);