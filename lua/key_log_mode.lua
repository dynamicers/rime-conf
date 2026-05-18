-- 捕获 Rime 中所有按键事件并记录到文件, for debug

function key_log(key, env)
	local log_mode = env.engine.context:get_option("key_log_mode")

	if not log_mode then
		return 2
	end

	local f = io.open("/tmp/rime_key.log", "a")
  local milli = string.format("%03d", math.floor((os.clock() * 1000) % 1000))
  local time_str = os.date("%Y-%m-%d %H:%M:%S.") .. milli
  local log_line = string.format("[%s] keycode: %d, repr: %s\n",
  	time_str,
  	key.keycode,
  	key:repr()
  )
  if f then
    f:write(log_line)
    f:close()
  end

  return 2
	
end

return key_log

