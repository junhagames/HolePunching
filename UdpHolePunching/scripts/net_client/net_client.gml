var ip = argument[0];
var port = argument[1];
var buff = argument[2];
var command = buffer_read(buff, buffer_u8);

switch (command) {
	case PACKET.PLAYER_CONNECTED:
	    show_message("마스터서버에 연결되었습니다!");
	    isMasterConnected = true;
		break;
	
	case PACKET.PLAYER_CONNECTFAIL:
	    show_message("게임서버가 존재하지 않습니다!");
	    game_end();
		break;
	
	case PACKET.GAMESERVER_CLOSE:
	    show_message("게임서버가 종료되었습니다!");
		game_end();
		break;
	
	case PACKET.MASTERSERVER_CLOSE:
	    show_message("마스터서버가 종료되었습니다!");
	    game_end();
		break;
}
