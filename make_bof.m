p_food = 'udon'; % ポジティブ画像クラスの指定 curry or udon
n_food = 'soba'; % ネガティブ画像クラスの指定 pizza or soba
% 今回はcurry/pizza と udon/sobaで行った

load(strcat(p_food,'_',n_food,'_cb.mat'));% 指定したコードブックの読み込み
n=200; % 画像の合計枚数を指定
bof = zeros(n, 1000); % 出現頻度をカウントするための0ベクトルをbofとして生成
for j = 1:n
     I=rgb2gray(imread(Training{j})); % 画像の読み込み
     p=createRandomPoints(I,3000); % ランダムに特徴点を抽出
    [f,p2] = extractFeatures(I,p);% 特徴点のベクトルを出力
    for i = 1:size(p2,1)
        X = repmat(f(i,:),1000,1);
        d = sum((X-CODEBOOK).^2, 2);
        [m, index] = min(d);
        bof(j, index) = bof(j, index)+1;
        % 対象の画像の特徴ベクトルとコードブックを比較しどの代表ベクトルと類似しているかを求めbofにカウント
    end
end

save(strcat(p_food,'_',n_food,'_bof.mat'),'bof','Training'); % bofと画像パス一覧を保存