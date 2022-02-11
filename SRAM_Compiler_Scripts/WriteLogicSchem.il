/*====================================================================

Generates the Write Logic
and nessecary subcomponents
Written by Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(WriteLogicSchem(libName cellName nCell pCell cellLibName
inv_1_plength 
inv_1_pwidth  
inv_1_nwidth 
inv_1_nlength
inv_2_plength 
inv_2_pwidth  
inv_2_nwidth 
inv_2_nlength
nand_1_plength 
nand_1_pwidth  
nand_1_nwidth 
nand_1_nlength
nand_2_plength 
nand_2_pwidth  
nand_2_nwidth 
nand_2_nlength
inv_3_plength 
inv_3_pwidth  
inv_3_nwidth 
inv_3_nlength
inv_4_plength 
inv_4_pwidth  
inv_4_nwidth 
inv_4_nlength
fetNLength
fetNWidth
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

foreach(pinName list("VDD" "VSS" "DATAIN" "WRITE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    
foreach(pinName list("BL" "BLB")
      pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0")
      y=y+0.5
    )
			

y=0
x=3



/*****************************
THIS SECTION CREATES CUSTOM CELLS FOR USE WITH THIS INSTANCE
******************************/


/************* INVERTER CREATION *****************/
x=x+1
load("./skill/schemINV.il")

invCell = "dataInInv1"
schemINV(libName invCell inv_1_plength inv_1_pwidth inv_1_nwidth inv_1_nlength  nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName "dataInInv1"  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "DATAIN")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "inv1_out")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+2


/************* INVERTER CREATION *****************/
x=x+1
load("./skill/schemINV.il")

invCell = "dataInInv2"
schemINV(libName invCell inv_2_plength inv_2_pwidth inv_2_nwidth inv_2_nlength  nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName "dataInInv2"  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_2")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "inv1_out")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "inv2_out")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+3


/********* NAND CREATION *****************/
load("./skill/schemNAND_2to1.il")

nandCell = "WriteLogNand1"
schemNAND_2to1(libName nandCell nand_1_plength 
nand_1_pwidth  
nand_1_nwidth 
nand_1_nlength nCell pCell cellLibName gate
base
drain
source)
/* Create a NAND*/
  inst = lpSchematicCreateInst( cvid libName "WriteLogNand1"  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "nand_1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("A" "WRITE")
			list("B" "inv1_out")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "nand1_out")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+4
/********* NAND CREATION *****************/
load("./skill/schemNAND_2to1.il")

nandCell = "WriteLogNand2"
schemNAND_2to1(libName nandCell nand_2_plength 
nand_2_pwidth  
nand_2_nwidth 
nand_2_nlength nCell pCell cellLibName gate
base
drain
source)
/* Create a NAND*/
  inst = lpSchematicCreateInst( cvid libName "WriteLogNand2" "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "nand_2")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("A" "WRITE")
			list("B" "inv2_out")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "nand2_out")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/


/************* INVERTER CREATION *****************/
x=x+3
load("./skill/schemINV.il")

invCell = "WriteLogInv3"
schemINV(libName invCell inv_3_plength inv_3_pwidth inv_3_nwidth inv_3_nlength  nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName invCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_3")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "nand1_out")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "inv3_out")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+3


/************* INVERTER CREATION *****************/
x=x+1
load("./skill/schemINV.il")

invCell = "WriteLogInv4"
schemINV(libName invCell inv_4_plength inv_4_pwidth inv_4_nwidth inv_4_nlength  nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName invCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_4")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "nand2_out"))
			
		   /*No Other Side Pins*/
  		   list(list("OUT" "inv4_out")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+3

/* Create FET */

jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M1" 
list(list(gate "inv3_out")) 
list(list(base "VSS")) 
list(list(drain "BLB"))
list(list(source "VSS"))
x:y "R0"  fetNWidth fetNLength "1" "1") 

x=x+2
/* Create FET */

jwSchematicCreateFETInst(cvid cellLibName nCell "symbol" "M2" 
list(list(gate "inv4_out")) 
list(list(base "VSS")) 
list(list(drain "BL"))
list(list(source "VSS"))
x:y "R0"  fetNWidth fetNLength "1" "1") 

/* Check and Save*/
pinList = `( nil ports (( nil name "BLB" direction "output" )
( nil name "BL" direction "output" )
( nil name "VDD" direction "input" )
( nil name "VSS" direction "input" )
( nil name "DATAIN" direction "input" )
( nil name "WRITE" direction "input" )))
 
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
====================================================================*/
;;let((libName cellName  nCell pCell cellLibName)  
 
  /* Library for the output cell*/
  ;;libName="SRAMGen"
  
  /* What the cell name is called*/
  ;;sprintf(cellName "WriteLogic")

;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
;;sprintf(cellLibName "cmos090")

  /* Run the Procedure*/
  ;;WriteLogicSchem(libName cellName nCell pCell cellLibName)

  ;;printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
