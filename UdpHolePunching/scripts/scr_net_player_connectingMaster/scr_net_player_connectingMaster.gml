/// @description 마스터서버에 플레이어 등록

buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u16, COMMAND.PLAYER_CONNECTING_MASTER);
buffer_write(global.buffer, buffer_string, global.hash);
buffer_write(global.buffer, buffer_string, global.playerName);
network_send_udp(global.socket, global.masterIp, global.masterPort, global.buffer, buffer_tell(global.buffer));