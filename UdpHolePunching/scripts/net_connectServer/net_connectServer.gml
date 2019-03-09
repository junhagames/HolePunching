/// @description 마스터서버에서 게임서버 찾기

buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u8, COMMAND.PLAYER_CONNECTING_SERVER);
buffer_write(global.buffer, buffer_string, global.serverIp);
buffer_write(global.buffer, buffer_string, global.serverPort);
network_send_udp(global.socket, global.masterIp, global.masterPort, global.buffer, buffer_tell(global.buffer));