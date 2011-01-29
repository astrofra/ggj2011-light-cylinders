/*
	File: C:/works/ggj2011/ggj2011/light_cyl/scripts/main_scene.nut
	Author: Syl_Fra_Mat
*/

/*!
	@short	MainScene
	@author	Syl_Fra_Mat
*/
class	MainScene
{
	spawn_sfx			=	0
	cyl_base			=	0
	spawn_timeout		=	0
	current_col_pos		=	0

	/*!
		@short	OnUpdate
		Called each frame.
	*/
	function	OnUpdate(scene)
	{
		if (g_clock - spawn_timeout < SecToTick(Sec(1.0)))
			return

		local	new_pos	=	current_col_pos + Vector(Rand(-5, 5), Rand(-1.5, -0.5), Rand(3,6))
		local	i

		for (i = 0; i < 3; i++)
		{
			local	new_cyl = SceneDuplicateItem(scene, cyl_base)
			ItemSetPosition(new_cyl, new_pos + Vector(Rand(-15, 15), Rand(-2.5, 2.5), Rand(-1,1)))
			ItemSetup(new_cyl)
			ItemSetupScript(new_cyl)
		}

		current_col_pos = new_pos
		spawn_timeout = g_clock
	}

	/*!
		@short	OnSetup
		Called when the scene is about to be setup.
	*/
	function	OnSetup(scene)
	{
		print("MainScene::OnSetup()")
		SceneSetCurrentCamera(scene, ItemCastToCamera(SceneFindItem(scene, "game_camera")))
		spawn_sfx = EngineLoadSound(g_engine, "sfx/spawn.wav")
		SpawnSfx()

		cyl_base = SceneFindItem(scene, "cylinder")
		current_col_pos = ItemGetPosition(cyl_base)
		spawn_timeout = g_clock
	}

	function	SpawnSfx()
	{
		MixerSoundStart(EngineGetMixer(g_engine), spawn_sfx)
	}
}
