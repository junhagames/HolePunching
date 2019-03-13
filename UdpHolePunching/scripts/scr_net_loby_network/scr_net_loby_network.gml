var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u16);

switch (command) {
	case COMMAND.PLAYER_FINDING_PRIVATEIP:
		global.privateIp = ip;
		scr_net_player_connectingMaster();
		break;
	
	case COMMAND.PLAYER_CONNECTED_MASTER:
	    show_message("로비에 입장했습니다!");
		global.isMasterConnected = true;
		publicIp = ip;
		break;
		
	case COMMAND.SERVER_CONNECTED_MASTER:
	    show_message("게임서버 호스팅을 성공했습니다!");
		global.isHost = true;
		room_goto_next();
		break;
		
	case COMMAND.PLAYER_FINDED_SERVER:
	    show_message("게임서버를 찾았습니다!");
		alarm[2] = 0;
		buffer_seek(global.buffer, buffer_seek_start, 0);
		buffer_write(global.buffer, buffer_u16, COMMAND.PLAYER_CONNECTING_SERVER);
		network_send_udp(global.socket, global.serverIp, global.serverPort, global.buffer, buffer_tell(global.buffer));
		break;
	
	case COMMAND.PLAYER_FINDFAIL_SERVER:
		alarm[2] = 1;
		break;
	
	case COMMAND.SERVER_CONNECTING_PLAYER:
		room_goto_next();
		break;
}
