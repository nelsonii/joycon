include <BOSL/constants.scad>
use <BOSL/shapes.scad>

//JoyConForXBAC_PackOfGumStyle

fileVersion = "1B";

caseWidthX = 35;
caseDepthY = 80;
caseHeightZ = 18;
wallThickness = 3;
overlap = 1; // overlap ensures that subtractions go beyond the edges

stickScrewDiameter = 1.6; // M1.6 screw for attaching stick to case
breakoutScrewDiameter = 3; // M3 Screw (any head type)

caseScrewDiameter = 3; // M3 
caseScrewHeight = 12; // M3-12 mushroom head hex screw
caseScrewHeadDiameter = 5.25; // M3
caseScrewHeadHeight = 1.5; // M3 

emboss = true; // optional labels on case (inside and out)
includeCaseMounts = true; 
includeComponents = false; // optional component models, usually not included in print

  
$fn=60; //circle smoothness
  
difference(){
  union() {
    difference(){
      
      //base
      //rounded cuboid is from the BOSL library
      //I'm using p1 setting to zero bottom (z). X/Y are centered on 0,0,0
      color("steelblue")
      cuboid([caseWidthX,caseDepthY,caseHeightZ], fillet=4, 
       p1=[-(caseWidthX/2), -(caseDepthY/2), 0]);
      
      //subtract out the inner cuboid
      cuboid([caseWidthX-wallThickness,caseDepthY-wallThickness,caseHeightZ-wallThickness], fillet=4, 
       p1=[-((caseWidthX-wallThickness)/2), -((caseDepthY-wallThickness)/2), (wallThickness/2)]);
      
      //subtract out the hole for the joystick
      color("pink")
       translate([0,-16,(caseHeightZ-wallThickness-overlap)])
        cylinder( h=10 , d=15, center=true); //can't be less than 14.75, otherwise cap of stick won't fit.
      
      if (emboss) {
        //emboss version on inside case (bottom)
        color("whitesmoke")
         translate([-5, -18, 1])
          linear_extrude(2)
           text(fileVersion, size=5);
        //emboss version on inside case (top)
        mirror([1,0,0]) // since this is "upside down, inside" we mirror the text
         color ("whitesmoke")
          translate([-5,11, caseHeightZ-wallThickness])
           linear_extrude(2)
            text(fileVersion, size=5);
        /*
        //emboss port info on outside of case
        color("whitesmoke")
         translate([-5, 25, caseHeightZ - 1]) 
          linear_extrude(2)
           text("USB", size=5);
        */
      }
    }//difference (base)

    //riser for micro pro board
    color("purple")
     translate([-5,5,0])
      cube([10, 30, 3]);
   
    //bumper for micro pro board -- endstop
    color("violet")
     translate([-4.5, 3, 0])  
      cube([9, 2, 5]);
    //bumpers for micro pro board -- lower side
    color("violet")
     translate([-11.25, 7, 0]) 
      cube([2,5,5]);
    color("violet")
     translate([9.25, 7, 0]) 
      cube([2,5,5]);
    //bumpers for micro pro board -- upper side
    color("violet")
     translate([-11.25, 34, 1.5]) 
      cube([2,5,3.5]);
    color("violet")
     translate([9.25, 34, 1.5]) 
      cube([2,5,3.5]);

    /*
    //orientation pin (toward front -- +y)
    //include this early on to keep track of which way is up. :-)
    color("olivedrab")
     translate([0,18,caseHeightZ-wallThickness+1])
      cylinder(h=1, d=2, center=true);
    */

    //mounting bars for joystick
    color("lime") //horz
     translate([-11, -30, caseHeightZ-wallThickness-1])
      cube([23, 4, 4]);
    color("lime") //vert
     translate([8.5, -30, caseHeightZ-wallThickness-1])
      cube([4, 25, 4]);
      
    //mount for joystick breakout board
    color("greenyellow")
     translate([-5, -35, caseHeightZ-wallThickness-6])
      cube([5,5,9]);

    if (includeCaseMounts) {
      //case screw mounts -- near joystick
      color("gold")
       translate([-12-2.5, -18.5, 1])
        cube([5,5,caseHeightZ-2]);
      color("gold")
       translate([+12-2.5, -18.5, 1])
        cube([5,5,caseHeightZ-2]);
      //case screw mount countersink strengthener
      color("PeachPuff")
       translate([-12-3, -20, 1])
        cube([7,8,wallThickness-1]);
      color("PeachPuff")
       translate([+12-4, -20, 1])
        cube([7,8,wallThickness-1]);
      //case screw mounts -- near mcu --------------------------------
      color("gold")
       translate([-12-2.5, +14.5, 1])
        cube([5,5,caseHeightZ-2]);
      color("gold")
       translate([+12-2.5, +14.5, 1])
        cube([5,5,caseHeightZ-2]);
      //case screw mount countersink strengthener
      color("PeachPuff")
       translate([-12-3, +13, 1])
        cube([7,8,wallThickness-1]);
      color("PeachPuff")
       translate([+12-4, +13, 1])
        cube([7,8,wallThickness-1]);
    }//includeCaseMounts

    if (includeComponents) {

    }//includeComponents
    
  }//union
  
  // Start of Difference stuff

  //USB Micro cable outlet
  color("coral")
   translate([-4.0, 35, 4.75])
    cube([8, (wallThickness*2), 4]);

  //screw holes for mounting joystick (inside upper lid)
  color("orange") //horz
   translate([-6.625, -27.5, caseHeightZ-wallThickness-4.5])
    cylinder(h=6, d=stickScrewDiameter);
  color("orange") //vert
   translate([9.75, -8.75, caseHeightZ-wallThickness-4.5])
    cylinder(h=6, d=stickScrewDiameter);
  
  //screw hole for mounting joystick breakout board (inside upper lid)
  color("orange")
   translate([-2.5, -32.5, caseHeightZ-wallThickness-7])
    cylinder(h=8, d=breakoutScrewDiameter);

  //carve out inside intersection of joystick mounting bars
  color("coral")
   translate([8.25, -25.75, caseHeightZ-wallThickness-4.5])
    cylinder(h=6, d=2);


  if (includeCaseMounts) {
    //screw hole for case (goes through bottom of case) -- near joystick
    color("tomato")
     translate([-12, -16, -overlap])
      cylinder(h=caseHeightZ, d=caseScrewDiameter);
    color("tomato")
     translate([+12, -16, -overlap])
      cylinder(h=caseHeightZ, d=caseScrewDiameter);
    //countersink
    color("darkorange")
     translate([-12, -16, -overlap])
      cylinder(h=caseScrewHeadHeight+overlap, d=caseScrewHeadDiameter);
    color("darkorange")
     translate([+12, -16, -overlap])  
      cylinder(h=caseScrewHeadHeight+overlap, d=caseScrewHeadDiameter);
    //screw hole for case (goes through bottom of case) -- near mcu
    color("tomato")
     translate([-12, +17, -overlap])
      cylinder(h=caseHeightZ, d=caseScrewDiameter);
    color("tomato")
     translate([+12, +17, -overlap])
      cylinder(h=caseHeightZ, d=caseScrewDiameter);
    //countersink
    color("darkorange")
     translate([-12, +17, -overlap])
      cylinder(h=caseScrewHeadHeight+overlap, d=caseScrewHeadDiameter);
    color("darkorange")
     translate([+12, +17, -overlap])  
      cylinder(h=caseScrewHeadHeight+overlap, d=caseScrewHeadDiameter);
  }//includeCaseMounts
 
  //-------------------------------------------------------------------------------------------------------

  splitAtZ=8.7; //size this so the hole for the usb is all on the bottom part (easier printing)
  
  //remove the top for split
  color("crimson")  translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);
  // ******* OR ******
  //Remove everything but the top
  //color("crimson") translate([-((caseWidthX+overlap)/2),-((caseDepthY+overlap)/2),splitAtZ-caseHeightZ])  cube([caseWidthX+overlap, caseDepthY+overlap, caseHeightZ+overlap]);

  //-------------------------------------------------------------------------------------------------------
  
  
}//difference
  