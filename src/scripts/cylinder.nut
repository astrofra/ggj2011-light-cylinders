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
	pos	=	0
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{
		pos += Vector(0,Mtr(1.0), 0).Scale(0.5 * g_dt_frame)
		ItemSetPosition(item, pos)
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
