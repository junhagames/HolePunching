draw_set_font(font_main);
randomize();

enum PACKET {
	GAMESERVER_REGISTER,
	GAMESERVER_NEWPLAYER,
	GAMESERVER_CLOSE,
	
	CLIENT_REGISTER,
	CLIENT_DISCONNECT,
	CLIENT_CONNECTFAIL,
	
	isConnected,
	MASTERSERVER_CLOSE
}