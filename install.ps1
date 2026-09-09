
$baseUrl = "https://raw.githubusercontent.com/gustavodeceserovieira/INSTALADOR_PROGRAMAS/main/programas"
$pasta = "$env:USERPROFILE\Downloads\basicos"

New-Item -ItemType Directory -Force -Path $pasta | Out-Null

#Baixa os arquivos da pasta programas
$arquivos = @(
    "programa1.exe",
    "programa2.reg",
    "programa3.exe",
    "programa4.exe"
)

foreach ($arquivo in $arquivos) {
    Write-Host "Baixando $arquivo..."
    Invoke-WebRequest `
        -Uri "$baseUrl/$arquivo" `
        -OutFile "$pasta\$arquivo"
}

#Baixa e executa o arquivo bat

Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/gustavodeceserovieira/INSTALADOR_PROGRAMAS/main/basicos.bat" `
    -OutFile "$env:USERPROFILE\Downloads\basicos\instalador_programas.bat"

Start-Process "$env:USERPROFILE\Downloads\basicos\instalador_programas.bat" -Wait


Write-Host("INFORMAÇÃO IMPORTANTE: Para windows 10, é necessário realizar todas as atualizações antes de instalar os programas
    Caso queria fazer em paralelo é necessário baixar um arquivo nesse link: 
    https://learn.microsoft.com/pt-br/windows/msix/app-installer/install-update-app-installer
")


do{
    Clear-Host
    Write-Host "---------------------------------------------"
    Write-Host "0 - Sair"
    Write-Host "1 - Instalar programas basicos"
    Write-Host "2 - Atualizar todos os programas"
    Write-Host "3 - Pesquisar programa por palavra"
    Write-Host "4 - Ativar Office"
    Write-Host "5 - Instalar Office 365"
    Write-Host "---------------------------------------------"

    $opcao = Read-Host "Selecione uma opcao"

    switch($opcao){
        "0"{exit}
        "1"{
                $programas =@(
                    "Google.Chrome",
                    "Mozilla.Firefox.pt-BR",
                    "CodecGuide.K-LiteCodecPack.Full",
                    "Oracle.JavaRuntimeEnvironment",
                    "Adobe.Acrobat.Reader.64-bit",
                    "RARLab.WinRAR"
            )
            foreach ($prog in $programas) {
                Write-Host "Instalando $prog ..."
                winget install --id $prog -e --source winget --accept-package-agreements --accept-source-agreements
            }
	    Write-Host "Todos os programas foram instalados e atualizados com sucesso!"
        }
        "2"{
           winget upgrade --all `
            --accept-package-agreements `
            --accept-source-agreements
            Write-Host "Programas atualizados com sucesso!"
        }
        "3"{
            $nome = Read-Host "Palavra chave do programa"
	    Write-Host "---------------------------------------------"
            Write-Host "0 - Sair"
            Write-Host "1 - Instalar o programa"
            Write-Host "2 - Desinstalar o programa"
            Write-Host "3 - Atualizar o programa"
 	    Write-Host "---------------------------------------------"
            $opcao = Read-Host "Selecione uma opcao"
            switch($opcao){
                "0"{break}
                "1"{
                    winget search $nome  
                    $programa = Read-Host "Cole o ID do programa"
                    winget install --id $programa -e --source winget --accept-package-agreements --accept-source-agreements
                    Write-Host "Programa $nome instalado com sucesso!"
                }
                "2"{
                    winget list $nome
                    $programa = Read-Host "Cole o ID do programa"
                    winget uninstall $programa
                    Write-Host "Programa $nome desinstalado com sucesso!"
                }
                "3"{
                    winget list $nome
                    $programa = Read-Host "Cole o ID do programa"
                    winget upgrade $programa `
                    --accept-package-agreements `
                    --accept-source-agreements
                    Write-Host "Programa $nome atualizado com sucesso!"
                }
                default{
                    Write-Host "Opcao invalida!"
                }   
            }
        }
	"4"{
	    irm https:\\get.activated.win | iex
	}
	"5"{
	  winget install --id "Microsoft.Office" --source winget	    
	  Write-Host "Office 365 instalado com sucesso!"

	}
        default{
            Write-Host "Opcao invalida!"
        }
    }
    Read-Host "Pressione ENTER para voltar ao menu"
}while ($true)

