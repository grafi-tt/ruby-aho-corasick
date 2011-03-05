=何コレ？
文字列検索アルゴリズムのAho Corasickのrubyによる実装です。プリミティブな部分のみの実装なので、実用的なものにするには別途検索のインターフェイスを実装した方が良いと思います。

=ライセンス
MIT License

=対応バージョン
Ruby1.9系
少し修正すれば以前のバージョンでも動くはず

=注意点
Ruby1.9以降のRegexp#unionで作った正規表現よりも低速です。あくまでアルゴリズムの試験的な実装ということで。以前の正規表現との速度比較は行っていないので分かりません。

=メソッド
--- AhoCorasickTree#initialize(*strs)
    Aho Corasick法に用いる木を作成します。

      terms = %w!hoge fuga piyo foo foobar!
      tree = AhoCorasickTree.new(*terms)

--- AhoCorasickTree#apply(char)
    引数として与えられた文字で木を辿ります。
    マッチ文字列を含む配列を返します。マッチが無かった場合空の配列となります。

      str = "hogefugapiyopiyofoobarhogera"
      str.chars.each_with_index do |char,i|
        # i文字目
        matches = tree.apply char
        puts "matches: #{matches.join(" ")} at #{i+1}th char"
      end
