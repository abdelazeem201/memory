/* This procedure creates the schematic for a 6T bitcell */

load("./skill/lpSchematic.il")

;;;; To create instance of nsvt and psvt
procedure( jwSchematicCreateFETInst(cvid libName cellName cellType instName leftPins rightPins topPins botPins origin rotation width length nfing @optional (SUBPmos "VSS"))
  prog((inst mstr bBox d)

    mstr = dbOpenCellViewByType(libName cellName cellType)
    inst = dbCreateInst(cvid mstr instName origin rotation 1)

   /* Now add the connectivity */

    lpFETAddLabelsToInstPins(cvid inst origin mstr leftPins "left")        
    lpFETAddLabelsToInstPins(cvid inst origin mstr  rightPins "right")        
    lpFETAddLabelsToInstPins(cvid inst origin mstr  topPins "top")        
    lpFETAddLabelsToInstPins(cvid inst origin mstr   botPins "bottom")        

   /* now add the properties */
    dbCreateProp(inst "w" "string" width)
    dbCreateProp(inst "l" "string" length)
    dbCreateProp(inst "nf" "string" nfing)
 ;   dbCreateProp(inst "m" "string" mult)
 ;   dbCreateProp(inst "srcefirst" "string" srcefirst)
 ;   dbCreateProp(inst "mismatch" "string" mismatch)
    ;;if( strcmp(substring(cellName,1,1), "P")==0 then 
	;;dbCreateProp(inst "SUB" "string" SUBPmos)
	;;net = dbMakeNet(cvid SUBPmos nil)
        ;;dbCreateConnByName(net inst "SUB")
    ;;);

    return(inst)
  )
)

;;;; To create instance of inv
procedure( jwSchematicCreateInstInv_X(cvid Iname location in out VDD VSS pw nw l m )
  prog((inst mstr)
  if(Iname != nil then
    inst = lpSchematicCreateInst(cvid "lpsramST090" "inv_X" "symbol" 
	Iname
	list(list("A" in))
	list(list("Y" out))
        list(list("VDD" VDD))
        list(list("GND" VSS))
        location "R0")
    
    /* now add the properties */
    if(inst != nil then
	if(pw > 0 then
	   dbCreateProp(inst "wp" "string" sprintf(nil "%L" pw)))
	if(nw > 0 then
	   dbCreateProp(inst "wn" "string" sprintf(nil "%L" nw)))
	if(l > 0 then
	   dbCreateProp(inst "ln" "string" sprintf(nil "%L" l))
	   dbCreateProp(inst "lp" "string" sprintf(nil "%L" l)))
	if(m > 0 then
	   dbCreateProp(inst "mfactor" "string" sprintf(nil "%L" m)))
	)
    ) 
    return(inst)
  )
)

;;;; To create instance of inv_X_BB
procedure( jwSchematicCreateInstInv_X_BB(cvid Iname location in out VDD VSS BP BN pw nw l m )
  prog((inst mstr)
  if(Iname != nil then
    inst = lpSchematicCreateInst(cvid "lpsramST090" "inv_X_BB" "symbol" 
	Iname
	list(list("A" in))
	list(list("Y" out))
        list(list("VDD" VDD) list("BP" BP))
        list(list("GND" VSS) list("BN" BN))
        location "R0")
    
    /* now add the properties */
    if(inst != nil then
	if(pw > 0 then
	   dbCreateProp(inst "wp" "string" sprintf(nil "%L" pw)))
	if(nw > 0 then
	   dbCreateProp(inst "wn" "string" sprintf(nil "%L" nw)))
	if(l > 0 then
	   dbCreateProp(inst "ln" "string" sprintf(nil "%L" l))
	   dbCreateProp(inst "lp" "string" sprintf(nil "%L" l)))
	if(m > 0 then
	   dbCreateProp(inst "mfactor" "string" sprintf(nil "%L" m)))
	)
    ) 
    return(inst)
  )
)

