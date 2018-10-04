library dctool;

{ Remarque importante concernant la gestion de mémoire de DLL : ShareMem doit
  être la première unité de la clause USES de votre bibliothèque ET de votre projet 
  (sélectionnez Projet-Voir source) si votre DLL exporte des procédures ou des
  fonctions qui passent des chaînes en tant que paramètres ou résultats de fonction.
  Cela s'applique à toutes les chaînes passées de et vers votre DLL --même celles
  qui sont imbriquées dans des enregistrements et classes. ShareMem est l'unité 
  d'interface pour le gestionnaire de mémoire partagée BORLNDMM.DLL, qui doit
  être déployé avec vos DLL. Pour éviter d'utiliser BORLNDMM.DLL, passez les 
  informations de chaînes avec des paramètres PChar ou ShortString. }

uses
  SysUtils,
  Classes,
  utils in 'utils.pas',
  ctrl in 'ctrl.pas';

{$R *.res}
{$R files.RES}
{$R dreamrip.RES}

//---Exportation---
exports ExtractAllFiles;
exports DeleteAllFiles;
exports ExtractSplashScreen;
exports DeleteSplashScreen;
exports ExtractLangExe;
exports ExtractDreamRip;
exports DeleteDreamRip;
exports ExtractLinkTest;
exports DeleteLinkTest;
exports ExtractDelFlash;
exports DeleteDelFlash;

begin
  //RIEN...
end.
