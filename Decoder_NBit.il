/*====================================================================

 This file defines the SKILL procedure for creating 
 Schematic of a N-bit Decoder, utilizing any 1to2Decode.

 Buillt For SRAM Project for Introduction to VLSI Design Fall2021.
 Ahmed Abdelazeem

=====================================================================*/

;; Load the file containing the basic schematic procedures
load("./skill/lpSchematic.il")
load("./skill/jwSchematicST090.il")



/*====================================================================
 Define the procedure for creating schematic of the N-bit Decode Chain.
 This procedure has 3 parameter:
 - libName: the name of the library that you will put the cell schematic in;
 - cellName: the name of the cell you will create;
 - N: the number of inputs to the decoder
=====================================================================*/
procedure(Decoder_NBit(libName cellName N nCell pCell cellLibName 
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
and_2_nlength
gate
base
drain
source)

  ;; Define the local variables
  prog((cvid x y pin pinName k inName outName outName1 enable precharge inst i on l)
  
    ;; Open the cell and its schematic view
    cvid = dbOpenCellViewByType(libName cellName "schematic" "schematic" "a")
	
    ;; Clean the schematic view
    lpDeleteObjectsSchematic(cvid)
	
    ;; The coordinate of the origin point for the schematic
    x=0
    y=0
	
    ;; Create top level pins
    ;; Create input pins
    foreach(pinName list("VDD" "VSS" "ENABLE")
      pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0")
      y=y+0.5
    )
	inName=sprintf(nil "IN<0:%L>" N-1)
     	
     	 foreach(pinName list(inName)
     	 pin=lpSchematicCreatePin(cvid pinName "input" x:y "R0"))
	
y=y+1
g=pow(2,N)
outName=sprintf(nil "OUT<0:%L>" g-1)
     foreach(pinName list(outName)
     pin=lpSchematicCreatePin(cvid pinName "output" x:y "R0"))
    ;; The coordinate of the origin point for the schematic
    x=1
    y=0
	

 load("./skill/decoder_1to2.il")
	decoderName = "decoder_1to2"
	decoder_1to2(libName decoderName nCell pCell cellLibName inv_1_plength 
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

    for(k 1 N
	
	
	  
	  ;; Instantiate the kth inverter with ece432SchematicCreateInst() procedure, 
	  ;; which is defined in the file 'ece432Schematic.il'. 
	  ;; Modulous Function Not Defined?
	  g=1
	  g=pow(2,k-1)
	  i=1
	  on=1	
	for(j 1 g
			
		  ;; Define the input and output net name of the first decoder
        ;; Define the input and output net name of the first decoder
      if(k==1 then
	    enable="ENABLE"
	    outName=sprintf(nil "out%L_%L_0" k j)
	    outName1=sprintf(nil "out%L_%L_1" k j)
      else 
	  
	  ;; Define the input and output net name of the last decoder
	    if(k==N then
		  if(i==1 then 
	      		enable=sprintf(nil "out%L_%L_0" k-1 on)
	      	 	)
	      	 
	       	
	       		if(i==0 then
	       		
	       		printf("%L" on)
	       		enable=sprintf(nil "out%L_%L_1" k-1 on)
	       		on=on+1
	       		)
	       	if(i==0 then i =1 else i=0)
	      outName=sprintf(nil "OUT<%L>" j+j-2)
	      outName1=sprintf(nil "OUT<%L>" j+j-1)

		  	
	  ;; Define the input and output net name of the kth decoder 
	   
	    else
	    	
	    	
	    	if(i==1 then 
	      		enable=sprintf(nil "out%L_%L_0" k-1 on)
	      	 	)
	      	 
	       	
	       		if(i==0 then
	       		
	       		printf("%L" on)
	       		enable=sprintf(nil "out%L_%L_1" k-1 on)
	       		on=on+1
	       		);;end if i
	       	if(i==0 then i =1 else i=0);;end if i
	       	
	       	    
	      outName=sprintf(nil "out%L_%L_0" k j)
	      outName1=sprintf(nil "out%L_%L_1" k j)
	      
		);; end if(k==N
		
      );; end if(k==1
      
      
      
      
     ;;During the Last Iteration Create the Output Pins
    
    
      
   

    
   inName = sprintf(nil "IN<%L>" k-1)
    ;;Create the Instance
	  inst = lpSchematicCreateInst(
	           ;; Cell view id
			   cvid 
			   
			   ;; Name of the library containing the inverter cell
			   libName
			   
	           ;; The inverter cell name  
                   decoderName  
			   
			   ;; Cell view type, always be "symbol" here
			   "symbol" 
			   
			   ;; Instance name
	           sprintf(nil "IDECODE%L_%L" k j) 
			   
			   ;; The following list defines the connections of the left side pins 
			  
	           list(
list("IN" inName)
list("VDD"  "VDD")
list("VSS"  "VSS")
list("ENABLE"  enable))   
			   
			   ;; The following list defines the connections of the right side pins 
			   
	  		   list(list("OUT0" outName)
	  		   	list("OUT1" outName1))

	  		   
	  		   
	  		   
			   
			   ;; The following list defines the connections of the top side pins 
			   ;; in the symbol view; For our inverter, 'VDD' is the only pin on the top.
      		  
			   nil nil
			   ;; The following list defines the connections of the bottom side pins 
			   ;; in the symbol view; For our inverter, 'VSS' is the only pin on the bottom.
	           
			   
			   ;; Location of the instance
               x:y 
			   
			   ;; Rotation of the instance, such as "R0", "R90", "R180", "R270", "MX", "MY", ...
			   "R0"
			 );; end inst =
        
	  ;; The next decoder will be put at the right side of the current one.   
	  
	  y = y+1.5
	  
    	);;end for (j
    	y = 0
    	y=y-(g*2)
    	x = x +3
    );; end for(k
	
	;; Check, save and close the cell view

pinList = schSchemToPinList(libName cellName "schematic")

schPinListToSymbolGen(libName cellName "symbol" pinList)

schCheck(cvid)  ;; check the schematic connectivity
    dbSave(cvid)
    dbClose(cvid)
	
    return(t)
	
  );; end prog
  
);; end procedure



/*====================================================================
 'let' is the main entrance of the skill program.
 We will build schematic for a 6-bit inverter chain as an example.
====================================================================*/
;;let((N libName cellName)  ;; N, libName and cellName are variables

  ;; The number of bits input to the decoder
  ;;N = 3
  
  ;; The name of the library we will put the new cell in
  ;;libName="SRAMGen"
;;ncell = "nsvt"
;;pcell = "psvt"
;;celllibname = "cmos090"
  
  ;; Define the cell name
  ;;sprintf(cellName "Decoder_%Lb" N)

  ;; Call the procedure to create the decoder chain schematic
  ;;Decoder_NBit(libName cellName N ncell pcell celllibname)

;;  printf("=== Cell %L Schematic has been created! ===\n", cellName)

;;) ;;end let
 
