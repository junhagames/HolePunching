var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u8);

switch (command) {
	case PACKET.CONNECTED:
	    show_message("[게임서버] 마스터서버에 등록되었습니다!");
	    isConnected = true;
		break;
	
	case PACKET.GAMESERVER_NEWPLAYER:
		// 게임서버에 플레이어 정보 추가
		var playerMap = ds_map_create();
		playerMap[? "hash"] = buffer_read(buff, buffer_string);
		playerMap[? "name"] = buffer_read(buff, buffer_string);
		playerMap[? "ip"] = buffer_read(buff, buffer_string);
		playerMap[? "port"] = buffer_read(buff, buffer_u16);
		ds_list_add(playerList, playerMap);
		break;
	
	case PACKET.PLAYER_DISCONNECT:
		var player_ip = buffer_read(buff, buffer_string);
		var player_port = buffer_read(buff, buffer_u16);
		
		for (var i = 0; i < ds_list_size(playerList); i++) {
			var playerMap = playerList[| i];
			
			if (playerMap[? "ip"] == player_ip && playerMap[? "port"] == player_port) {
				// 플레이어 정보 초기화
				ds_list_delete(playerList, i);
				break;
			}
		}
		break;
	
	case PACKET.MASTERSERVER_CLOSE:
		show_message("[게임서버] 마스터서버가 종료되었습니다!");
	    game_end();
		break;
}
