function [hPlane,sPlane,iPlane,hsi] = hsiImage(f)

f = im2double(f);

rPlane = f(:,:,1);
gPlane = f(:,:,2);
bPlane = f(:,:,3);

th = acos((0.5*((rPlane-gPlane)+(rPlane-bPlane)))./((sqrt((rPlane-gPlane).^2+(rPlane-bPlane).*(gPlane-bPlane)))+eps));
hPlane = th;
hPlane(bPlane>gPlane) = 2*pi-hPlane(bPlane>gPlane);
hPlane = hPlane/(2*pi);
sPlane = 1-3.*(min(min(rPlane,gPlane),bPlane))./(rPlane+gPlane+bPlane+eps);
iPlane = (rPlane+gPlane+bPlane)/3;

hsi = cat(3,hPlane,sPlane,iPlane);

end