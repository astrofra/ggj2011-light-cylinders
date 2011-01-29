/*
	File: C:/works/ggj2011/ggj2011/light_cyl/scripts/player.nut
	Author: Syl_Fra_Mat
*/

/*!
	@short	player
	@author	Syl_Fra_Mat
*/
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
				RendererDrawCross(EngineGetRenderer(g_engine), hit.p)

				if (MousePoolFunction(DeviceButton0))
					TeleportTo(item, hit.item)
			}
		}
	}

	function	TeleportTo(item, target_item)
	{
		if (g_clock - teleport_timeout < SecToTick(Sec(0.5)))
			return

		local	new_pos = ItemGetWorldPosition(target_item)
		new_pos.y += Mtr(5.5)

		ItemSetPosition(item, new_pos)
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
	}
}
