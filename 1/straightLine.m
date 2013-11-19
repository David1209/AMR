function [tacho] = straightLine(distance, diameterWheel)
rotations = distance/(pi*diameterWheel);
tacho = int64(360 * abs(rotations));
end