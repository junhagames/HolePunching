var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u16);

switch (command) {
	case COMMAND.PLAYER_CONNECTING_MASTER:
		// 플레이어 정보 추가
		var playerMap  = ds_map_create();
		playerMap[? "hash"] = buffer_read(buff, buffer_string);
		playerMap[? "ip"] = ip;
		playerMap[? "port"] = port;
		playerMap[? "name"] = buffer_read(buff, buffer_string);
		playerMap[? "serverHash"] = NULL;
		ds_list_add(playerList, playerMap);

		// 플레이어에게 연결완료 알리기
		buffer_seek(global.buffer, buffer_seek_start, 0);
		buffer_write(global.buffer, buffer_u16, COMMAND.PLAYER_CONNECTED_MASTER);
		network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
        break;

	case COMMAND.SERVER_CONNECTING_MASTER:
		var playerHash, playerName;
		
		// 플레이어 해시값, 이름 찾기
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == ip && playerMap[? "port"] == port) {
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
		serverMap[? "title"] = buffer_read(buff, buffer_string);
		serverMap[? "description"] = buffer_read(buff, buffer_string);
		serverMap[? "maxPlayer"] = buffer_read(buff, buffer_u8);
		serverMap[? "playerCount"] = 1;
		serverMap[? "host"] = playerName;
		ds_list_add(serverList, serverMap);
		
		// 게임서버에 연결완료 알리기
		buffer_seek(global.buffer, buffer_seek_start, 0);
		buffer_write(global.buffer, buffer_u16, COMMAND.SERVER_CONNECTED_MASTER);
		network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
		break;
		
	case COMMAND.PLAYER_FINDING_SERVER:
		var serverIp = buffer_read(buff, buffer_string);
		var serverPort = buffer_read(buff, buffer_u16);
		var playerHash, playerName;
		var isServerExists = false;
		
		// 플레이어 해시값 찾기
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == ip && playerMap[? "port"] == port) {
				playerHash = playerMap[? "hash"];
				playerName = playerMap[? "name"];
				break;
			}
		}
		
		// 게임서버에 플레이어 정보 알리기
		for (var i = 0; i < ds_list_size(serverList); i++) {
			var serverMap = serverList[| i];
			
			if (serverMap[? "ip"] == serverIp && serverMap[? "port"] == serverPort) {
				buffer_seek(global.buffer, buffer_seek_start, 0);
				buffer_write(global.buffer, buffer_u16, COMMAND.SERVER_CONNECTING_PLAYER);
				buffer_write(global.buffer, buffer_string, playerHash);
				buffer_write(global.buffer, buffer_string, ip);
				buffer_write(global.buffer, buffer_u16, port);
				buffer_write(global.buffer, buffer_string, playerName);
				network_send_udp(global.socket, serverIp, serverPort, global.buffer, buffer_tell(global.buffer));
				isServerExists = true;
				break;
			}
		}
		
		// 플레이어에게 게임서버 연결성공 여부 알리기
		if (isServerExists) {
			buffer_seek(global.buffer, buffer_seek_start, 0);
			buffer_write(global.buffer, buffer_u16, COMMAND.PLAYER_FINDED_SERVER);
			network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
		}
		else {
			buffer_seek(global.buffer, buffer_seek_start, 0);
			buffer_write(global.buffer, buffer_u16, COMMAND.PLAYER_FINDFAIL_SERVER);
			network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
		}
		break;
	
	case COMMAND.SERVER_CLOSE:
		var serverHash, serverIndex;
		
		// 게임서버 해시값, 인덱스값 찾기
		for (var i = 0; i < ds_list_size(serverList); i++) {
			var serverMap = serverList[| i];
			
			if (serverMap[? "ip"] == ip && serverMap[? "port"] == port) {
				serverHash = serverMap[? "hash"]; 
				serverIndex = i;
				break;
			}
		}
		
		// 게임서버에 등록된 모든 플레이어에게 게임서버 종료 알리기
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "serverHash"] == serverHash) {
				buffer_seek(global.buffer, buffer_seek_start, 0);
				buffer_write(global.buffer, buffer_u16, COMMAND.SERVER_CLOSE);
				network_send_udp(global.socket, playerMap[? "ip"], playerMap[? "port"], global.buffer, buffer_tell(global.buffer));
			}
		}
			
		// 게임서버 정보 초기화
		ds_list_delete(serverList, serverIndex);
		break;
        
	case COMMAND.DISCONNECT:
		var serverHash, serverIndex;
		var isHost = false;
		
		// 게임서버 해시값, 인덱스값 찾기
		for (var i = 0; i < ds_list_size(serverList); i++) {
			var serverMap = serverList[| i];
			
			if (serverMap[? "ip"] == ip && serverMap[? "port"] == port) {
				serverHash = serverMap[? "hash"]; 
				serverIndex = i;
				isHost = true;
				break;
			}
		}
		
		// 플레이어 정보 초기화
		// 게임서버에 등록된 모든 플레이어에게 게임서버 종료 알리기
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == ip && playerMap[? "port"] == port) {
				ds_list_delete(playerList, i);
				
				if (!isHost) {
					break;
				}
			}
			
			if (isHost) {
				if (playerMap[? "serverHash"] == serverHash) {
					buffer_seek(global.buffer, buffer_seek_start, 0);
					buffer_write(global.buffer, buffer_u16, COMMAND.SERVER_CLOSE);
					network_send_udp(global.socket, playerMap[? "ip"], playerMap[? "port"], global.buffer, buffer_tell(global.buffer));
				}
			}
		}
		
		// 게임서버 정보 초기화
		if (isHost) {
			ds_list_delete(serverList, serverIndex);
		}
		break;
}
