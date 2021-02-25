net = resnet101; % ネットワークの指定
f = 'pool5'; % レイヤー指定

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


database = []; % 特徴点保存用配列
for i=1:length(Training)
    img = imread(Training{i}); % 画像の読み込み
    reimg = imresize(img,net.Layers(1).InputSize(1:2)); % ネットワークの入力サイズに合わせて画像をリサイズ
    dcnnf = activations(net,reimg,f); % 指定したレイヤーで特徴抽出
    dcnnf = squeeze(dcnnf); % ベクトル化
    dcnnf = dcnnf/norm(dcnnf); % 正規化
    database = [database; dcnnf.']; % databaseに保存
end
save(strcat(p_food,'_',n_food,'_dcnn.mat'),'database','Training'); % databaseと画像パス一覧を保存