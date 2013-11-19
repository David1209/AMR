function [] = drive(mB, mC, tacho1, tacho2, power1, power2)
    fprintf('Motor B tacho %d\n', tacho1);
    fprintf('Motor C tacho %d\n\n', tacho2);
    dataB = mB.ReadFromNXT();
    dataC = mC.ReadFromNXT();
    error1 = abs(tacho1 - dataB.Position);
    error2 = abs(tacho2 - dataC.Position);
    mB.Power = power1;
    mC.Power = power2;
    mB.SendToNXT();
    mC.SendToNXT();
    while error1 > 0 || error2 > 0
        sendB = 0;
        sendC = 0;
        if (abs(tacho1) > abs(dataB.Position))
            if (mB.Power ~= power1)
                mB.Power = power1/10;
                sendB = 1;
            end
        else
            if (mB.Power ~= -power1)
                mB.Power = -power1/10;
                sendB = 1;
            end

        end
        if (abs(tacho2) > abs(dataC.Position))
            if (mC.Power ~= power2)
                mC.Power = power2/10;
                sendC = 1;
            end
        else
            if (mC.Power ~= -power2)
                mC.Power = -power2/10;
                sendC = 1;
            end
        end
        if (error1 == 0) 
            mB.Stop('off'); 
            sendB = 1;
        end
        if (error2 == 0) 
            mC.Stop('off');
            sendC = 1;
        end
        if (sendB == 1)
            mB.SendToNXT();
        end
        if (sendC == 1)
            mC.SendToNXT();
        end
        pause(0.01);
        dataB = mB.ReadFromNXT();
        dataC = mC.ReadFromNXT();
        error1 = abs(tacho1 - dataB.Position);
        error2 = abs(tacho2 - dataC.Position);
        fprintf('Motor B is currently at position %d\n', dataB.Position);
        fprintf('Motor C is currently at position %d\n\n', dataC.Position);
    end
    mB.ResetPosition();
    mC.ResetPosition();
end

