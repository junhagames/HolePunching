var ip = argument0;
var port = argument1;
var buff = argument2;
var message_id = buffer_read(buff, buffer_u8);

switch (message_id) {
	case PACKET.GAMESERVER_REGISTER:
        var server_hash = buffer_read(buff, buffer_string);
		var server_name = buffer_read(buff, buffer_string);
		net_register(server_list, server_hash, server_name, ip, port);
		
		// 게임서버에 연결 완료 알리기
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.CONNECTED);
		network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
		
		servers++;
		break;
        
	case PACKET.CLIENT_REGISTER:
		var server_ip = buffer_read(buff, buffer_string);
		var server_port = buffer_read(buff, buffer_u16);
		var client_hash = buffer_read(buff, buffer_string);
		var client_name = buffer_read(buff, buffer_string);
		var exists = false;
	
		for (var i = 0; i < ds_list_size(server_list); i++) {
			var map = ds_list_find_value(server_list, i);
			var find_ip = ds_map_find_value(map, "ip");
			var find_port = ds_map_find_value(map, "port");
			
			if (find_ip == server_ip && find_port == server_port) {
				// 마스터서버에 클라이언트 정보 추가
				net_register(player_list, client_hash, client_name, ip, port);
				
				// 클라이언트에게 연결 완료 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.CONNECTED);
				network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
				
				// 게임서버에게 플레이어 정보 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.NEWCLIENT);
				buffer_write(buffer, buffer_string, client_hash);
				buffer_write(buffer, buffer_string, client_name);
				buffer_write(buffer, buffer_string, ip);
				buffer_write(buffer, buffer_u16, port);
				network_send_udp(socket, server_ip, server_port, buffer, buffer_tell(buffer));
				
				players++;
				exists = true;
				break;
			}
		}

		if (!exists) {
			// 존재하지 않는 게임서버
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, PACKET.CLIENT_CONNECTFAIL);
			network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
		}
        break;
        
	case PACKET.GAMESERVER_CLOSE:
		var index;
		for (var i = 0; i < ds_list_size(server_list); i++) {
			var map = ds_list_find_value(server_list, i);
			var find_ip = ds_map_find_value(map, "ip");
			var find_port = ds_map_find_value(map, "port");
			
			// 클라이언트에게 서버 종료 알리기
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_CLOSE);
			network_send_udp(socket, find_ip, find_port, buffer, buffer_tell(buffer));
			
			if (find_ip == ip && find_port == port) {
				index = i;
			}
		}
			
		// 게임서버 정보 초기화
		ds_list_delete(server_list, index);
		/// TODO ds_map 메모리 누수 확인
		
		servers--;
		break;
        
	case PACKET.CLIENT_DISCONNECT:
		var server_ip = buffer_read(buff, buffer_string);
		var server_port = buffer_read(buff, buffer_u16);
		
		// 게임서버에게 클라이언트 연결 종료 알리기
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.CLIENT_DISCONNECT);
		network_send_udp(socket, server_ip, server_port, buffer, buffer_tell(buffer));
		
		for (var i = 0; i < ds_list_size(player_list); i++) {
			var map = ds_list_find_value(player_list, i);
			
			if (map[? "ip"] == ip && map[? "port"]) {
				// 클라이언트 정보 초기화
				ds_list_delete(player_list, i);
				/// TODO ds_map 메모리 누수 확인 
			}
			
			players--;
			break;
		}
		break;
}
