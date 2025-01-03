# Create simulator
set ns [new Simulator]

# Open trace file
set tf [open out.tr w]
$ns trace-all $tf

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

# Create links
$ns duplex-link $n0 $n2 10Mb 10ms DropTail
$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 10Mb 10ms DropTail
$ns duplex-link $n3 $n5 10Mb 10ms DropTail

# Setup TCP connections
# TCP Reno
set tcp1 [new Agent/TCP/Reno]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n4 $sink1
$ns connect $tcp1 $sink1

# TCP Tahoe
set tcp2 [new Agent/TCP]
$ns attach-agent $n1 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n5 $sink2
$ns connect $tcp2 $sink2

# Setup FTP applications
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

# Schedule events
$ns at 0.1 "$ftp1 start"
$ns at 0.5 "$ftp2 start"
$ns at 10.0 "$ftp1 stop"
$ns at 10.0 "$ftp2 stop"
$ns at 10.1 "finish"

# Finish procedure
proc finish {} {
    global ns tf
    $ns flush-trace
    close $tf
    exit 0
}

# Run simulation
$ns run