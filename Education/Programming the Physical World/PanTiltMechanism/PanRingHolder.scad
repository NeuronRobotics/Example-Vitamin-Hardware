use <CameraMount.scad>
use <TiltRingHolder.scad>
use <../../../hardware/Vitamins/Actuators/StandardServo/StandardServo_Vitamin.scad>
use <../../../hardware/Vitamins/Structural/SealedBearings/SealedBearing608_Vitamin.scad>
use <../../../hardware/Vitamins/Sensors/Camera/QuickCam_STX.scad>

function getPanRingRadius(3dPrinterTolerance=.4) = getRingRadius(3dPrinterTolerance)+getCamerabarWidth();

module mainPanRing(3dPrinterTolerance=.4){
	intersection(){
		translate([0,-getPanRingRadius(3dPrinterTolerance),-.5]){
				cube([getPanRingRadius(3dPrinterTolerance)*2,getPanRingRadius(3dPrinterTolerance)*2,getCamerabarThickness()+1]);
		}
		translate([0,0,getCamerabarThickness()/2]){
			difference(){
				sphere(getPanRingRadius(3dPrinterTolerance));
				sphere(getRingRadius(3dPrinterTolerance)+2);
			}
		}
	}
	
	
	//Bearing brick
	translate([0,
	           getPanRingRadius(3dPrinterTolerance),
	           getCamerabarThickness()/2]){
		rotate([90,90,0]){
			cylinder(	h=getCamerabarWidth(),				//
						r=getCamerabarThickness()/2, 	// 
						center=false);
		}
	}
	//Servo Brick
	translate([0,
	           -(getPanRingRadius(3dPrinterTolerance)-getCamerabarWidth() ),
	           getCamerabarThickness()/2]){
		rotate([90,90,0]){
			translate([	-getCamerabarThickness()/2,
			           	-getCamerabarThickness()/2-5,
						1]){
						
						cube([	getCamerabarThickness(),
								StandardServoLength(),
								StandardServoBoltHeight()+5]);
			}
		}
	}
}

module panRingHolder(3dPrinterTolerance=.4){
	
	difference(){
		mainPanRing(3dPrinterTolerance);
		placePanBearing(3dPrinterTolerance){
			608BallBearing(3dPrinterTolerance);		
		}
		#cameraPanServo(3dPrinterTolerance, 0);
	}
}

panRingHolder();
tiltRing(.3);
cameraTiltBar();