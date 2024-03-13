//
// NESS V8.1.2
//
// Spawn sample onEnter, version 2
//
// If you want to use pseudo-heartbeats and do not already have an area onEnter
// script, you can use this one.  Otherwise, just add Spawn_OnAreaEnter() to
// your existing onEnter handler.  Note that you use this (and
// SpawnOnAreaExit()) INSTEAD OF Spawn() / spawn_sample_hb.
//

#include "spawn_functions"

void main()
{
  // Spawn_OnAreaEnter() can take three arguments - the name of the heartbeat
  // script to execute, the heartbeat duration, and a delay for the first
  // heartbeat.  They default to spawn_sample_hb, 6.0, and 0.0 respectively; as
  // if it were called like:
  // Spawn_OnAreaEnter( "spawn_sample_hb", 6.0, 0.0 );

  if ( GetIsAreaAboveGround( OBJECT_SELF ) &&
    ! GetIsAreaNatural( OBJECT_SELF ) )
  {
    // Indoors - no delay on the first HB
    Spawn_OnAreaEnter( "spawn_sample_hb", 10.0 );
  }

  else
  {
    // Outdoors or underground - do a 3 second delay on the first HB
    Spawn_OnAreaEnter( "spawn_sample_hb", 10.0, 3.0 );
  }
}