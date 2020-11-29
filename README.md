# 3D Printable Oscilloscope Probe Tip Protector

OpenSCAD implementation of parametric tip protector for scope probes. This is an accessory that is usually bundled with probes, but they're tiny and prone to be lost and, above all in my experience, a little bit too bulky for some tight spaces since they have a section with larger diameter than the probe.

There's one one (OpenSCAD) module to build the protector, ProbeTipProtection(), in ProbeTipProtectLib.scad . Then there are other files with names specific to the probe in question (there are several size probes), which invoke ProbeTipProtection() with appropriate parameters.

The STL output files for 2 protector models (with and without a long tip sleeve) are included, for Rigol's RP220 probes, ready to be sliced and printed.

In the image below we have at the top the original protector and a few of the protectors without the long tip sleeve.

![SDCard wallets](./images/ProbeTipProtect.jpg)

Product development is a set of think - design - print - test iterations.

![Development leftovers](./images/ProbeTipProtect-Development.jpg)


# Printing Guidelines

Printing should be done with *no* supports, using the "spiral" mode of your slicer.
Printing parameters depends alot on your slicer, printer and filament. In my tests I have used Slic3r (Ultimakercura didn't work for this, does not spiralize all layers), Creality Ender 3 Pro and [Tucab's Fil3D PLA 4032D](https://www.tucab.pt/en/Fil-3D/Filamentos-3D-PLA) filament.

Before the first use, insert once the probe's tip into the protector hole from the outside, to finish the hole opening. Otherwise you risk rupturing the protector at the tip.

Have fun :)
