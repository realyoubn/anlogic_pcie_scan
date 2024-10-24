#! /bin/csh  -f

set caseNum = $argv[1]
echo "# -------------------------------------------------------------------------"
echo "#"
echo "#    Func: $caseNum result compare"
echo "#"
echo "# -------------------------------------------------------------------------"

if($caseNum == "CASE0") then
	diff ../data/case0/case_cfg_sim.txt  ../data/case0/case_cfg_golden.dat > ../data/case0/case_cfg_diff.txt
	set test_case_cfg = `ls -l ../data/case0/case_cfg_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE1") then
	diff ../data/case1/case_c2h_pmodewb_sim.txt ../data/case1/case_c2h_pmodewb_golden.dat > ../data/case1/case_c2h_pmodewb_diff.txt
	set test_case_c2hpmodewb = `ls -l ../data/case1/case_c2h_pmodewb_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE2") then
	diff ../data/case2/case_c2h_ofm_sim.txt ../data/case2/case_c2h_ofm_golden.dat > ../data/case2/case_c2h_ofm_diff.txt
	set test_case_c2hofm = `ls -l ../data/case2/case_c2h_ofm_diff.txt | awk '{print $5}'`	
else if($caseNum == "CASE3") then
	diff ../data/case3/case_c2h_ofm_sim.txt ../data/case3/case_c2h_ofm_golden.dat > ../data/case3/case_c2h_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case2/case_c2h_ofm_diff.txt | awk '{print $5}'`	
else if($caseNum == "CASE4") then
	diff ../data/case4/case_c2h_ofm_sim.txt ../data/case4/case_c2h_ofm_golden.dat > ../data/case4/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case4/case_ofm_diff.txt | awk '{print $5}'`		
else if($caseNum == "CASE5") then
	diff ../data/case5/case_c2h_ofm_sim.txt ../data/case5/case_c2h_ofm_golden.dat > ../data/case5/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case5/case_ofm_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE6") then
	diff ../data/case6/case_c2h_ofm_sim.txt ../data/case6/case_c2h_ofm_golden.dat > ../data/case6/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case5/case_ofm_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE7") then
	diff ../data/case7/case_c2h_ofm_sim.txt ../data/case7/case_c2h_ofm_golden.dat > ../data/case7/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case7/case_ofm_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE9") then
	diff ../data/case9/case_c2h_ofm_sim.txt ../data/case9/case_c2h_ofm_golden.dat > ../data/case9/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case9/case_ofm_diff.txt | awk '{print $5}'`		
else if($caseNum == "CASE11") then
	diff ../data/case11/case_c2h_ofm_sim.txt ../data/case11/case_c2h_ofm_golden.dat > ../data/case11/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case11/case_ofm_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE12") then
	diff ../data/case12/case_int_sim.txt ../data/case12/case_int_golden.dat > ../data/case12/case_int_diff.txt
	set test_case_int = `ls -l ../data/case12/case_int_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE13") then
	diff ../data/case13/case_c2h_ofm_sim.txt ../data/case13/case_c2h_ofm_golden.dat > ../data/case13/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case13/case_ofm_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE18") then
	diff ../data/case18/case_h2c_ofm_sim.txt ../data/case18/case_h2c_ofm_golden.dat > ../data/case18/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case18/case_ofm_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE19") then
	diff ../data/case19/case_h2c_ofm_sim.txt ../data/case19/case_h2c_ofm_golden.dat > ../data/case19/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case19/case_ofm_diff.txt | awk '{print $5}'`
else if($caseNum == "CASE41") then
	diff ../data/case41/case_c2h_ofm_sim.txt ../data/case41/case_c2h_ofm_golden.dat > ../data/case41/case_ofm_diff.txt
	set test_case_ofm = `ls -l ../data/case41/case_ofm_diff.txt | awk '{print $5}'`		
else 
	echo "It is not yet developed,so please look forward to it!"
endif


if($caseNum == "CASE0") then
	if ($test_case_cfg)  then
	   echo " -----------------" 
	   echo " CASE0 TEST FAIL!"     
	   echo " Confiuration diff data is :" 
	   cat ../data/case0/case_cfg_diff.txt
	   echo " -----------------" 
	else 
	   echo " -----------------" 
	   echo " CASE0 TEST PASS!" 
	   echo " -----------------" 
	endif	
else if($caseNum == "CASE1") then
	 if ($test_case_c2hpmodewb) then
	   echo " -----------------" 
	   echo " CASE1 TEST FAIL!"     
	   echo " Poll Mode diff data is :" 
	   cat ../data/case1/case_c2h_pmodewb_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE1 TEST PASS!" 
	   echo " -----------------" 
	endif
else if($caseNum == "CASE2") then	
	 if ($test_case_c2hofm) then
	   echo " -----------------" 
	   echo " CASE2 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case2/case_c2h_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE2 TEST PASS!" 
	   echo " -----------------" 
	endif	
else if($caseNum == "CASE3") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE3 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case3/case_ofm_diff.txt
	   echo " Interrupt diff data is :"
	   cat ../data/case3/case_int_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE3 TEST PASS!" 
	   echo " -----------------" 
	endif
		
else if($caseNum == "CASE4") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE4 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case4/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE4 TEST PASS!" 
	   echo " -----------------" 
	endif
else if($caseNum == "CASE5") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE5 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case5/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE5 TEST PASS!" 
	   echo " -----------------" 
	endif
else if($caseNum == "CASE6") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE6 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case5/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE6 TEST PASS!" 
	   echo " -----------------" 
	endif

else if($caseNum == "CASE7") then
	if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE7 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case7/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE7 TEST PASS!" 
	   echo " -----------------" 
	endif

else if($caseNum == "CASE9") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE9 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case9/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE9 TEST PASS!" 
	   echo " -----------------" 
	endif

else if($caseNum == "CASE11") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE11 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case11/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE11 TEST PASS!" 
	   echo " -----------------" 
	endif

else if($caseNum == "CASE12") then
	 if ($test_case_int) then
	   echo " -----------------" 
	   echo " CASE12 TEST FAIL!"     
	   echo " Interrupt diff data is :"
	   cat ../data/case12/case_int_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE12 TEST PASS!" 
	   echo " -----------------" 
	endif

else if($caseNum == "CASE13") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE13 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case13/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE13 TEST PASS!" 
	   echo " -----------------" 
    endif
else if($caseNum == "CASE18") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE18 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case18/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE18 TEST PASS!" 
	   echo " -----------------" 
	endif
else if($caseNum == "CASE19") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE19 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case19/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE19 TEST PASS!" 
	   echo " -----------------" 
	endif

else if($caseNum == "CASE41") then
	 if ($test_case_ofm) then
	   echo " -----------------" 
	   echo " CASE41 TEST FAIL!"     
	   echo " OFM diff data is :" 
	   cat ../data/case41/case_ofm_diff.txt
	   echo " -----------------" 
	 else 
	   echo " -----------------" 
	   echo " CASE41 TEST PASS!" 
	   echo " -----------------" 
	endif
else 
	echo "No results!"

endif
