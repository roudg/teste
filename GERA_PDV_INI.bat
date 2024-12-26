@echo off
echo :: Configurando o Codigo do PDV e Caminho do Banco de Dados no arquivo "PDV.INI" ::

setlocal enabledelayedexpansion

rem Define o caminho para o arquivo PDV.ini
set "configPath=C:\Quality\Conf\PDV.ini"

:inputPDV

set /p PDV="Digite o Codigo do PDV: "
rem Verifica se o PDV é um número inteiro
for /f "delims=0123456789" %%a in ("!PDV!") do (
   
echo O valor inserido para PDV precisa ser um numero inteiro. Tente novamente. O valor a ser inserido deve ser o "Referencia" do Cadastro do PDV.
    goto inputPDV
)



:inputIP
set /p IP="Digite o IP do banco ou 'localhost', caso seja essa maquina: "
rem Verifica se o IP é válido ou 'localhost'
if "!IP!"=="localhost" (
    goto writeConfig
) else (
    for /f "tokens=1-4 delims=." %%a in ("!IP!") do (
        set a=%%a
        set b=%%b
        set c=%%c
        set d=%%d
        
        rem Verifica se cada parte do IP está entre 0 e 255
        if !a! lss 0 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
        if !b! lss 0 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
        if !c! lss 0 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
        if !d! lss 0 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
        
        if !a! gtr 255 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
        if !b! gtr 255 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
        if !c! gtr 255 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
        if !d! gtr 255 (
            echo Endereço de IP inserido invalido. Tente novamente.
            goto inputIP
        )
    )
)

:inputPorta

set /p PORTA="Digite a Porta do banco de dados: "
rem Verifica se a Porta é um número inteiro
for /f "delims=0123456789" %%a in ("!PORTA!") do (
   
echo O valor inserido para Porta precisa ser um numero inteiro.
    goto inputPorta
)


:writeConfig

rem Cria o diretório caso ele não exista 
if not exist "C:\Quality\Conf" mkdir "C:\Quality\Conf"

(
echo [CONFIGURAÇÃO]
echo PDV=!PDV!
echo ATUALIZA=SIM
echo TENTATIVAS=0
echo ULTIMOABASTECIMENTO=83335

echo [ECF]

echo [REDE]
echo ENTRALOCAL=NÃO

echo [BANCO DE DADOS]
echo USA_PG=True
echo IP=!IP!
echo NOME_BASE=posto
echo SENHA=123456
echo USUARIO=postgres 
echo PASSWORD=123456
echo PORTA=!PORTA!
) > "!configPath!"

echo Configuração salva em "!configPath!" com sucesso!
endlocal 