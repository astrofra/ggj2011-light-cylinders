/*
	File: C:/works/ggj2011/ggj2011/light_cyl/scripts/camera.nut
	Author: Syl_Fra_Mat
*/

/*!
	@short	GameCamera
	@author	Syl_Fra_Mat
*/
class	GameCamera
{

	scene = 0
	player_item	=	0
	player_pos	=	0
	player_rot	=	0
	player_pos_lerp = 0
	/*!
		@short	OnUpdate
		Called during the scene update, each frame.
	*/
	function	OnUpdate(item)
	{
		player_pos	=	ItemGetPosition(player_item)
		player_rot	=	ItemGetRotation(player_item)

		player_pos_lerp = player_pos_lerp.Lerp(0.9, player_pos) 
		ItemSetPosition(item, player_pos_lerp)
		ItemSetRotation(item, player_rot)
	}

	/*!
		@short	OnSetup
		Called when the item is about to be setup.
	*/
	function	OnSetup(item)
	{
		scene = ItemGetScene(item)
		player_item = SceneFindItem(scene, "player")
		player_pos_lerp = ItemGetPosition(player_item)

	}
}
