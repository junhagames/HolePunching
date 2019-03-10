if (global.isHost) {
	instance_create_depth(0, 0, 0, obj_net_server);
}
else {
	instance_create_depth(0, 0, 0, obj_net_client);
}