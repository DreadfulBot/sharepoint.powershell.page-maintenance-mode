#DATA
Add-PSSnapin "Microsoft.SharePoint.PowerShell"

$maintencanceLink = "/maintenance.aspx"
$activeLink = "/active.aspx"

#Connect to Central Admin
$taxonomySite = get-SPSite http://char/

#Connect to Term Store in the Managed Metadata Service Application
$taxonomySession = Get-SPTaxonomySession -site $taxonomySite

#root item of term set tree
$termStore = $taxonomySession.TermStores["Служба управляемых метаданных"]
      
#Connect to the Group and Term Set
$termStoreGroup = $termStore.Groups["web-site-family"]
 
#Gets TermSet and lists the Terms under it by Name
$termSet = $termStoreGroup.TermSets["root-entry-level-0"]

#Get one specified term params
$term = $termSet.Terms["АБИТУРИЕНТАМ"].Terms["root-entry-level-1"]

#Editing term custom property
$term.SetLocalCustomProperty("_Sys_Nav_TargetUrl", $maintencanceLink)

#Saving changes
$term.TermStore.CommitAll();