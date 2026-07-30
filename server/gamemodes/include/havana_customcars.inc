// =============================================================================
//  havana_customcars.inc
// -----------------------------------------------------------------------------
//  Custom-vehicle (ONLINERP launcher) support for arabonline.pwn.
//
//  IMPORTANT: sending a model id to a client whose launcher pack does not
//  contain that model CRASHES the client (mass "timeout" disconnects).
//  Therefore any launcher id (>611) NOT explicitly whitelisted in
//  g_HavanaCars is created as HAVANA_DEFAULT_BASE (stock Sultan) so no
//  client ever receives an unknown model id.
//
//  To make a launcher car actually display, verify the id exists in the
//  players' launcher pack, then add a row { launcher_id, launcher_id } to
//  g_HavanaCars: Custom_GetBaseModel() then returns the second column and
//  vehiclesIdFix.so lets CreateVehicle() accept it directly.
// =============================================================================

#if defined _havana_customcars_included
    #endinput
#endif
#define _havana_customcars_included

// Vehicle pool size (SA-MP 0.3.7 default is 2000). Kept self-contained so this
// include does not depend on the MAX_VEHICLES define order in the gamemode.
#if !defined HAVANA_MAX_VEHICLES
    #define HAVANA_MAX_VEHICLES (2000)
#endif

// SA-MP vehicle stream-in RPC (server -> client, WorldVehicleAdd). Layout:
// UINT16 vehicleid, UINT32 modelid, ... - the model id is the UINT32 field
// right after the (UINT16) vehicle id.
#if !defined HAVANA_RPC_VEHICLE_STREAM_IN
    #define HAVANA_RPC_VEHICLE_STREAM_IN (164)
#endif

// Default base model (a valid stock SA-MP vehicle, 400..611) used server-side
// for ANY launcher id that is not explicitly listed in g_HavanaCars below.
// The client never sees it - it is rewritten to the launcher id on stream-in -
// it only drives the physics/collision. 560 (Sultan) is a safe 4-seat sedan.
#if !defined HAVANA_DEFAULT_BASE
    #define HAVANA_DEFAULT_BASE (560)
#endif

