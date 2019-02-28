var ip = argument0;
var port = argument1;
var buff = argument2;
var message_id = buffer_read(buff, buffer_u8);

switch (message_id) {
	case PACKET.GAMESERVER_REG:
        var nick = buffer_read(buff, buffer_string);
		
        for (var i = 0; i < 100; i++) {
			if (ds_map_find_value(server[i], "name") == "") {
				// 마스터서버에 게임서버 등록
				ds_map_replace(server[i], "name", nick);
				ds_map_replace(server[i], "ip", ip);
                ds_map_replace(server[i], "port", port);
			
				// 게임서버에 연결 완료 알리기
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_CONNECTED);
                network_send_udp(listen, ip, port, buffer, buffer_tell(buffer));
				
                servers++;
                break;
			}
		}
		break;
        
	case PACKET.CLIENT_REG:
		var get_ip = buffer_read(buff, buffer_string);
		var get_port = buffer_read(buff, buffer_u16);
		var nick = buffer_read(buff, buffer_string);
		var isFind = false;
		
		for (var i = 0; i < 100; i++) {
			if (ds_map_find_value(server[i], "ip") == get_ip && ds_map_find_value(server[i], "port") == get_port) {
				// 마스터서버에 클라이언트 정보 추가
				ds_map_replace(player[i], "name", nick);
				ds_map_replace(player[i], "ip", ip);
				ds_map_replace(player[i], "port", port);
				
				// 클라이언트에게 연결 완료 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.CLIENT_CONNECTED);
				network_send_udp(listen, ip, port, buffer, buffer_tell(buffer));
				
				// 게임서버에게 클라이언트 닉네임, 아이피, 포트 알리기
				// UDP hole punching 1단계
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_NEWPLAYER);
				buffer_write(buffer, buffer_string, nick);
				buffer_write(buffer, buffer_string, ip);
				buffer_write(buffer, buffer_u16, port);
				network_send_udp(listen, ds_map_find_value(server[i], "ip"), ds_map_find_value(server[i], "port"), buffer, buffer_tell(buffer));
				
				players++;
				isFind = true;
				break;
			}
		}
		if (!isFind) {
			// 존재하지 않는 게임서버
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, PACKET.CLIENT_CONNECTFAIL);
			network_send_udp(listen, ip,port, buffer, buffer_tell(buffer));
		}
        break;
        
	case PACKET.GAMESERVER_CLOSE:
		var nick = buffer_read(buff, buffer_string);
		
	    for (var i = 0; i < 100; i++) {
			if (ds_map_find_value(server[i], "name") == nick) {
				// 게임서버 정보 초기화
				ds_map_replace(server[i], "name", "");
				ds_map_replace(server[i], "ip", "");
				ds_map_replace(server[i], "port", 0);
				
				servers--;
				break;
			}
		}
		break;
        
	case PACKET.CLIENT_DISCONNECT:
		var nick = buffer_read(buff, buffer_string);
		var get_ip = buffer_read(buff, buffer_string);
		var get_port = buffer_read(buff, buffer_u16);
		
		// 게임서버에게 클라이언트 연결 종료 알리기
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.CLIENT_DISCONNECT);
		buffer_write(buffer, buffer_string, nick);
		network_send_udp(listen, get_ip, get_port, buffer, buffer_tell(buffer));
		
		for (i = 0; i < 100; i++) {
			if (ds_map_find_value(player[i], "name") == nick) {
				// 클라이언트 정보 초기화
				ds_map_replace(player[i], "ip", "");
				ds_map_replace(player[i], "name", "");
				ds_map_replace(player[i], "port", 0);
				
				players--;
				break;
			}
		}
		break;
        
	case PACKET.GAMESERVER_PASSID:
		var get_ip = buffer_read(buff, buffer_string);
		var get_port = buffer_read(buff, buffer_u16);
		var get_id = buffer_read(buff, buffer_u8);
		
		// 클라이언트에게 ID 알리기
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.CLIENT_GETID);
		buffer_write(buffer, buffer_u8, get_id);
		network_send_udp(listen, get_ip, get_port, buffer, buffer_tell(buffer));
		break;
}
