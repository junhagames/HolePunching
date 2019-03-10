var ip = argument0;
var port = argument1;
var buff = argument2;
var command = buffer_read(buff, buffer_u16);

switch (command) {	
	case COMMAND.SERVER_CLOSE:
	    room_goto(room_loby);
		break;
}
