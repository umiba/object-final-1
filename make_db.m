food = 'soba'; % クラスの指定、curry or pizza or udon or soba

load(strcat(food,'_list.mat')); % 指定された画像パス一覧を保存したmatファイルの読み込み

database = []; % ベクトルを保存する空配列の生成
for i =1:length(list)
    X = imread(list{i}); % 画像を先頭から読み込む
    
    R = X(:,:,1);G = X(:,:,2);B = X(:,:,3); % R,G,BにそれぞれのRGB値を保存
    X64=floor(double(R)/64) *4*4 + floor(double(G)/64) *4 + floor(double(B)/64); % 64色に減色する
    X64_vec = reshape(X64, 1, numel(X64));
    h = histc(X64_vec,[0:63]); % 横ベクトルカラーヒストグラムに変換
    h = h/sum(h);
    database = [database; h];
end

save(strcat(food,'_db.mat'), 'database','list'); % カラーヒストグラムdatabaseとパス一覧listを合わせて保存