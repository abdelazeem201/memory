/*====================================================================

Configuration File for SRAM Generator
Set Sizes and Paths
RUN THIS TO GENERATE SRAM

Written by Tyler Healy February 2009

=====================================================================*/





procedure(SRAMConfigLauncher()
  prog(()
load("./skill/SRAMGenerator.il")
/***********************************************************/
/***************** General Configuration *******************/
/***********************************************************/


/* Library and Name of the Process Technology & NMOS/PMOS cell names */
cellLibName = "cmos090"
nCell = "nsvt"
pCell = "psvt"

/* Number of Rows & Columns  */
R = 128
C = 256

/*Number of Address Bits*/
rbits=7
cbits=8
/****/

/* Library for generated SRAM to get stored & Cell Name of the FINAL TOP LEVEL SCHEMATIC*/
libName = "SRAMGen"
cellName = "tthSRAMBig"

/* These parameters designate the strings and order of the FET parameters, which differ by device model */
gate = "g"
base = "b"
drain = "d"
source = "s"



/*============ SIZING PARAMETERS =================

The following section describes sizing specifics 
Please Refer to Documentation on which transistors
the parameters apply to. The diagrams have names corresponding
to the following parameters. Sizes Are Based on the
min Size set below (Future Implementation).
===================================================*/


/***** "1.0". FET SIZE *****/
/*Not in use yet*/
min = "1.0"


/**************** BitCell Sizing (6T Bitcell) *******************/

bitcell_pWidth = "1.0"
bitcell_pLength = "1.0"
bitcell_nWidth = "1.0"
bitcell_nLength = "1.0"
bitcell_accessLength = "1.0"
bitcell_accessWidth = "1.0"
/****************************************************************/

/********* Wordline Driver *********/
wldriver_inv_1_plength  = "1.0"
wldriver_inv_1_pwidth   ="1.0"
wldriver_inv_1_nwidth ="1.0"
wldriver_inv_1_nlength ="1.0"
wldriver_inv_2_plength ="1.0"
wldriver_inv_2_pwidth  ="1.0"
wldriver_inv_2_nwidth ="1.0"
wldriver_inv_2_nlength ="1.0"
wldriver_nand_1_plength ="1.0"
wldriver_nand_1_pwidth  ="1.0"
wldriver_nand_1_nwidth  ="1.0"
wldriver_nand_1_nlength ="1.0"
wldriver_inv_3_plength ="1.0"
wldriver_inv_3_pwidth  ="1.0"
wldriver_inv_3_nwidth ="1.0"
wldriver_inv_3_nlength ="1.0"
/*************************************/

/********* Column Logic **************/
collogic_precharge_pwidth ="1.0"
collogic_precharge_plength ="1.0"
collogic_nand_1_plength ="1.0"
collogic_nand_1_pwidth  ="1.0"
collogic_nand_1_nwidth ="1.0"
collogic_nand_1_nlength ="1.0"
collogic_inv_1_plength ="1.0"
collogic_inv_1_pwidth  ="1.0"
collogic_inv_1_nwidth ="1.0"
collogic_inv_1_nlength ="1.0"
collogic_txPLength ="1.0"
collogic_txPWidth ="1.0"
collogic_txNLength ="1.0"
collogic_txNWidth ="1.0"
/*************************************/

/********** Write Logic **************/
writelog_inv_1_plength ="1.0"
writelog_inv_1_pwidth  ="1.0"
writelog_inv_1_nwidth ="1.0"
writelog_inv_1_nlength ="1.0"
writelog_inv_2_plength ="1.0"
writelog_inv_2_pwidth  ="1.0"
writelog_inv_2_nwidth ="1.0"
writelog_inv_2_nlength ="1.0"
writelog_nand_1_plength ="1.0" 
writelog_nand_1_pwidth  ="1.0"
writelog_nand_1_nwidth ="1.0"
writelog_nand_1_nlength ="1.0"
writelog_nand_2_plength ="1.0"
writelog_nand_2_pwidth  ="1.0"
writelog_nand_2_nwidth ="1.0"
writelog_nand_2_nlength ="1.0"
writelog_inv_3_plength ="1.0"
writelog_inv_3_pwidth  ="1.0"
writelog_inv_3_nwidth ="1.0"
writelog_inv_3_nlength ="1.0"
writelog_inv_4_plength ="1.0"
writelog_inv_4_pwidth  ="1.0"
writelog_inv_4_nwidth ="1.0"
writelog_inv_4_nlength ="1.0"
writelog_fetNLength ="1.0"
writelog_fetNWidth ="1.0"
/***************************************/

/********* Read Logic *****************/
readlogic_inv_1_plength ="1.0"
readlogic_inv_1_pwidth   ="1.0"
readlogic_inv_1_nwidth  ="1.0"
readlogic_inv_1_nlength ="1.0"
readlogic_inv_2_plength  ="1.0"
readlogic_inv_2_pwidth   ="1.0"
readlogic_inv_2_nwidth  ="1.0"
readlogic_inv_2_nlength ="1.0"
/**************************************/

/******** Sense Amp *******************/	
sa_plength ="1.0"
sa_pwidth   ="1.0"
sa_nwidth ="1.0"
sa_nlength ="1.0"
/**************************************/

/********* Row Decoder ****************/
rowdecoder_inv_1_plength ="1.0"
rowdecoder_inv_1_pwidth  ="1.0"
rowdecoder_inv_1_nwidth  ="1.0"
rowdecoder_inv_1_nlength ="1.0"
rowdecoder_and_1_plength  ="1.0"
rowdecoder_and_1_pwidth  ="1.0"
rowdecoder_and_1_nwidth  ="1.0"
rowdecoder_and_1_nlength ="1.0"
rowdecoder_and_2_plength  ="1.0"
rowdecoder_and_2_pwidth   ="1.0"
rowdecoder_and_2_nwidth  ="1.0"
rowdecoder_and_2_nlength ="1.0"
/***************************************/

/*********** Column Decoder ************/
coldecoder_inv_1_plength ="1.0"
coldecoder_inv_1_pwidth   ="1.0"
coldecoder_inv_1_nwidth  ="1.0"
coldecoder_inv_1_nlength ="1.0"
coldecoder_and_1_plength  ="1.0"
coldecoder_and_1_pwidth   ="1.0"
coldecoder_and_1_nwidth  ="1.0"
coldecoder_and_1_nlength ="1.0"
coldecoder_and_2_plength  ="1.0"
coldecoder_and_2_pwidth  ="1.0"
coldecoder_and_2_nwidth  ="1.0"
coldecoder_and_2_nlength ="1.0"
/******************************************/

/*****END CONFIG********/

/*LAUNCH THE GENERATOR */
SRAMGenerator(R C libName cellName  nCell pCell cellLibName 
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


	
    return(t)
	
  )/*End Prog*/
  
)/* End Procedure*/



/*====================================================================
 'let' is the main entrance of the skill program.
  This executes the config and generates the SRAM
====================================================================*/
let(()  
 
  

  /* Run the Procedure*/
  SRAMConfigLauncher()

  printf("=== SRAM HAS BEEN GENERATED! ===")

) /* End Let */
