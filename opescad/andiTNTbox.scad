// AUTHOR: Kaname Muroya
// CONTACT: info@avatify.com
// this is an opensource project, under the licencing terms of GNU, MIT


//---------------------------------------------------------
// CONFIG FÜR ANDI
//---------------------------------------------------------
seite = 80;    // kantenlänge des ganzen in mm
platteDicke = 3; // dicke der Platte in mm
toothTolerance = -0.45; // negativ for press fit in mm

schriftgroesse = platteDicke;
schriftart = "Minecrafter";
//---------------------------------------------------------

baseArea = [seite,seite]; // damit es ein quadratisches würfel ist
frontArea = [seite,seite];// damit es ein quadratisches würfel ist
numZahn = 7;    //anzahl der verzahnung = größe der verzahung,
breite=7;

module toothwork(kanteLaenge,begin){
    toothLength = kanteLaenge/numZahn; // odd numbers
    //echo(toothLength);
    numTooth = kanteLaenge/toothLength;
    translate([(-toothLength) *begin,0]){
       for (i=[begin:numTooth/2]) {
               translate([ toothLength*i*2 - toothTolerance/2*begin,0]) square([toothLength + toothTolerance*begin,platteDicke]);
       }
    }
}

module front(){
   difference(){
      square(frontArea);
      translate([0,-0.1])  toothwork(frontArea[0],0);
      translate([platteDicke + 0.1,0]) rotate(90) toothwork(frontArea[0],0);
      translate([frontArea[0],0]) rotate(90) toothwork(frontArea[0],0);
      translate([0,frontArea[0] - platteDicke + 0.1]) toothwork(frontArea[0],0);
   }
}
//front();
module base(){
   difference(){
      square(baseArea);
      translate([0,-0.1])  toothwork(baseArea[0],1);
      translate([platteDicke + 0.1,0]) rotate(90) toothwork(baseArea[1],1);
      translate([baseArea[0],0]) rotate(90) toothwork(baseArea[1],1);
      translate([0,baseArea[1] - platteDicke + 0.1]) toothwork(baseArea[0],1);
   }
}
//base();
module side(){
   difference(){
      square(baseArea);
       translate([0,-0.1])  toothwork(baseArea[0],0);
      translate([platteDicke + 0.1,0]) rotate(90) toothwork(baseArea[1],1);
      translate([baseArea[0],0]) rotate(90) toothwork(baseArea[1],1);
      translate([0,baseArea[1] - platteDicke + 0.1]) toothwork(baseArea[0],0);
   }
}
//side();

module tnt(){
    difference(){
        base();
        translate([platteDicke*2,platteDicke*2]) text("TOP", schriftgroesse, schriftart);
    }

    translate([baseArea[0] + 1,baseArea[1] + 1]) difference(){
         side();
        translate([platteDicke*2,platteDicke*2]) text("LEFT", schriftgroesse, schriftart);
    }

    translate([0,baseArea[1] + 1]) difference() {
        base(); // licht
        translate([platteDicke*2,platteDicke*2]) text("BOTTOM", schriftgroesse, schriftart);
    }

    translate([baseArea[0] + 1,0]) difference(){
        side();
        translate([platteDicke*2,platteDicke*2]) text("RIGHT", schriftgroesse, schriftart);
    };

    translate([0,-baseArea[0]]) difference(){
        front();
        translate([platteDicke*2,platteDicke*2]) text("FRONT", schriftgroesse, schriftart);
    };

    translate([baseArea[0] + 1,-baseArea[0] - 1]) difference(){
        front();
        translate([platteDicke*2,platteDicke*2]) text("BACK", schriftgroesse, schriftart);

    };
}
tnt();