;;;; To create instance of pass transistors
procedure( jwSchematicTGate_X(cvid Name location in out CK CKB VDD VSS pw nw l)
  prog((instP instN)
  if(Name != nil then 
    instP = jwSchematicCreateFETInst(cvid "cmos090" 
	  "psvt" "symbol" 
	  strcat("MPTG_" Name)
	  list(list("g" CKB))
	  list(list("b" VDD))
	  list(list("s" in))
	  list(list("d" out))
	  location "R0" sprintf(nil "%L" pw) 
	  sprintf(nil "%L" l) "1" "1" "1" "1")   
    instN = jwSchematicCreateFETInst(cvid "cmos090" 
	  "nsvt" "symbol" 
	  strcat("MNTG_" Name)
	  list(list("g" CK))
	  list(list("b" VSS))
	  list(list("d" in))
	  list(list("s" out))
	  xCoord(location)+1.5:yCoord(location) "R0" sprintf(nil "%L" nw) 
	  sprintf(nil "%L" l) "1" "1" "1" "1")
    )
    return(list(instP instN))
  )
)

;;;; NAND2_X
procedure( jwSchematicCreateInstNand2_X(cvid Iname loc in0 in1 out VDD VSS pw nw l m)
  prog((inst)
  if(Iname != nil then 
    inst = lpSchematicCreateInst(cvid "lpsramST090" "nand2_X" "symbol" 
	Iname
	list(list("A" in0) list("B" in1))
	list(list("Y" out))
        list(list("VDD" VDD))
        list(list("GND" VSS))
        loc "R0")
    if(inst != nil then
	if(pw > 0 then
	   dbCreateProp(inst "wp" "string" sprintf(nil "%L" pw)))
	if(nw > 0 then
	   dbCreateProp(inst "wn" "string" sprintf(nil "%L" nw)))
	if(l > 0 then
	   dbCreateProp(inst "lp" "string" sprintf(nil "%L" l))
	   dbCreateProp(inst "ln" "string" sprintf(nil "%L" l)))
        if(m > 0 then
	   dbCreateProp(inst "mfactor" "string" sprintf(nil "%L" m)))
    )
    return(inst)
  )
 )
)


;;;; NAND2_X_BB
procedure( jwSchematicCreateInstNand2_X_BB(cvid Iname loc in0 in1 out VDD VSS BP BN pw nw l m)
  prog((inst)
  if(Iname != nil then 
    inst = lpSchematicCreateInst(cvid "lpsramST090" "nand2_X_BB" "symbol" 
	Iname
	list(list("A" in0) list("B" in1))
	list(list("Y" out))
        list(list("VDD" VDD) list("BP" BP))
        list(list("GND" VSS) list("BN" BN))
        loc "R0")
    if(inst != nil then
	if(pw > 0 then
	   dbCreateProp(inst "wp" "string" sprintf(nil "%L" pw)))
	if(nw > 0 then
	   dbCreateProp(inst "wn" "string" sprintf(nil "%L" nw)))
	if(l > 0 then
	   dbCreateProp(inst "lp" "string" sprintf(nil "%L" l))
	   dbCreateProp(inst "ln" "string" sprintf(nil "%L" l)))
        if(m > 0 then
	   dbCreateProp(inst "mfactor" "string" sprintf(nil "%L" m)))
    )
    return(inst)
  )
 )
)


;;;; NOR2_X
procedure( jwSchematicCreateInstNor2_X(cvid Iname loc in0 in1 out VDD VSS pw nw l m)
  prog((inst)
  if(Iname != nil then 
    inst = lpSchematicCreateInst(cvid "lpsramST090" "nor2_X" "symbol" 
	Iname
	list(list("A" in0) list("B" in1))
	list(list("Y" out))
        list(list("VDD" VDD))
        list(list("GND" VSS))
        loc "R0")
    if(inst != nil then
	if(pw > 0 then
	   dbCreateProp(inst "wp" "string" sprintf(nil "%L" pw)))
	if(nw > 0 then
	   dbCreateProp(inst "wn" "string" sprintf(nil "%L" nw)))
	if(l > 0 then
	   dbCreateProp(inst "lp" "string" sprintf(nil "%L" l))
	   dbCreateProp(inst "ln" "string" sprintf(nil "%L" l)))
        if(m > 0 then
	   dbCreateProp(inst "mfactor" "string" sprintf(nil "%L" m)))
    )
    return(inst)
  )
 )
)

;;;; Flip-Flop
procedure( jwSchematicCreateInstDFF(cvid Iname loc D Q CP)
  prog((inst)
  if(Iname != nil then 
    inst = lpSchematicCreateInst(cvid "lpsramST090" "dff" "symbol" 
	Iname
	list(list("D" D) list("CP" CP))
	list(list("Q" Q))
        nil
        nil
        loc "R0")
    return(inst)
  )
 )
)


