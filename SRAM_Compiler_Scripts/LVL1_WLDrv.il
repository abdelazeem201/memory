/*====================================================================



Written by  Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



procedure(LVL1_WLDrv(libName cellName C R  wlCellName)
;;Local Variables
  prog((cvid x y pin pinName k j i inName inNameEN inNameBL inNameBLB outName outName1 enable precharge inst pPre pPreB blPin blbPin wlPin)
  
	/* Create the CellView */
    cvid = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a")
	
	/* Clean the Schematic*/
    lpDeleteObjectsSchematic(cvid)
	
	/* Origin Point for the Array*/
    x=0
    y=0
	
  
    foreach(pinName list("VDD" "VSS")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )

	
	x=0
	y=-2
	
	
  		inName=sprintf(nil "WLSEL<0:%L>" R-1)
		foreach(pinName list(inName)
			pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
		)
		y = y-1
		inName=sprintf(nil "ENABLE" R-1)
		foreach(pinName list(inName)
			pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
		)
		y = y-1
	
	/* Create BL and BLB Pins, Set Coords*/
	x=2
	y=1



  		outName = sprintf(nil "WLOUT<0:%L>" R-1)
		
		foreach(pinName list(outName)
			pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0")
		x=x+.5
		)
		x=x+1
	
			
	
	
/* Coords for First Bitcell*/
    x=1
    y=0
	
/* For Loops to Place Instances of Bitcells*/
    for(k 0 R-1		
	
	
	inName=sprintf(nil "WLSEL<%L>" k)
	inNameEN=sprintf(nil "ENABLE" k)
	outName = sprintf(nil "WLOUT<%L>" k)
	
	/* Create the instance*/
	  inst = lpSchematicCreateInst( cvid libName wlCellName  "symbol" 
			/*Set Cell Name*/			
			sprintf(nil "CELL%L" k)    
			   /*Left Side Pins*/
	          	   list(list("WLSEL" inName)
				list("ENABLE" inNameEN)
	           		list("VSS" "VSS")
				list("VDD" "VDD"))
			   /*No Right Side Pins*/
	  		   list(list("WLOUT" outName))
			/*TopSide Pins*/
      		   nil
			   
			 /*Bottom Side Pins*/
	           nil
			   
		/*Location*/
               x:y 
			   
			   
			   "R0"
			 )/* End Cell Place*/
        
	
	  
	  x = x+3
	  
    	
    	
    )/* End for K*/


	
	
/* Check and Save*/
schCheck(cvid)  /* Check Connectivity*/

    dbSave(cvid)

pinList = schSchemToPinList(libName cellName "schematic")
;;pinList = `( nil ports (( nil name preLine direction "inputOutput" )
;;( nil name preLineB direction "inputOutput" )
;;( nil name "VDD" direction "input" )
;;( nil name "VSS" direction "input" )
;;( nil name  direction "input" )))
schPinListToSymbolGen(libName cellName "symbol" pinList)

	schCheck(cvid)  /* Check Connectivity*/

    dbSave(cvid)


    dbClose(cvid)
	
    return(t)
	
  )/*End Prog*/
  
)/* End Procedure*/



/*====================================================================
 'let' is the main entrance of the skill program.
  This executes the procedure to build and NxM SRAM array
====================================================================*/
;;let((N libName cellName)  

;;  /* Cell Numbers, Row and Cols*/
 ;; C = 4 
  ;;R = 6
 
  /* Library for the output cell*/
;;  libName="SRAMGen"
;; bitCellName = "6TCell"
  
  /* What the cell name is called*/
 ;; sprintf(cellName "BLK_%Lx%L" C R)

  /* Run the Procedure*/
  ;;schemBLK(libName cellName C R bitCellName)

;;  printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) /* End Let */
 
