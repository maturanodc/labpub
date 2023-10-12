global main "C:\Users\Dimitri\Documents\pessoal\pesquisa\labpub\"
global data "$main\censo_2010\Dados\"
global raw "$data\Raw\"
global rendimentos v6511 v6513 v6514 v6521 v6524 v6525 v6526 v6527 v6528 ///
	v6529 v6530 v6531 v6532
	

cd "$main\censo_2010"

* Compatibiliza microdados em .txt na pasta \Raw\ e salva em \Dados\
foreach uf in "AC" "AL" "AP" "AM" "BA" "CE" "DF" "ES" "GO" "MA" "MT" "MS" ///
	"MG" "PA" "PB" "PR" "PE" "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO" {
	datazoom_censo, original("$raw") saving("$data") years(2010) ufs(`uf') both
}

* Cria base que exclui salarios menores ou iguais que o SM (faixa menor)
do tratamento_censo_lowest

* Cria base que exclui salarios menores ou iguais que o SM (faixa media)
do tratamento_censo_mean
