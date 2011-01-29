/*
	File: C:/works/ggj2011/ggj2011/light_cyl/scripts/cylinder.nut
	Author: Syl_Fra_Mat
*/

/*!
	@short	Cylinder
	@author	Syl_Fra_Mat
*/
class	Cylinder
{
	pos		=	0
	life	=	Sec(5.0)
	speed	=	1.0
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{
		pos += Vector(0,Mtr(1.0), 0).Scale(0.5 * g_dt_frame * speed)
		ItemSetPosition(item, pos)

		if (g_current_cyl != 0)
		{
				if (ItemCompare(g_current_cyl, item))
				{
				//	Player is on cylinder
				life -= g_dt_frame
				print("Cylinder::OnUpdate() life = " + life)

				if (life > 1.0)
				{
					ItemSetAlpha(item, 1.0)
				}
				else
				{
					speed = Clamp(life, 0.0, 1.0)
					ItemSetAlpha(item, speed)
				}
				//
			}
		}
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		pos = ItemGetPosition(item)
	}
}
