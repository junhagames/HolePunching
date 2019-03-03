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
		var player_map = ds_map_create();
		player_map[? "hash"] = buffer_read(buff, buffer_string);
		player_map[? "name"] = buffer_read(buff, buffer_string);
		player_map[? "ip"] = buffer_read(buff, buffer_string);
		player_map[? "port"] = buffer_read(buff, buffer_u16);
		ds_list_add(player_list, player_map);
		
		players++;
		break;
	
	case PACKET.CLIENT_DISCONNECT:
		var player_ip = buffer_read(buff, buffer_string);
		var player_port = buffer_read(buff, buffer_u16);
		
		for (var i = 0; i < ds_list_size(player_list); i++) {
			var player_map = player_list[| i];
			
			if (player_map[? "ip"] == player_ip && player_map[? "port"] == player_port) {
				ds_list_delete(player_list, i);
				break;
			}
		}
		
		players--;
		break;
	
	case PACKET.MASTERSERVER_CLOSE:
		show_message("[게임서버] 마스터서버가 종료되었습니다!");
	    game_end();
		break;
}
