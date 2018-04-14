module keyStem(o = 8.22, i = 7, h = 19.2,b = 0.5, bw=2.6, bh=2.3, s = 1.75, m = 10, mt = 1.25 )
{	difference() {
	union() {


		squareTube(o=o,i=i,h=h);


		/* // Just get rid of strain relief
		translate([o/2-bw/2-(o-i)/2,-o,-h])
			cube([(o-i)/2,o*3,h+m-mt]);
		//translate([o/2+bw/2,-o,-h])
		//	cube([(o-i)/2,o*3,h+m-mt]);
		*/

		translate([o/2,-b/2,bh/2])
			lockingTab(b*3,b,bw,bh);

		translate([o/2,o+b/2,bh/2])
		rotate([0,0,180])
			lockingTab(b*3,b,bw,bh);

		translate([o/2,o/2,m-mt/2])
			innerCorners(o=i, i=o-2,h=mt);

		translate([(o-i)/2,(o-i)/2,m-mt])
			squareTube(o=i,i=i-0.5,h=mt);

		translate([o/2,o/2,m])
		rotate([0,0,90])
			splitBar(l=i, w=s,h=mt*2);

		// Extra lip for added strength
		translate([-1.5/2,-1.5/2,h])
			topLip(o,i,1.5,1);
		}
	translate([o/2,o/2,h*0.75+1.1])
		shape_wedge(x1=0.01,y1=0.01,z=h/4,x2=o,y2=o,x2p = 0.5,y2p = 0.5);
}}

module topLip(o=10,i=9,lw=1, lh =1)
{
	squareTube(i=i,o=o+lw,h=lh);
}

module lockingTab(s = 50,b = 1, w = 3, h=3)
{union () {
	// Top Removable wedge
	shape_wedge(x1=w,y1=b,z=h/2,x2=w,y2=0.1,x2p = 1,y2p = 1);

	// Bottom removal only top cube
	//translate([-w/2,-b/2,0])
		//cube([w,b,h/2]);

	rotate([0,180,0])
	//translate([0,-s,0])
		shape_wedge(x1=w,y1=b,z=h/2,x2=w,y2=0.1,x2p = 1,y2p = 1);
}}


module innerCorners(o=9,i=8,h=2)
{difference() {
	cube([o,o,h],true);

	translate([0,0,-h/2])
	rotate([0,0,45])
		cube([i,i,h*3],true);
}}

module splitBar(l = 10, w = 2,h=2)
{	rotate([180,0,0])
	shape_wedge(x1=l,y1=w,z=h,x2=l*0.8,y2=0.1,x2p = 0.5,y2p = 0.5);
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


module squareTube(i = 9, o = 10, h = 20)
{difference() {
	cube([o,o,h]);

	translate([(o-i)/2,(o-i)/2,-h/2])
		cube([i,i,h*2]);

}}



keyStem();
