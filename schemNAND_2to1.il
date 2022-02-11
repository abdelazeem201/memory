/*====================================================================

Generates a 2 to 1 NAND
Written by Tyler Healy Jan. 2009.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")


procedure(schemNAND_2to1(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName gate
base
drain
source)
;;Local Variables
  prog((cvid x y pin pinName)
  
	/* Create the CellView */
    cvid = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a")
	
	/* Clean the Schematic*/
    lpDeleteObjectsSchematic(cvid)
	
	/* Origin Point*/
    x=0
y=0

foreach(pinName list("VDD" "VSS" "A" "B")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    
foreach(pinName list("OUT")
      pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0")
      y=y+0.5
    )
			

y=0
x=x+4

/* Place MOSFET Cells*/

/*PD A NMOS*/
jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M1" 
list(list(gate "A")) 
list(list(base "VSS")) 
list(list(drain "OUT"))
list(list(source "conn0"))
x:y "R0"  nWidth nLength "1" "1")

x=x+1

/*PD B NMOS*/
jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M2" 
list(list(gate "B")) 
list(list(base "VSS")) 
list(list(drain "conn0"))
list(list(source "VSS"))
x:y "R0"  nWidth nLength "1" "1")

x=x+1

/*PU A PMOS*/
jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M3" 
list(list(gate "A")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "OUT"))
x:y "R0"  pWidth pLength "1" "1")

x=x+1

/*PU B PMOS*/
jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M4" 
list(list(gate "B")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "OUT"))
x:y "R0"  pWidth pLength "1" "1")

x=x+1



	
/* Check and Save*/
pinList = `( nil ports (( nil name "B" direction "input" )
( nil name "A" direction "input" )
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
;;let((libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName)  
 
  /* Library for the output cell*/
 ;;libName="SRAMGen"
  
  /* What the cell name is called*/
;;sprintf(cellName "gen-NAND_2to1")
;;sprintf(pLength  "2")
;;sprintf(pWidth  "2")
;;sprintf(nWidth  "2")
;;sprintf(nLength "2")
;;sprintf(nCell  "nsvt")
;;sprintf(pCell  "psvt")
;;sprintf(cellLibName "cmos090")

  /* Run the Procedure*/
  ;;schemNAND_2to1(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName)

;;  printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
