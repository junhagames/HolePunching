var ip = argument[0];
var port = argument[1];
var buff = argument[2];
var message_id = buffer_read(buff, buffer_u8);

switch (message_id) {
	case PACKET.CONNECTED:
	    show_message("[클라이언트] 게임서버에 연결되었습니다!");
	    connected = true;
		break;
	
	case PACKET.CLIENT_CONNECTFAIL:
	    show_message("[클라이언트] 게임서버가 존재하지 않습니다!");
	    game_end();
		break;
	
	case PACKET.GAMESERVER_CLOSE:
	    show_message("[클라이언트] 게임서버가 종료되었습니다");
		game_end();
		break;
	
	case PACKET.MASTERSERVER_CLOSE:
	    show_message("[클라이언트] 마스터서버가 종료됬습니다!");
	    game_end();
		break;
}
