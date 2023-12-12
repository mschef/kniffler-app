xquery version "3.0";

module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config";

import module namespace pm-web="http://www.tei-c.org/pm/models/knifflerdesignodd/web/module" at "../transform/knifflerdesignodd-web-module.xql";
import module namespace pm-print="http://www.tei-c.org/pm/models/knifflerdesignodd/fo/module" at "../transform/knifflerdesignodd-print-module.xql";
import module namespace pm-latex="http://www.tei-c.org/pm/models/knifflerdesignodd/latex/module" at "../transform/knifflerdesignodd-latex-module.xql";
import module namespace pm-epub="http://www.tei-c.org/pm/models/knifflerdesignodd/epub/module" at "../transform/knifflerdesignodd-epub-module.xql";

declare variable $pm-config:web-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    pm-web:transform($xml, $parameters)
};
declare variable $pm-config:print-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    pm-print:transform($xml, $parameters)
};
declare variable $pm-config:latex-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    pm-latex:transform($xml, $parameters)
};
declare variable $pm-config:epub-transform := function($xml as node()*, $parameters as map(*)?, $odd as xs:string?) {
    pm-epub:transform($xml, $parameters)
};
