var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u8);

switch (command) {
	case PACKET.GAMESERVER_REGISTER:
		// 마스터서버에 게임서버 정보 추가
		var server_map = ds_map_create();
		server_map[? "hash"] = buffer_read(buff, buffer_string);
		server_map[? "name"] = buffer_read(buff, buffer_string);
		server_map[? "ip"] = ip;
		server_map[? "port"] = port;
		ds_list_add(server_list, server_map);
		
		// 게임서버에 연결완료 알리기
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.CONNECTED);
		network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
		
		servers++;
		break;
        
	case PACKET.CLIENT_REGISTER:
		var server_ip = buffer_read(buff, buffer_string);
		var server_port = buffer_read(buff, buffer_u16);
		var player_hash = buffer_read(buff, buffer_string);
		var player_name = buffer_read(buff, buffer_string);
		var isExists = false;
	
		for (var i = 0; i < ds_list_size(server_list); i++) {
			var server_map = server_list[| i];
			
			if (server_map[? "ip"] == server_ip && server_map[? "port"] == server_port) {
				// 마스터서버에 플레이어 정보 추가
				var player_map  = ds_map_create();
				player_map[? "hash"] = player_hash;
				player_map[? "name"] = player_name;
				player_map[? "ip"] = ip;
				player_map[? "port"] = port;
				player_map[? "server"] = server_map[? "hash"];
				ds_list_add(player_list, player_map);
				
				// 플레이어에게 연결완료 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.CONNECTED);
				network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
				
				// 게임서버에게 플레이어 정보 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_NEWPLAYER);
				buffer_write(buffer, buffer_string, player_hash);
				buffer_write(buffer, buffer_string, player_name);
				buffer_write(buffer, buffer_string, ip);
				buffer_write(buffer, buffer_u16, port);			
				network_send_udp(socket, server_ip, server_port, buffer, buffer_tell(buffer));
				
				players++;
				isExists = true;
				break;
			}
		}

		if (!isExists) {
			// 존재하지 않는 게임서버
			buffer_seek(buffer, buffer_seek_start, 0);
			buffer_write(buffer, buffer_u8, PACKET.CLIENT_CONNECTFAIL);
			network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
		}
        break;
        
	case PACKET.GAMESERVER_CLOSE:
		var server_hash, index;
		
		for (var i = 0; i < ds_list_size(server_list); i++) {
			var server_map = server_list[| i];
			
			if (server_map[? "ip"] == ip && server_map[? "port"] == port) {
				// 게임서버 해시, 인덱스 찾기
				server_hash = server_map[? "hash"]; 
				index = i;
				break;
			}
		}
		
		for (var i = 0; i < ds_list_size(player_list); i++) {
			var player_map = player_list[| i];
			
			if (player_map[? "server"] == server_hash) {
				// 게임서버에 접속된 모든 플레이어에게 게임서버 종료 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_CLOSE);
				network_send_udp(socket, player_map[? "ip"], player_map[? "port"], buffer, buffer_tell(buffer));
			}
		}
			
		// 게임서버 정보 초기화
		ds_list_delete(server_list, index);
		
		servers--;
		break;
        
	case PACKET.CLIENT_DISCONNECT:
		var player_hash, index;
		
		for (var i = 0; i < ds_list_size(player_list); i++) {
			var player_map = player_list[| i];
			
			if (player_map[? "ip"] == ip && player_map[? "port"] == port) {
				// 클라리언트가 접속한 게임서버 해시, 인덱스 찾기
				player_hash = player_map[? "server"]; 
				index = i;
				break;
			}
		}
		
		for (var i = 0; i < ds_list_size(server_list); i++) {
			var server_map = server_list[| i];
			
			if (server_map[? "hash"] == player_hash) {
				// 게임서버에게 플레이어 연결종료 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.CLIENT_DISCONNECT);
				buffer_write(buffer, buffer_string, ip);
				buffer_write(buffer, buffer_u16, port);
				network_send_udp(socket, server_map[? "ip"], server_map[? "port"], buffer, buffer_tell(buffer));
				break;
			}
		}
		
		// 플레이어 정보 초기화
		ds_list_delete(player_list, index);
		
		players--;
		break;
}
