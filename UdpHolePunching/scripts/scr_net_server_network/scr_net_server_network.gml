var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u16);

switch (command) {
	case COMMAND.SERVER_CONNECTING_PLAYER:
		// 게임서버에 플레이어 정보 추가
		var playerMap = ds_map_create();
		playerMap[? "hash"] = buffer_read(buff, buffer_string);
		playerMap[? "ip"] = buffer_read(buff, buffer_string);
		playerMap[? "port"] = buffer_read(buff, buffer_u16);
		playerMap[? "name"] = buffer_read(buff, buffer_string);
		ds_list_add(playerList, playerMap);
		break;
		
	case COMMAND.PLAYER_CONNECTING_SERVER:
		// 플레이어에게 연결하기
		buffer_seek(global.buffer, buffer_seek_start, 0);
		buffer_write(global.buffer, buffer_u16, COMMAND.SERVER_CONNECTING_PLAYER);
		network_send_udp(global.socket, ip, port, global.buffer, buffer_tell(global.buffer));
		break;
	
	case COMMAND.DISCONNECT:
		var player_ip = buffer_read(buff, buffer_string);
		var player_port = buffer_read(buff, buffer_u16);
		
		// 플레이어 정보 초기화
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == player_ip && playerMap[? "port"] == player_port) {
				ds_list_delete(playerList, i);
				break;
			}
		}
		break;
}
