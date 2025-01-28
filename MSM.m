clc,clear,close all 
load('Yale_32x32.mat')

training_sampleP = fea(1:8,:);

test_sampleP = fea(9:11,:);

[P1_U,P1_S,P1_V] = svd(test_sampleP, "econ");
[Q1_U,Q1_S,Q1_V] = svd(training_sampleP, 'econ');

X1 = P1_V' * Q1_V;
[X1_U,X1_S,X1_V] = svd(X1,'econ');
canonical_angle1 = acos(diag(X1_S));
t1 = length(canonical_angle1);

S1 = zeros(1, t1);
for i = 1:t1
    S1(i) = sum(X1_S(1:i).^2) / t1;
end 


training_sampleQ = fea(12:19,:);
test_sampleQ = fea(20:22,:);

[P2_U,P2_S,P2_V] = svd(test_sampleQ, "econ");
[Q2_U,Q2_S,Q2_V] = svd(training_sampleQ, 'econ');

X2 = P2_V' * Q2_V;
[X2_U,X2_S,X2_V] = svd(X2,'econ');
canonical_angle2 = acos(diag(X2_S));
t2 = length(canonical_angle2);

S2 = zeros(1, t2);
for i = 1:t2
    S2(i) = sum((X2_S(1:i).^2 / t2));
end 

training_sampleC = fea(23:30,:);
test_sampleC = fea(31:33,:);

[P3_U,P3_S,P3_V] = svd(test_sampleC, "econ");
[Q3_U,Q3_S,Q3_V] = svd(training_sampleC, 'econ');

X3 = P3_V' * Q3_V;
[X3_U,X3_S,X3_V] = svd(X3,'econ');
canonical_angle3 = acos(diag(X3_S));
t3 = length(canonical_angle3);

S2 = zeros(1, t2);
for i = 1:t2
    S2(i) = sum((X2_S(1:i).^2 / t2));
end 
thrshold = 0.5;

if S1 > S2
  disp("P = class")
elseif S1 < S2
    disp("Q = class")
end

