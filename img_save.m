food = 'soba'; % 対象のクラスを指定 'curry' or 'pizza' or 'udon' or 'soba'
% urlは'url_curry_1.txt'の形式であらかじめ保存してある 1は再度収集した時に変更できるように加えた
list = textread(strcat('url_', food,'_1.txt'),'%s'); % urlリストの読み込み

mkdir(strcat('imgdir/', food)); % 保存ディレクトリの作成

for i=1:size(list,1)
    fname=strcat('imgdir','/',food,'/',num2str(i,'%04d'),'.jpg') % 保存名を指定
    websave(fname,list{i});
end