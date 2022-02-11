/*====================================================================

Generates a single block SRAM RxC 
Written by  Ahmed Abdelazeem. 2021.

=====================================================================*/

;;Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")


procedure(SRAMGenerator(R C libName cellName  nCell pCell cellLibName 
bitcell_pWidth
bitcell_pLength
bitcell_nWidth
bitcell_nLength
bitcell_accessLength
bitcell_accessWidth
wldriver_inv_1_plength 
wldriver_inv_1_pwidth  
wldriver_inv_1_nwidth 
wldriver_inv_1_nlength
wldriver_inv_2_plength 
wldriver_inv_2_pwidth  
wldriver_inv_2_nwidth 
wldriver_inv_2_nlength
wldriver_nand_1_plength 
wldriver_nand_1_pwidth  
wldriver_nand_1_nwidth 
wldriver_nand_1_nlength
wldriver_inv_3_plength 
wldriver_inv_3_pwidth  
wldriver_inv_3_nwidth 
wldriver_inv_3_nlength
collogic_precharge_pwidth 
collogic_precharge_plength
collogic_nand_1_plength 
collogic_nand_1_pwidth  
collogic_nand_1_nwidth 
collogic_nand_1_nlength
collogic_inv_1_plength 
collogic_inv_1_pwidth  
collogic_inv_1_nwidth 
collogic_inv_1_nlength
collogic_txPLength
collogic_txPWidth
collogic_txNLength
collogic_txNWidth
writelog_inv_1_plength 
writelog_inv_1_pwidth  
writelog_inv_1_nwidth 
writelog_inv_1_nlength
writelog_inv_2_plength 
writelog_inv_2_pwidth  
writelog_inv_2_nwidth 
writelog_inv_2_nlength
writelog_nand_1_plength 
writelog_nand_1_pwidth  
writelog_nand_1_nwidth 
writelog_nand_1_nlength
writelog_nand_2_plength 
writelog_nand_2_pwidth  
writelog_nand_2_nwidth 
writelog_nand_2_nlength
writelog_inv_3_plength 
writelog_inv_3_pwidth  
writelog_inv_3_nwidth 
writelog_inv_3_nlength
writelog_inv_4_plength 
writelog_inv_4_pwidth  
writelog_inv_4_nwidth 
writelog_inv_4_nlength
writelog_fetNLength
writelog_fetNWidth
readlogic_inv_1_plength 
readlogic_inv_1_pwidth  
readlogic_inv_1_nwidth 
readlogic_inv_1_nlength
readlogic_inv_2_plength 
readlogic_inv_2_pwidth  
readlogic_inv_2_nwidth 
readlogic_inv_2_nlength
sa_plength 
sa_pwidth  
sa_nwidth 
sa_nlength
rowdecoder_inv_1_plength 
rowdecoder_inv_1_pwidth  
rowdecoder_inv_1_nwidth 
rowdecoder_inv_1_nlength
rowdecoder_and_1_plength 
rowdecoder_and_1_pwidth  
rowdecoder_and_1_nwidth 
rowdecoder_and_1_nlength
rowdecoder_and_2_plength 
rowdecoder_and_2_pwidth  
rowdecoder_and_2_nwidth 
rowdecoder_and_2_nlength
coldecoder_inv_1_plength 
coldecoder_inv_1_pwidth  
coldecoder_inv_1_nwidth 
coldecoder_inv_1_nlength
coldecoder_and_1_plength 
coldecoder_and_1_pwidth  
coldecoder_and_1_nwidth 
coldecoder_and_1_nlength
coldecoder_and_2_plength 
coldecoder_and_2_pwidth  
coldecoder_and_2_nwidth 
coldecoder_and_2_nlength
rbits
cbits
gate
base
drain
source
)

;;Local Variables
  prog((cvid x y pin pinName wlInNeti wlNet blNet  blbNet driverCell  wlOutNeti 
	preChargeSchem  enableWL colSel bl blb write datain writeLog dataout readLog sae rnet label outNet inNet)
  
	/* Create the CellView */
    cvid = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a")
	
	/* Clean the Schematic*/
    lpDeleteObjectsSchematic(cvid)
	
	/* Origin Point*/
x=0
y=0

foreach(pinName list("VDD" "VSS" "PREBAR" "ENABLE" "READ" "WRITE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
x=-2

tempAdd = sprintf(nil "DATAIN<0:%L>" C-1)
	foreach(pinName list(tempAdd)
      	pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
     	 y=y+0.5
    	)


x=-3

tempAdd = sprintf(nil "DATAOUT<0:%L>" C-1)
	foreach(pinName list(tempAdd)
      	pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0")
     	 y=y+0.5
    	)

x=-4

  		tempAdd = sprintf(nil "ColAdd<0:%L>" cbits-1)
		
		foreach(pinName list(tempAdd)
			pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
		
		)
		y=y-1
	



  		tempAdd = sprintf(nil "RowAdd<0:%L>" rbits-1)
		
		foreach(pinName list(tempAdd)
			pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
		
		)
	
		y=y-1



x=0
y=0
/**** GLOBAL PARAMS ****/


x=2
/**************************
 BEGIN ARRAY GENERATOR
************************/
load("./skill/schemBLK.il")
load("./skill/CellGen.il")
printf("Begin Array Generator")

/*Generate a 6T Bitcell */
bitCellName = "BitCell"
pWidth  ="2"
nWidth  ="2"
pLength = "2"
nLength = "2"

accWidth ="2"
accLength ="2"
CellGen(libName bitCellName bitcell_pLength bitcell_pWidth bitcell_nWidth bitcell_nLength nCell pCell cellLibName bitcell_accessWidth bitcell_accessLength gate
base
drain
source
)
/* End BitCell Generate*/

/*Begin RxC Array*/
arrayName = "Array6T"
schemBLK(libName arrayName C R  bitCellName)
vddNet = "VDD"
vssNet = "VSS"
sprintf(wlNet "WL<0:%L>" R)
sprintf(blNet "BL<0:%L>" C)
sprintf(blbNet "BLB<0:%L>" C)

/* Create the instance*/
	  inst1 = lpSchematicCreateInst( cvid libName arrayName  "symbol" 
			/*Set Cell Name*/			
			sprintf(nil "arrayInst")    
			   /*Left Side Pins*/
	          	   list(list("VDD" "VDD") list("VSS" "VSS")) nil nil nil
			   
x:y 
"R0")/* End Cell Place*/

i=0
mstr = dbOpenCellViewByType(libName arrayName "symbol")

wlNet = sprintf(nil "WL<0:%L>" R-1)
pinList = list(list(wlNet))
lpAddLabelsToInstPins(cvid inst1 x:y mstr pinList "left")



blNet = sprintf(nil "BL<0:%L>" C-1)
blbNet = sprintf(nil "BLB<0:%L>" C-1)
pinList = list(list(blNet) list(blbNet))
lpAddLabelsToInstPins(cvid inst1 x:y mstr pinList "top")

/* End RxC Array*/


/**********************
END ARRAY GENERATOR
 *******************/
x=5
/********************************
 BEGIN WORDLINE CIRCUITRY GENERATOR
***********************************/

load("./skill/WLDriverSchem.il")
load("./skill/LVL1_WLDrv.il")
printf("Begin Wordline Generator")
driverCellName = "WLDriver"
LVL1Name = "TopLevel_WLDriver"

WLDriverSchem(libName driverCellName nCell pCell cellLibName
wldriver_inv_1_plength 
wldriver_inv_1_pwidth  
wldriver_inv_1_nwidth 
wldriver_inv_1_nlength
wldriver_inv_2_plength 
wldriver_inv_2_pwidth  
wldriver_inv_2_nwidth 
wldriver_inv_2_nlength
wldriver_nand_1_plength 
wldriver_nand_1_pwidth  
wldriver_nand_1_nwidth 
wldriver_nand_1_nlength
wldriver_inv_3_plength 
wldriver_inv_3_pwidth  
wldriver_inv_3_nwidth 
wldriver_inv_3_nlength 
gate
base
drain
source
)
i = 0

LVL1_WLDrv(libName LVL1Name C R driverCellName)

		  sprintf(wlInNeti "WLSEL<0:%L>" R-1)
			sprintf(wlOutNeti "WL<0:%L>" R-1)
			sprintf(enableWL "ENABLE" R-1)
			sprintf(driverCell "WLDrivers")

	

 		  inst = lpSchematicCreateInst( cvid libName LVL1Name  "symbol" 
			/*Set Cell Name*/			
			sprintf(nil driverCell)    
			   /*Left Side Pins*/
	          	   list(list("VDD" "VDD")
				list("VSS" "VSS")
				list(sprintf(nil "WLSEL<0:%L>" R-1) wlInNeti)
	           		list("ENABLE" enableWL))

				

				list(list(sprintf(nil "WLOUT<0:%L>" R-1) wlOutNeti))

				nil
nil
			   
x:y 
"R0")/* End Cell Place*/
y=y-1



/******************************* 
END WORDLINE CIRCUITRY GENERATOR 
*******************************/

/********************************
 BEGIN Bitline CIRCUITRY GENERATOR
********************************** */

x=5
y=-2
/********** PRECHARGE ****************/
load("./skill/ColLogicSchem.il")
load("./skill/LVL1_ColLogic.il")
preChargeSchemCell = "preChargeSchem"
LVL1_preChargeSchem = "TopLevel_PreChargeSchem"

ColLogicSchem(libName preChargeSchemCell nCell pCell cellLibName 
collogic_precharge_pwidth 
collogic_precharge_plength
collogic_nand_1_plength 
collogic_nand_1_pwidth  
collogic_nand_1_nwidth 
collogic_nand_1_nlength
collogic_inv_1_plength 
collogic_inv_1_pwidth  
collogic_inv_1_nwidth 
collogic_inv_1_nlength
collogic_txPLength
collogic_txPWidth
collogic_txNLength
collogic_txNWidth
gate
base
drain
source)

LVL1_ColLogic(libName LVL1_preChargeSchem C R preChargeSchemCell)



			sprintf(colSel "COLSEL<0:%L>" C-1)
			sprintf(bl "BL<0:%L>" C-1)
			sprintf(blb "BLB<0:%L>" C-1)
			sprintf(preChargeSchem "Precharge%L" i)
	 inst = lpSchematicCreateInst( cvid libName LVL1_preChargeSchem "symbol" 
		/*Set Cell Name*/			
		sprintf(nil preChargeSchem)    
		   /*Left Side Pins*/
	             list(list("VDD" "VDD")
			list("VSS" "VSS")
			list("PREBAR" "PREBAR")
	             list(colSel colSel)
			list("ENABLE" "ENABLE")
			)
nil
			list(list(bl bl)
			list(blb blb))



nil

		   
x:y 
"R0")/* End Cell Place*/
y=y-2



x=5
y=y-1
/************ WRITE LOGIC **************/
load("./skill/WriteLogicSchem.il")
load("./skill/LVL1_WriteLog.il")
wLogic = "WriteLogic"
LVL1_WriteLogic = "TopLevel_WriteLogic"


WriteLogicSchem(libName wLogic nCell pCell cellLibName
writelog_inv_1_plength 
writelog_inv_1_pwidth  
writelog_inv_1_nwidth 
writelog_inv_1_nlength
writelog_inv_2_plength 
writelog_inv_2_pwidth  
writelog_inv_2_nwidth 
writelog_inv_2_nlength
writelog_nand_1_plength 
writelog_nand_1_pwidth  
writelog_nand_1_nwidth 
writelog_nand_1_nlength
writelog_nand_2_plength 
writelog_nand_2_pwidth  
writelog_nand_2_nwidth 
writelog_nand_2_nlength
writelog_inv_3_plength 
writelog_inv_3_pwidth  
writelog_inv_3_nwidth 
writelog_inv_3_nlength
writelog_inv_4_plength 
writelog_inv_4_pwidth  
writelog_inv_4_nwidth 
writelog_inv_4_nlength
writelog_fetNLength
writelog_fetNWidth
gate
base
drain
source)

LVL1_WriteLog(libName LVL1_WriteLogic C R wLogic)

			
			sprintf(bl "BL<0:%L>" C-1)
			sprintf(blb "BLB<0:%L>" C-1)
			sprintf(datain "DATAIN<0:%L>" C-1)
			sprintf(writeLog "WriteLogic_Top%L" i)	
	 inst = lpSchematicCreateInst( cvid libName LVL1_WriteLogic  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil writeLog)    
		   /*Left Side Pins*/
	             list(list("VDD" "VDD")
			list("VSS" "VSS")
	             list("WRITE" "WRITE")
			list(datain datain))

			list(list(bl bl)
			list(blb blb))

nil
nil

		   
x:y 
"R0")/* End Cell Place*/





x=5
y=y-1
/***************** READ LOGIC *******************/
load("./skill/readCktSchem.il")
load("./skill/LVL1_ReadLog.il")
rLogic = "ReadLogic"
LVL1_rLogic = "Toplevel_ReadLogic"

readCktSchem(libName rLogic nCell pCell cellLibName
readlogic_inv_1_plength 
readlogic_inv_1_pwidth  
readlogic_inv_1_nwidth 
readlogic_inv_1_nlength
readlogic_inv_2_plength 
readlogic_inv_2_pwidth  
readlogic_inv_2_nwidth 
readlogic_inv_2_nlength
sa_plength 
sa_pwidth  
sa_nwidth 
sa_nlength
gate
base
drain
source)


LVL1_ReadLog(libName LVL1_rLogic C R rLogic)

			sprintf(sae "SAE<0:%L>" C-1)
			sprintf(bl "BL<0:%L>" C-1)
			sprintf(blb "BLB<0:%L>" C-1)
			sprintf(dataout "DATAOUT<0:%L>" C-1)
			sprintf(readLog "ReadLogic%L" C-1)	
	 inst = lpSchematicCreateInst( cvid libName LVL1_rLogic  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil readLog)    
		   /*Left Side Pins*/
	             list(list("VDD" "VDD")
			list("VSS" "VSS")
			list(bl bl)
			list(blb blb)
			list("SAE" "READ"))
	             
list(list(dataout dataout))
nil
nil

		   
x:y 
"R0")/* End Cell Place*/
y=y-1



/******************************* 
ROW DECODER
*******************************/
y=-2
x = 0
load("./skill/Decoder_NBit.il")
rDecoder = "rowDecoder"

Decoder_NBit(libName rDecoder rbits nCell pCell cellLibName
rowdecoder_inv_1_plength 
rowdecoder_inv_1_pwidth  
rowdecoder_inv_1_nwidth 
rowdecoder_inv_1_nlength
rowdecoder_and_1_plength 
rowdecoder_and_1_pwidth  
rowdecoder_and_1_nwidth 
rowdecoder_and_1_nlength
rowdecoder_and_2_plength 
rowdecoder_and_2_pwidth  
rowdecoder_and_2_nwidth 
rowdecoder_and_2_nlength
gate
base
drain
source)
wlNet = sprintf(nil "WLSEL<0:%L>" R-1)
inNet = sprintf(nil "IN<0:%L>" rbits-1)
outNet = sprintf(nil "OUT<0:%L>" R-1)
rnet = sprintf(nil "RowAdd<0:%L>" rbits-1)

 inst = lpSchematicCreateInst( cvid libName rDecoder  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "rowDec")    
		   /*Left Side Pins*/
	             list(
			
			list("ENABLE" "ENABLE")
			list(inNet rnet)
			list("VDD" "VDD")
			list("VSS" "VSS"))

list(list(outNet wlNet))
nil
nil
		   
x:y 
"R0")/* End Cell Place*/



y=y-2

/******** END ROW DECODER ****************/

/********** BEGIN COLUMN DECODER **********/
x = 0
load("./skill/Decoder_NBit.il")
cDecoder = "colDecoder"

Decoder_NBit(libName cDecoder cbits nCell pCell cellLibName
coldecoder_inv_1_plength 
coldecoder_inv_1_pwidth  
coldecoder_inv_1_nwidth 
coldecoder_inv_1_nlength
coldecoder_and_1_plength 
coldecoder_and_1_pwidth  
coldecoder_and_1_nwidth 
coldecoder_and_1_nlength
coldecoder_and_2_plength 
coldecoder_and_2_pwidth  
coldecoder_and_2_nwidth 
coldecoder_and_2_nlength
gate
base
drain
source)

colNet = sprintf(nil "COLSEL<0:%L>" C-1)
cnet = sprintf(nil "ColAdd<0:%L>" cbits-1)

inNet = sprintf(nil "IN<0:%L>" cbits-1)
outNet = sprintf(nil "OUT<0:%L>" C-1)


inst = lpSchematicCreateInst( cvid libName cDecoder  "symbol" 
		/*Set Cell Name*/			
		sprintf(nil "colDec")    
		   /*Left Side Pins*/
	             list(
			
			list("ENABLE" "ENABLE")
			list(inNet cnet)
			list("VDD" "VDD")
			list("VSS" "VSS")
			
			
	             )

list(list(outNet colNet))
nil
nil
		   
x:y 
"R0")/* End Cell Place*/


i=0

y=y-1

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
;;let((libName cellName  nCell pCell cellLibName)  
 
  /* Library for the output cell*/
  ;;libName="SRAMGen"
  
  /* What the cell name is called*/
  
;;R = 2
;;C = 2

;;sprintf(cellName "SRAMGenerated_%Lx%L" R C)
;;sprintf(nCell "nsvt")
;;sprintf(pCell "psvt")
;;sprintf(cellLibName "cmos090")

  /* Run the Procedure*/
  ;;SRAMGenerator(R C libName cellName nCell pCell cellLibName)

  ;;printf("=== Cell %L Schematic has been created! ===\n", cellName)

;) /* End Let */

