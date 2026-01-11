-- 参考 https://github.com/lei4519/blog/issues/85

-- 是否在中文模式的情况下被此程序切换为了英文模式
local prev_is_cn_mode = false
-- 是否处于普通模式中 (ESC 触发)
local in_normal_mode = false

-- i, a, o, s, c, I, A, O, S, C
local enter_insert_keys = {
	[105] = true,
	[97] = true,
	[111] = true,
	[115] = true,
	[99] = true,
	[73] = true,
	[65] = true,
	[79] = true,
	[83] = true,
	[67] = true,
}

local function vim_mode(key, env)
	local vmode = env.engine.context:get_option("ex_vim_mode")

	if not vmode then
		return 2
	end

	local is_ascii_mode = env.engine.context:get_option("ascii_mode")
	local keyCode = key.keycode

	--- 1. 处理 Ctrl + o 进入 临时 Normal Mode 时切换---
	--- 最佳实现是在回到 Insert Mode 时恢复原来的 ascii_mode 状态
	--- 但目前没有想到比较完善的实现方案，暂时先这样简单处理
	if key:repr() == "Control+o" then
		if not is_ascii_mode then
			env.engine.context:set_option("ascii_mode", true)
		end
		return 2
	end

	--- 2. 监听 ESC 键进入 Normal Mode ---
	if key.keycode == 65307 then
		in_normal_mode = true
		if is_ascii_mode then
			prev_is_cn_mode = false
		else
			prev_is_cn_mode = true
			env.engine.context:set_option("ascii_mode", true)
		end
	end

	--- 3. Normal Mode 重新进入 Insert Mode 时恢复 ---
	if in_normal_mode then
		if is_ascii_mode then
			if enter_insert_keys[keyCode] then
				in_normal_mode = false
				if prev_is_cn_mode then
					env.engine.context:set_option("ascii_mode", false)
					return 1 -- 消费进入键，防止首字母直接上屏
				end
			end
		end
	end

	return 2
end

return vim_mode
