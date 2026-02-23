extends Node

#region Time/Ticks
var current_tick : int = 0
@warning_ignore("unused_signal")
signal time_advance_tick
#endregion

#region Maps/Map Transitions
signal map_transition(new_map : Map, trans_point : MapTransitionPoint)
#endregion
