" ORIGINAL:
"   SOURCE: https://github.com/shg-eo/skkeleton-azik/blob/master/plugin/skkeleton-azik.vim
"   LICENSE: https://github.com/shg-eo/skkeleton-azik/blob/master/LICENSE.md

" <summary>
"   `azik`という名前の仮名テーブルを作成し、いくつかのキーバインドを定義する。
" </summary>
" <remarks>
"   <see cref="skkeleton#config">に相当する処理は実行しないが、
"   <see cref="skkeleton-config-kanaTable">に"azik"を
"   設定したい場合はskkeleton#configよりも先に実行する必要がある。
" </remarks>
function! skkeleton_azik#setup(config = {}) abort
  let l:azik_kanatable = {
    \ 'a':     ['あ', ''],
    \ 'i':     ['い', ''],
    \ 'u':     ['う', ''],
    \ 'e':     ['え', ''],
    \ 'o':     ['お', ''],
    \ 'ka':    ['か', ''],
    \ 'ki':    ['き', ''],
    \ 'ku':    ['く', ''],
    \ 'ke':    ['け', ''],
    \ 'ko':    ['こ', ''],
    \ 'kz':    ['かん', ''],
    \ 'kn':    ['かん', ''],
    \ 'kk':    ['きん', ''],
    \ 'kj':    ['くん', ''],
    \ 'kd':    ['けん', ''],
    \ 'kl':    ['こん', ''],
    \ 'kq':    ['かい', ''],
    \ 'kh':    ['くう', ''],
    \ 'kw':    ['けい', ''],
    \ 'kp':    ['こう', ''],
    \ 'sa':    ['さ', ''],
    \ 'si':    ['し', ''],
    \ 'su':    ['す', ''],
    \ 'se':    ['せ', ''],
    \ 'so':    ['そ', ''],
    \ 'sz':    ['さん', ''],
    \ 'sn':    ['さん', ''],
    \ 'sk':    ['しん', ''],
    \ 'sj':    ['すん', ''],
    \ 'sd':    ['せん', ''],
    \ 'sl':    ['そん', ''],
    \ 'sq':    ['さい', ''],
    \ 'sh':    ['すう', ''],
    \ 'sw':    ['せい', ''],
    \ 'sp':    ['そう', ''],
    \ 'ta':    ['た', ''],
    \ 'ti':    ['ち', ''],
    \ 'tu':    ['つ', ''],
    \ 'te':    ['て', ''],
    \ 'to':    ['と', ''],
    \ 'tz':    ['たん', ''],
    \ 'tn':    ['たん', ''],
    \ 'tk':    ['ちん', ''],
    \ 'tj':    ['つん', ''],
    \ 'td':    ['てん', ''],
    \ 'tl':    ['とん', ''],
    \ 'tq':    ['たい', ''],
    \ 'th':    ['つう', ''],
    \ 'tw':    ['てい', ''],
    \ 'tp':    ['とう', ''],
    \ 'tsa':   ['つぁ', ''],
    \ 'na':    ['な', ''],
    \ 'ni':    ['に', ''],
    \ 'nu':    ['ぬ', ''],
    \ 'ne':    ['ね', ''],
    \ 'no':    ['の', ''],
    \ 'nz':    ['なん', ''],
    \ 'nn':    ['ん', ''],
    \ 'nk':    ['にん', ''],
    \ 'nj':    ['ぬん', ''],
    \ 'nd':    ['ねん', ''],
    \ 'nl':    ['のん', ''],
    \ 'nq':    ['ない', ''],
    \ 'nh':    ['ぬう', ''],
    \ 'nw':    ['ねい', ''],
    \ 'np':    ['のう', ''],
    \ 'ha':    ['は', ''],
    \ 'hi':    ['ひ', ''],
    \ 'hu':    ['ふ', ''],
    \ 'he':    ['へ', ''],
    \ 'ho':    ['ほ', ''],
    \ 'hz':    ['はん', ''],
    \ 'hn':    ['はん', ''],
    \ 'hk':    ['ひん', ''],
    \ 'hj':    ['ふん', ''],
    \ 'hd':    ['へん', ''],
    \ 'hl':    ['ほん', ''],
    \ 'hq':    ['はい', ''],
    \ 'hh':    ['ふう', ''],
    \ 'hw':    ['へい', ''],
    \ 'hp':    ['ほう', ''],
    \ 'fa':    ['ふぁ', ''],
    \ 'fi':    ['ふぃ', ''],
    \ 'fu':    ['ふ', ''],
    \ 'fe':    ['ふぇ', ''],
    \ 'fo':    ['ふぉ', ''],
    \ 'fz':    ['ふぁん', ''],
    \ 'fn':    ['ふぁん', ''],
    \ 'fk':    ['ふぃん', ''],
    \ 'fj':    ['ふん', ''],
    \ 'fd':    ['ふぇん', ''],
    \ 'fl':    ['ふぉん', ''],
    \ 'fq':    ['ふぁい', ''],
    \ 'fh':    ['ふう', ''],
    \ 'fw':    ['ふぇい', ''],
    \ 'fp':    ['ふぉー', ''],
    \ 'ma':    ['ま', ''],
    \ 'mi':    ['み', ''],
    \ 'mu':    ['む', ''],
    \ 'me':    ['め', ''],
    \ 'mo':    ['も', ''],
    \ 'mz':    ['まん', ''],
    \ 'mk':    ['みん', ''],
    \ 'mj':    ['むん', ''],
    \ 'md':    ['めん', ''],
    \ 'ml':    ['もん', ''],
    \ 'mq':    ['まい', ''],
    \ 'mh':    ['むう', ''],
    \ 'mw':    ['めい', ''],
    \ 'mp':    ['もう', ''],
    \ 'ya':    ['や', ''],
    \ 'yu':    ['ゆ', ''],
    \ 'yo':    ['よ', ''],
    \ 'yz':    ['やん', ''],
    \ 'yn':    ['やん', ''],
    \ 'yj':    ['ゆん', ''],
    \ 'yl':    ['よん', ''],
    \ 'yq':    ['やい', ''],
    \ 'yh':    ['ゆう', ''],
    \ 'yp':    ['よう', ''],
    \ 'ra':    ['ら', ''],
    \ 'ri':    ['り', ''],
    \ 'ru':    ['る', ''],
    \ 're':    ['れ', ''],
    \ 'ro':    ['ろ', ''],
    \ 'rz':    ['らん', ''],
    \ 'rn':    ['らん', ''],
    \ 'rk':    ['りん', ''],
    \ 'rj':    ['るん', ''],
    \ 'rd':    ['れん', ''],
    \ 'rl':    ['ろん', ''],
    \ 'rq':    ['らい', ''],
    \ 'rh':    ['るう', ''],
    \ 'rw':    ['れい', ''],
    \ 'rp':    ['ろう', ''],
    \ 'wa':    ['わ', ''],
    \ 'wi':    ['うぃ', ''],
    \ 'we':    ['うぇ', ''],
    \ 'wo':    ['を', ''],
    \ 'wz':    ['わん', ''],
    \ 'wn':    ['わん', ''],
    \ 'wk':    ['うぃん', ''],
    \ 'wd':    ['うぇん', ''],
    \ 'wl':    ['うぉん', ''],
    \ 'wq':    ['わい', ''],
    \ 'wp':    ['うぉー', ''],
    \ 'ga':    ['が', ''],
    \ 'gi':    ['ぎ', ''],
    \ 'gu':    ['ぐ', ''],
    \ 'ge':    ['げ', ''],
    \ 'go':    ['ご', ''],
    \ 'gz':    ['がん', ''],
    \ 'gn':    ['がん', ''],
    \ 'gk':    ['ぎん', ''],
    \ 'gj':    ['ぐん', ''],
    \ 'gd':    ['げん', ''],
    \ 'gl':    ['ごん', ''],
    \ 'gq':    ['がい', ''],
    \ 'gh':    ['ぐう', ''],
    \ 'gw':    ['げい', ''],
    \ 'gp':    ['ごう', ''],
    \ 'za':    ['ざ', ''],
    \ 'zi':    ['じ', ''],
    \ 'zu':    ['ず', ''],
    \ 'ze':    ['ぜ', ''],
    \ 'zo':    ['ぞ', ''],
    \ 'zz':    ['ざん', ''],
    \ 'zn':    ['ざん', ''],
    \ 'zk':    ['じん', ''],
    \ 'zj':    ['ずん', ''],
    \ 'zd':    ['ぜん', ''],
    \ 'zl':    ['ぞん', ''],
    \ 'zq':    ['ざい', ''],
    \ 'zh':    ['ずう', ''],
    \ 'zw':    ['ぜい', ''],
    \ 'zp':    ['ぞう', ''],
    \ 'da':    ['だ', ''],
    \ 'di':    ['ぢ', ''],
    \ 'du':    ['づ', ''],
    \ 'de':    ['で', ''],
    \ 'do':    ['ど', ''],
    \ 'dz':    ['だん', ''],
    \ 'dn':    ['だん', ''],
    \ 'dk':    ['ぢん', ''],
    \ 'dj':    ['づん', ''],
    \ 'dd':    ['でん', ''],
    \ 'dl':    ['どん', ''],
    \ 'dq':    ['だい', ''],
    \ 'dh':    ['づう', ''],
    \ 'dw':    ['でい', ''],
    \ 'dp':    ['どう', ''],
    \ 'ba':    ['ば', ''],
    \ 'bi':    ['び', ''],
    \ 'bu':    ['ぶ', ''],
    \ 'be':    ['べ', ''],
    \ 'bo':    ['ぼ', ''],
    \ 'bz':    ['ばん', ''],
    \ 'bn':    ['ばん', ''],
    \ 'bk':    ['びん', ''],
    \ 'bj':    ['ぶん', ''],
    \ 'bd':    ['べん', ''],
    \ 'bl':    ['ぼん', ''],
    \ 'bq':    ['ばい', ''],
    \ 'bh':    ['ぶう', ''],
    \ 'bw':    ['べい', ''],
    \ 'bp':    ['ぼう', ''],
    \ 'pa':    ['ぱ', ''],
    \ 'pi':    ['ぴ', ''],
    \ 'pu':    ['ぷ', ''],
    \ 'pe':    ['ぺ', ''],
    \ 'po':    ['ぽ', ''],
    \ 'pz':    ['ぱん', ''],
    \ 'pn':    ['ぱん', ''],
    \ 'pk':    ['ぴん', ''],
    \ 'pj':    ['ぷん', ''],
    \ 'pd':    ['ぺん', ''],
    \ 'pl':    ['ぽん', ''],
    \ 'pq':    ['ぱい', ''],
    \ 'ph':    ['ぷう', ''],
    \ 'pw':    ['ぺい', ''],
    \ 'pp':    ['ぽう', ''],
    \ 'kya':   ['きゃ', ''],
    \ 'kyu':   ['きゅ', ''],
    \ 'kye':   ['きぇ', ''],
    \ 'kyo':   ['きょ', ''],
    \ 'kyz':   ['きゃん', ''],
    \ 'kyn':   ['きゃん', ''],
    \ 'kyj':   ['きゅん', ''],
    \ 'kyd':   ['きぇん', ''],
    \ 'kyl':   ['きょん', ''],
    \ 'kyq':   ['きゃい', ''],
    \ 'kyh':   ['きゅう', ''],
    \ 'kyw':   ['きぇい', ''],
    \ 'kyp':   ['きょう', ''],
    \ 'kga':   ['きゃ', ''],
    \ 'kgu':   ['きゅ', ''],
    \ 'kge':   ['きぇ', ''],
    \ 'kgo':   ['きょ', ''],
    \ 'kgz':   ['きゃん', ''],
    \ 'kgn':   ['きゃん', ''],
    \ 'kgj':   ['きゅん', ''],
    \ 'kgd':   ['きぇん', ''],
    \ 'kgl':   ['きょん', ''],
    \ 'kgq':   ['きゃい', ''],
    \ 'kgh':   ['きゅう', ''],
    \ 'kgw':   ['きぇい', ''],
    \ 'kgp':   ['きょう', ''],
    \ 'sya':   ['しゃ', ''],
    \ 'syu':   ['しゅ', ''],
    \ 'sye':   ['しぇ', ''],
    \ 'syo':   ['しょ', ''],
    \ 'syz':   ['しゃん', ''],
    \ 'syn':   ['しゃん', ''],
    \ 'syj':   ['しゅん', ''],
    \ 'syd':   ['しぇん', ''],
    \ 'syl':   ['しょん', ''],
    \ 'syq':   ['しゃい', ''],
    \ 'syh':   ['しゅう', ''],
    \ 'syw':   ['しぇい', ''],
    \ 'syp':   ['しょう', ''],
    \ 'xa':    ['しゃ', ''],
    \ 'xu':    ['しゅ', ''],
    \ 'xe':    ['しぇ', ''],
    \ 'xo':    ['しょ', ''],
    \ 'xz':    ['しゃん', ''],
    \ 'xn':    ['しゃん', ''],
    \ 'xj':    ['しゅん', ''],
    \ 'xd':    ['しぇん', ''],
    \ 'xl':    ['しょん', ''],
    \ 'xq':    ['しゃい', ''],
    \ 'xh':    ['しゅう', ''],
    \ 'xw':    ['しぇい', ''],
    \ 'xp':    ['しょう', ''],
    \ 'tya':   ['ちゃ', ''],
    \ 'tyu':   ['ちゅ', ''],
    \ 'tye':   ['ちぇ', ''],
    \ 'tyo':   ['ちょ', ''],
    \ 'tyz':   ['ちゃん', ''],
    \ 'tyn':   ['ちゃん', ''],
    \ 'tyj':   ['ちゅん', ''],
    \ 'tyd':   ['ちぇん', ''],
    \ 'tyl':   ['ちょん', ''],
    \ 'tyq':   ['ちゃい', ''],
    \ 'tyh':   ['ちゅう', ''],
    \ 'tyw':   ['ちぇい', ''],
    \ 'typ':   ['ちょう', ''],
    \ 'ca':    ['ちゃ', ''],
    \ 'cu':    ['ちゅ', ''],
    \ 'ce':    ['ちぇ', ''],
    \ 'co':    ['ちょ', ''],
    \ 'cz':    ['ちゃん', ''],
    \ 'cn':    ['ちゃん', ''],
    \ 'cj':    ['ちゅん', ''],
    \ 'cd':    ['ちぇん', ''],
    \ 'cl':    ['ちょん', ''],
    \ 'cq':    ['ちゃい', ''],
    \ 'ch':    ['ちゅう', ''],
    \ 'cw':    ['ちぇい', ''],
    \ 'cp':    ['ちょう', ''],
    \ 'nya':   ['にゃ', ''],
    \ 'nyu':   ['にゅ', ''],
    \ 'nye':   ['にぇ', ''],
    \ 'nyo':   ['にょ', ''],
    \ 'nyz':   ['にゃん', ''],
    \ 'nyn':   ['にゃん', ''],
    \ 'nyj':   ['にゅん', ''],
    \ 'nyd':   ['にぇん', ''],
    \ 'nyl':   ['にょん', ''],
    \ 'nyq':   ['にゃい', ''],
    \ 'nyh':   ['にゅう', ''],
    \ 'nyw':   ['にぇい', ''],
    \ 'nyp':   ['にょう', ''],
    \ 'nga':   ['にゃ', ''],
    \ 'ngu':   ['にゅ', ''],
    \ 'nge':   ['にぇ', ''],
    \ 'ngo':   ['にょ', ''],
    \ 'ngz':   ['にゃん', ''],
    \ 'ngn':   ['にゃん', ''],
    \ 'ngj':   ['にゅん', ''],
    \ 'ngd':   ['にぇん', ''],
    \ 'ngl':   ['にょん', ''],
    \ 'ngq':   ['にゃい', ''],
    \ 'ngh':   ['にゅう', ''],
    \ 'ngw':   ['にぇい', ''],
    \ 'ngp':   ['にょう', ''],
    \ 'hya':   ['ひゃ', ''],
    \ 'hyu':   ['ひゅ', ''],
    \ 'hye':   ['ひぇ', ''],
    \ 'hyo':   ['ひょ', ''],
    \ 'hyz':   ['ひゃん', ''],
    \ 'hyn':   ['ひゃん', ''],
    \ 'hyj':   ['ひゅん', ''],
    \ 'hyd':   ['ひぇん', ''],
    \ 'hyl':   ['ひょん', ''],
    \ 'hyq':   ['ひゃい', ''],
    \ 'hyh':   ['ひゅう', ''],
    \ 'hyw':   ['ひぇい', ''],
    \ 'hyp':   ['ひょう', ''],
    \ 'hga':   ['ひゃ', ''],
    \ 'hgu':   ['ひゅ', ''],
    \ 'hge':   ['ひぇ', ''],
    \ 'hgo':   ['ひょ', ''],
    \ 'hgz':   ['ひゃん', ''],
    \ 'hgn':   ['ひゃん', ''],
    \ 'hgj':   ['ひゅん', ''],
    \ 'hgd':   ['ひぇん', ''],
    \ 'hgl':   ['ひょん', ''],
    \ 'hgq':   ['ひゃい', ''],
    \ 'hgh':   ['ひゅう', ''],
    \ 'hgw':   ['ひぇい', ''],
    \ 'hgp':   ['ひょう', ''],
    \ 'mya':   ['みゃ', ''],
    \ 'myu':   ['みゅ', ''],
    \ 'mye':   ['みぇ', ''],
    \ 'myo':   ['みょ', ''],
    \ 'myz':   ['みゃん', ''],
    \ 'myn':   ['みゃん', ''],
    \ 'myj':   ['みゅん', ''],
    \ 'myd':   ['みぇん', ''],
    \ 'myl':   ['みょん', ''],
    \ 'myq':   ['みゃい', ''],
    \ 'myh':   ['みゅう', ''],
    \ 'myw':   ['みぇい', ''],
    \ 'myp':   ['みょう', ''],
    \ 'mga':   ['みゃ', ''],
    \ 'mgu':   ['みゅ', ''],
    \ 'mge':   ['みぇ', ''],
    \ 'mgo':   ['みょ', ''],
    \ 'mgz':   ['みゃん', ''],
    \ 'mgn':   ['みゃん', ''],
    \ 'mgj':   ['みゅん', ''],
    \ 'mgd':   ['みぇん', ''],
    \ 'mgl':   ['みょん', ''],
    \ 'mgq':   ['みゃい', ''],
    \ 'mgh':   ['みゅう', ''],
    \ 'mgw':   ['みぇい', ''],
    \ 'mgp':   ['みょう', ''],
    \ 'rya':   ['りゃ', ''],
    \ 'ryu':   ['りゅ', ''],
    \ 'rye':   ['りぇ', ''],
    \ 'ryo':   ['りょ', ''],
    \ 'ryz':   ['りゃん', ''],
    \ 'ryn':   ['りゃん', ''],
    \ 'ryj':   ['りゅん', ''],
    \ 'ryd':   ['りぇん', ''],
    \ 'ryl':   ['りょん', ''],
    \ 'ryq':   ['りゃい', ''],
    \ 'ryh':   ['りゅう', ''],
    \ 'ryw':   ['りぇい', ''],
    \ 'ryp':   ['りょう', ''],
    \ 'gya':   ['ぎゃ', ''],
    \ 'gyu':   ['ぎゅ', ''],
    \ 'gye':   ['ぎぇ', ''],
    \ 'gyo':   ['ぎょ', ''],
    \ 'gyz':   ['ぎゃん', ''],
    \ 'gyn':   ['ぎゃん', ''],
    \ 'gyj':   ['ぎゅん', ''],
    \ 'gyd':   ['ぎぇん', ''],
    \ 'gyl':   ['ぎょん', ''],
    \ 'gyq':   ['ぎゃい', ''],
    \ 'gyh':   ['ぎゅう', ''],
    \ 'gyw':   ['ぎぇい', ''],
    \ 'gyp':   ['ぎょう', ''],
    \ 'zya':   ['じゃ', ''],
    \ 'zyu':   ['じゅ', ''],
    \ 'zye':   ['じぇ', ''],
    \ 'zyo':   ['じょ', ''],
    \ 'zyz':   ['じゃん', ''],
    \ 'zyn':   ['じゃん', ''],
    \ 'zyj':   ['じゅん', ''],
    \ 'zyd':   ['じぇん', ''],
    \ 'zyl':   ['じょん', ''],
    \ 'zyq':   ['じゃい', ''],
    \ 'zyh':   ['じゅう', ''],
    \ 'zyw':   ['じぇい', ''],
    \ 'zyp':   ['じょう', ''],
    \ 'ja':    ['じゃ', ''],
    \ 'ji':    ['じ', ''],
    \ 'ju':    ['じゅ', ''],
    \ 'je':    ['じぇ', ''],
    \ 'jo':    ['じょ', ''],
    \ 'jk':    ['じん', ''],
    \ 'jz':    ['じゃん', ''],
    \ 'jn':    ['じゃん', ''],
    \ 'jj':    ['じゅん', ''],
    \ 'jd':    ['じぇん', ''],
    \ 'jl':    ['じょん', ''],
    \ 'jq':    ['じゃい', ''],
    \ 'jh':    ['じゅう', ''],
    \ 'jw':    ['じぇい', ''],
    \ 'jp':    ['じょう', ''],
    \ 'bya':   ['びゃ', ''],
    \ 'byu':   ['びゅ', ''],
    \ 'bye':   ['びぇ', ''],
    \ 'byo':   ['びょ', ''],
    \ 'byz':   ['びゃん', ''],
    \ 'byn':   ['びゃん', ''],
    \ 'byj':   ['びゅん', ''],
    \ 'byd':   ['びぇん', ''],
    \ 'byl':   ['びょん', ''],
    \ 'byq':   ['びゃい', ''],
    \ 'byh':   ['びゅう', ''],
    \ 'byw':   ['びぇい', ''],
    \ 'byp':   ['びょう', ''],
    \ 'pya':   ['ぴゃ', ''],
    \ 'pyu':   ['ぴゅ', ''],
    \ 'pye':   ['ぴぇ', ''],
    \ 'pyo':   ['ぴょ', ''],
    \ 'pyz':   ['ぴゃん', ''],
    \ 'pyn':   ['ぴゃん', ''],
    \ 'pyj':   ['ぴゅん', ''],
    \ 'pyd':   ['ぴぇん', ''],
    \ 'pyl':   ['ぴょん', ''],
    \ 'pyq':   ['ぴゃい', ''],
    \ 'pyh':   ['ぴゅう', ''],
    \ 'pyw':   ['ぴぇい', ''],
    \ 'pyp':   ['ぴょう', ''],
    \ 'pga':   ['ぴゃ', ''],
    \ 'pgu':   ['ぴゅ', ''],
    \ 'pge':   ['ぴぇ', ''],
    \ 'pgo':   ['ぴょ', ''],
    \ 'pgz':   ['ぴゃん', ''],
    \ 'pgn':   ['ぴゃん', ''],
    \ 'pgj':   ['ぴゅん', ''],
    \ 'pgd':   ['ぴぇん', ''],
    \ 'pgl':   ['ぴょん', ''],
    \ 'pgq':   ['ぴゃい', ''],
    \ 'pgh':   ['ぴゅう', ''],
    \ 'pgw':   ['ぴぇい', ''],
    \ 'pgp':   ['ぴょう', ''],
    \ 'va':    ['ヴぁ', ''],
    \ 'vi':    ['ヴぃ', ''],
    \ 'vu':    ['ヴ', ''],
    \ 've':    ['ヴぇ', ''],
    \ 'vo':    ['ヴぉ', ''],
    \ 'vz':    ['ヴぁん', ''],
    \ 'vn':    ['ヴぁん', ''],
    \ 'vk':    ['ヴぃん', ''],
    \ 'vj':    ['ヴん', ''],
    \ 'vd':    ['ヴぇん', ''],
    \ 'vl':    ['ヴぉん', ''],
    \ 'vq':    ['ヴぁい', ''],
    \ 'vh':    ['ヴう', ''],
    \ 'vw':    ['ヴぇい', ''],
    \ 'vp':    ['ヴぉう', ''],
    \ 'kf':    ['き', ''],
    \ 'sf':    ['さい', ''],
    \ 'ss':    ['せい', ''],
    \ 'nf':    ['ぬ', ''],
    \ 'hf':    ['ふ', ''],
    \ 'mf':    ['む', ''],
    \ 'yf':    ['ゆ', ''],
    \ 'wf':    ['わい', ''],
    \ 'zc':    ['ざ', ''],
    \ 'zf':    ['ぜ', ''],
    \ 'zv':    ['ざい', ''],
    \ 'zx':    ['ぜい', ''],
    \ 'df':    ['で', ''],
    \ 'jf':    ['じゅ', ''],
    \ 'cf':    ['ちぇ', ''],
    \ 'pf':    ['ぽん', ''],
    \ 'tgi':   ['てぃ', ''],
    \ 'tgk':   ['てぃん', ''],
    \ 'tgu':   ['とぅ', ''],
    \ 'tgl':   ['とぅん', ''],
    \ 'tgh':   ['とぅう', ''],
    \ 'dci':   ['でぃ', ''],
    \ 'dck':   ['でぃん', ''],
    \ 'dcu':   ['どぅ', ''],
    \ 'dcj':   ['どぅん', ''],
    \ 'dch':   ['どぅう', ''],
    \ 'wso':   ['うぉ', ''],
    \ 'wsl':   ['うぉん', ''],
    \ 'xxa':   ['ぁ', ''],
    \ 'xxi':   ['ぃ', ''],
    \ 'xxu':   ['ぅ', ''],
    \ 'xxe':   ['ぇ', ''],
    \ 'xxo':   ['ぉ', ''],
    \ 'xya':   ['ゃ', ''],
    \ 'xyu':   ['ゅ', ''],
    \ 'xyo':   ['ょ', ''],
    \ 'xwa':   ['ゎ', ''],
    \ 'q':     ['ん', ''],
    \ 'kt':    ['こと', ''],
    \ 'st':    ['した', ''],
    \ 'tt':    ['たち', ''],
    \ 'ht':    ['ひと', ''],
    \ 'wt':    ['わた', ''],
    \ 'mn':    ['もの', ''],
    \ 'ms':    ['ます', ''],
    \ 'ds':    ['です', ''],
    \ 'km':    ['かも', ''],
    \ 'tm':    ['ため', ''],
    \ 'dm':    ['でも', ''],
    \ 'kr':    ['から', ''],
    \ 'sr':    ['する', ''],
    \ 'tr':    ['たら', ''],
    \ 'nr':    ['なる', ''],
    \ 'yr':    ['よる', ''],
    \ 'rr':    ['られ', ''],
    \ 'zr':    ['ざる', ''],
    \ 'mt':    ['また', ''],
    \ 'tb':    ['たび', ''],
    \ 'nb':    ['ねば', ''],
    \ 'bt':    ['びと', ''],
    \ 'gr':    ['がら', ''],
    \ 'gt':    ['ごと', ''],
    \ 'nt':    ['にち', ''],
    \ 'dt':    ['だち', ''],
    \ 'wr':    ['われ', ''],
    \ '!':     ['！', ''],
    \ 'x!':    ['!', ''],
    \ "'":     ['ー', ''],
    \ "x'":    ["'", ''],
    \ '"':     ['-', ''],
    \ 'x"':    ['"', ''],
    \ ',':     ['、', ''],
    \ 'z,':    ['‥', ''],
    \ 'x,':    [',', ''],
    \ '-':     ['ー', ''],
    \ 'z-':    ['～', ''],
    \ '.':     ['。', ''],
    \ 'z.':    ['…', ''],
    \ 'x.':    ['.', ''],
    \ ';':     ['っ', ''],
    \ 'z;':    ['゛', ''],
    \ 'x;':    [';', ''],
    \ 'z:':    ['゜', ''],
    \ '?':     ['？', ''],
    \ 'x?':    ['?', ''],
    \ 'x[':    ['「', ''],
    \ 'z[':    ['『', ''],
    \ ']':     ['」', ''],
    \ 'z]':    ['』', ''],
    \ 'z{':    ['【', ''],
    \ 'z}':    ['】', ''],
    \ 'z ':    ['　', ''],
    \ 'z~':    ['〜', ''],
    \ 'z/':    ['・', ''],
    \ 'z(':    ['（', ''],
    \ 'z)':    ['）', ''],
    \ 'xxh':   ['←', ''],
    \ 'xxj':   ['↓', ''],
    \ 'xxk':   ['↑', ''],
    \ 'xxl':   ['→', ''],
    \ 'xxL':   ['⇒', ''],
    \ }

  call skkeleton#register_kanatable('azik', l:azik_kanatable, v:true)

  let l:config = deepcopy(a:config)
  call extend(l:config, get(g:, 'skkeleton_azik', {}), 'keep')
  call extend(l:config, skkeleton_azik#get_default_config(), 'keep')

  " input stateのマッピングはregister_keymapではなくてregister_kanatableでやるのがよさそう
  " kanatable毎にマッピングを定義できたり、lexima的なことも少しはできる
  " 例: "xl" -> "しょん", "l" -> "disable" を両立させる
  call skkeleton#register_kanatable('azik', {
        \ 'l':        'disable',
        \ "\<SPACE>": 'henkanFirst',
        \ l:config.keys.katakana: 'katakana',
        \})

  call skkeleton#register_kanatable('azik', { ':': 'henkanPoint' })
  augroup _skkeleton_azik_
    autocmd!
    autocmd User skkeleton-enable-post lnoremap <buffer> : <Cmd>call skkeleton#handle('handleKey', { 'key': ':' })<CR><Cmd>call skkeleton#handle('handleKey', { 'key': ';' })<CR>
    autocmd User skkeleton-initialize-post lunmap :
    " NOTE: lunmapするとskkeleton-enable一回でひらがな入力モードに入ることができなくなる
    " TODO: <C-j>決め打ちでやるのをやめて、ユーザーがskkeleton-enable,skkeleton-toggleを割り当ててるキーを特定して上書きするように変更する
    autocmd User skkeleton-enable-post ++once inoremap <C-j> <Plug>(skkeleton-enable)<Plug>(skkeleton-enable)
  augroup END
endfunction

function! skkeleton_azik#get_default_config() abort
  return {
        \  'keys': {
        \    'katakana': '[',
        \  },
        \}
endfunction
