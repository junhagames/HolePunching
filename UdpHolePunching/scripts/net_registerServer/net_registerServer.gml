/// @description 마스터서버에 게임서버 등록

buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_string, COMMAND.SERVER_REGISTER_MASTER);
buffer_write(global.buffer, buffer_string, global.serverTitle);
buffer_write(global.buffer, buffer_string, global.serverDescription);
buffer_write(global.buffer, buffer_u8, global.serverMaxPlayer);
network_send_udp(global.socket, global.masterIp, global.masterPort, global.buffer, buffer_tell(global.buffer));
