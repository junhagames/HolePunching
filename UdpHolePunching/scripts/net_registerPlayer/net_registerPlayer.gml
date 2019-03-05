/// @description 마스터서버에 플레이어 등록
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_u8, PACKET.PLAYER_REGISTER);
buffer_write(buffer, buffer_string, global.hash);
buffer_write(buffer, buffer_string, global.nickName);
buffer_write(buffer, buffer_string, global.privateIp);
network_send_udp(global.masterSocket, global.masterIp, global.masterPort, buffer, buffer_tell(buffer));