// ---------------------------------------------------------------------------
//  Launcher catalogue: each row is { LAUNCHER_ID, BASE_MODEL }.
//  LAUNCHER_ID : the id shown in the ONLINERP launcher (may be > 611).
//  BASE_MODEL  : a valid stock SA-MP vehicle id (400..611) used server-side.
//
//  Example (fill with the real IDs from your launcher pack):
//      { 15851, 439 },   // launcher car 15851 -> base Stallion (439)
//      { 15555, 560 },   // launcher car 15555 -> base Sultan   (560)
//
//  NOTE: a single sentinel row keeps the array non-empty so it always
//        compiles even before the real table is filled in.
// ---------------------------------------------------------------------------
//  OPTIONAL per-car overrides. Any launcher id NOT listed here automatically
//  uses HAVANA_DEFAULT_BASE for physics, and its display model falls back to
//  the stock base model (display = 0) unless it is explicitly mapped. This avoids
//  sending an unrecognised high ID to the client and crashing it.
new const g_HavanaCars [ ] [ 2 ] =
{
    // HavanaRP launcher pack catalogue (232 cars: 666, 15750..15980).
    // { launcher_id, model_to_create }: ids listed here are created directly
    // (vehiclesIdFix.so); any other id > 611 falls back to HAVANA_DEFAULT_BASE.
    { 666, 666 },
    { 15750, 15750 },
    { 15751, 15751 },
    { 15752, 15752 },
    { 15753, 15753 },
    { 15754, 15754 },
    { 15755, 15755 },
    { 15756, 15756 },
    { 15757, 15757 },
    { 15758, 15758 },
    { 15759, 15759 },
    { 15760, 15760 },
    { 15761, 15761 },
    { 15762, 15762 },
    { 15763, 15763 },
    { 15764, 15764 },
    { 15765, 15765 },
    { 15766, 15766 },
    { 15767, 15767 },
    { 15768, 15768 },
    { 15769, 15769 },
    { 15770, 15770 },
    { 15771, 15771 },
    { 15772, 15772 },
    { 15773, 15773 },
    { 15774, 15774 },
    { 15775, 15775 },
    { 15776, 15776 },
    { 15777, 15777 },
    { 15778, 15778 },
    { 15779, 15779 },
    { 15780, 15780 },
    { 15781, 15781 },
    { 15782, 15782 },
    { 15783, 15783 },
    { 15784, 15784 },
    { 15785, 15785 },
    { 15786, 15786 },
    { 15787, 15787 },
    { 15788, 15788 },
    { 15789, 15789 },
    { 15790, 15790 },
    { 15791, 15791 },
    { 15792, 15792 },
    { 15793, 15793 },
    { 15794, 15794 },
    { 15795, 15795 },
    { 15796, 15796 },
    { 15797, 15797 },
    { 15798, 15798 },
    { 15799, 15799 },
    { 15800, 15800 },
    { 15801, 15801 },
    { 15802, 15802 },
    { 15803, 15803 },
    { 15804, 15804 },
    { 15805, 15805 },
    { 15806, 15806 },
    { 15807, 15807 },
    { 15808, 15808 },
    { 15809, 15809 },
    { 15810, 15810 },
    { 15811, 15811 },
    { 15812, 15812 },
    { 15813, 15813 },
    { 15814, 15814 },
    { 15815, 15815 },
    { 15816, 15816 },
    { 15817, 15817 },
    { 15818, 15818 },
    { 15819, 15819 },
    { 15820, 15820 },
    { 15821, 15821 },
    { 15822, 15822 },
    { 15823, 15823 },
    { 15824, 15824 },
    { 15825, 15825 },
    { 15826, 15826 },
    { 15827, 15827 },
    { 15828, 15828 },
    { 15829, 15829 },
    { 15830, 15830 },
    { 15831, 15831 },
    { 15832, 15832 },
    { 15833, 15833 },
    { 15834, 15834 },
    { 15835, 15835 },
    { 15836, 15836 },
    { 15837, 15837 },
    { 15838, 15838 },
    { 15839, 15839 },
    { 15840, 15840 },
    { 15841, 15841 },
    { 15842, 15842 },
    { 15843, 15843 },
    { 15844, 15844 },
    { 15845, 15845 },
    { 15846, 15846 },
    { 15847, 15847 },
    { 15848, 15848 },
    { 15849, 15849 },
    { 15850, 15850 },
    { 15851, 15851 },
    { 15852, 15852 },
    { 15853, 15853 },
    { 15854, 15854 },
    { 15855, 15855 },
    { 15856, 15856 },
    { 15857, 15857 },
    { 15858, 15858 },
    { 15859, 15859 },
    { 15860, 15860 },
    { 15861, 15861 },
    { 15862, 15862 },
    { 15863, 15863 },
    { 15864, 15864 },
    { 15865, 15865 },
    { 15866, 15866 },
    { 15867, 15867 },
    { 15868, 15868 },
    { 15869, 15869 },
    { 15870, 15870 },
    { 15871, 15871 },
    { 15872, 15872 },
    { 15873, 15873 },
    { 15874, 15874 },
    { 15875, 15875 },
    { 15876, 15876 },
    { 15877, 15877 },
    { 15878, 15878 },
    { 15879, 15879 },
    { 15880, 15880 },
    { 15881, 15881 },
    { 15882, 15882 },
    { 15883, 15883 },
    { 15884, 15884 },
    { 15885, 15885 },
    { 15886, 15886 },
    { 15887, 15887 },
    { 15888, 15888 },
    { 15889, 15889 },
    { 15890, 15890 },
    { 15891, 15891 },
    { 15892, 15892 },
    { 15893, 15893 },
    { 15894, 15894 },
    { 15895, 15895 },
    { 15896, 15896 },
    { 15897, 15897 },
    { 15898, 15898 },
    { 15899, 15899 },
    { 15900, 15900 },
    { 15901, 15901 },
    { 15902, 15902 },
    { 15903, 15903 },
    { 15904, 15904 },
    { 15905, 15905 },
    { 15906, 15906 },
    { 15907, 15907 },
    { 15908, 15908 },
    { 15909, 15909 },
    { 15910, 15910 },
    { 15911, 15911 },
    { 15912, 15912 },
    { 15913, 15913 },
    { 15914, 15914 },
    { 15915, 15915 },
    { 15916, 15916 },
    { 15917, 15917 },
    { 15918, 15918 },
    { 15919, 15919 },
    { 15920, 15920 },
    { 15921, 15921 },
    { 15922, 15922 },
    { 15923, 15923 },
    { 15924, 15924 },
    { 15925, 15925 },
    { 15926, 15926 },
    { 15927, 15927 },
    { 15928, 15928 },
    { 15929, 15929 },
    { 15930, 15930 },
    { 15931, 15931 },
    { 15932, 15932 },
    { 15933, 15933 },
    { 15934, 15934 },
    { 15935, 15935 },
    { 15936, 15936 },
    { 15937, 15937 },
    { 15938, 15938 },
    { 15939, 15939 },
    { 15940, 15940 },
    { 15941, 15941 },
    { 15942, 15942 },
    { 15943, 15943 },
    { 15944, 15944 },
    { 15945, 15945 },
    { 15946, 15946 },
    { 15947, 15947 },
    { 15948, 15948 },
    { 15949, 15949 },
    { 15950, 15950 },
    { 15951, 15951 },
    { 15952, 15952 },
    { 15953, 15953 },
    { 15954, 15954 },
    { 15955, 15955 },
    { 15956, 15956 },
    { 15957, 15957 },
    { 15958, 15958 },
    { 15959, 15959 },
    { 15960, 15960 },
    { 15961, 15961 },
    { 15962, 15962 },
    { 15963, 15963 },
    { 15964, 15964 },
    { 15965, 15965 },
    { 15966, 15966 },
    { 15967, 15967 },
    { 15968, 15968 },
    { 15969, 15969 },
    { 15970, 15970 },
    { 15971, 15971 },
    { 15972, 15972 },
    { 15973, 15973 },
    { 15974, 15974 },
    { 15975, 15975 },
    { 15976, 15976 },
    { 15977, 15977 },
    { 15978, 15978 },
    { 15979, 15979 },
    { 15980, 15980 },
    { -1, -1 }        // sentinel
};

