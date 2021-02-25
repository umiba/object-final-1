p_food = 'curry'; % ポジティブ画像クラスの指定 curry or udon
n_food = 'pizza'; % ネガティブ画像クラスの指定 pizza or soba
% 今回はcurry/pizza と udon/sobaで行った

load(strcat(p_food,'_',n_food,'_bof.mat')); % 指定したbofを呼び出し

data_pos = bof(1:100,:); % 先頭100個がポジティブ画像
data_neg = bof(101:200,:); % 後半100個がネガティブ画像
% それぞれdata_pos、data_negに格納

n= 100; % 1クラス当たりの画像枚数の指定 

cv=5; % cross validationで何分割するか　今回は5分割
idx=[1:n]; % cross validation で分割する際のインデックス配列
accuracy=[]; % 精度を保存する配列

for i=1:cv 
  train_pos=data_pos(find(mod(idx,cv)~=(i-1)),:);
  eval_pos =data_pos(find(mod(idx,cv)==(i-1)),:);
  train_neg=data_neg(find(mod(idx,cv)~=(i-1)),:);
  eval_neg =data_neg(find(mod(idx,cv)==(i-1)),:);
  % modでそれぞれインデックスを5分割し、学習用train_posとtrain_negおよび評価用eval_posとeval_negに格納 
  train=[train_pos; train_neg]; % 学習用データを一つの配列に保存
  eval=[eval_pos; eval_neg]; % 評価用データを一つの配列に保存

  train_label=[ones(size(train_pos,1), 1); ones(size(train_neg,1),1)*(-1)];
  eval_label =[ones(size(eval_pos,1), 1); ones(size(eval_neg,1),1)*(-1)];
  % train_pos等の配列のサイズだけ1をtrain_negの配列のサイズだけ-1をラベル配列に
  % 評価用ラベルも同様に生成
  
  model = fitcsvm(train, train_label, 'KernelFunction', 'rbf', 'KernelScale', 'auto');
  % 非線形SVMで学習
  [p_label, scores] = predict(model, eval); % 分類
  ac = numel(find(eval_label==p_label))/numel(eval_label);
  % SVMによって分類されたラベル配列と正解のラベル配列で正誤判定 精度を算出
  accuracy = [accuracy ac]; % 精度配列に保存
end

fprintf('accuracy: %f\n',mean(accuracy)) % 全ての平均を出力