/*====================================================================

Generates the readCkt
and nessecary subcomponents
Written by  Ahmed Abdelazeem. 2021.
=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(readCktSchem(libName cellName nCell pCell cellLibName
inv_1_plength 
inv_1_pwidth  
inv_1_nwidth 
inv_1_nlength
inv_2_plength 
inv_2_pwidth  
inv_2_nwidth 
inv_2_nlength
sa_plength 
sa_pwidth  
sa_nwidth 
sa_nlength
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

foreach(pinName list("VDD" "VSS" "BLB" "BL" "SAE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    
foreach(pinName list("DATAOUT")
      pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0")
      y=y+0.5
    )
			

y=0
x=3



/*****************************
THIS SECTION CREATES CUSTOM CELLS FOR USE WITH THIS INSTANCE
******************************/

/******** SENSE AMP **********/
load("./skill/schemSenseAmp.il")

saCell = "SenseAmp"
schemSenseAmp(libName saCell sa_plength 
sa_pwidth  
sa_nwidth 
sa_nlength nCell pCell cellLibName gate
base
drain
source)

inst = lpSchematicCreateInst( cvid libName saCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "sense_amp")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("BL" "BL")
list("BLB" "BLB")
list("SAE" "SAE")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "sao")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+3

/************* INVERTER CREATION *****************/
x=x+1
load("./skill/schemINV.il")

invCell = "readBuffInv1"
schemINV(libName invCell inv_1_plength inv_1_pwidth inv_1_nwidth inv_1_nlength  nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName invCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "inv_1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("IN" "sao")
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

invCell = "readBuffInv2"
schemINV(libName invCell inv_2_plength inv_2_pwidth inv_2_nwidth inv_2_nlength  nCell pCell cellLibName gate
base
drain
source)
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
  		   list(list("OUT" "DATAOUT")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+3












/* Check and Save*/
pinList = `( nil ports (( nil name "SAE" direction "input" )
( nil name "DATAOUT" direction "output" )
( nil name "VDD" direction "input" )
( nil name "VSS" direction "input" )
( nil name "BLB" direction "input" )
( nil name "BL" direction "input" )))
 
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
  ;;sprintf(cellName "ReadCircuit")

;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
;;sprintf(cellLibName "cmos090")

  /* Run the Procedure*/
  ;;readCktSchem(libName cellName nCell pCell cellLibName)

;;  printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
