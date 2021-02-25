p_food = 'udon'; % ポジティブ画像クラスの指定 curry or udon
n_food = 'soba'; % ネガティブ画像クラスの指定 pizza or soba
% 今回はcurry/pizza と udon/sobaで行った

load(strcat(p_food,'_list.mat'));
PosList = list;
load(strcat(n_food,'_list.mat'));
NegList = list;
% それぞれ画像リストを呼び出し、ポジティブ画像用リストPosList
% ネガティブ画像用リストNegListに保存

Training={PosList{1:100} NegList{1:100}};
% Trainingに先頭100個を並べて格納

Features=[]; % 特徴点保存配列
for i=1:200
  I=rgb2gray(imread(Training{i}));% 画像の読み込み
  p=createRandomPoints(I,3000);% ランダムに3000個点を抽出
  [f,p2]=extractFeatures(I,p);% 特徴ベクトルを出力
  Features=[Features; f]; % Featuresに保存
end

k=1000; % 得られた特徴ベクトルをkmeansを用いて1000個のグループに分割
[idx, CODEBOOK] =kmeans(Features, k,'MaxIter', 10000);
save(strcat(p_food,'_',n_food,'_cb.mat'), 'CODEBOOK', 'Training'); % コードブックと画像パス一覧を合わせて保存