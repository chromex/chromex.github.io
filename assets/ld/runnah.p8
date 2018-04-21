pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- runnah

g={
	build=3,
	debug=true,
	t=0
}

function _init()
	set_state(menu)
	if g.debug then
		set_state(game)
	end
end

function _update()
	g.t+=1
	g.t2=flr(g.t/2)
	g.t3=flr(g.t/3)
	g.t4=flr(g.t/4)
	g.t5=flr(g.t/5)
	g.state:update()
end

function _draw()
	g.state:draw()

	if g.debug and g.state.debug_draw != nil then
		g.state:debug_draw()
	end
end

function set_state(state)
	g.state=state
	if state.init!=nil then
		state:init()
	end
end

-->8
-- menu state
menu={
	update=function(self)
		if btnp(5) then
			set_state(game)
		end
	end, -- update()

	draw=function(self)
		cls()
		print("runnah."..g.build,2,2,10)
		print("press 'x' to start",2,10,10)
	end -- draw()
}

-->8
-- game state
game={
	init=function(self)
		blds:init()
		self.chef=make_chef()
		go:add(self.chef)
	end,

	update=function(self)
		blds:update(self.chef.s)
		go:update()
		particles:update()
	end,

	draw=function(self)
		cls()

		blds:draw()
		go:draw()
		particles:draw()
	end,

	debug_draw=function(self)
		print("b"..g.build,1,122,15)
	end,
}

function make_chef()
	return {
		x=15,
		y=10,
		f=false,
		v=0,
		s=0,
		d=false,

		update=function(self)
			if not self.d then
				-- if we are grounded, speed up
				if self.f then
					self.s=3
					if btnp(5) then
						self.v=-3
					end
				end

				self.v+=0.25
				self.y+=self.v
				self.f=false

				if self.y>136 then
					self.d=true
					self.s=0
					for i=0,7 do
						particles:add(6,self.x,128,rnd(10)/5-1,-1.5-rnd(10)/10,1)
					end
				else
					hit=blds:chk_hit(self)
					if hit[1]==1 then
						self.v=0
						self.f=true
						self.y=hit[3]
					elseif hit[1]==2 then
						self.s=0
						self.y=hit[3]
						self.f=false
						self.v=0
						blds:move(self.x-hit[2]+1)
						for i=0,4 do
							particles:add(10+flr(rnd(3)),self.x,self.y-4,rnd(10)/10-1,0.5-rnd(10)/5,1)
						end
					end
				end
			end	
		end,

		draw=function(self)
			d_chef(self.x,self.y,self.f)

			if self.d then
				print("u ded",54,60,10)
			end
		end,
	}
end

go={
	lst={},

	add=function(self,obj)
		obj.ded=false
		add(self.lst,obj)
	end,

	update=function(self)
		for obj in all(self.lst) do
			obj:update()
			if obj.ded then
				del(self.lst,obj)
			end
		end
	end,

	draw=function(self)
		for obj in all(self.lst) do
			obj:draw()
		end
	end,
}

blds={
	lst={},

	init=function(self)
		-- todo: delete old buildings
		self:add()
		self:add()
		self:add()
	end,

	add=function(self)
		local x=0
		if #self.lst>0 then
			x=self.lst[#self.lst][1]+65
		end
		add(self.lst,{x,124-flr(rnd(28))})
	end,

	--0=no hit,1=top,2=side
	chk_hit=function(self,chef)
		local x=chef.x
		local px=x-chef.s
		local y=chef.y
		local py=y-chef.v
		for bld in all(self.lst) do
			local cross_x=px<bld[1] and x>=bld[1]
			local cross_y=py<=bld[2] and y>bld[2]
			
			if cross_x then
				-- compute y intersect -- if side then fall
				local iy=py+(y-py)*((bld[1]-px)/(x-px))
				if iy>bld[2] then
					return {2,bld[1],iy}
				end
			end

			if cross_y then
				-- compute x intersect -- if land then top
				local ix=px+(x-px)*((bld[2]-py)/(y-py))
				if ix>=bld[1] and ix<(bld[1]+48) then
					return {1,ix,bld[2]}
				end
			end
		end

		return {0}
	end,

	move=function(self,dx)
		for bld in all(self.lst) do
			bld[1]+=dx
		end
	end,

	update=function(self,spd)
		for b in all(self.lst) do
			b[1]-=spd
			if b[1]<-128 then
				del(self.lst,b)
			end
		end

		if self.lst[#self.lst][1]<128 then
			self:add()
		end
	end,

	draw=function(self)
		for b in all(self.lst) do
			d_building(b[1],b[2])
		end
	end,
}

-->8
-- draws
function d_chef(x,y,running)
	if running then
		spr(4+g.t3%2,x-2,y-8)
	else
		spr(3,x-2,y-8)
	end
end

function d_building(x,y)
	map(0,0,x,y,6,4)
end

particles={
	lst={},

	add=function(self,s,x,y,vx,vy,t)
		add(self.lst,{s,x,y,vx,vy,t})
	end,

	update=function(self)
		for p in all(self.lst) do
			p[6]-=0.0333
			if p[6]<0 then
				del(self.lst,p)
			else
				p[5]+=0.1
				p[2]+=p[4]
				p[3]+=p[5]
			end
		end
	end,

	draw=function(self)
		for p in all(self.lst) do
			spr(p[1],p[2],p[3])
		end
	end,
}

__gfx__
000e00000e000eee00e00e0000777700007777000077770000000000555555555555555555555555000000000000000000000000000000000000000000000000
0000777770000eee0007700007766400077664000776640000000000445444445454444444544445000000000000000000000000000000000000000000000000
0077777777700eeee077770e078f8000078f8000078f800000000000445444445454444444544445000000000000000000000000000000000000000000000000
e07777777770eeee0707707000fff00000fff00000fff00000088000445444445454444444544445000040000005400000050000000000000000000000000000
0770077700770eee0777777000fef00000fef00000fef0000008e000555555555555555555555555000450000000000000005000000000000000000000000000
0700077700070eee0775577000566500005665000056650000000000444445445444454444444545000000000000000000000000000000000000000000000000
0700777770070eeee077770e00666000006660000066600000000000444445445444454444444545000000000000000000000000000000000000000000000000
0777700077770eeeee0000ee00505000005000000000500000000000444445445444454444444545000000000000000000000000000000000000000000000000
e07777077770eeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e07777777770eeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ee007777700eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeee00000eeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0807070707090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0807070707090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0807070707090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0807070707090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
