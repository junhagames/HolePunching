var ip = argument[0];
var port = argument[1];
var buff = argument[2];
var command = buffer_read(buff, buffer_u8);

switch (command) {
	case COMMAND.LOBY_CONNECTED:
	    show_message("로비에 입장했습니다!");
		global.publicIp = buffer_read(buff, buffer_string);
	    isMasterConnected = true;
		break;
}
