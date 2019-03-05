var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u8);

switch (command) {
	case PACKET.PLAYER_REGISTER:
		// 마스터서버에 플레이어 정보 추가
		var playerMap  = ds_map_create();
		playerMap[? "hash"] = buffer_read(buff, buffer_string);
		playerMap[? "nickName"] = buffer_read(buff, buffer_string);
		playerMap[? "privateIp"] = buffer_read(buff, buffer_string);
		playerMap[? "publicIp"] = ip;
		playerMap[? "port"] = port;
		playerMap[? "serverHash"] = "";
		ds_list_add(playerList, playerMap);
		
		// 플레이어에게 연결완료 알리기
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.PLAYER_CONNECTED);
		network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
        break;

	case PACKET.GAMESERVER_REGISTER:
		// 마스터서버에 게임서버 정보 추가
		var server_map = ds_map_create();
		server_map[? "hash"] = buffer_read(buff, buffer_string);
		server_map[? "name"] = buffer_read(buff, buffer_string);
		server_map[? "ip"] = ip;
		server_map[? "port"] = port;
		ds_list_add(serverList, server_map);
		
		// 게임서버에 연결완료 알리기
		buffer_seek(buffer, buffer_seek_start, 0);
		buffer_write(buffer, buffer_u8, PACKET.CONNECTED);
		network_send_udp(socket, ip, port, buffer, buffer_tell(buffer));
		break;
		
	case PACKET.GAMESERVER_CLOSE:
		var server_hash, index;
		
		for (var i = 0; i < ds_list_size(serverList); i++) {
			var server_map = serverList[| i];
			
			if (server_map[? "ip"] == ip && server_map[? "port"] == port) {
				// 게임서버 해시, 인덱스 찾기
				server_hash = server_map[? "hash"]; 
				index = i;
				break;
			}
		}
		
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "server"] == server_hash) {
				// 게임서버에 등록된 모든 플레이어에게 게임서버 종료 알리기
				buffer_seek(buffer, buffer_seek_start, 0);
				buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_CLOSE);
				network_send_udp(socket, playerMap[? "ip"], playerMap[? "port"], buffer, buffer_tell(buffer));
			}
		}
			
		// 게임서버 정보 초기화
		ds_list_delete(serverList, index);
		break;
        
	case PACKET.PLAYER_DISCONNECT:
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "publicIp"] == ip && playerMap[? "port"] == port) {
				// 플레이어 정보 초기화
				ds_list_delete(playerList, i);
				break;
			}
		}
		break;
}
