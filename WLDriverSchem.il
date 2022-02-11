/*====================================================================

Generates the Write Logic
and nessecary subcomponents
Written by Tyler Healy Jan. 2009.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(WLDriverSchem(libName cellName nCell pCell cellLibName
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
inv_3_plength 
inv_3_pwidth  
inv_3_nwidth 
inv_3_nlength
gate
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

foreach(pinName list("VDD" "VSS" "WLSEL" "ENABLE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    
foreach(pinName list("WLOUT")
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

invCell = "wlDriveInv1"
schemINV(libName invCell inv_1_plength inv_1_pwidth inv_1_nwidth inv_1_nlength  nCell pCell cellLibName gate
base
drain
source
)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName invCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "nand_out")
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

invCell = "wlDriveInv2"
schemINV(libName invCell inv_2_plength inv_2_pwidth inv_2_nwidth inv_2_nlength  nCell pCell cellLibName gate
base
drain
source
)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName invCell "symbol" 
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

nandCell = "WLDriveNand1"
schemNAND_2to1(libName nandCell nand_1_plength 
nand_1_pwidth  
nand_1_nwidth 
nand_1_nlength nCell pCell cellLibName gate
base
drain
source
)
/* Create a NAND*/
  inst = lpSchematicCreateInst( cvid libName nandCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "nand_1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("A" "WLSEL")
			list("B" "ENABLE")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "nand_out")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/




/************* INVERTER CREATION *****************/
x=x+3
load("./skill/schemINV.il")

invCell = "WlDriveInv2"
schemINV(libName invCell inv_3_plength inv_3_pwidth inv_3_nwidth inv_3_nlength  nCell pCell cellLibName gate
base
drain
source
)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName invCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_3")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "inv2_out")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "WLOUT")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+3




/* Check and Save*/
pinList = `( nil ports (( nil name "ENABLE" direction "input" )
( nil name "WLOUT" direction "output" )
( nil name "VDD" direction "input" )
( nil name "VSS" direction "input" )
( nil name "WLSEL" direction "input" )))
 
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
  ;;sprintf(cellName "WLDriverGEN")

;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
;;sprintf(cellLibName "cmos090")

  /* Run the Procedure*/
  ;;WLDriverSchem(libName cellName nCell pCell cellLibName)

  ;;printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