// Per-vehicle launcher model to display (0 = stock vehicle, no rewrite).
static g_HavanaDisplayModel [ HAVANA_MAX_VEHICLES ] ;

// Returns the catalogue row index for a launcher id, or -1 if not found.
stock Havana_FindLauncher ( modelid )
{
    for ( new i = 0 ; i < sizeof ( g_HavanaCars ) ; i ++ )
    {
        if ( g_HavanaCars [ i ] [ 0 ] <= 0 ) continue ;
        if ( g_HavanaCars [ i ] [ 0 ] == modelid ) return i ;
    }
    return -1 ;
}

// Returns the model id CreateVehicle() should be called with.
// vehiclesIdFix.so lets the server create launcher ids (>611) natively, so
// the requested id is returned unchanged unless an explicit override row
// exists in g_HavanaCars.
stock Custom_GetBaseModel ( modelid )
{
    new i = Havana_FindLauncher ( modelid ) ;
    if ( i != -1 ) return g_HavanaCars [ i ] [ 1 ] ;
    if ( modelid > 611 ) return HAVANA_DEFAULT_BASE ;
    return modelid ;
}

// Returns the launcher model that must be rewritten into the stream-in RPC,
// or 0 for no rewrite. Launcher cars are now created directly with their
// real model id (vehiclesIdFix), so a rewrite is only needed for ids that
// were explicitly substituted with a base model via g_HavanaCars.
stock Custom_GetDisplayModel ( modelid )
{
    // Whitelisted launcher ids are created directly with their real model id,
    // so the client already receives the right model: no RPC rewrite, ever.
    #pragma unused modelid
    return 0 ;
}

// True when the id can be spawned: a stock 400..611 id or a known launcher id.
stock Custom_IsValidVehicleID ( modelid )
{
    if ( modelid >= 400 && modelid <= 611 ) return 1 ;
    if ( modelid > 611 && modelid <= 65535 ) return 1 ;  // any launcher id (UINT16)
    return 0 ;
}

// Record (or clear) the launcher model to display for a freshly created vehicle.
stock Custom_SetDisplayModel ( vehicleid, requestedmodel )
{
    if ( vehicleid < 1 || vehicleid > HAVANA_MAX_VEHICLES ) return 0 ;
    g_HavanaDisplayModel [ vehicleid - 1 ] = Custom_GetDisplayModel ( requestedmodel ) ;
    if ( requestedmodel > 611 )
        printf ( "[HAVANA] vehicle %d requested model %d -> created as %d",
                 vehicleid, requestedmodel, GetVehicleModel ( vehicleid ) ) ;
    return 1 ;
}

stock Custom_ClearDisplayModel ( vehicleid )
{
    if ( vehicleid < 1 || vehicleid > HAVANA_MAX_VEHICLES ) return 0 ;
    g_HavanaDisplayModel [ vehicleid - 1 ] = 0 ;
    return 1 ;
}

// Launcher model recorded for a live vehicle (0 = stock vehicle).
stock Custom_GetVehicleDisplayModel ( vehicleid )
{
    if ( vehicleid < 1 || vehicleid > HAVANA_MAX_VEHICLES ) return 0 ;
    return g_HavanaDisplayModel [ vehicleid - 1 ] ;
}

// Kept for backward compatibility with the previous stub.
stock Custom_RegisterDefaultCatalog ( )
{
    return 1 ;
}

// NOTE: the OnOutcomingRPC stream-in rewrite hook was removed. Launcher cars
// are created directly with their real model id (vehiclesIdFix.so), so no
// packet rewriting is ever needed. The hook ran on every vehicle stream-in
// for every player and caused long-callback stalls.
