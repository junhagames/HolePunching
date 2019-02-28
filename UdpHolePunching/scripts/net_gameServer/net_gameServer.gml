var ip = argument0;
var port = argument1;
var buff = argument2;
var message_id = buffer_read(buff, buffer_u8);

switch (message_id) {
	case PACKET.GAMESERVER_CONNECTED:
	    show_message("[게임서버] 마스터서버에 등록됬습니다!");
	    connected = true;
		break;
	
	case PACKET.GAMESERVER_NEWPLAYER:
	    var nick = buffer_read(buff, buffer_string);
	    var get_ip = buffer_read(buff, buffer_string);
	    var get_port = buffer_read(buff, buffer_u16);
		
	    for (var i = 0; i < 100; i++) {
	        if (ds_map_find_value(player[i], "id") == 0) {
				// 게임서버에 클라이언트 정보 추가
				ds_map_replace(player[i], "id", i);
	            ds_map_replace(player[i], "name", nick);
				
				// 마스터서버를 거처 클라이언트에게 ID 알리기
				// UDP hole punching 2단계
	            buffer_seek(buffer, buffer_seek_start, 0);
	            buffer_write(buffer, buffer_u8, PACKET.GAMESERVER_PASSID);
				buffer_write(buffer, buffer_string, get_ip);
				buffer_write(buffer, buffer_u16, get_port);
				buffer_write(buffer, buffer_u8, ds_map_find_value(player[i], "id"));
				network_send_udp(listen,master_ip, master_port, buffer, buffer_tell(buffer));
				
				players++;
				break;
			}
		}
		break;
	
	case PACKET.CLIENT_DISCONNECT:
	    var nick = buffer_read(buff, buffer_string);
		
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
