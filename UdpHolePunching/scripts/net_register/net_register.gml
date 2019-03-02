/// @description 리스트에 새로운 맵을 등록합니다
/// @param ds_list
/// @param hash
/// @param name
/// @param ip
/// @param port

var list = argument0;
var hash = argument1;
var name = argument2;
var ip = argument3;
var port = argument4;
var map = ds_map_create();

ds_map_add(map, "hash", hash);
ds_map_add(map, "name", name);
ds_map_add(map, "ip", ip);
ds_map_add(map, "port", port);
ds_list_add(list, map);
