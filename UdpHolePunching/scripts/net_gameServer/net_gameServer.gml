var ip = argument0;
var port = argument1;
var buff = argument2;
var message_id = buffer_read(buff, buffer_u8);

switch (message_id) {
	case PACKET.CONNECTED:
	    show_message("[게임서버] 마스터서버에 등록됬습니다!");
	    connected = true;
		break;
	
	case PACKET.NEWCLIENT:
	    var player_hash = buffer_read(buff, buffer_string);
		var player_name = buffer_read(buff, buffer_string);
	    var player_ip = buffer_read(buff, buffer_string);
	    var player_port = buffer_read(buff, buffer_u16);
		net_register(player_list, player_hash, player_name, player_ip, player_port);
		
		players++;
		break;
	
	case PACKET.CLIENT_DISCONNECT:
	    for (i = 0; i < 100; i++) {
			if (ds_map_find_value(player[i], "name") == nick) {
				// 클라이언트 등록 초기화
				ds_map_replace(player[i], "id", 0);
				ds_map_replace(player[i], "name", "");
				
				players--;
				break;
			}
		}
		break;
	
	case PACKET.MASTERSERVER_CLOSE:
		show_message("[게임서버] 마스터서버가 종료됬습니다!");
	    game_end();
		break;
}
