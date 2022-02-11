/*====================================================================

Generates a 2 to 1 AND
Written by  Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(schemINV(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName gate
base
drain
source
)
;;Local Variables
  prog((cvid x y pin pinName)
  
	/* Create the CellView */
    cvid = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a")
	
	/* Clean the Schematic*/
    lpDeleteObjectsSchematic(cvid)
	
	/* Origin Point*/
    x=0
    y=0
printf("creating pins")
foreach(pinName list("VDD" "VSS" "IN")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    
foreach(pinName list("OUT")
      pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0")
      y=y+0.5
    )
			

y=0
x=x+2
/* Place MOSFET Cells*/
printf("placing fets")
printf(cellLibName)
printf(nCell)
/*PD  NMOS*/
jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M1" 
list(list(gate "IN")) 
list(list(base "VSS")) 
list(list(drain "OUT"))
list(list(source "VSS"))
x:y "R0"  nWidth nLength "1" "1")

x=x+3

printf("create pmos")
/*PU  PMOS*/
jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M2" 
list(list(gate "IN")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "OUT"))
x:y "R0"  pWidth pLength "1" "1")

x=x+1





	
/* Check and Save*/
pinList = `( nil ports (( nil name "IN" direction "input" )

( nil name "VDD" direction "input" )
( nil name "VSS" direction "input" )
( nil name "OUT" direction "output" )))
 
schPinListToSymbolGen(libName cellName "symbol" pinList)

schCheck(cvid)  /* Check Connectivity*/

    dbSave(cvid)
    printf("Creating Symbol from Schematic")
    
    dbClose(cvid)
	
    return(t)
	
  )/*End Prog*/
  
)/* End Procedure*/



/*====================================================================
 'let' is the main entrance of the skill program.
  This executes the procedure to build a 6T Cell
====================================================================*/
;;let((N libName cellName pWidth nWidth pLength nLength cellLibName nCell)  
 
  /* Library for the output cell*/
  ;;libName="SRAMGen"
  
  /* What the cell name is called*/
 
;;pWidth = "2"
;;nWidth  = "2"
;;pLength = "2"
;;nLength  = "1"
;;sprintf(cellLibName "cmos090")
;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
 ;;sprintf(cellName "gen-INV8" nWidth nLength pWidth pLength)


  /* Run the Procedure*/
  ;;schemINV(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName)


  ;;printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
