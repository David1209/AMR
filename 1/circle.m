function [tacho1,tacho2, power1, power2] = circle(radius, diameterWheel, l, deg)
rotations1 = (pi * 2 * (radius - l))/(pi*diameterWheel);
rotations2 = (pi * 2 * (radius + l))/(pi*diameterWheel);
tacho1 = int64(360 * rotations1 * (deg/360));
tacho2 = int64(360 * rotations2 * (deg/360));

if (rotations1 <= rotations2)
    power2 = 40;
    power1 = int8(power2 * (rotations1/rotations2));
else
    power1 = 40;
    power2 = int8(power1 * (rotations2/rotations1));
end

end