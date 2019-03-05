if (global.privateIp != "null" && !isMasterConnecting) {
	net_registerPlayer();
	isMasterConnecting = true;
}