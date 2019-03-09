scr_init();

var msg = get_string("마스터 {y}", "n");

if (msg == "y") {
	instance_create_depth(0, 0, 0, obj_master);
	
	with (obj_loby) {
		instance_destroy();	
	}
	
	with (obj_serverCreateBtn) {
		instance_destroy();
	}
	
	with (obj_directConnectBtn) {
		instance_destroy();
	}
}
