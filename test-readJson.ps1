$jsonFile = Get-Content .\settings.json | ConvertFrom-Json
$sealOptions = $jsonFile.sealOptions 
foreach ($setting in $sealOptions) {
    switch ($setting.psobject.Properties.Name) {
        regKeysToDelete {
            foreach ($key in $setting.regKeysToDelete) {
                Write-Host $key.key
            
            } 
        }
        regKeysToAdd { Write-host "add" }
        servicesToCheck { 
            foreach ($service in $setting.servicesToCheck) {
                switch ($service.status) {
                    'disabled' {
                        Write-host " disabling"
                        #Set-Service ($service.name) -StartupType Disabled
                        
                    }
                    'stop' {
                        Write-host " st"

                        #Stop-Service -Name ($service.name) -Force
                    }
                    'start' {
                        Write-host " start"

                        #Start-Service -Name ($service.name)
                    }
                    'automatic' {
                        Write-host " at"

                        #Set-Service ($service.name) -StartupType Automatic
                    }
                }
            }
        }
        filesToDelete {
            
        }
        Default {}
    }
}





function Seal-image {
    Param(
        [Parameter(Mandatory = $True)]
        [Object[]]$configObj
    )

}