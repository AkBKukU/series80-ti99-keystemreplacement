module splitWedge(w=3,l=30,h=1.2)
{
	shape_wedge(w,10,h,w,0.1,1,1);

	translate([0,10,0])
	rotate([0,0,180])
	shape_wedge(w,10,h,w,0.1,1,1);

	translate([0,30,0])
	rotate([0,0,180])
	shape_wedge(w,50,0.75,w,0.1,1,1);
}


module shape_wedge(x1,y1,z,x2,y2,x2p = 0.5,y2p = 0.5)
{
	x = (x1-x2) * (x2p - 0.5);
	y = (y1-y2) * (y2p - 0.5);
	points = [
		[x1/2,y1/2,0],  // 0
		[x1/2,-y1/2,0], // 1
		[-x1/2,-y1/2,0],// 2
		[-x1/2,y1/2,0], // 3

		[(x2)/2+x,(y2)/2+y,z],  // 4
		[(x2)/2+x,-(y2)/2+y,z], // 5
		[-(x2)/2+x,-(y2)/2+y,z],// 6
		[-(x2)/2+x,(y2)/2+y,z], // 7
	];

	faces = [
		[3,2,1,0],
		[6,5,1,2],
		[7,6,2,3],
		[4,7,3,0],
		[5,4,0,1],
		[4,5,6,7]
	];

	polyhedron( points, faces );
}


splitWedge();
