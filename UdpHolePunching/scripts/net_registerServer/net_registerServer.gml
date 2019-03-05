/// @description 마스터서버에 게임서버 등록
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_REGISTER);
network_send_udp(global.masterSocket, global.masterIp, global.masterPort, buffer, buffer_tell(buffer));