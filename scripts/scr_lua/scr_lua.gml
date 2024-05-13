// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function new_lua_state() {
	var state = lua_state_create();
	ref_variable_instance_init(state);
	lua_global_set(state, "os", undefined);
	lua_global_set(state, "io", undefined);
	lua_add_function(state, "string", string);
	lua_add_function(state, "log", l_log);
	lua_add_function(state, "loadJson", read_json_lua);
	lua_add_function(state, "loadConductorData", load_conductor_data);
	lua_add_function(state, "createCharacter", create_character);
	lua_add_function(state, "createStrum", create_strum);
	lua_add_function(state, "createConductor", create_conductor);
	lua_add_function(state, "getCharacter", l_get_character);
	return state
}

function clear_lua_state(state) {
	lua_state_destroy(state)
}

// apollo docs functions

function ref_variable_instance_get(context, name) {
	var q = context, s = name;
	with (q) return variable_instance_get(id, s);
	if (q < 100000) {
	    lua_show_error("Couldn't find any instances of " + string(q)
	        + " (" + object_get_name(q) + ")");
	} else lua_show_error("Couldn't find instance " + string(q));
	return undefined;	
}

function ref_variable_instance_set(context, name, value) {
	var q = context, s = name, v = value, n = 0;
	with (q) { variable_instance_set(id, s, v); n++; }
	if (n) return;
	if (q < 100000) {
	    lua_show_error("Couldn't find any instances of " + string(q)
	        + " (" + object_get_name(q) + ")");
	} else lua_show_error("Couldn't find instance " + string(q));
}

function ref_variable_instance_init(lua_state) {
	var q = lua_state;
	lua_add_function(q, "variable_instance_get", ref_variable_instance_get);
	lua_add_function(q, "variable_instance_set", ref_variable_instance_set);
	lua_add_code(q, @'-- ref_variable_instance_init()
	__idfields = __idfields or { };
	debug.setmetatable(0, {
	    __index = function(self, name)
	        if (__idfields[name]) then
	            return _G[name];
	        else
	            return variable_instance_get(self, name);
	        end
	    end,
	    __newindex = variable_instance_set,
	})\n');
}

// TODO: make this better lol

function call_lua(func, args) {
	// songscript
	try {
		if global.songscript > -1 {
			var value = lua_call(global.songscript, func, args);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) {
		if e.message != "Attempting to call a non-existent Lua function!" {
			show_debug_message(e.longMessage);	
		}
	}
	
	// packscript
	try {
		if global.packscript > -1 {
			var value = lua_call(global.packscript, func, args);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) {
		if e.message != "Attempting to call a non-existent Lua function!" {
			show_debug_message(e.longMessage);	
		}
	}
	
	return undefined;
}

function call_lua_2arg(func, arg1, arg2) {
	// songscript
	try {
		if global.songscript > -1 {
			var value = lua_call(global.songscript, func, arg1, arg2);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) {
		if e.message != "Attempting to call a non-existent Lua function!" {
			show_debug_message(e.longMessage);	
		}
	}
	
	// packscript
	try {
		if global.packscript > -1 {
			var value = lua_call(global.packscript, func, arg1, arg2);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) {
		if e.message != "Attempting to call a non-existent Lua function!" {
			show_debug_message(e.longMessage);	
		}
	}
	
	return undefined;
}

function call_lua_3arg(func, arg1, arg2, arg3) {
	// songscript
	try {
		if global.songscript > -1 {
			var value = lua_call(global.songscript, func, arg1, arg2, arg3);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) {
		if e.message != "Attempting to call a non-existent Lua function!" {
			show_debug_message(e.longMessage);	
		}
	}
	
	// packscript
	try {
		if global.packscript > -1 {
			var value = lua_call(global.packscript, func, arg1, arg2, arg3);
			if value != undefined {
				return value;
			}
		}
	}
	catch (e) {
		if e.message != "Attempting to call a non-existent Lua function!" {
			show_debug_message(e.longMessage);	
		}
	}
	
	return undefined;
}

function call_lua_event(func, arg1) {
	var val = call_lua(func, arg1);
	if is_bool(val) { return val }
	else { return true; }
}

function call_lua_event_2arg(func, arg1, arg2) {
	var val = call_lua_2arg(func, arg1, arg2);
	if is_bool(val) { return val }
	else { return true; }
}

function call_lua_event_3arg(func, arg1, arg2, arg3) {
	var val = call_lua_3arg(func, arg1, arg2, arg3);
	if is_bool(val) { return val }
	else { return true; }
}


function l_log(msg) {
	show_debug_message(msg);	
}

function l_get_character(idx) {
	return [ global.bfinstance, global.dadinstance, global.gfinstance ];
}