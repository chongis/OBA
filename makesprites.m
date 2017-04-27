% make sprites used for the experiment
global width;
global height;
width = 50;
height = 50;
% Transition token sprites
cgmakesprite(61,500,500,1,1,1);
cgsetsprite(61);
cgloadbmp(61, 'Images/section1.bmp');

cgmakesprite(62,500,500,0,0,0);
cgsetsprite(62);
cgloadbmp(62,'Images/inst1.bmp');

cgmakesprite(63,500,500,0,0,0);
cgsetsprite(63);
cgloadbmp(63,'Images/inst2.bmp');

cgmakesprite(64,500,500,0,0,0);
cgsetsprite(64);
cgloadbmp(64,'Images/inst3.bmp');

cgmakesprite(65,500,500,0,0,0);
cgsetsprite(65);
cgloadbmp(65,'Images/inst4.bmp');
% Half token sprites
% First token triangle
cgmakesprite(101,width,height,0,0,0);
cgsetsprite(101);
cgloadbmp(101,'Images/first_token_left.bmp');

cgmakesprite(102,width,height,0,0,0);
cgsetsprite(102);
cgloadbmp(102,'Images/first_token_right.bmp');

cgmakesprite(103,width,height,0,0,0);
cgsetsprite(103);
cgloadbmp(103,'Images/first_token_both.bmp');

% Second Token rectangle
cgmakesprite(201,width,height,0,0,0);
cgsetsprite(201);
cgloadbmp(201,'Images/second_token_left.bmp');

cgmakesprite(202,width,height,0,0,0);
cgsetsprite(202);
cgloadbmp(202,'Images/second_token_right.bmp');

cgmakesprite(203,width,height,0,0,0);
cgsetsprite(203);
cgloadbmp(203,'Images/second_token_both.bmp');

% Third token circle
cgmakesprite(301,width,height,0,0,0);
cgsetsprite(301);
cgloadbmp(301,'Images/third_token_left.bmp');

cgmakesprite(302,width,height,0,0,0);
cgsetsprite(302);
cgloadbmp(302,'Images/third_token_right.bmp');

% White Noise
cgmakesprite(5,width,height,0,0,0);
cgsetsprite(5);
cgloadbmp(5,'Images/whitenoise.bmp');

% White Screen
cgmakesprite(123,500,500,1,1,1);
cgsetsprite(123);
cgloadbmp(123,'Images/white.bmp');

% Distractor
cgmakesprite(303,500,500,0,0,0);
cgsetsprite(303);
cgloadbmp(303,'Images/dist.bmp');

% Dollar
cgmakesprite(469,500,500,0,0,0);
cgsetsprite(469);
cgloadbmp(469,'Images/dollar.bmp');

cgmakesprite(470,500,500,0,0,0);
cgsetsprite(470);
cgloadbmp(470,'Images/dollar.bmp');

% Target
cgmakesprite(1,500,500,0,0,0);
cgsetsprite(1);
cgloadbmp(1,'Images/target.bmp');

% Distractors
cgmakesprite(2,500,500,0,0,0);
cgsetsprite(2);
cgloadbmp(2,'Images/distractor1.bmp');

cgmakesprite(3,500,500,0,0,0);
cgsetsprite(3);
cgloadbmp(3,'Images/distractor2.bmp');

cgmakesprite(4,500,500,0,0,0);
cgsetsprite(4);
cgloadbmp(4,'Images/distractor3.bmp');

% Black bar
cgmakesprite(812,500,500,0,0,0);
cgsetsprite(812);
cgloadbmp(812,'Images/bar.bmp');

% Fixation Cross
cgmakesprite(444,500,500,0,0,0);
cgsetsprite(444);
cgloadbmp(444,'Images/fixationcross.bmp');

% Greek Symbols
cgmakesprite(104,500,500,0,0,0);
cgsetsprite(104);
cgloadbmp(104,'Images/alpha.bmp');

cgmakesprite(204,500,500,0,0,0);
cgsetsprite(204);
cgloadbmp(204,'Images/beta.bmp');

cgmakesprite(304,1000,1000,0,0,0);
cgsetsprite(304);
cgloadbmp(304,'Images/gamma.bmp');

% Incorrect

cgmakesprite(105,500,500,0,0,0);
cgsetsprite(105);
cgloadbmp(105,'Images/alpha2.bmp');

cgmakesprite(205,500,500,0,0,0);
cgsetsprite(205);
cgloadbmp(205,'Images/beta2.bmp');

cgmakesprite(305,500,500,0,0,0);
cgsetsprite(305);
cgloadbmp(305,'Images/gamma2.bmp');

% Correct

cgmakesprite(106,500,500,0,0,0);
cgsetsprite(106);
cgloadbmp(106,'Images/alpha3.bmp');

cgmakesprite(206,500,500,0,0,0);
cgsetsprite(206);
cgloadbmp(206,'Images/beta3.bmp');

cgmakesprite(306,500,500,0,0,0);
cgsetsprite(306);
cgloadbmp(306,'Images/gamma3.bmp');

% line
cgmakesprite(1000,500,500,0,0,0);
cgsetsprite(1000);
cgloadbmp(1000,'Images/line.bmp');

% line_green (for feedback)
cgmakesprite(999,500,500,0,0,0);
cgsetsprite(999);
cgloadbmp(999,'Images/line_green.bmp')

% Active
cgmakesprite(777,500,500,0,0,0);
cgsetsprite(777);
cgloadbmp(777,'Images/active.bmp');

% Inactive
cgmakesprite(778,500,500,0,0,0);
cgsetsprite(778);
cgloadbmp(778,'Images/inactive.bmp');

% Part 1 Instructions
cgmakesprite(1001,500,500,0,0,0);
cgsetsprite(1001);
cgloadbmp(1001,'Images/Slide1.bmp');

cgmakesprite(1002,500,500,0,0,0);
cgsetsprite(1002);
cgloadbmp(1002,'Images/Slide2.bmp');

cgmakesprite(1003,500,500,0,0,0);
cgsetsprite(1003);
cgloadbmp(1003,'Images/Slide3.bmp');

cgmakesprite(1004,500,500,0,0,0);
cgsetsprite(1004);
cgloadbmp(1004,'Images/Slide4.bmp');
