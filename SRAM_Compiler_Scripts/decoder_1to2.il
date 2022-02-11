/*====================================================================

Generates a 1 to 2 decoder
Written by  Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(decoder_1to2(libName cellName nCell pCell cellLibName
inv_1_plength 
inv_1_pwidth  
inv_1_nwidth 
inv_1_nlength
and_1_plength 
and_1_pwidth  
and_1_nwidth 
and_1_nlength
and_2_plength 
and_2_pwidth  
and_2_nwidth 
and_2_nlength gate
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

foreach(pinName list("VDD" "VSS" "IN" "ENABLE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
    
foreach(pinName list("OUT0" "OUT1")
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

invCell = "Decoder_1to2_Inverter1"
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
			list("IN" "IN")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "INBAR")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+2

/************* AND CREATION *****************/
x=x+1
load("./skill/schemAND_2to1.il")

andCell = "Decoder_1to2_And1"
schemAND_2to1(libName andCell and_1_plength and_1_pwidth and_1_nwidth and_1_nlength nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName andCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "and1")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("A" "IN")
			list("B" "ENABLE")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "OUT1")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+2

/************* AND CREATION *****************/
x=x+1
load("./skill/schemAND_2to1.il")

andCell = "Decoder_1to2_And2"
schemAND_2to1(libName andCell and_2_plength and_2_pwidth and_2_nwidth and_2_nlength nCell pCell cellLibName gate
base
drain
source)
/* Create an INV*/
  inst = lpSchematicCreateInst( cvid libName andCell  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "and2")    
		   /*Left Side Pins*/
	  	   list(list("VDD" "VDD")
	   		list("VSS" "VSS")
			list("A" "INBAR")
			list("B" "ENABLE")
			)
		   /*No Other Side Pins*/
  		   list(list("OUT" "OUT0")) nil nil
		   
	/*Location*/
       x:y "R0"
	)/* End Cell Place*/

x=x+2






/* Check and Save*/
pinList = `( nil ports (( nil name "IN" direction "input" )
( nil name "OUT0" direction "output" )
( nil name "VDD" direction "input" )
( nil name "ENABLE" direction "input" )
( nil name "VSS" direction "input" )
( nil name "OUT1" direction "output" )))
 
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
  ;;sprintf(cellName "decoder_1to2")

;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
;;sprintf(cellLibName "cmos090")

  /* Run the Procedure*/
  ;;decoder_1to2(libName cellName nCell pCell cellLibName)

 ;; printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
