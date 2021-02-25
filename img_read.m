n=0; list={}; % ファイルパスを保存するセル配列を生成
food = 'soba'; % 対象のクラスを指定 'curry' or 'pizza' or 'udon' or 'soba'
DIR0=strcat('imgdir/',food,'/'); % imgdirにcurry, pizza, udon, sobaのディレクトリが存在するのでstrcatで合わせて指定しDIR0に格納 
W=dir(DIR0); % DIR0内のファイル名を取得
for j=1:size(W)
    if (strfind(W(j).name,'.jpg')) % jpgのみ取得
      fn=strcat(DIR0,W(j).name);
      n=n+1;
      fprintf('[%d] %s\n',n,fn); % 保存枚数、名前を出力
	  list={list{:} fn}; % listにファイル名を保存していく
    end
end

save(strcat(food,'_list.mat'),'list') % クラス名と合わせてlistを保存