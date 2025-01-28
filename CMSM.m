clc,clear,close all 
load('Yale_64x64.mat')

training_sampleA = fea(1:8,:);
test_sampleA = fea(9:11,:);
training_sampleB = fea(12:19,:);
test_sampleB = fea(20:22,:);

[A_U,A_S,A_V] = svd(training_sampleA,'econ');
[a_U,a_S,a_V] = svd(test_sampleA,'econ');
[B_U,B_S,B_V] = svd(training_sampleB,'econ');
[b_U,b_S,b_V] = svd(test_sampleB,'econ');

proj_A = A_V * A_V'; %training A,training B 로 DS생성
proj_B = B_V * B_V';

temp = proj_A + proj_B;
tempAB = (temp + temp')/2;

[AB_eigvec, AB_eigval] = eig(tempAB,'vector');

D1 = double(find(round(AB_eigval,5)< 1.0));
difference_subspaceD1 = AB_eigvec(D1,:);

proj_D = difference_subspaceD1' * difference_subspaceD1;

proj_Pc = proj_D * training_sampleA';
proj_Qc = proj_D * training_sampleB';
proj_testPC = proj_D *test_sampleA';
proj_testQC = proj_D *test_sampleB';

[PC_U,PC_S,PC_V] = svd(proj_Pc,'econ');
[QC_U,QC_S,QC_V] = svd(proj_Qc,'econ');
[testPC_U,testPC_S,testPC_V] = svd(proj_testPC,'econ');
[testQC_U,testQC_S,testQC_V] = svd(proj_testQC,'econ');

X = testPC_U' * PC_U;
[~,X_S,~] = svd(X,'econ');
S1 = mean(diag(X_S) .^2);

X2 = testPC_U' * QC_U;
[~,X2_S,~] = svd(X2,'econ');
S2 = mean(diag(X2_S) .^2);

classA = 'class = A';
classB = 'class = B';

if (S1 > S2) 
 disp(classA)
elseif (S2 > S1) 
  disp(classB)
end

%%
XX = testQC_U' * PC_U;
[~,XX_S,~] = svd(XX,'econ');
S1 = mean(diag(XX_S) .^2);

XX2 = testQC_U' * QC_U;
[~,XX2_S,~] = svd(XX2,'econ');
S2 = mean(diag(XX2_S) .^2);

if (S1 > S2) 
 disp(classA)
elseif (S2 > S1) 
  disp(classB)
end