show_message("[마스터] 네트워크 감지");
var type = async_load[? "type"];

switch (type) {
	case network_type_data:
		var ip = async_load[? "ip"];
		var port = async_load[? "port"];
		var buff = async_load[? "buffer"];
		net_master(ip, port, buff);
        break;
}

