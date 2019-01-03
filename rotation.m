% Function that displays a few rotations, to show
% that these do not particularly seem to improve the
% quality of the images
function rotation(a)

% Rotate by -20 and +20 degrees
rotationAngles = [-0.35, 0.35];
rot1 = im_rotate(a, rotationAngles(1));
rot2 = im_rotate(a); % Rotates around the main axis
rot3 = im_rotate(a, rotationAngles(2));
rot4 = im_rotate(rot2,1.57); % Rotates rot2 by 90 degrees, to make the images straight

figure(10); show(rot1);
figure(11); show(rot2);
figure(12); show(rot3);
figure(13); show(rot4);
showfigs;