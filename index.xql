xquery version "3.1";

module namespace idx = "http://teipublisher.com/index";

declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace dbk = "http://docbook.org/ns/docbook";

declare variable $idx:app-root :=
let $rawPath := system:get-module-load-path()
return
    (: strip the xmldb: part :)
    if (starts-with($rawPath, "xmldb:exist://")) then
        if (starts-with($rawPath, "xmldb:exist://embedded-eXist-server")) then
            substring($rawPath, 36)
        else
            substring($rawPath, 15)
    else
        $rawPath
;

(:~
 : Helper function called from collection.xconf to create index fields and facets.
 : This module needs to be loaded before collection.xconf starts indexing documents
 : and therefore should reside in the root of the app.
 :)
declare function idx:get-metadata($node as element(), $root as element(), $field as xs:string) {
    let $header := $root/tei:teiHeader
    return
        (:~ Ignore translated text when counting facet hits :)
        if ($node/@type = 'translation') then () else 
        switch ($field)
            case "title" return
                    $header//tei:titleStmt/tei:title[not (@type = 'file')]
            case "date" return head((
                $header//tei:correspDesc/tei:correspAction[@type="sent"]/tei:date/@when,
                $header//tei:profileDesc/tei:creation/tei:date/@when
            ))
            case "language"
                return
                    $header//tei:langUsage/tei:language/@ident
            case "datesent"
                return
                    tokenize($header//tei:correspAction[@type = "sent"]/tei:date/@when, '-')
            case "daterecd"
                return
                    tokenize($header//tei:correspAction[@type = "received"]/tei:date/@when, '-')
            case "placesent"
                return
                    $header//tei:correspAction[@type = "sent"]/tei:settlement
            case "placerecd"
                return
                    $header//tei:correspAction[@type = "received"]/tei:settlement
            case "senderOrg"
                return
                    $header//tei:correspAction[@type = "sent"]/tei:orgName
            case "senderPers"
                return
                    $header//tei:correspAction[@type = "sent"]/tei:persName
            case "addresseeOrg"
                return
                    $header//tei:correspAction[@type = "received"]/tei:orgName
            case "addresseePers"
                return
                    $header//tei:correspAction[@type = "received"]/tei:persName
            default return
                ()
};
