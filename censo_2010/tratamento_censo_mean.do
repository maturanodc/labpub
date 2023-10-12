cd $data 

local SP = 570.00
local RJ = 780.46
local PR = 707.63
local SC = 632.25
local RS = 567.98

foreach uf in "AC" "AL" "AP" "AM" "BA" "CE" "DF" "ES" "GO" "MA" "MT" "MS" ///
	"MG" "PA" "PB" "PR" "PE" "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO" {
	use CENSO10_`uf', clear
	foreach w in $rendimentos {
		gen x = `w' if v0601 == 1
		egen `w'_h = total(x), by(v0300)
		gen y = `w' if v0601 == 2
		egen `w'_m = total(y), by(v0300)
		gen `w'_frac = `w'_m / (`w'_h + `w'_m)
		drop x y
	}
		if "`uf'" == "SP" {
			drop if v6513_h <= `SP' | v6513_m <= `SP'
		}
		else if "`uf'" == "RJ" {
			drop if v6513_h <= `RJ' | v6513_m <= `RJ'
		}
		else if "`uf'" == "PR" {
			drop if v6513_h <= `PR' | v6513_m <= `PR'
		}
		else if "`uf'" == "SC" {
			drop if v6513_h <= `SC' | v6513_m <= `SC'
		}
		else if "`uf'" == "RS" {
			drop if v6513_h <= `RS' | v6513_m <= `RS'
		}
		else {
			drop if v6513_h <= 510 | v6513_m <= 510
		}
	keep v0001 v0002 v0300 v0010 v0601 v6511 v6513 v6514 v6521 v6524 v6525 ///
		v6526 v6527 v6528 v6529 v6530 v6531 v6532 v6511_frac v6513_frac ///
		v6514_frac v6521_frac v6524_frac v6525_frac v6526_frac v6527_frac ///
		v6528_frac v6529_frac v6530_frac v6531_frac v6532_frac
	tempfile base`uf'
	save `base`uf'', replace
}

clear
foreach uf in "AC" "AL" "AP" "AM" "BA" "CE" "DF" "ES" "GO" "MA" "MT" "MS" ///
	"MG" "PA" "PB" "PR" "PE" "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO" {
	append using `base`uf''
}
save base_20231012_mean, replace

cd ${main}censo_2010
