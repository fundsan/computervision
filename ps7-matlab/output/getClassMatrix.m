function [MU,NU] = getClassMatrix(vid)

MHIA1 = double(computeMHI(vid))./255;
M00 = computeMij(0,0,MHIA1);
M10 = computeMij(1,0,MHIA1);
M01 = computeMij(0,1,MHIA1);

mu00 = compute_mu(M00,M10,M01,MHIA1,0,0);

mu20 = compute_mu(M00,M10,M01,MHIA1,2,0);
nu20 = getNu(mu00,mu20,2,0);
mu02 = compute_mu(M00,M10,M01,MHIA1,0,2);
nu02 = getNu(mu00,mu02,0,2);
mu12 = compute_mu(M00,M10,M01,MHIA1,1,2);
nu12 = getNu(mu00,mu12,1,2);
mu21 = compute_mu(M00,M10,M01,MHIA1,2,1);
nu21 = getNu(mu00,mu21,2,1);
mu22 = compute_mu(M00,M10,M01,MHIA1,2,2);
nu22 = getNu(mu00,mu22,2,2);
mu30 = compute_mu(M00,M10,M01,MHIA1,3,0);
nu30 = getNu(mu00,mu30,3,0);
mu03 = compute_mu(M00,M10,M01,MHIA1,0,3);
nu03 = getNu(mu00,mu03,0,3);
MU = [mu20, mu02,mu12,mu21,mu22,mu30,mu03];
NU = [nu20, nu02,nu12,nu21,nu22,nu30,nu03];
