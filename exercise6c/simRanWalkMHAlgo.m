function [vecX, sState] = simRanWalkMHAlgo(m, nSample, aCap_1, aCap_2)
    x1 = randi(m + 1) - 1;
    x2 = randi(x1) - 1;
    sState(1).x = [x1, x2];
    for n = 2:nSample
        y1 = sState(n - 1).x(1) + randWalk();
        if y1 > m
            y1 = y1 - (m + 1);
        elseif y1 < 0
            y1 = y1 + (m + 1);
        end
        % disp(y1)
        y2 = sState(n - 1).x(2) + randWalk();
        % disp(y2)
        if y2 > m - y1
            y2 = 0;
        elseif y2 < 0
            y2 = m - y1;
        end
        sState(n).y = [y1, y2];
        % disp(sState(n).y)
        %
        if calCount2(sState(n).y(1), sState(n).y(2), aCap_1, aCap_2) >= ...
            calCount2(sState(n - 1).x(1), sState(n - 1).x(2), aCap_1, aCap_2)
            sState(n).x = sState(n).y;
        else
            if rand() < (calCount2(sState(n).y(1), sState(n).y(2), aCap_1, aCap_2) / ...
                calCount2(sState(n - 1).x(1), sState(n - 1).x(2), aCap_1, aCap_2))
                sState(n).x = sState(n).y;
            else
                sState(n).x = sState(n - 1).x;
        end
    end
    vecX = [sState.x];
end
