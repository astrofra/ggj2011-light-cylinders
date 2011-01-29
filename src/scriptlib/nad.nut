/*
	GameStart SQUIRREL binding API.
	Copyright 2010 Emmanuel Julien.
*/

try
{	__DEFINE_NENGINE_LIBRARY__ = 1;	}
catch(e)
{
	__DEFINE_NENGINE_LIBRARY__ <- 1;

	Include("scriptlib/vector.nut");
	Include("scriptlib/vector2.nut");
	Include("scriptlib/rect.nut");
	Include("scriptlib/matrix.nut");
	Include("scriptlib/math.nut");
	Include("scriptlib/minmax.nut");
	Include("scriptlib/io.nut");
	Include("scriptlib/ui.nut");
	Include("scriptlib/timeout_handler.nut");
	Include("scriptlib/helper.nut");
	Include("scriptlib/project.nut");
	Include("scriptlib/billboard.nut");

	// OO wrapper API.
	Include("scriptlib/oo/oo.nut");
}
