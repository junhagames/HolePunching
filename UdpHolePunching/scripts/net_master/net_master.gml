var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u8);

switch (command) {
	case COMMAND.PLAYER_REGISTER:
		// 플레이어 정보 추가
		var playerMap  = ds_map_create();
		playerMap[? "hash"] = buffer_read(buff, buffer_string);
		playerMap[? "name"] = buffer_read(buff, buffer_string);
		playerMap[? "ip"] = ip;
		playerMap[? "port"] = port;
		playerMap[? "serverHash"] = NULL;
		ds_list_add(playerList, playerMap);
		
		// 플레이어에게 연결완료 알리기
		buffer_seek(global.buffer, buffer_seek_start, 0);
		buffer_write(global.buffer, buffer_u8, COMMAND.LOBY_CONNECTED);
		buffer_write(global.buffer, buffer_string, ip);
		network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
        break;

	case COMMAND.SERVER_REGISTER:
		var playerHash, playerName;
		
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == ip && playerMap[? "port"] == port) {
				// 플레이어 해시, 이름 찾기
				playerHash = playerMap[? "hash"];
				playerName = playerMap[? "name"]
				break;
			}
		}
		
		// 게임서버 정보 추가
		var serverMap = ds_map_create();
		serverMap[? "hash"] = playerHash;
		serverMap[? "ip"] = ip;
		serverMap[? "port"] = port;
		serverMap[? "title"] = buffer_read(global.buffer, buffer_string);
		serverMap[? "description"] = buffer_read(global.buffer, buffer_string);
		serverMap[? "maxPlayer"] = buffer_read(global.buffer, buffer_u8);
		serverMap[? "playerCount"] = 1;
		serverMap[? "host"] = playerName;
		ds_list_add(serverList, serverMap);
		
		// 게임서버에 연결완료 알리기
		buffer_seek(global.buffer, buffer_seek_start, 0);
		buffer_write(global.buffer, buffer_u8, COMMAND.SERVER_CONNECTED);
		network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
		break;
		
	case COMMAND.PLAYER_CONNECTING_SERVER:
		var serverIp = buffer_read(global.buffer, buffer_string);
		var serverPort = buffer_read(global.buffer, buffer_string);
		var isServerExists = false;
		var playerHash, playerName;
		
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == ip && playerMap[? "port"] == port) {
				// 플레이어 해시 찾기
				playerHash = playerMap[? "hash"];
				playerName = playerMap[? "name"];
				break;
			}
		}
		
		for (var i = 0; i < ds_list_size(serverList); i++) {
			var serverMap = serverList[| i];
			
			if (serverMap[? "ip"] == ServerIp && serverMap[? "port"] == ServerPort) {
				// 게임서버에 플레이어 정보 알리기
				buffer_seek(global.buffer, buffer_seek_start, 0);
				buffer_write(global.buffer, buffer_string, COMMAND.SERVER_NEWPLAYER);
				buffer_write(global.buffer, buffer_string, playerHash);
				buffer_write(global.buffer, buffer_string, ip);
				buffer_write(global.buffer, buffer_u16, port);
				buffer_write(global.buffer, buffer_string, playerName);
				network_send_udp(global.socket, serverIp, serverPort, global.buffer, buffer_tell(global.buffer));
				
				isServerExists = true;
				break;
			}
		}
		
		if (isServerExists) {
			// 플레이어에게 게임서버 연결완료 알리기
			buffer_seek(global.buffer, buffer_seek_start, 0);
			buffer_write(global.buffer, buffer_seek_start, COMMAND.PLAYER_CONNECTED_SERVER);
			network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
		}
		else {
			// 플레이어에게 게임서버 연결실패 알리기
			buffer_seek(global.buffer, buffer_seek_start, 0);
			buffer_write(global.buffer, buffer_seek_start, COMMAND.PLAYER_CONNECT_FAIL);
			network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
		}
		break;
		
	case COMMAND.SERVER_CLOSE:
		var serverHash, index;
		
		for (var i = 0; i < ds_list_size(serverList); i++) {
			var serverMap = serverList[| i];
			
			if (serverMap[? "ip"] == ip && serverMap[? "port"] == port) {
				// 플레이어 서버 해시, 인덱스 찾기
				serverHash = serverMap[? "hash"]; 
				index = i;
				break;
			}
		}
		
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "serverHash"] == serverHash) {
				// 게임서버에 등록된 모든 플레이어에게 게임서버 종료 알리기
				buffer_seek(global.buffer, buffer_seek_start, 0);
				buffer_write(global.buffer, buffer_u8, COMMAND.SERVER_CLOSE);
				network_send_udp(global.socket, playerMap[? "ip"], playerMap[? "port"], global.buffer, buffer_tell(global.buffer));
			}
		}
			
		// 게임서버 정보 초기화
		ds_list_delete(serverList, index);
		break;
        
	case COMMAND.DISCONNECT:
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == ip && playerMap[? "port"] == port) {
				// 플레이어 정보 초기화
				ds_list_delete(playerList, i);
				break;
			}
		}
		
		for (var i = 0; i < ds_list_size(serverList); i++) {
			var serverMap = serverList[| i];
			
			if (serverMap[? "ip"] == ip && serverMap[? "port"] == port) {
				// 게임서버 정보 초기화
				ds_list_delete(serverList, i);
				break;
			}
		}
		break;
}
