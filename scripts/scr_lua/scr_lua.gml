// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function new_lua_state() {
	var state = lua_state_create();
	lua_global_set(state, "os", undefined)
	lua_global_set(state, "io", undefined)
	lua_add_function(state, "loadJson", read_json_lua);
	return state
}

function clear_lua_state(state) {
	lua_state_destroy(state)
}