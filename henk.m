COM_CloseNXT all;
close all;
clear all;
Henk = COM_OpenNXT();
COM_SetDefaultNXT(Henk);
mA = NXTMotor('A');
mB = NXTMotor('B');
mC = NXTMotor('C');
mA.Power = 0;
mA.SendToNXT();
diameterWheel = 56;
l = 57.53;

radius = 600;
deg = 180;
[tacho1, tacho2, power1, power2] = circle(radius, diameterWheel, l, deg);

drive(mB, mC, tacho1, tacho2, power1, power2);


radius = 0;
deg = 90;
[tacho1, tacho2, power1, power2] = circle(radius, diameterWheel, l, deg);
drive(mB, mC, tacho1, tacho2, power1, power2);

distance = 1200;
tacho = straightLine(distance, diameterWheel);
power = 40;
mB.Power = power;
mB.TachoLimit = tacho;
mC.Power = power;
mC.TachoLimit = tacho;

mB.SendToNXT();
mC.SendToNXT();

mB.WaitFor();
mC.WaitFor();
dataB = mB.ReadFromNXT();
dataC = mC.ReadFromNXT();

% show it to the user:
fprintf('Motor B is currently at position %d\n', dataB.Position);
fprintf('Motor C is currently at position %d\n\n', dataC.Position);

