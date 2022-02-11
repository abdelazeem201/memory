/*====================================================================

Generates a 6TCell
Written by Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(CellGen(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName accWidth accLength
gate
base
drain
source
)
;;Local Variables
  prog((cvid x y pin pinName)
  
	/* Create the CellView */
	/* Create the CellView */
    cvid = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a")
	
	/* Clean the Schematic*/
    lpDeleteObjectsSchematic(cvid)
	
	/* Origin Point*/
    x=0
	y=0
foreach(pinName list("VDD" "VSS" "WL")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    


foreach(pinName list("BL" "BLB")
pin=lpSchematicCreatePin(cvid pinName "inputOutput" x:y "R0")
		y=y+.5
		)
			

y=0
x=x+3
/* Place MOSFET Cells*/

/*PullDown for BLB*/
jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M1" 
list(list(gate "conn0")) 
list(list(base "VSS")) 
list(list(drain "conn1"))
list(list(source "VSS"))
x:y "R0"  nWidth nLength "1" "1")

x=x+1

/*PullUp for BLB*/
jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M2" 
list(list(gate "conn0")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "conn1"))
x:y "R0"  pWidth pLength "1" "1") 

x=x+1

/*PullDown for BL*/
jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M3" 
list(list(gate "conn1")) 
list(list(base "VSS")) 
list(list(drain "conn0"))
list(list(source "VSS"))
x:y "R0"  nWidth nLength "1" "1") 

x=x+1

/*PullUp for BL*/
jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M4" 
list(list(gate "conn1")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "conn0"))
x:y "R0"  pWidth pLength "1" "1") 

x=x+1

/*BLB Access*/
jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M5" 
list(list(gate "WL")) 
list(list(base "VSS")) 
list(list(drain "BLB"))
list(list(source "conn1"))
x:y "R0" accWidth accLength "1" "1") 

x=x+1

/*BL Access*/
jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M6" 
list(list(gate "WL")) 
list(list(base "VSS")) 
list(list(drain "BL"))
list(list(source "conn0"))
x:y "R0"  accWidth accWidth "1" "1") 

x=x+1

	
/* Check and Save*/
pinList = `( nil ports (( nil name "BLB" direction "inputOutput" )
( nil name "BL" direction "inputOutput" )
( nil name "VDD" direction "input" )
( nil name "VSS" direction "input" )
( nil name "WL" direction "input" )))
 
schPinListToSymbolGen(libName cellName "symbol" pinList)
    schCheck(cvid)  /* Check Connectivity*/
    dbSave(cvid)
    dbClose(cvid)
	
    return(t)
	
  )/*End Prog*/
  
)/* End Procedure*/




/*====================================================================
 'let' is the main entrance of the skill program.
  This executes the procedure to build a 6T Cell
====================================================================*/
;;let((N libName cellName pWidth nWidth pLength nLength cellLibName nCell accWidth accLength)  
 
  /* Library for the output cell*/
  ;;libName="SRAMGen"
  
  /* What the cell name is called*/
  ;;sprintf(cellName "6TCell")
;;sprintf(pWidth  "2")
;;sprintf(nWidth  "2")
;;sprintf(pLength  "2")
;;sprintf(nLength  "2")
;;sprintf(cellLibName "cmos090")
;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
;;sprintf(accWidth "2")
;;sprintf(accLength "2")

  /* Run the Procedure*/
  ;;CellGen(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName accWidth accLength)

;;  printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
