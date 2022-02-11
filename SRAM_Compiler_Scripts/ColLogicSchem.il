/*====================================================================

Generates the Column parts
and nessecary subcomponents
Written by  Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")


procedure(ColLogicSchem(libName cellName nCell pCell cellLibName 
prePWidth 
prePLength
nand_1_plength 
nand_1_pwidth  
nand_1_nwidth 
nand_1_nlength
inv_1_plength 
inv_1_pwidth  
inv_1_nwidth 
inv_1_nlength
txPLength
txPWidth
txNLength
txNWidth
gate
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

foreach(pinName list("VDD" "VSS" "PREBAR" "COLSEL" "ENABLE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    
foreach(pinName list("BL" "BLB")
      pin=lpSchematicCreatePin(cvid pinName "inputOutput" x:y "R0")
      y=y+0.5
    )
			

y=0
x=3

/*****************************
THIS SECTION CREATES CUSTOM CELLS FOR USE WITH THIS INSTANCE
******************************/

/*PRECHARGE PMOSES*/
y=4

jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M1" 
list(list(gate "PREBAR")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "BL_in"))
x:y "R0"  prePWidth prePLength "1" "1") 


x=x+1


jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M2" 
list(list(gate "PREBAR")) 
list(list(base "VDD")) 
list(list(source "VDD"))
list(list(drain "BLB_in"))
x:y "R0"  prePWidth prePLength "1" "1") 

x=x+1


jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M3" 
list(list(gate "PREBAR")) 
list(list(base "VDD")) 
list(list(source "BL_in"))
list(list(drain "BLB_in"))
x:y "R0"  prePWidth prePLength "1" "1") 

x=x+1




/********* NAND CREATION *****************/
load("./skill/schemNAND_2to1.il")

nandCell = "ColSelNAND"
schemNAND_2to1(libName nandCell nand_1_plength 
nand_1_pwidth  
nand_1_nwidth 
nand_1_nlength nCell pCell cellLibName gate
base
drain
source)
/* Create a NAND*/
  inst = lpSchematicCreateInst( cvid libName nandCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "nand_1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("A" "COLSEL")
			list("B" "ENABLE")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "ColSel_o")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

/************* INVERTER CREATION *****************/
x=x+4
load("./skill/schemINV.il")

invCell = "ColSelINV"
schemINV(libName invCell inv_1_plength inv_1_pwidth inv_1_nwidth inv_1_nlength  nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName invCell "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "COLSEL")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "ColSelBar")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+4

/* TX-GATE CREATION */

jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M4" 
list(list(gate "ColSelBar")) 
list(list(base "VDD")) 
list(list(source "BL_in"))
list(list(drain "BL"))
x:y "R0"  txPWidth txPLength "1" "1") 

x=x+1


jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M5" 
list(list(gate "ColSel_o")) 
list(list(base "VSS")) 
list(list(drain "BL_in"))
list(list(source "BL"))
x:y "R0"  txNWidth txNLength "1" "1") 

x=x+1
/* TX-GATE CREATION */

jwSchematicCreateFETInst(cvid cellLibName pCell "symbol" "M6" 
list(list(gate "ColSelBar")) 
list(list(base "VDD")) 
list(list(source "BLB_in"))
list(list(drain "BLB"))
x:y "R0"  txPWidth txPLength "1" "1") 

x=x+1

jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M7" 
list(list(gate "ColSel_o")) 
list(list(base "VSS")) 
list(list(drain "BLB_in"))
list(list(source "BLB"))
x:y "R0"  txNWidth txNLength "1" "1") 
x=x+1



	
/* Check and Save*/
pinList = `( nil ports (( nil name "PREBAR" direction "input" )
( nil name "COLSEL" direction "input" )
( nil name "VDD" direction "input" )
( nil name "VSS" direction "input" )
( nil name "BL" direction "inputOutput" )
( nil name "BLB" direction "inputOutput" )
( nil name "ENABLE" direction "input" )
))
 
schPinListToSymbolGen(libName cellName "symbol" pinList)
    schCheck(cvid)  /* Check Connectivity*/
    printf("Creating Symbol from Schematic")

    dbSave(cvid)
    dbClose(cvid)
	
    return(t)
	
  )/*End Prog*/
  
)/* End Procedure*/



/*====================================================================
 'let' is the main entrance of the skill program.
  This executes the procedure to build a 6T Cell
====================================================================*/;;let((libName cellName  nCell pCell cellLibName)  
 
  /* Library for the output cell*/
  ;;libName="SRAMGen"
  
  /* What the cell name is called*/
 ;;sprintf(cellName "ColumnLogic")

;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
;;sprintf(cellLibName "cmos090")

  /* Run the Procedure*/
  ;;ColLogicSchem(libName cellName nCell pCell cellLibName)

  ;;printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */

