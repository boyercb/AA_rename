/* ==========================
   file: AA_rename.do
   author: christopher boyer
   date: 21 jul 2015
   version: 0.1.1
   ========================== */
/*
   description: 
       this script renames surveyCTO audio files using the naming convention
    AA_UUID_fieldname.3pgg.
*/

clear all
set more off
global S_SHELL "cmd.exe"

* set local working directory (CHANGE THIS!)
cd Q:\stata\bin\AA_rename

* define local variables (CHANGE THESE!)
local filename = "example_audio_xlsform.csv"
local fields = "sisbq1_opfinance " ///
            + "sisbq2_metas " ///
			+ "sisbq3_ahorro " ///
			+ "sisbq4_cuenta " ///
			+ "sisfinexplain_surveyor"

* import surveyCTO .csv file
import delimited using `filename'

* keep only audio fields
keep key `fields'

* generate intermediate variables
g fext = ""
g uuid = ""
g fstr1 = ""
g fstr2 = ""
g fstr3 = ""
local N = _N

* loop through audio fields and rename associated audio files
foreach field of local fields {
  capture assert mi(`field')
  if !_rc {
    drop `field'
	continue
  }
  replace fext = regexs(1) if(regexm(`field', "(\.[a-z0-9]*)"))
  replace uuid = regexs(1) if(regexm(key, ":([a-z0-9\-]*)"))
  replace fstr1 = `field' 
  replace fstr2 = "wav\AA_" + uuid + "_" + "`field'" + fext
  replace fstr3 = "wav\AA_" + uuid + "_" + "`field'"
  forvalues i = 1/`N' {
  	if fstr1[`i'] != "" & !missing(fstr1[`i']) & fext[`i'] ==".3gpp" {
		local f1 = fstr1[`i']
		local f2 = fstr2[`i']
		local f3 = fstr3[`i']+".wav"
		quietly cp "`f1'" "`f2'", replace
		!ffmpeg -i "`f2'" "`f3'" -y
	}
  }
}
!erase wav\*.3gpp
