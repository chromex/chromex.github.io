pico-8 cartridge // http://www.pico-8.com
version 14
__lua__
-- happy happy marshmallow factory

function _init()
	build=60
	
	debug=false
	t=0
	state=0
	
	--topbox
	tip=""
	tipx=0
	news=""
	
	--map
	mlayer=0
	e_sugar=false
	e_bone=false
	
	--gameplay
	p_u=false
	p_d=false
	p_l=false
	p_r=false
	money=0
	phase=-1
	t_sugar=0
	t_bone=0
	e_table=false
	e_cauldron=false
	boiling=0
	e_iron=false
	iron=0
	heating=0
	mallow=0
	e_comp=false
 e_customers=false
 newsmsg=""
 e_leftroom=false
 e_rightroom=false
 cost=1
 oven_output=1
 robot_spd=0.02
 e_snow=false
 e_chemist=false
 e_convert=false
	
	--chef
	cx=124
	cy=60
	moving=false
	cr=false
	has_sugar=false
	has_bone=false
	
	-- !!!debug tool!!!
	--skip_to(3,180,40)
	--skip_to(4,6000,300)
	-- !!!debug tool!!!
end

function _update()
	t+=1
	if state==0 then
		updatemenu()
	elseif state==1 then
		updategame()
	else
		updateclose()
	end

	--if btnp(4,1) then
	--	debug=not debug
	--end
end

