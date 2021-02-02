$jsonFile = Get-Content .\settings.json | ConvertFrom-Json
$sealOptions = $jsonFile.sealOptions 
$operationsQtty= 0
foreach ($setting in $sealOptions) {
    switch ($setting.psobject.Properties.Name) {
        regKeysToDelete {
            $operationsQtty += ($setting.regKeysToDelete.Count)
            foreach ($key in $setting.regKeysToDelete) {
            
                switch ($key.value) {
                    "novalue" {
                        Write-Host "deleting item $($key.key) "
                    }
                    default {
                        Write-Host "deleting item property $($key.value)"
                    }
                }
                
            }
        }
        regKeysToAdd { 
            $operationsQtty += ($setting.regKeysToAdd.Count)

            Write-host "Adding Reg KEys" }
        servicesToCheck { 
            $operationsQtty += ($setting.servicesToCheck.Count)

            foreach ($service in $setting.servicesToCheck) {
                switch ($service.status) {
                    'disabled' {
                        Write-host "SERVICE disabling"
                        #Set-Service ($service.name) -StartupType Disabled
                        
                    }
                    'stop' {
                        Write-host "SERVICE Stopping"

                        #Stop-Service -Name ($service.name) -Force
                    }
                    'start' {
                        Write-host "SERVICE start"

                        #Start-Service -Name ($service.name)
                    }
                    'automatic' {
                        Write-host "SERVICE at"

                        #Set-Service ($service.name) -StartupType Automatic
                    }
                }
            }
        }
        filesToDelete { 
            $operationsQtty += ($setting.filesToDelete.Count)

            foreach ($file in $setting.filesToDelete) {
                Write-Host "removing file $($file.path)"
            }
            # Remove-Item -Path C:\Test\hidden-RO-file.txt -Force
        }
        Default {}
    }
}
write-host $operationsQtty


 

function Seal-image {
    Param(
        [Parameter(Mandatory = $True)]
        [Object[]]$configObj
    )

}