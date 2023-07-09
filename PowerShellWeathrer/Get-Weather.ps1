function Get-Weather {
    <#
        .SYNOPSIS
        Retrieves the weather information for a specified city.

        .DESCRIPTION
        The Get-Weather cmdlet retrieves the current weather information for the specified city.

        .PARAMETER City
        Specifies the city for which to retrieve the weather information. If not specified, the default city is "Minsk".

        .EXAMPLE
        Get-Weather -City "New York"
        Retrieves the weather information for the city of New York.

        .EXAMPLE
        Get-Weather
        Retrieves the weather information for the default city (Minsk).
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$City = ""
    )



    process {
        if([string]::IsNullOrWhiteSpace($City))
        {
            Write-Host "City not specified, use Minsk"
            $City = "Minsk"
        }

        $apiKey = "40255d4be6d1ab1b8e7421b006a86f5d"
        $url = "https://api.openweathermap.org/data/2.5/weather?q=$City&appid=$apiKey&units=metric"


        #Валидация ответа
        try {
            $response = Invoke-RestMethod -Uri $url
        } catch {

            if ($_.Exception.Response.StatusCode.value__ -eq 400) {
                Write-Host "Ошибка запроса для $City "
                return
            }
    
            if($_.Exception.Response.StatusCode.value__ -eq 404)
            {
                Write-Host "Данные для $City не найдены "
                return  
            }
        }
        

        #Вывод данных
        $temperature = $response.main.temp
        $humidity = $response.main.humidity
        $description = $response.weather[0].description

        Write-Host "Weather in $City :"
        Write-Host "Temperature: $temperature°C"
        Write-Host "Humidity: $humidity%"
        Write-Host "Description: $description"
    }
}

