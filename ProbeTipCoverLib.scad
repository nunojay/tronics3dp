////////////////////////////////////////////////////////////////
// Scope probe tip protection
// By Nuno João from https://EmbeddedDreams.com
// Released 2020 under Creative Commons 3.0
//
// This creates a cover to protect a scope's probe tip from
// shorting to nearby components when probing a board.
// Scope probes include this accessory, but it can be lost,
// and is tipically larger than I would like them to be...
//


// Parameter defaults are for Rigol RP2200 probes.
module ProbeTipCover (
        InnerDiameter = 5.00,
        BodyLength = 7.10,
        ConeLength = 2.50,
        TipLength = 0.00,
        TipHoleDiameter = 0.90,
        WallThickness = 0.4
)  {
    // Precalcs and other constants
    cType = 0;
    cHeight = 1;
    cDiameter = 2;
    cPreviousDiameter = 3;
    cSmoothness = 70;

    // Tip definition, by vertical segments. Types:
    //  0: cylinder
    //  1: cone, a linear transition between 2 adjacent segments
    //  2: flat, diameter is a center hole's diameter
    cSegments = [
    //  type  height       in/hole-diam      prevDiam
        [ 0,  BodyLength,  InnerDiameter                   ],
        [ 1,  ConeLength,  TipHoleDiameter,  InnerDiameter ],
        [ 0,   TipLength,  TipHoleDiameter                 ],
    ];

    // OpenSCAD's stupid concept of "variable" forces me to this (and more):
    function GetBaseHeight(idx) =
        idx < 0 ?
            0 :
            (cSegments[idx][cHeight] + GetBaseHeight(idx - 1));

    limit = len(cSegments) - 1;
    for (idx = [0 : limit])  {
        section = cSegments[idx];
        type = section[cType];
        height = section[cHeight];
        diameter = section[cDiameter];
        fn = cSmoothness;

        if (height > 0.0)  {
            if (type == 0)  {
                translate([0, 0, GetBaseHeight(idx-1)])
                    difference()  {
                        cylinder(h = height+0.006, d = diameter + WallThickness*2, $fn=fn);
                        translate([0, 0, -0.01])
                            cylinder(h = height * 0.01 + 0.02, d = diameter, $fn=fn);
                            cylinder(h = height + 0.02, d = diameter, $fn=fn);
                    }
            }
            else if (type == 1)  {
                prevDiam = section[cPreviousDiameter];
                outDiam = diameter + WallThickness*2;
                outPrevDiam = prevDiam + WallThickness*2;
                translate([0, 0, GetBaseHeight(idx-1)])
                    difference()  {
                        cylinder(h = height+0.006, d1 = outPrevDiam, d2 = outDiam, $fn=fn);
                        translate([0, 0, -0.01])
                            cylinder(h = height + 0.02, d1 = prevDiam,
                                                        d2 = diameter, $fn=fn);
                    }
            }
            else if (type == 2)  {
                holeDiam = section[cDiameter2];
                echo("hole diam: ", holeDiam);
                translate([0, 0, GetBaseHeight(idx-1) - WallThickness])
                    difference()  {
                        // The flat top slab
                        cylinder(h = WallThickness+0.006, d = diameter + 0.6, $fn=fn);
                        // Hole in the center
                        translate([0, 0, -0.005])
                            cylinder(h = WallThickness*2 + 0.01, d = holeDiam, $fn=fn);
                    }
            }
            else  {
                echo("***** UPS!! Unkonwn type!");
            }
        }
    }
}


/// Test
//ProbeTipCover();

