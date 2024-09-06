CLS
# Define the IP address to test
$ipAddress = "10.10.10.1"  # Replace with the target IP address of the existing Domain Controller

# List of ports needed for ADDC communication
$ports = @(53, 88, 389, 445, 135, 636, 3268, 3269, 123, 9389, 5722, 464)

$myIP = Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.IPAddress -like "10.*" } | Select-Object -ExpandProperty IPAddress
Write-Host "Testing ADDS connectivity between $myIP and $ipAddress..."

# Loop through each port and test connectivity
foreach ($port in $ports) {
    $result = (New-Object System.Net.Sockets.TcpClient).ConnectAsync($ipAddress, $port).Wait(500)
    if ($result) {
       Write-Host "Port $port : Connection Successful" -ForegroundColor Green
    } else {
       Write-Host "Port $port : Connection Failed" -ForegroundColor Red
    }
}
