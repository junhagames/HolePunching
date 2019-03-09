var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u8);

switch (command) {
	case COMMAND.PLAYER_CONNECTED_MASTER:
	    show_message("로비에 입장했습니다!");
		global.publicIp = ip;
	    isMasterConnected = true;
		break;
}
