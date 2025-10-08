# culture = 'fr-FR'
@{
    InvokeAsBuiltReportSystemResources = ConvertFrom-StringData @'
    Message1 = - Veuillez consulter le site Web GitHub de AsBuiltReport.System.Resources pour plus d'informations sur ce projet.
    Message2 = - N'oubliez pas de mettre à jour votre fichier de configuration de rapport après chaque nouvelle version : https://www.asbuiltreport.com/user-guide/new-asbuiltreportconfig/
    Message3 = - Documentation : https://github.com/AsBuiltReport/AsBuiltReport.System.Resources
    Message4 = - Signalement de problèmes ou de bogues : https://github.com/AsBuiltReport/AsBuiltReport.System.Resources/issues
    Message5 = - Ce projet est maintenu par la communauté et n'a aucun parrainage de Microsoft/*Linux/MacOS, de ses employés ou de l'un de ses affiliés.

    ModuleStatus = - Le module {0} {1} est actuellement installé.
    ModuleAvailable = - Le module {0} {1} est disponible.
    ModuleUpdateCmd = - Exécutez 'Update-Module -Name {0} -Force' pour installer la dernière version.
'@

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} Niveau d'information défini à {1}.
    Collecting  = Collecte des informations sur la date du système.
    ParagraphDetail = Les sections suivantes détaillent la date du système.
    ParagraphSummary = Le tableau suivant résume la date du système.
    Heading = Date

    Date = Date
    Hour = Heure
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} Niveau d'information défini à {1}.
    Collecting  = Collecte des informations sur les processus système.
    ParagraphDetail = Les sections suivantes détaillent les processus système.
    ParagraphSummary = Le tableau suivant résume les 10 principaux processus système. Pour plus d'informations, veuillez définir la valeur InfoLevel.ProcessInfo à 2 dans votre fichier de configuration du rapport. Trié par utilisation CPU.
    Heading = Processus

    Name = Nom
    Id = Id
    CPU = CPU (%)
    Memory = Mémoire (Mo)
    Company = Société
    Product = Produit
    Unknown = Inconnu
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} Niveau d'information défini à {1}.
    Collecting  = Collecte des informations sur le fuseau horaire du système.
    ParagraphDetail = Les sections suivantes détaillent le fuseau horaire du système.
    ParagraphSummary = Le tableau suivant résume le fuseau horaire du système.
    Heading = Fuseau horaire

    TimeZone = Fuseau horaire
    Id = Id
    DisplayName = Nom d'affichage
    CurrentTime = Heure actuelle
    BaseUTCOffset = Décalage UTC de base
    SupportsDaylightSavingTime = Prend en charge l'heure d'été
    Yes = Oui
    No = Non
    Unknown = Inconnu
'@

    # Get-AbrUptime
    GetAbrUptime = ConvertFrom-StringData @'
    InfoLevel = {0} Niveau d'information défini à {1}.
    Collecting = Collecte des informations sur le temps de fonctionnement du système.
    ParagraphDetail = Les sections suivantes détaillent le temps de fonctionnement du système.
    ParagraphSummary = Le tableau suivant résume le temps de fonctionnement du système.
    Heading = Temps de fonctionnement

    Uptime = Temps de fonctionnement
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} Niveau d'information défini à {1}.
    Collecting = Collecte des informations sur l'hôte PowerShell du système.
    ParagraphDetail = Les sections suivantes détaillent l'hôte PowerShell du système.
    ParagraphSummary = Le tableau suivant résume l'hôte PowerShell du système.
    Heading = Hôte PowerShell

    Name = Nom
    Version = Version
    CurrentCulture = Culture actuelle
    CurrentUICulture = Culture UI actuelle
    DebuggerEnabled = Débogueur activé
    Yes = Oui
    No = Non
    Unknown = Inconnu
'@
}