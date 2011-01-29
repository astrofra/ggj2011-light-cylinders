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
	spawn_sfx	=	0
	/*!
		@short	OnUpdate
		Called each frame.
	*/
	function	OnUpdate(scene)
	{}

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
	}

	function	SpawnSfx()
	{
		MixerSoundStart(EngineGetMixer(g_engine), spawn_sfx)
	}
}
