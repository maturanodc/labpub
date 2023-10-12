global main "C:\Users\Dimitri\Documents\pessoal\pesquisa\labpub\"
global data "$main\censo_2010\Dados\"
global raw "$data\Raw\"
global rendimentos v6511 v6513 v6514 v6521 v6524 v6525 v6526 v6527 v6528 ///
	v6529 v6530 v6531 v6532

cd "$main\censo_2010"

foreach uf in "AC" "AL" "AP" "AM" "BA" "CE" "DF" "ES" "GO" "MA" "MT" "MS" ///
	"MG" "PA" "PB" "PR" "PE" "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO" {
*	datazoom_censo, original("$raw") saving("$data") years(2010) ufs(`uf') both // Para compatibilizar os microdados em .txt na pasta \Raw\, basta remover o asterisco nessa linha
	use ${data}CENSO10_`uf', clear
	foreach w in $rendimentos {
		gen x = `w' if v0601 == 1
		egen `w'_h = total(x), by(v0300)
		gen y = `w' if v0601 == 2
		egen `w'_m = total(y), by(v0300)
		gen `w'_frac = `w'_m / (`w'_h + `w'_m)
		drop x y `w'_h `w'_m
	}
	drop if v6514 == 1 | v6526 == 1 | v6528 == 1 | v6530 == 1 | v6532 == 1
	keep v0001 v0002 v0300 v0010 v0601 $rendimentos v6511_frac-v6532_frac
	tempfile base`uf'
	save `base`uf''
}

clear
foreach uf in "AC" "AL" "AP" "AM" "BA" "CE" "DF" "ES" "GO" "MA" "MT" "MS" ///
	"MG" "PA" "PB" "PR" "PE" "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO" {
	append using `base`uf''
}
save ${data}base_20231012, replace
