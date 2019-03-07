// 플레이어 게임종료 알리기
buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u8, COMMAND.DISCONNECT);
network_send_udp(global.socket, global.masterIp, global.masterPort, global.buffer, buffer_tell(global.buffer));

network_destroy(global.socket);
buffer_delete(global.buffer);