/// @description 해시값을 생성합니다
/// @param length

var length = argument0;
var str = "";

for (var i = 0; i < 8; i++) {
    str += chr(random_range(48, 122));
}
return str;
