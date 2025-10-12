# culture = 'fr-FR'
@{

    # Get-AbrDate
    GetAbrDate = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel défini à {1}.
    Collecting  = Collecte des informations sur la date du système.
    ParagraphDetail = Les sections suivantes détaillent la date du système.
    ParagraphSummary = Le tableau suivant résume la date du système.
    Heading = Date

    Date = Date
    Hour = Heure
'@
    # Get-AbrProcessInfo
    GetAbrProcessInfo = ConvertFrom-StringData @'
    InfoLevel  = {0} InfoLevel défini à {1}.
    Collecting  = Collecte des informations sur les processus système.
    ParagraphDetail = Les sections suivantes détaillent les processus système.
    ParagraphSummary = Le tableau suivant résume les 10 principaux processus système. Pour plus d'informations, veuillez définir la valeur InfoLevel.ProcessInfo à 2 dans votre fichier de configuration du rapport. Trié par utilisation CPU.
    Heading = Processus

    Name = Nom
    Id = Id
    CPU = CPU (%)
    Memory = Mémoire (MB)
    Company = Société
    Product = Produit
    Unknown = Inconnu
'@

    # Get-AbrTimeZone
    GetAbrTimeZone = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel défini à {1}.
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
    InfoLevel = {0} InfoLevel défini à {1}.
    Collecting = Collecte des informations sur le temps de fonctionnement du système.
    ParagraphDetail = Les sections suivantes détaillent le temps de fonctionnement du système.
    ParagraphSummary = Le tableau suivant résume le temps de fonctionnement du système.
    Heading = Temps de fonctionnement

    Uptime = Temps de fonctionnement
'@

    # Get-AbrPSHost
    GetAbrPSHost = ConvertFrom-StringData @'
    InfoLevel = {0} InfoLevel défini à {1}.
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
