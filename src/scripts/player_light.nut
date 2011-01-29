/*
	File: C:/works/ggj2011/ggj2011/light_cyl/scripts/player_light.nut
	Author: Syl_Fra_Mat
*/

/*!
	@short	PlayerLight
	@author	Syl_Fra_Mat
*/
class	PlayerLight
{
	pos			=	0
	rand_pos	=	0
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{

		rand_pos = rand_pos.Lerp(0.9,  Vector(Rand(-2,2),Rand(-2,2),Rand(-2,2)))
		ItemSetPosition(item, pos + rand_pos)
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		pos = ItemGetPosition(item)
		rand_pos = Vector(0,0,0)
	}
}
