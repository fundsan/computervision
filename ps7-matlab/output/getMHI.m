function MHI1 = getMHI(binaryImg, MHI0, tao)

MaxMHI0 = MHI0-1;
underZero = MaxMHI0 < 0 ;
MaxMHI0(underZero) = 0;
trues = binaryImg == 1;

MHI1 = zeros(size(MHI0));
MHI1(trues) = tao;
MHI1(~(trues)) = MaxMHI0(~(trues));


