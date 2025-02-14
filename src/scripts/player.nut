/*
	File: C:/works/ggj2011/ggj2011/light_cyl/scripts/player.nut
	Author: Syl_Fra_Mat
*/

/*!
	@short	player
	@author	Syl_Fra_Mat
*/

g_current_cyl	<-	0

class	Player
{

	render	=	0
	euler	=	0
	acc		=	0
	scene	=	0

	old_mx	=	0
	old_my	=	0

	mx		=	0
	my		=	0

	pos		=	0

	teleport_timeout	=	0

	teleport_sfx		=	0
	sfx_target_no_ok	=	0
	sfx_target_ok		=	0

	y_offset			=	1.0

	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{
		//KeyboardUpdate()
		MouseUpdate()

		old_mx = mx
		old_my = my
		mx = MousePoolFunction(DeviceAxisX)
		my = MousePoolFunction(DeviceAxisY)

		acc = Vector(0, 0, 0)
		euler = item.rotation() + Vector(my - old_my, mx - old_mx, 0) * Deg(0.006)

		if	(euler.x < Deg(-30))
			euler.x = Deg(-30)
		if	(euler.x > Deg(35))
			euler.x = Deg(35)
		item.setRotation(euler)

		local	player_matrix, player_front
		player_matrix = ItemGetRotationMatrix(item)
		player_front = player_matrix.GetRow(2)
		pos	= ItemGetWorldPosition(item)

		//RendererDrawLine(EngineGetRenderer(g_engine), pos, pos + player_front.Scale(Mtr(5.0)))

		local	hit
		hit	=	SceneCollisionRaytrace(scene, pos + player_front.Scale(Mtr(2.0)), player_front, -1, CollisionTraceAll, Mtr(100.0))
		
		if (hit.hit)
		{
			if (ItemGetName(hit.item) == "cylinder")
			{
				local	_color 
				if ((ItemGetWorldPosition(item).y + Mtr(1.5)) < GetCylinderTopPosition(hit.item).y)
					_color = Vector(1,0,0,1)
				else
					_color = Vector(0,1,0,1)

				RendererDrawCrossColored(EngineGetRenderer(g_engine), hit.p, _color)

				if (MousePoolFunction(DeviceButton0))
					TeleportTo(item, hit.item)
			}
		}

		StickOnCylinderTop(item)

		local	altitude = (ItemGetWorldPosition(item).y * 5).tointeger()
		SceneGetScriptInstance(scene).UpdateTimeout(altitude)
	}

	function	StickOnCylinderTop(item)
	{
		pos = ItemGetWorldPosition(item)
		local	hit = SceneCollisionRaytrace(scene, pos , Vector(0, -1, 0), -1, CollisionTraceAll, Mtr(5.0))
		if (hit.hit)
		{
			pos.y = GetCylinderTopPosition(hit.item).y
			ItemSetPosition(item, pos)
		}
	}

	function	TeleportTo(item, target_item)
	{

		if ((ItemGetWorldPosition(item).y + Mtr(1.5)) < GetCylinderTopPosition(target_item).y)
		{			
			MixerSoundStart(EngineGetMixer(g_engine), sfx_target_no_ok)
			return
		}

		if (g_clock - teleport_timeout < SecToTick(Sec(0.5)))
			return

		local	new_pos = GetCylinderTopPosition(target_item)

		MixerSoundStart(EngineGetMixer(g_engine), sfx_target_ok)
		MixerSoundStart(EngineGetMixer(g_engine), teleport_sfx)

		ItemSetPosition(item, new_pos)

		g_current_cyl = target_item
		teleport_timeout = g_clock
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		print("Player::OnSetup()")
		scene = ItemGetScene(item)
		teleport_timeout = g_clock

		teleport_sfx = EngineLoadSound(g_engine, "sfx/tp.wav")
		sfx_target_no_ok = EngineLoadSound(g_engine, "sfx/target_no_ok.wav")
		sfx_target_ok = EngineLoadSound(g_engine, "sfx/target_ok.wav")
	}

	function	GetCylinderTopPosition(item_cyl)
	{
		return (ItemGetWorldPosition(item_cyl) + Vector(0,Mtr(5.0),0) + Vector(0, Mtr(y_offset), 0))
	}
}
