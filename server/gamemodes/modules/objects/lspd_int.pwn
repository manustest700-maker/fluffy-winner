// =============================================================================
// Havana RP -- LSPD custom interior (corf_pd_* set from launcher data pack
// orp_objects_03: 4795 corf_door_stat, 4796 corf_pd_allwalls, 4797 corf_pd_alpha,
// 4798 corf_pd_props1, 4799 corf_pd_props2, 4800 corf_signlspd, 4803 corf_pd_props3)
//
// This object set shares a single scene origin, so every piece is spawned at the
// SAME world position/rotation to reassemble the interior. Placed high above the
// in-game LSPD (no script placement existed for it -- exploratory linkage so the
// owner can locate it via /golspd, then we anchor the real entrance).
// Origin: (1554.8755, -1675.6212, 1300.0)
// =============================================================================
{
    new tmpobjid;
    #pragma unused tmpobjid
    tmpobjid = CreateDynamicObjectEx(4796, 1554.875500, -1675.621200, 1300.000000, 0.000000, 0.000000, 0.000000, 400.00, 400.00);
    tmpobjid = CreateDynamicObjectEx(4797, 1554.875500, -1675.621200, 1300.000000, 0.000000, 0.000000, 0.000000, 400.00, 400.00);
    tmpobjid = CreateDynamicObjectEx(4795, 1554.875500, -1675.621200, 1300.000000, 0.000000, 0.000000, 0.000000, 400.00, 400.00);
    tmpobjid = CreateDynamicObjectEx(4798, 1554.875500, -1675.621200, 1300.000000, 0.000000, 0.000000, 0.000000, 400.00, 400.00);
    tmpobjid = CreateDynamicObjectEx(4799, 1554.875500, -1675.621200, 1300.000000, 0.000000, 0.000000, 0.000000, 400.00, 400.00);
    tmpobjid = CreateDynamicObjectEx(4803, 1554.875500, -1675.621200, 1300.000000, 0.000000, 0.000000, 0.000000, 400.00, 400.00);
    tmpobjid = CreateDynamicObjectEx(4800, 1554.875500, -1675.621200, 1300.000000, 0.000000, 0.000000, 0.000000, 400.00, 400.00);
}