function _draw()
	if state==0 then
		drawmenu()
	elseif state==1 then
		drawgame()
	else
		drawclose()
	end
	
	if debug then
		rectfill(0,128-13,127,127,8)
		line(0,128-14,127,128-14,5)
		print("p:"..phase.." s:"..state.." m:"..mallow.." c:"..#customers,1,128-6,2)
		print("$:"..money.." tb:"..t_bone.." ts:"..t_sugar.." i:"..iron.." delta:"..cdelta,1,128-12,2)
	end
	
	-- must be last thing updated
 _prevbtn=btn(5)
end
-->8
--menu

__mallowy=0
__e_intro=false
__fadecount=0

function updatemenu()
	if btnp(5) then
		__e_intro=true
	end
	
	if __e_intro and t%1==0 then
		__mallowy+=1
	end
	
	if __mallowy==50 then
		pal()
		state=1
		go_phase(0)
	end
end

function drawmenu()
	cls(14)
	print("happy happy marshmallow factory", 3, 50, 10)	
		
	map(16,0,0,85+__mallowy,16,16)

	if not __e_intro then
		print("press 'x' to start", 30, 56, 15)
		print("b"..build,1,128-6,15)
	else
		__fadecount+=1
		if __fadecount<20 then
		elseif __fadecount<30 then
 		pal(1,0,1)
 		pal(2,0,1)
 		pal(4,0,1)
 		pal(5,0,1)
 		
 		pal(3,5,1)
 		pal(6,5,1)
 		pal(8,5,1)
 		pal(9,5,1)
 		pal(13,5,1)
 		
 		pal(7,6,1)
 		pal(10,6,1)
 		pal(11,6,1)
 		pal(12,6,1)
 		pal(14,6,1)
 		pal(15,6,1)
 	elseif __fadecount<40 then
 	 pal(1,0,1)
 		pal(2,0,1)
 		pal(4,0,1)
 		pal(5,0,1)
 		
 		pal(3,0,1)
 		pal(6,0,1)
 		pal(8,0,1)
 		pal(9,0,1)
 		pal(13,0,1)
 		
 		pal(7,5,1)
 		pal(10,5,1)
 		pal(11,5,1)
 		pal(12,5,1)
 		pal(14,5,1)
 		pal(15,5,1)
 	elseif __fadecount<50 then
 	 cls()
 	end
 end
end
-->8
-- game

-- constants
sugar_box={86,32,98,48}
bone_box={158,32,170,48}
table_box={112,46,144,64}
cauldron_box={116,56,140,71}
iron_box={116,71,140,88}
iron_max=20
iron_colors={1,5,6,6,7}
comp_box={74,42,85,54}

function go_phase(p)
	if p<=phase then return end
	
	phase=p
	if p==0 then
		mlayer=1
		tip="move with ����"
		tipx=28
	elseif p==1 then
		e_sugar=true
		tip="pick up sugar with �"
		tipx=22
	elseif p==2 then
		e_sugar=false
		tip="place sugar on table"
		tipx=24
		e_table=true
	elseif p==3 then
		e_bone=true
		tip="now get the bone! �"
		tipx=26
	elseif p==4 then
		e_bone=false
		tip="and deliver it"
		tipx=36
	elseif p==5 then
		tip="now boil them together �"
		tipx=14
		e_cauldron=true
	elseif p==6 then
		tip="finally bake them �"
		tipx=24
		e_iron=true
	elseif p==7 then
		tip="you've perfected mallows!"
		tipx=14
		e_comp=true
		e_upgrades=true
	elseif p==8 then
		-- make sure state is correct
		mlayer=6
		money=0
		mallow=20
		e_upgrades=false
		e_customers=true
		newsmsg="mews: mallow factory opens!"
		tip="first customers incoming"
		tipx=16
	elseif p==9 then
		tip="oh no! make more mallows"
		tipx=16
		newsmsg="news: mallow shortage hits"
		e_sugar=true
		e_bone=true
	elseif p==10 then
		tip=""
		newsmsg="news: phew, mallows back"
 elseif p==11 then
 	newsmsg="news: who let the dogs out?"
 	tip="upgrade available at computer"
 	tipx=6
 	e_upgrades=true
 	add_upgrade("sugar bot 1.0",50,0)
 	add_upgrade("bone bot 1.0",50,1)
 elseif p==12 then
 	tip="buy with �"
 	tipx=44
 elseif p==13 then
 	newsmsg="news: mechanical keyboards rule"
 	tip=""
 elseif p==14 then
 	newsmsg="news: craft mallow fad grows"
 	cdelta=75
 elseif p==15 then
 	add_upgrade("national ads",80,2)
 	tip="time to grow?"
 	tipx=36
 elseif p==16 then
 	newsmsg="news: record mallow demand"
 	tip=""
 elseif p==17 then
 	newsmsg="news: epic birthday eclipse"
 	add_upgrade("expand oven",150,3)
 elseif p==18 then
 	newsmsg="news: mmm mallows"
 	arate=10
 elseif p==19 then
 	newsmsg="news: fad: mallows and chill"
 	add_upgrade("stir bot 1.0",150,4)
 	add_upgrade("bake bot 1.0",150,5)
 elseif p==20 then
 	arate=9
 	newsmsg="news: mallows for breakfast?"
 elseif p==21 then
 	arate=8
 	add_upgrade("global ads",200,6)
 elseif p==22 then
 	arate=7
 	newsmsg="news: mallow-mania hits high"
 elseif p==23 then
 	add_upgrade("add dopamine",500,7)
 	arate=6
 elseif p==24 then
 	newsmsg="news: mallows addictive?"
 	arate=4
 elseif p==25 then
 	add_upgrade("faster robots",500,8)
 	add_upgrade("embiggen oven",800,9)
 	arate=3
 elseif p==26 then
 	newsmsg="news: mallows un-healthy?"
 	arate=2
 elseif p==27 then
 	newsmsg="news: mallows make you fat :("
 	tip="oh no! they caught on!"
 	tipx=20
 	e_adults=false
 	cdelta=75
 	add_upgrade("hire the chemist",600,10)
 elseif p==28 then
		e_chemist=true
 	tip="...researching..."
 	tipx=30
 elseif p==29 then
  tip="..."
 	tipx=58
 	add_upgrade("add cocaine",40,11)
 elseif p==30 then
 	tip="dope. let them eat coke."
 	tipx=16
 	e_adults=true
		cdelta=20
		adelta=25
 	e_snow=true
 	cost=2
 	newsmsg="news: mallows back on the table"
 elseif p==31 then
 	tip="hehe"
 	tipx=56
 	newsmsg="news: wait! mallows are drugs!"
 	add_upgrade("buyout media",1000,12)
 elseif p==32 then
 	newsmsg="mallow news network buys media"
 	tip="be more evil. why not."
 	tipx=20
 elseif p==33 then
 	newsmsg="mnn: mallows are life"
 	tip=""
 	tipx=30
 	add_upgrade("magic mallows",1000,13)
 elseif p==34 then
 	newsmsg="mnn: you are what you eat"
 	tip="the other other white meat"
 	tipx=12
 	e_convert=true
 elseif p==35 then
 	newsmsg="mnn: mallowcaust unstoppable"
 	tip=""
 elseif p==36 then
 	newsmsg="mnn: mallow mallow mallow mallow"
 	add_upgrade("convert earth",0,14)
 elseif p==37 then
 	e_usecomp=false
 	e_fadeout=true
 	fadecount=0
 end
end

function updategame()
	if e_usecomp then
		update_upgrades()
	else
 	move_chef()
 end
 
	-- pickups
	if not has_sugar and not has_bone then
 	if e_sugar and click() and chef_in(sugar_box) then
 		has_sugar=true
 	elseif e_bone and click() and chef_in(bone_box) then
 	 has_bone=true
 	end
	end

	-- dropoffs
	if has_sugar and chef_in(table_box) then
		has_sugar=false
	 add_sugar(20)
	end
	if has_bone and chef_in(table_box) then
		has_bone=false
		add_bone(20)
	end
	
	-- boiling
	if boiling>0 then
		boiling-=1
		if t%5==0 then
			t_bone=max(t_bone-1,0)
			t_sugar=max(t_sugar-1,0)
			iron+=1
		end
		if iron==iron_max or t_bone==0 or t_sugar==0 then
			boiling=0
		end
	end
	if click() and can_boil() then
		boil()
	end
	
	-- baking
	if heating>0 then
		heating-=1
		if t%5==0 then
			iron=max(iron-1,0)
			mallow+=oven_output
		end
		if iron==0 then
			heating=0
		end
	end
	if click() and can_bake() then
		bake()
	end
	
	update_robots()
	
	if click() and can_comp() and phase>10 then
		e_usecomp=true
	end
	
	if e_customers then
		update_customers()
	end

	-- phase shifts
	if phase==0 then
		if p_u and p_d and p_r and p_l then
			go_phase(1)
		end
	elseif phase==1 then
		if has_sugar then
			go_phase(2)
		end
	elseif phase==2 then
		if t_sugar>0 then
			go_phase(3)
		end
	elseif phase==3 then
		if has_bone then
			go_phase(4)
		end
	elseif phase==4 then
		if t_bone>0 then
			go_phase(5)
		end
	elseif phase==5 then
		if iron==iron_max then
			go_phase(6)
		end
	elseif phase==6 then
		if mallow==20 then
			go_phase(7)
		end
	elseif phase==7 then
		if click() and chef_in(comp_box) then
			go_phase(8)
		end
	elseif phase==8 then
		if mallow==0 then
			go_phase(9)
		end
	elseif phase==9 then
		if mallow>0 then
			go_phase(10)
		end
	elseif phase==10 then
		if money>=50 then
			go_phase(11)
		end
	elseif phase==11 then
		if e_usecomp then
			go_phase(12)
		end
	elseif phase==12 then
		if robots[1].e==true or robots[2].e==true then
			go_phase(13)
		end
	elseif phase==13 then
		if robots[1].e==true and robots[2].e==true then
			go_phase(14)
		end
	elseif phase==14 then
		if money>=80 then
			go_phase(15)
		end
	elseif phase==16 then
		if money>=75 then
			go_phase(17)
		end
	elseif phase==18 then
		if money>=100 then
			go_phase(19)
		end
	elseif phase==19 then
		if robots[3].e and robots[4].e then
			go_phase(20)
		end
	elseif phase==20 then
		if money>=100 then
			go_phase(21)
		end
 elseif phase==22 then
 	if money>=150 then
 		go_phase(23)
 	end
 elseif phase==24 then
 	if money>=250 then
 		go_phase(25)
 	end
 elseif phase==26 then
 	if money>500 then
 		go_phase(27)
 	end
 elseif phase==28 then
 	if money>=40 then
 		go_phase(29)
 	end
 elseif phase==30 then
 	if money>=500 then
 		go_phase(31)
 	end
 elseif phase==32 then
 	if money>=400 then
 		go_phase(33)
 	end
 elseif phase==34 then
 	if cdelta>80 then
 		go_phase(35)
 	end
 elseif phase==35 then
 	if cdelta>200 then
 		go_phase(36)
 	end
	end
	
	if money<0 then
		money=0
	end
end

function drawgame()
 cls()
 camera(64,0)
 
 map(8,16,0,0,32,16,mlayer)
 
 -- pickups
 if e_sugar then
 	draw_sugar(sugar_box[1]+2,sugar_box[2],4)
 end
 if e_bone then
 	draw_bone(bone_box[1]+2,bone_box[2],4)
 end
 
 -- drop offs {112,46,144,56}
 if e_table then
 	rectfill(112,46,143,55,9)
 	line(116,56,116,60,5)
 	line(139,56,139,60,5)
 end
 if t_sugar>0 then
		draw_sugar(117,47,flr(t_sugar/5))
	end
	if t_bone>0 then
		draw_bone(131,47,flr(t_bone/5))
	end
	
	-- production
	if e_cauldron then
		local s = boiling>0 and 46 or 14
		local t0 = flr(t/6)
		spr(s,120,56,2,2,t0%2==0)
		
		pal(1,iron_colors[flr(iron/5)+1])
		if heating>0 then
			pal(13,t0%2==0 and 10 or 9)
		end
		spr(44,120,71,2,2)
		pal()
	end
	
	draw_mallows()
	
	if e_comp then
		if e_upgrades and (#upgrades>0 or phase==7) then
	 	spr(9+flr(t/5)%2,76,44)
	 else
	 	spr(11,76,44)
	 end
 end
 
 if phase>=8 then
 	if not e_leftroom then
 		spr(48,64,48)
 		spr(48,64,56)
 	end
 	if not e_rightroom then
 		spr(48,184,48)
 		spr(48,184,56)
 	end
 end
 
 draw_robots()
	
	if e_chemist then
		draw_chemist(164,70,true,true)
	end
 
	draw_chef(false,false)
	
 if mlayer>3 then
 	rectfill(114,102,140,110,0)
 	rect(114,102,140,110,13)
 end
 if money>0 then
	 print("$"..money,116,104,3)
	end
	
	if e_customers then
		draw_customers()
	end
	
	if debug then
		fillp(0b0011001111001100.1)
		draw_box(table_box,8)
		draw_box(sugar_box,8)
		draw_box(bone_box,8)
		draw_box(cauldron_box,9)
		draw_box(iron_box,8)
		draw_box(comp_box,8)
		fillp(0)
	end
	
	-- top display
	camera(0,0)
	-- news box
	if phase>7 then
 	rectfill(0,0,127,7,8)
 	line(0,7,127,7,2)
 	local t2=flr(t)
 	print(newsmsg,128-t2%256,1,14)
	end
	
	-- tip
	print(tip,tipx,9,14)
	
	-- special tutorial overlay
	if phase==0 then
		if p_u then
			print("�",68,9,10)
		end
		if p_d then
			print("�",76,9,10)
		end
		if p_l then
			print("�",84,9,10)
		end
		if p_r then
			print("�",92,9,10)
		end
	elseif phase==5 then
		print("�",106,9,flr((t/4)/2)%2==0 and 10 or 14)
	elseif phase==6 then
		print("�",96,9,flr((t/4)/2)%2==0 and 10 or 14)
	elseif phase==7 then
		print("buy factory at computer �",12,16,15)
	end
	
	draw_upgrades()
	
	if e_fadeout then
		fadecount+=1
		if fadecount<30 then
		elseif fadecount<75 then
 		pal(1,0,1)
 		pal(2,0,1)
 		pal(4,0,1)
 		pal(5,0,1)
 		
 		pal(3,5,1)
 		pal(6,5,1)
 		pal(8,5,1)
 		pal(9,5,1)
 		pal(13,5,1)
 		
 		pal(7,6,1)
 		pal(10,6,1)
 		pal(11,6,1)
 		pal(12,6,1)
 		pal(14,6,1)
 		pal(15,6,1)
 	elseif fadecount<110 then
 	 pal(1,0,1)
 		pal(2,0,1)
 		pal(4,0,1)
 		pal(5,0,1)
 		
 		pal(3,0,1)
 		pal(6,0,1)
 		pal(8,0,1)
 		pal(9,0,1)
 		pal(13,0,1)
 		
 		pal(7,5,1)
 		pal(10,5,1)
 		pal(11,5,1)
 		pal(12,5,1)
 		pal(14,5,1)
 		pal(15,5,1)
 	elseif fadecount<140 then
 	 cls()
 	else
 		state=2
 	end
	end
end
-->8
-- util

-- 0==nothing
-- 1==skip tutorial
-- 2==skip first customers
-- 3==skip to first ad
function skip_to(p,mo,ma)
 if p==0 then return end
	
	state=1
	local target
	if     p==1 then target=8
	elseif p==2 then target=10
	elseif p==3 then target=15
	elseif p==4 then target=20
	end
	
	local i
	for i=0,target do
		go_phase(i)
	end
	
	money=mo
	mallow=ma
end

function lerp(x,y,s)
 if s>0.95 then s=1 end
 if s<0.05 then s=0 end
	return x+(y-x)*s
end

function add_sugar(amt)
	t_sugar=min(t_sugar+amt,20)
end

function add_bone(amt)
	t_bone=min(t_bone+amt,20)
end

function allow_boil()
	return t_bone>0 and t_sugar>0 and iron<iron_max
end

function can_boil()
	return chef_in(cauldron_box) and allow_boil()
end

function boil()
 boiling=min(boiling+10,10)
end

function allow_bake()
	return iron>0 and mallow<540
end

function can_bake()
 return e_iron and chef_in(iron_box) and allow_bake()
end

function bake()
 heating=min(heating+10,10)
end

function can_comp()
	return chef_in(comp_box) and e_upgrades and (#upgrades>0 or phase==7)
end

function move_chef()
	moving=false
	if btn(0) then
		cx-=1
		moving=true
		cr=false
		p_l=true
	end
	if btn(1) then
		cx+=1
		moving=true
		cr=true
		p_r=true
	end
	if btn(2) then
		cy-=1
		moving=true
		p_u=true
	end
	if btn(3) then
		cy+=1
		moving=true
		p_d=true
	end
	--lock
	if cx<70 then
		cx=70
	end
	if cx>178 then
	 cx=178
	end
	if cy<34 then
		cy=34
	end
	if cy>96 then
		cy=96
	end
end

function draw_chef()
	local t3=flr(t/3)
	local t6=flr(t/6)
	if moving then
	 spr(7+t3%2,cx,cy,1,1,cr)
	else
		local sp=6
		
		if (chef_in(sugar_box) and e_sugar and not has_sugar)
		or (chef_in(bone_box) and e_bone and not has_bone) 
		or can_boil()
		or can_bake() 
		or can_comp() then
			sp = t6%2==0 and 6 or 13
		end
		
		spr(sp,cx,cy,1,1,cr)
	end
	
	if has_bone or has_sugar then
		local sp = has_bone and 5 or 25
		spr(sp,cx,cy-9,1,1,cr)
	end
end

--amt[0..4]
function draw_sugar(x,y,amt)
	spr(21+amt,x,y)
end

function draw_bone(x,y,amt)
	spr(1+amt,x,y)
end

function draw_box(box,c)
	rect(box[1],box[2],box[3]-1,box[4]-1,c)
end

function chef_in(box)
	local x = cx+4
	local y = cy+4
	return x >= box[1] and x < box[3] and y >= box[2] and y < box[4]
end

function draw_chemist(x,y,eb,ec)
	local t2=flr(t/3)
	local t4=flr(t/4)
	if eb then
		spr(77+t2%2,x,y-16)
		spr(93+t2%2,x,y-8)
	end
	if ec then
		spr(96+t4%4,x+9,y-10,1,1,true)
	end
end

function draw_mallow(x,y,f)
	spr(12,x,y)
	if f>0 then
		spr(16+flr(min(f,20)/5),x,y)
	end
end

function draw_mallows()
	local m=mallow
	local i=1
	local c
	while i<=#crate_locs do
		c = crate_locs[i]
		if m>0 then
			c[3] = 30
		end
		c[3] -= 1
		if c[3]>0 then 
			draw_mallow(c[1],c[2],m)
		else
			break
		end
		m=max(m-20,0)
		i+=1
	end
end

crate_locs={
 {124,89,0},
 {73,95,0},
 {83,95,0},
 {93,95,0},
 {103,95,0},
 {113,95,0},
 {175,95,0},
 {165,95,0},
 {155,95,0},
 {145,95,0},
 {135,95,0},
 {73,85,0},
 {83,85,0},
 {93,85,0},
 {103,85,0},
 {175,85,0},
 {165,85,0},
 {155,85,0},
 {145,85,0},
 {73,75,0},
 {83,75,0},
 {93,75,0},
 {103,75,0},
 {175,75,0},
 {165,75,0},
 {155,75,0},
 {145,75,0}
}

_prevbtn=nil
function click()
	local ret=false
 if btn(5) then
  ret=
  	_prevbtn==nil or 
  	_prevbtn==false
 end
 return ret
end
-->8
-- customers

customers={}

--chidlren
cdelta=150
ctime=0
cstop=126
e_children=true
--adults
adelta=75
atime=0
e_adults=false
arate=1000

function add_customer()
	if mallow>5 then
 	if ctime==0 and e_children then
 		local col=flr(rnd(2))%2==0 and 12 or 14
 		add(customers,
 			{
 				x=192+flr(rnd(15)),
 				p=40,
 				r=false,
 				c=col,
 				y=flr(rnd(7)),
 				s=26,
 				fat=false
 			})
 		ctime=cdelta
 		if atime==0 then
 			atime+=flr(adelta/2)
 		end
 		
 		if e_convert then
 			cdelta+=flr(cdelta/10)+1
 			if cdelta>200 then
 				e_children=false
 			end
 		end
 	end
 	
 	if atime==0 and e_adults then
 		local r1=flr(rnd(2))
 		local r2=flr(rnd(arate))
 		local sp
 		if r1==0 then
 			sp=r2!=0 and 64 or 83
 		else
 		 sp=r2!=0 and 80 or 88
 		end 
 		add(customers,
 		 {
 		 	x=192+flr(rnd(15)),
 		 	p=56,
 		 	r=false,
 		 	c=0,
 		 	y=flr(rnd(7)),
 		 	s=sp,
 		 	fat=r2==0
 		 })
 		atime=adelta
 		
 		if e_convert then
 			adelta+=flr(adelta/10)+1
 			if adelta>200 then
 				e_adults=false
 			end
 		end
 	end
	end
	
	if ctime>0 then ctime-=1 end
	if atime>0 then atime-=1 end
end

function update_customers()
	add_customer()

	-- update
	for c in all(customers) do
		if c.x>cstop then
			c.x-=0.5
		elseif c.x==cstop then
		 if c.p>0 then
		 	if mallow>0 then
 		 	c.p-=1
 		 	if c.p%8==0 then
  		 	mallow-=1
  		 	money+=cost
 		 	end
		 	end
		 else
		 	c.x-=1
		 end
		else
			c.x-=1
			if c.x<57 then
				c.r=true
			end
		end
	end
	
	-- cull
	local i=1
	while i<=#customers do
		if customers[i].r==true then
			del(customers,customers[i])
		else
			i+=1
		end
	end
end

function draw_customers()
 local t3=flr(t/3)
 local t6=flr(t/6)
 --todo:cry if paused
	for i = #customers,1,-1 do
		local c=customers[i]
		if c.c!=0 then 
			pal(12,c.c)
		else
			pal()
		end
	
		local spd=(c.x>cstop and t6 or t3)
		if not c.fat then
 		if e_convert and c.x<cstop then
 			spr(123,c.x,114+c.y+sin((c.x+c.y)/20))
 		elseif c.x!=cstop then
 			spr(c.s+1+spd%2,c.x,114+c.y)
 		else
 			spr(c.s,c.x,114+c.y)
 		end
 	else
 		if e_convert and c.x<cstop then
 		 spr(125,c.x,114+c.y+sin((c.x+c.y)/20))
 		else
  		if c.x!=cstop then
  		 spr(c.s+1+spd%4,c.x,114+c.y)
  		else
  			spr(c.s,c.x,114+c.y)
  		end
  		spr(c.s-16,c.x,106+c.y)
  	end
 	end
	end
	pal()
end
-->8
-- upgrades

e_upgrades=false
upgrades={}
e_usecomp=false
comp_row=1

function add_upgrade(name,cost,id)
 add(upgrades,{n=name,c=cost,i=id})
end

function purchase(id)
	if id==0 then
		enable_bot(1)
	elseif id==1 then
		enable_bot(2)
	elseif id==2 then
		e_adults=true
		go_phase(16)
	elseif id==3 then
		oven_output=2
		go_phase(18)
	elseif id==4 then
		enable_bot(3)
	elseif id==5 then
		enable_bot(4)
	elseif id==6 then
		cdelta=30
		adelta=40
		go_phase(22)
	elseif id==7 then
		cdelta=20
		adelta=25
		go_phase(24)
	elseif id==8 then
		robot_spd*=2
		oven_output+=1
		go_phase(26)
	elseif id==9 then
		oven_output+=1
		go_phase(26)
	elseif id==10 then
		go_phase(28)
	elseif id==11 then
		go_phase(30)
	elseif id==12 then
		go_phase(32)
	elseif id==13 then
		go_phase(34)
	elseif id==14 then
		go_phase(37)
	end
end

function update_upgrades()
 if not e_usecomp then return end
 
 if btnp(4) then
 	e_usecomp=false
 	comp_row=1
 end
 
 if #upgrades>0 then
 	local u = upgrades[comp_row]
  
  if btnp(5) and u.c<=money then
  	purchase(u.i)
  	money-=u.c
  	del(upgrades,u)
  else
  	if btnp(2) then
   	comp_row-=1	
   elseif btnp(3) then
   	comp_row+=1
   end
  end
 
	 comp_row=min(#upgrades,max(1,comp_row))
	end
end

function draw_upgrades()
 if not e_usecomp then return end

	local t8=flr(t/8)
 
 map(112,0,0,0,16,16)
 
	if #upgrades>0 then
  if t8%2==0 then
 	 spr(36,20,22+comp_row*6)
 	end
 end
	
	local offset=0
	for u in all(upgrades) do
		print(u.n,24,28+offset,6)
		if u.c>0 then
			print("$"..u.c,28+#u.n*4,28+offset,u.c>money and 2 or 11)
		else
			print("$???",28+#u.n*4,28+offset,11)
		end
		offset+=6
	end
	
	print("press 'z' to exit",41,87,14)
end

-->8
-- automatons

robot_anim={37,39,38,39}
function draw_robot(x,y,i,item)
 local t4=flr(t/4)
 if i then
 	spr(40+t4%4,x,y)
 else
	 spr(robot_anim[1+t4%4],x,y)
	 if item!=0 then
	 	spr(item,x,y-8)
	 end
	end
end

srobot_anim={56,58,57,58}
function draw_srobot(x,y,i)
	local t4=flr(t/4)
	if i then
 	spr(40+t4%4,x+2,y)
 else
	 spr(srobot_anim[1+t4%4],x,y)
	end	
end

robots={
 {e=false,x=0,y=0,sx=88,sy=40,tx=117,ty=55,s=0,idle=true,item=0},
 {e=false,x=0,y=0,sx=160,sy=40,tx=131,ty=55,s=0,idle=true,item=0},
 {e=false,x=134,y=61,idle=true},
 {e=false,x=135,y=78,idle=true},
}

function enable_bot(b)
	robots[b].e = true
end

function exe_delivery(bot,spd,item,do_work)
	local ret=false
	if bot.s==0 and bot.item==0 and do_work then
		bot.item=item
		bot.idle=false
	elseif not bot.idle then
		if bot.item!=0 then
			bot.s=min(bot.s+spd,1)
		else
			bot.s=max(bot.s-spd,0)
		end

		bot.x=lerp(bot.sx,bot.tx,bot.s)
		bot.y=lerp(bot.sy,bot.ty,bot.s)
	end
	
	if bot.item!=0 and bot.s==1 then
		bot.item=0
		ret = true
	elseif bot.item==0 and bot.s==0 then
	 bot.idle=true
	end
	
	return ret
end

function update_robots()
	if robots[1].e and exe_delivery(robots[1],robot_spd,25,t_sugar==0) then
		add_sugar(20)
	end
	if robots[2].e and exe_delivery(robots[2],robot_spd,5,t_bone==0) then
	 add_bone(20)
	end
	
	if robots[3].e then
		robots[3].idle = not allow_boil()	
		if not robots[3].idle then
			boil()
		end
	end
	
	if robots[4].e then
		robots[4].idle = not allow_bake()
		if not robots[4].idle then
			bake()
		end
	end
end

function draw_robots()
	for i=1,#robots do
		local r=robots[i]
		if r.e==true then
			if i<3 then
				draw_robot(r.x,r.y,r.idle,r.item)
			else
				draw_srobot(r.x,r.y,r.idle)
			end
		end
	end
end
-->8
-- closing

_starcolor=0
_mallowy=64
_time=0
_msg=""
_msgx=0
_msgtime=0
_msgcolor=0
_e_pop0=false
_popx=0
_e_pop1=false
_pop1x=0

function settext(msg)
	_msg=msg
	_msgx=64-(#msg*2)
	_msgtime=150
end

function updateclose()
		_time+=1
		if _time==5 then
			_starcolor=1
		elseif _time==35 then
			_starcolor=5
		elseif _time==65 then
			_starcolor=6
		elseif _time==90 then
			_starcolor=7
		end
		
		if _time<128 then
			if _time%2==0 then
				_mallowy-=1
			end
		end
		
		if _time==160 then
			settext("you've done it")
		elseif _time==340 then
			settext("but...")
		elseif _time==520 then
			_e_pop0=true
			settext("loneliness always wins")
		elseif _time==670 then
			_e_pop1=true
		elseif _time==700 then
			settext("mallow mallow mallow mallow")
		elseif _time==880 then
			settext("a ludum dare 40 jam game")
		elseif _time==1060 then
			settext("by loren 'thechemist' hoffman")
		elseif _time==1240 then
			settext("thank you for playing")
		elseif _time==1420 then
			settext("special thanks to:")
		elseif _time==1600 then
			settext("crusher4")
		elseif _time==1780 then
			settext("haxo leilas")
		elseif _time==1960 then
			settext("rogar")
		elseif _time==2140 then
			settext("ryder")
		elseif _time==2320 then
			settext("silvr")
		elseif _time==2500 then
			settext("pyrakra")
		end
		
		if _msgtime>120 then
			_msgcolor=5
		elseif _msgtime>90 then
			_msgcolor=6
		elseif _msgtime>60 then
			_msgcolor=14
		elseif _msgtime>30 then
			_msgcolor=6
		elseif _msgtime>0 then
			_msgcolor=5
		else
			_msgcolor=0
			_msg=""
		end
		_msgtime=max(_msgtime-1,0)
		
		if _e_pop0 then
			_popx+=1
		end
		
		if _e_pop1 then
			_pop1x+=1
		end
end

function drawclose()
	cls()
	camera(0,0)
	pal(7,_starcolor)
	map(0,0,0,_mallowy,16,16)
	map(0,0,0,-128+_mallowy,16,16)
	pal()
 map(16,0,0,84+_mallowy,16,16)
	
	local t3=flr(t/3)
	local t6=flr(t/6)	
	if _e_pop1 and _e_pop0 then
		spr(100+t3%5, 45,86)
	else
		spr(t6%2==0 and 6 or 13,45,85+_mallowy,1,1,_e_pop0)
	end
	draw_chemist(75,99+_mallowy,not _e_pop0,not _e_pop1)
	
	print(_msg,_msgx,60,_msgcolor)
	
	if _e_pop0 then
		local x=75+_popx
		local y=91+curve(_popx/24)*-25
		spr(125,x,y)
	end
	
	if _e_pop1 then
		local x=83+_pop1x
		local y=88+curve(_pop1x/16)*-35
		spr(124,x,y)
	end
end

function curve(x)
	return -((x-1)*(x-1))+1
end
__gfx__
00000000000000000000000000000000000000000000076000777700007777000077770009999900099999000999990044444444007777000000000000000000
000000000000000000000000000000000000000000000776004667700046677000466770933333909b3333909111119045555554004667700000088888800000
0000000000000000000000000000000000007760000077650008f8700008f8700008f870933333909333339091111190455555540008f8700008811111188000
000000000000000000000000000770000007760000077600000fff00000fff00000fff0093333390933333909111119041111114000fff000081111111111800
000000000000000000700000007760000077650000776500000fef00000fef00000fef0093333390933333909111119041111114005fe5000081111111111800
00000000000000007776000077765000777650007776500000565500005655000056550099998990999989909999899099999999000665000028811111188200
0000000067600000676000006760000067600000676000000006660000066600000666006565656065656560656565609aaaaaa9000666000002e811118e2000
00000000065000000650000006500000065000000650000000050500000500000000050006565656065656560656565699999999000505000002ee8118ee2000
00000000000000000000000000000000000677000000000000000000000000000000000000077700000000000000000000000000000000000002eeeeeeee2000
00000000000000000000000000077000007776700000000000000000000000000077700047777774000000000000000000000000000000000002eeeeeeee2000
000000000070000000767070007677700776777000000000000000000000040004444400544444450aa000000aa000000aa00000000000000002eeeeeeee2000
070000000777077007777770077777700777777000000000000000000055555005555550055555500dfa00000dfa00000dfa00000000000000002eeeeee20000
076776000767767007677670076776700767767000000000044400000444e4400444e4400444e4400ffa00000ffa00000ffa0000000000000000022222200000
000000000000000000000000000000000000000000000000044e4400044e4440044e4440044e4440fcfc0000fcfc0000fcfc0000000000000000000000000000
00000000000000000000000000000000000000000000e4400444e4400444e4400444e4400444e4400ccc00000ccc00000ccc0000000000000000000000000000
0000000000000000000000000000000000000000004e4400004e4400004e4400004e4400004e4400040400000004000004000000000000000000000000000000
6ddddddddddddd665555555005555555b00000006050060550600506060000600000000000000000000000000000000000000000000000000000000000000000
6d44444544444d6655555550055555550b0000000500005005000050050000500000000000000000000000000000000005555555555555500000088888800000
6d4ccc454ccc4d66555555500555555500b000000500005005000050050000500000000000000000000000000000000005555555555555500008867676788000
6d4cc44544cc4d6655555550055555550b00000000e66e0000e66e00009669000026620000266200002662000026620005555555555555500086776767667800
6d44442524444d665555555005555555b000000000666600006666000066660005c66c5005666650056666500566665005555555555555500087676677676800
6d4cc44544cc4d665555555005555555000000000065560000655600006556005066660550c66c05506666055066660505555555555555500028867766788200
6d4ccc454ccc4d66555555500555555500000000000000000000000000000000600000066000000660c00c066000000606666666666666600002e876768e2000
6d44444544444d6655555550055555550000000000000000000000000000000000000000000000000000000000c00c0006666555555666600002ee8778ee2000
5555555566666666666666600666666611111111bfbbbbb355555555555555550600000005000000000000000000000006666444444666600002eeee7eee2000
5555555566666666666666600666666611111111bbb3bb3b55555555555555550050000000500000065000000000000006666666666666600002eee7eeee2000
5555555566666666666666600666666611111111bb3bbb3b5555555555555555050500000605000000050000000000000661d1d1d1d1d6600002eee7eeee2000
5555555566666666666666600666666611111111fb3bfbbb55555555555555550000e66e0000e66e00009669000000000661d1d1d1d1d66000042ee7eee24000
5555555566666666666666600666666611111111bbbbbb3b555555555555555506056666050566660005666600000000066d1d1d1d1d16600009422272249000
5555555566666666666666600666666611111111bb3bb3bb555555555555555500506556005065560650655600000000066d1d1d1d1d16600000944744490000
5555555566666666666666600666666611111111b3bbb3bf55555055505555550500000006000000000000000000000006666666666666600000099799900000
5555555566666666666666600666666611111111b3bfbbbb55555055505555550000000000000000000000000000000006666666666666600000000070000000
09a9000009a9000009a9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaa0000aaaa0000aaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000060d00d0060d00d000000000
03f3000003f3000003f3000000000000000000000000000000000000000000000000000000000000000000000000000000000000065555500655555000000000
0fff00000fff00000fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000060d00d0060d00d000000000
0fef00000fef00000fef0000009a9000000000000000000000000000000000000004400000000000000000000000000000000000060d00d0060d00d000000000
0ccc00000ccc00000ccc00000aaaa000000000000000000000000000000000000045440000000000000000000000000000000000060900800609008000000000
fccf0000fccf0000fccf0000003f300000000000000000000000000000000000003f344000000000000000000000000000000000060000000600000000000000
04040000000400000400000000fff0000000000000000000000000000000000000fff544000000000000000000000000000000000600009a060000a900000000
00440000004400000044000000fef00000fef00000fef00000fef00000fef00000f8f05500f8f05500f8f05500f8f05500f8f055464449a946444a9a0d7777d0
04544000045440000454400000ccc00000ccc00000ccc00000ccc00000ccc00000eee00000eee00000eee00000eee00000eee00046544a94465449a4d777777d
03f3440403f3440403f34404fccccc500ccccc500ccccc500ccccc500ccccc50feeeee500eeeee500eeeee500eeeee500eeeee50465445444654454476777767
0fff54450fff54450fff54450cccf1500cccc1500cccc1500cccc1500cccc1500eeef2500eeee2500eeee2500eeee2500eeee250455454544554545467666676
0f8f05500f8f05500f8f05504c4c15004c4c15f04c4c1f004c4cf5004c4f15001e1e25001e1e25f01e1e2f001e1ef5001e1f2500444444444444444467777776
0eee00000eee00000eee0000414156004141560041415600414156004141560012125600121256001212560012125600121256004444444444444444d777767d
feef0000feef0000feef00005555616055556160555561605555616055556160555561605555616055556160555561605555616005000050050000500d7777d0
01010000000100000100000006000600060006000600060006000600060006000600060006000600060006000600060006000600050000500500005000dddd00
00800000000000008000000000000000007777000077770000777700007777000077770000000000000000000000000000000000000000000000000000000000
00066600800666000006660000866600004667700046677000466770004667700046677000000000000000000000000000000000000000000000000000000000
806aaa60006aaa60008aaa60006aaa600008f8700008f8700008f8700008f8700008f87000000000000000000000000000000000000000000000000000000000
00066600008666000006660080066600000cfc00000fff00000fff00000fff00000fff0000000000000000000000000000000000000000000000000000000000
0c5fef000c5fef0c0c5fef000c5fef0c000fef00000cec00000fef00000fef00000fef0000000000000000000000000000000000000000000000000000000000
0d06665c0d0666500d06665c0d0666500056665000566650005c6c50005666500056665000000000000000000000000000000000000000000000000000000000
02066600200666000206660000266600000c6c000006660000066600000c6c000006660000000000000000000000000000000000000000000000000000000000
0005050000050500000505000005050000050500000c0c000005050000050500000c0c0000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777700007777000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777770077777700000000000000000
00070000000000000000000000000000007000000000070000000000000000000000000000000000000000000077700006777760767777670000000000000000
00000000000000000000000000000000000000000000000000700000000007000007000000000000000000000766670007666670776666770000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000777770007777770777777770000000000000000
00000000000000700000000007000000000000000000000000000000000000000000000000700000000000000777770007777770777777770000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d777d000d7777d00d7777d00000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ddd00000dddd0000dddd000000000000000000
ffffffffffffffff333333335633333333333365f55555555555555f563333333333336555555555333333330000000000000000000000000000000000000000
fffffffff66666df3333333356333333333333655566666666666655563333333333336566666666333333330000000000000000000000000000000000000000
fffffffff688885f3333333356333333333333655663333333333665563333333333336533333333333333330000000000000000000000000000000000000000
fffffffff688885f3333333356333333333333655633333333333365563333333333336533333333333333330000000000000000000000000000000000000000
fffffffff688885f3333333356333333333333655633333333333365563333333333336533333333333333330000000000000000000000000000000000000000
fffffffff688885f3333333356633333333336655633333333333365563333333333336533333333333333330000000000000000000000000000000000000000
fffffffffd55555f3333333355666666666666555633333333333365563333333333336533333333666666660000000000000000000000000000000000000000
ffffffff4444444433333333f55555555555555f5633333333333365563333333333336533333333555555550000000000000000000000000000000000000000
0000777777770000ffffffffffffffffffffffff7777777777777777777777777777777700000000000000000000000000000000000000000000000000000000
0077ffffffff7700ffffffffffffffffffffffffffffffffffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000
07ffffffffffff70fffffffffffffffffffffffffffffffffffff8cabf88fff8fff88fff00000000000000000000000000000000000000000000000000000000
0ffffffffffffff04ffffffffffffff4ffffffffffffffffffff8cabff8f8f8f8f8fffff00000000000000000000000000000000000000000000000000000000
7ffffffffffffff75ffffffffffffff5fffffffffffffffffff8cabfff88ff8f8ff8ffff00000000000000000000000000000000000000000000000000000000
ffffffffffffffff54ffffffffffff45ffffffffffffffffff8cabffff8fff8f8fff8fff00000000000000000000000000000000000000000000000000000000
ffffffffffffffff5544ffffffff4455fffffffffffffffff8cabfffff8ffff8ff88ffff00000000000000000000000000000000000000000000000000000000
ffffffffffffffff555544444444555544444444ffffffffffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000
88000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000088
80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000066666666666666666600000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000666666677777777777777777766666666600000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000666666777777777777777777777777777777777666600000000000000000000000000000000
00000000000000000000000000000000000000000066666666666777777777777777777777777777777777777777777666000000000000000000000000000000
00000000000000000000000000000000000000066667777777777777777777777777777777777777777777777777777776600000000000000000000000000000
00000000000000000000000000000000000000667777777777777777777777777777777777777777777777777777777777600000000000000000000000000000
00000000000000000000000000000000000666777777777777777777777777777777777777777777777777777777777777600000000000000000000000000000
00000000000000000000000000000000666677777777777777777777777777777777777777777777777777777777777777760000000000000000000000000000
00000000000000000000000000000006667777777777777777777777777777777777777777777777777777777777777777760000000000000000000000000000
00000000000000000000000000000066677777777777777777777777777777777777777777777777777777777777777777760000000000000000000000000000
00000000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777766000000000000000000000000000
00000000000000000000000000066777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000000
00000000000000000000000000667777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000000
00000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000000
00000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777777766000000000000000000000000000
00000000000000000000000006677777777777777777777777777777777777777777777777777777777777777777777777666000000000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777776676000000000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777666776600000000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777766677777600000000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777666666666677777777600000000000000000000000000
00000000000000000000000006677777777777777777777777777777777777777777777777777666666777777777777777777600000000000000000000000000
00000000000000000000000006666777777777777777777777777777777777777777777776666677777777777777777777777760000000000000000000000000
00000000000000000000000066776667777777777777777777777777777777777777666667777777777777777777777777777760000000000000000000000000
00000000000000000000000067777766667777777777777777777777777776666666777777777777777777777777777777777760000000000000000000000000
00000000000000000000000067777777776666677777777777777777666667777777777777777777777777777777777777777766000000000000000000000000
00000000000000000000000067777777777777766666666666666666777777777777777777777777777777777777777777777776000000000000000000000000
00000000000000000000000067777777777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000
00000000000000000000000067777777777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000
00000000000000000000000067777777777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000
00000000000000000000000067777777777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000
00000000000000000000000067777777777777777777777777777777777777777777777777777777777777777777777777777776000000000000000000000000
00000000000000000000000067777777777777777777777777777777777777777777777777777777777777777777777777777776600000000000000000000000
00000000000000000000000066777777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000006777777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000006677777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777777777777600000000000000000000000
00000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777777777777760000000000000000000000
00000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777777777777760000000000000000000000
80000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777777777777760000000000000000000008
88000000000000000000000000677777777777777777777777777777777777777777777777777777777777777777777777777777760000000000000000000088

__gff__
0000000000000000000000000000000000000000000000000000000000000000040404040000000000000000000000000404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
7400007974007500757979000077740000000000a4a5a6a7a8a9aaabac000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00747300757979757900007300770071000000b3b4b5b5b6b7b9babbbc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0b0b0b0b0b0b0b0b0b0b0b0b0b000
00737500707500000000737977007100000000c3c4c5c6c7c8c9cacbcc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000909697989595959595959595959100
00007279760070727700757973790000000000d3d4d5d6d7d8d9dadbdc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808589898989898989898989868000
70730000737775000070757700797572000000e3e4e5e6e7e8e9eaebeced0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808782828282828282828282888000
00730073700000757300700000737175000000f3f4f5f6f7f8f9fafbfcfd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808782828282828282828282888000
0075770079777400007979007400007100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808782828282828282828282888000
00790000697a0069697577757100750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808782828282828282828282888000
7474740073740079697000007173700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808782828282828282828282888000
7370770000760074760076770000737000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808782828282828282828282888000
0000740079007300000079000070790000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000808782828282828282828282888000
737479760000707376007900007900730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080838a8a8a8a8a8a8a8a8a8a848000
0000000076767674747700007376000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000929494949494949494949494819300
7973007300767300007700007600760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7700700000000000740077007000007300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0074767979007970000079000073760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7900790079000000007700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000030302200233030303030302200233030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303030303030313200333131313131313200333130303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303131313130343434343434343434343434343430313131313000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303434343431343434343434343434343434343431343434343000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303434343434343434343434343434343434343434343434343000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303434343430343434343434343434343434343430343434343000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303434343430343434343434343434343434343430343434343000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303434343430343434343434343434343434343430343434343000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000303030303030343434343434343434343434343430303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000313131313130343434343434343434343434343430313131313100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000353535353530303030303036303037303030303030353535353500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000353535353531313131313131202131313131313131353535353500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000353535353535353535353535353535353535353535353535353500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000811008110071100711005110031100111006100031050110504105031050110202102011020110203102011020110200102001020010200102001020010200102001020010200102001020010200102
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

