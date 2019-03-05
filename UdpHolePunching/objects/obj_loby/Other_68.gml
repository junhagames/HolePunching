// 사설 IP 가져오기
global.privateIp = async_load[? "ip"];

var type = async_load[? "type"];

switch (type) {
	case network_type_data:
		var ip = async_load[? "ip"];
		var port = async_load[? "port"];
		var buff = async_load[? "buffer"];
		net_client(ip, port, buff);
        break;
}