module namespace zuDict = "http://acdh.oeaw.ac.at/zuludict";
declare namespace tei = 'http://www.tei-c.org/ns/1.0';

declare function zuDict:expandExamplePointers($in as item(), $dict as document-node()*) {
    typeswitch ($in)
        case text() return $in
        case attribute() return $in
        case document-node() return document {
            zuDict:expandExamplePointers($in/*, $dict)
        }
        case element(tei:ptr) return $dict//node()[@xml:id = substring-after($in/@target, '#')]
        case element() return 
            (: element { QName( namespace-uri($in), local-name($in) ) } { for $node in $in/node() return wde:expandExamplePointers($node, $dict) } :)
            element { QName( namespace-uri($in), local-name($in) ) } { 
              for $i in ($in/@*, $in/node()) 
              return zuDict:expandExamplePointers($i, $dict) 
            }
        default return $in
};
      
declare function zuDict:distinct-nodes( $nodes as node()* )  as node()* {
    for $seq in (1 to count($nodes))
    return $nodes[$seq][not(zuDict:is-node-in-sequence(.,$nodes[position() < $seq]))]
};
  
declare function zuDict:is-node-in-sequence
 ( $node as node()? ,
    $seq as node()* )  as xs:boolean {

   some $nodeInSeq in $seq satisfies $nodeInSeq is $node
};
 
declare 
    %rest:path("zuludict/dict_index")
    %rest:query-param("dict", "{$dict}")    
    %rest:query-param("ind", "{$ind}")    
    %rest:query-param("str", "{$str}")    
    %rest:GET 
    %output:method("html")
    
function zuDict:query-index___($dict as xs:string, $ind as xs:string, $str as xs:string) {  
let $rs := 
 switch($ind)
   case "any" return collection($dict)//index/w[starts-with(.,$str)]
   default return 
            if ($str='*')
               then collection($dict)//index[@id=$ind]/w
               else collection($dict)//index[@id=$ind]/w[starts-with(.,$str)]

let $rs2 := <res>{
    for $r in $rs
    return <w index="{$r/../@id}" lemma="{$r/@lemma}">{$r/text()}</w>
  }</res>

  let $style := doc('index_2_html.xslt')
  let $ress := <results>{$rs2}</results>
  let $sReturn := xslt:transform($ress, $style)
  return
    $sReturn 
};

declare function zuDict:createMatchString($in as xs:string) {
  let $s := replace($in, '"', '')
  let $s1 := 
    if (contains($s, '*') or contains($s, '.') or contains($s, '^') or contains($s, '$') or contains($s, '+')  )
    then 'matches(., "' || $s ||'")'
    else '.="' || $s || '"'    
    
  return $s1
};

declare 
    %rest:path("zuludict/dict_api")
    %rest:query-param("query", "{$query}")    
    %rest:query-param("dict", "{$dict}")    
    %rest:query-param("xslt", "{$xsltfn}")    
    %rest:GET 

function zuDict:dict_query($dict as xs:string, $query as xs:string*, $xsltfn as xs:string) {    
  let $nsTei := "declare namespace tei = 'http://www.tei-c.org/ns/1.0';"
  let $queries := tokenize($query, 'yyy')
  let $qs := 
     for $query in $queries
        let $terms := tokenize(normalize-space($query), '=')
        return
          switch(normalize-space($terms[1]))
          case 'any' return      '[.//node()[' || zuDict:createMatchString($terms[2]) || ']]'
          case 'lem' return      '[tei:form[@type="lemma"]/tei:orth[' || zuDict:createMatchString($terms[2]) || ']]'
          case 'infl' return     '[tei:form[@type="inflected"]/tei:orth[' || zuDict:createMatchString($terms[2]) || ']]'
          case 'en' return       '[tei:sense/tei:cit[@type="translation"][@xml:lang="en"]/tei:quote[' || zuDict:createMatchString($terms[2]) || ']]'
          case 'de' return       '[tei:sense/tei:cit[@type="translation"][@xml:lang="de"]/tei:quote[' || zuDict:createMatchString($terms[2]) || ']]'
          case 'dom' return      '[tei:sense/tei:usg[' || zuDict:createMatchString($terms[2]) || ']]'
          case 'etymLang' return '[tei:etym/tei:lang[' || zuDict:createMatchString($terms[2]) || ']]'
          case 'etymSrc' return  '[tei:etym/tei:mentioned['|| zuDict:createMatchString($terms[2]) || ']]'
          case 'subc' return     '[tei:gramGrp/tei:gram[@type="subc"][' || zuDict:createMatchString($terms[2]) || ']]'
          case 'pos' return      '[tei:gramGrp/tei:gram[@type="pos"][' || zuDict:createMatchString($terms[2]) || ']]'          
          default return      '[.//node()[' || zuDict:createMatchString($terms[2]) || ']]'
    
  let $qq := 'collection("' || $dict || '")//tei:entry'||string-join($qs)
  let $results := xquery:eval($nsTei||$qq)
  (: return <answer>{count($res)}||{$res}</answer> :)
  
  (: let $results := xquery:eval($query) :)
  (: let $eds := distinct-values($results//tei:fs/tei:f[@name='who']/tei:symbol/@value) 
  let $editors := 
    for $ed in $eds
      return <ed>{$ed}</ed> :)
    
  let $exptrs := $results//tei:ptr[@type = 'example']
  let $entries := 
    for $r in $results
      return ($r/ancestor::tei:entry, $r/ancestor::tei:cit[@type='example'], $r)[1]

  let $res := zuDict:distinct-nodes($entries)
  let $res2 := for $e in $res return zuDict:expandExamplePointers($e, collection($dict))
   
  let $style := doc($xsltfn)
  let $ress := <div type="results" xmlns="http://www.tei-c.org/ns/1.0">{$res2}</div>
  
  let $sReturn := xslt:transform-text($ress, $style)

  return     
     $sReturn

    (: if (wde:check-user_($dict, $user, $pw)) :)
      (: then $sReturn :)
      (: else <error type="user authentication" name="{$user}" pw="{$pw}"/> :)       
};
