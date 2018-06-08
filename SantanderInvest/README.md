# Avaliação do Teste iOS Santander

Esse projeto está sendo desenvolvido para ser apresentado como resposta à [avaliação de conhecimentos em desenvolvimento iOS Santander Tecnologia](https://github.com/SantanderTecnologia/TesteiOS).

## Para rodar esse projeto você precisa:
* Um Mac ;)
* Xcode 9.4 instalado (usei Swift 4.1)
* Carthage instalado ([instruções](https://github.com/Carthage/Carthage#installing-carthage))
* Cocoapods instalado ([instruções](https://cocoapods.org/))

## Rodando:
##### Baixe o projeto da branch develop:
```
git clone https://github.com/BrunoVillanova/TesteiOS
```
##### Compile os frameworks usando Carthage:
```
carthage update --platform iOS
```
##### Compile os frameworks usando Cocoapods:
```
pod install
```
##### Abra o workspace do projeto:
```
open SantanderInvest.xcworkspace
```
Agora você deve selecionar um Team para a assinatura do app, selecionar um tipo de device e pressionar CMD+R para compilar e rodar