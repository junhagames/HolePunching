var ip = argument[0];
var port = argument[1];
var buff = argument[2];
var command = buffer_read(buff, buffer_u8);

switch (command) {	
	case COMMAND.PLAYER_CONNECTED_SERVER:
	    show_message("게임서버에 연결되었습니다!");
	    isMasterConnected = true;
		room_goto_next();
		break;
	
	case COMMAND.PLAYER_CONNECTION_SERVER_FAIL:
		alarm[0] = 1;
		instance_destroy();
		break;
	
	case COMMAND.SERVER_CLOSE:
	    room_goto(room_loby);
		break;
}
