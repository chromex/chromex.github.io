pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- runnah

g={
	build=1,
	debug=true,
	t=0
}

function _init()
	g.state=menu
	if g.debug then
		g.state=game
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

-->8
-- menu state
menu={
	update=function(self)
		if btnp(5) then
			g.state=game
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
	cx=12,
	cy=4,
	cf=false,
	cv=0,
	cd=false,

	update=function(self)
		self.cv+=0.1
		self.cy+=self.cv
		if self.cy>128 and not self.cd then
			self.cd=true
			--todo:spawn death particles
			for i=0,7 do
				particles:add(6,self.cx,128,rnd(10)/5-1,-1.5-rnd(10)/10,1)
			end
		end

		particles:update()
	end,

	draw=function(self)
		cls()
		d_chef(self.cx,self.cy,self.cf)

		if self.cd then
			print("u ded",54,60,10)
		end

		particles:draw()
	end,

	debug_draw=function(self)
		print("b"..g.build,1,122,15)
	end,
}

-->8
-- fail state
fail={
	update=function(self)
	end,

	draw=function(self)
		print("u lose",2,2,10)
	end,
}

-->8
-- draws
function d_chef(x,y,running)
	if running then
		spr(4+g.t3%2,x,y)
	else
		spr(3,x,y)
	end
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
000e00000e000eee00e00e0000777700007777000077770000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000777770000eee0007700007766400077664000776640000000000000000000000000000000000000000000000000000000000000000000000000000000000
0077777777700eeee077770e078f8000078f8000078f800000000000000000000000000000000000000000000000000000000000000000000000000000000000
e07777777770eeee0707707000fff00000fff00000fff00000088000000000000000000000000000000000000000000000000000000000000000000000000000
0770077700770eee0777777000fef00000fef00000fef0000008e000000000000000000000000000000000000000000000000000000000000000000000000000
0700077700070eee0775577000566500005665000056650000000000000000000000000000000000000000000000000000000000000000000000000000000000
0700777770070eeee077770e00666000006660000066600000000000000000000000000000000000000000000000000000000000000000000000000000000000
0777700077770eeeee0000ee00505000005000000000500000000000000000000000000000000000000000000000000000000000000000000000000000000000
e07777077770eeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e07777777770eeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
ee007777700eeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeee00000eeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