;;;; TDC
procedure( jwSchematicCreateInstTDC(cvid Iname loc CK REF Qs VDD VSS)
  prog((inst)
  if(Iname != nil then 
    inst = lpSchematicCreateInst(cvid "lpsramST090" "outputTDC_4" "symbol" 
	Iname
	list(list("CK" CK) list("REF" REF) list("VDD" VDD) list("VSS" VSS))
	list(list("Q<0:3>" Qs))
        nil
        nil
        loc "R0")
    return(inst)
  )
 )
)


;;;; AND2_X
procedure( jwSchematicCreateInstAnd2_X(cvid name loc in0 in1 out VDD VSS pwnand nwnand pwinv nwinv l m)
  prog(()
  inst = lpSchematicCreateInst(cvid "lpsramST090" "and2_X" "symbol" 
	name
	list(list("A" in0) list("B" in1))
	list(list("Y" out))
        list(list("VDD" VDD))
        list(list("GND" VSS))
        loc "R0")
    if(inst != nil then
	if(pwnand > 0 then
	   dbCreateProp(inst "wp" "string" sprintf(nil "%L" pwnand)))
	if(nwnand > 0 then
	   dbCreateProp(inst "wn" "string" sprintf(nil "%L" nwnand)))
	if(pwinv > 0 then
	   dbCreateProp(inst "invwp" "string" sprintf(nil "%L" pwinv)))
	if(nwinv > 0 then
	   dbCreateProp(inst "invwn" "string" sprintf(nil "%L" nwinv)))   
	if(l > 0 then
	   dbCreateProp(inst "lp" "string" sprintf(nil "%L" l))
	   dbCreateProp(inst "ln" "string" sprintf(nil "%L" l)))
        if(m > 0 then
	   dbCreateProp(inst "mfactor" "string" sprintf(nil "%L" m)))
    )
    return()
  ;if(name != nil then 
   ; jwSchematicCreateInstNand2_X(cvid sprintf(nil "%s_NAND" name)
   ;     loc in0 in1 sprintf(nil "b_%s" out) VDD VSS pwnand nwnand l m)
   ; jwSchematicCreateInstInv_X(cvid sprintf(nil "%s_INV" name)
   ;     xCoord(loc)+2.5:yCoord(loc) 
   ;     sprintf(nil "b_%s" out) out VDD VSS pwinv nwinv l m)
   ; return()
  ;)
 )
)

;;;; Buf_X
procedure( jwSchematicCreateInstBuf_X(cvid Iname loc in out VDD VSS pw1 nw1 pw2 nw2 l1 l2 m)
  prog((inst)
    if(Iname != nil then 
      inst = lpSchematicCreateInst(cvid "lpsramST090" "buf_X" "symbol" 
	  Iname
	  list(list("A" in)) 
	  list(list("Y" out))
	  list(list("VDD" VDD))
	  list(list("VSS" VSS))
	  loc "R0")
      if(inst != nil then
	  if(pw1 > 0 then
	     dbCreateProp(inst "wp1" "string" sprintf(nil "%L" pw1)))
	  if(nw1 > 0 then
	     dbCreateProp(inst "wn1" "string" sprintf(nil "%L" nw1)))
	  if(l1 > 0 then
	     dbCreateProp(inst "l1" "string" sprintf(nil "%L" l1)))
          if(pw2 > 0 then
	     dbCreateProp(inst "wp2" "string" sprintf(nil "%L" pw2)))
	  if(nw2 > 0 then
	     dbCreateProp(inst "wn2" "string" sprintf(nil "%L" nw2)))
	  if(l2 > 0 then
	     dbCreateProp(inst "l2" "string" sprintf(nil "%L" l2)))
	  if(m > 0 then
	     dbCreateProp(inst "mfactor" "string" sprintf(nil "%L" m)))
      )
      return(inst)
    )
 )
)

;;;; Mux
procedure( svnSchematicCreateInstMux2_1(cvid Iname loc VDD VSS A B S Z)
  prog((inst)
  if(Iname != nil then 
    inst = lpSchematicCreateInst(cvid "lpsramSTD" "Mux2_1" "symbol" 
	Iname
	list(list("A" A) list("B" B))
	list(list("Z" Z))
	list(list("VDD" VDD)
	     list("VSS" VSS))
        list(list("S" S))
        loc "R0")
    return(inst)
  )
 )
)