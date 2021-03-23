## File Transfer Script
$targetIP = '';
$targetPath = 'data'
$destinationPath = 'C:\Backup\data';
$user = 'fileuser';
$password = '';
function isComputerOn {
    param ([string]$target, [string]$targetPath, [string] $destinationPath, [string]$user, [securestring]$password)
    $cmd = Test-NetConnection -ComputerName $target;
    if($cmd.PingSucceeded){
        ## Adding credentials to command
        $net = net use \\${targetIP}\${targetPath} /USER:${$user}\${targetIP} ${$password}
        Write-Output $net;
        ## check files and copy them
        $copy = robocopy \\${$targetIP}\${$targetPath} ${destinationPath} /MIR /Z /R:5 /W:5 /TBD /NP /V /MT:16;
        ## find out which attribute shows success/fail in this so copy.complete or whatever
        Write-Output $copy;
    } else {
        return;
    }
}
isComputerOn($targetIP, $targetPath, $destinationPath, $user, $password);