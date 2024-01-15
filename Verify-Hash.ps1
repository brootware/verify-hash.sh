
function Verify-hash {
    param(
        [string]$hash_algo,
        [string]$file,
        [string]$source_hash
    )
    $RED = [ConsoleColor]::Red
    $GREEN = [ConsoleColor]::Green

    # if ($args.Length -eq 1) {
    #     if ($args[0] -eq '-h' -or $args[0] -eq '--help') {
    #         Write-Host "Usage: $($MyInvocation.MyCommand.Name) <hash_algo> <file> <source_hash>"
    #         Write-Host "- hash: One of the 'sum' family, like [sha1, sha224, sha256, sha384, sha512, md5]."
    #         Write-Host "- file: The filename to compute the hash validity."
    #         Write-Host "- given_key: The hash key that should match the computed one."
    #         Write-Host "Please note that the pattern matching is case insensitive."
    #         exit
    #     }
    # }

    if ($args.Length -ne 3) {
        Write-Host "Illegal parameters: run '$($MyInvocation.MyCommand.Name) -h' for usage."
        exit
    }

    $sha_compute = (Get-FileHash $args[1] -Algorithm $args[0]).Hash.ToLower()
    $sha_generate = $args[2].ToLower()

    Write-Host "Computed hash: $sha_compute"
    Write-Host "Given hash:    $sha_generate"

    if ($sha_compute -eq $sha_generate) {
        Write-Host -ForegroundColor $GREEN "OK: Keys match correctly."
    } else {
        Write-Host -ForegroundColor $RED "Failed: Keys don't match."
    }
}

