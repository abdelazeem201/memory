/*====================================================================

Generates a Basic Diff Sense Amp
Written by  Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(schemSenseAmp(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName gate
base
drain
source)
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
foreach(pinName list("VDD" "VSS" "BL" "BLB" "SAE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    


foreach(pinName list("OUT")
pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0")
		y=y+.5
		)
			

y=0
x=x+3
/* Place MOSFET Cells*/

jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M1" 
list(list(gate "BL")) 
list(list(base "VSS")) 
list(list(drain "conn1"))
list(list(source "conn2"))
x:y "R0"  nWidth nLength "1" "1")

x=x+1


jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M2" 
list(list(gate "BLB")) 
list(list(base "VSS")) 
list(list(drain "y"))
list(list(source "conn2"))
x:y "R0"  pWidth pLength "1" "1") 

x=x+1


jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M3" 
list(list(gate "conn1")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "conn1"))
x:y "R0"  nWidth nLength "1" "1") 

x=x+1


jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M4" 
list(list(gate "conn1")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "y"))
x:y "R0"  pWidth pLength "1" "1") 

x=x+1


jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M5" 
list(list(gate "SAE")) 
list(list(base "VSS")) 
list(list(drain "conn2"))
list(list(source "VSS"))
x:y "R0" nWidth nLength "1" "1") 

x=x+1


jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M6" 
list(list(gate "y")) 
list(list(base "VSS")) 
list(list(drain "OUT"))
list(list(source "VSS"))
x:y "R0"  nWidth nWidth "1" "1") 

x=x+1

jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M7" 
list(list(gate "y")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "OUT"))
x:y "R0"  pWidth pLength "1" "1") 

x=x+1

	
/* Check and Save*/
pinList = `( nil ports (( nil name "BLB" direction "input" )
( nil name "BL" direction "input" )
( nil name "VDD" direction "input" )
( nil name "VSS" direction "input" )
( nil name "SAE" direction "input" )
( nil name "OUT" direction "output" )))
 
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
 
;;  /* Library for the output cell*/
 ;; libName="SRAMGen"
  
 ;; /* What the cell name is called*/
 ;; sprintf(cellName "SenseAmp")
;;sprintf(pWidth  "2")
;;sprintf(nWidth  "2")
;;sprintf(pLength  "2")
;;sprintf(nLength  "2")
;;sprintf(cellLibName "cmos090")
;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")


  ;;/* Run the Procedure*/
  ;;schemSenseAmp(libName cellName pLength pWidth nWidth nLength nCell pCell cellLibName)

;;  printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
