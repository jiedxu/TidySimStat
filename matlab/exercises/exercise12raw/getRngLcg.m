% 190606
function [vecRanNum, vecCumuProb] = getRngLcg(mCap, a, c, x0)
    % c -> b, mCap >- c
    vecRanNum = zeros(mCap, 1);
    vecProb = zeros(mCap, 1);
    vecRanNum(1) = rem(a * x0 + c, mCap);
    for i = 2:mCap
        vecRanNum(i) = rem(a * vecRanNum(i-1) + c, mCap);
    end
    vecCumuProb = vecRanNum / mCap;
end
