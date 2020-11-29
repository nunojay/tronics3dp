include <ProbeTipCoverLib.scad>;

// Build it!
// Note: InnerDiameter should be 4.7 - 4.8, but it simply doesn't fit,
// maybe something with my printer.
ProbeTipCover(
        InnerDiameter = 5.00,
        BodyLength = 7.10,
        ConeLength = 2.50,
        TipLength = 0.60,
        TipHoleDiameter = 0.90
);
