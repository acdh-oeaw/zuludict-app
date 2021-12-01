declare namespace tei = "http://www.tei-c.org/ns/1.0";
let $orths := <index id="fa">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:form/tei:orth/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $poss := <index id="pos">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:gramGrp/tei:gram[@type="pos"]/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $roots := <index id="root">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:gramGrp/tei:gram[@type="root"]/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $subcs := <index id="subc">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:gramGrp/tei:gram[@type="subc"]/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $ens := <index id="en">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:sense/tei:cit[@xml:lang="en"]/tei:quote/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $des := <index id="de">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:sense/tei:cit[@xml:lang="de"]/tei:quote/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $frs := <index id="fr">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:sense/tei:cit[@xml:lang="fr"]/tei:quote/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $etymLang := <index id="etymLang">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:etym/tei:lang/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $etymSrc := <index id="etymSrc">{
    for $v in distinct-values(collection('dc_zul_eng__publ')//tei:entry[tei:fs/tei:f/tei:symbol/@value="released"]/tei:etym/tei:mentioned/tokenize(.,'["(),;:/!\s&#39;&#34;.]')) 
    order by $v
    return <w>{$v}</w>
}</index>

let $indxs := 
  <indices>{$des,$ens,$frs,$poss,$roots,$orths,$subcs,$etymLang,$etymSrc}</indices>

return db:create("dc_zul_eng__publ__ind", $indxs, "ind.xml")
