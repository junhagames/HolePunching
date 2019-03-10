/// @description 게임서버에게 연결하기

buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u16, COMMAND.PLAYER_CONNECTING_SERVER);
network_send_udp(global.socket, global.serverIp, global.serverPort, global.buffer, buffer_tell(global.buffer));