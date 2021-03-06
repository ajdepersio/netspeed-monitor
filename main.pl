#!/usr/bin/perl
use strict;
use warnings;
use DateTime;

my $speedTestResults = `speedtest-cli --simple`;

my $ping = $speedTestResults =~ /Ping:\s(.*)\sms/ ? $1 : 'Error Retrieving Ping';
my $download = $speedTestResults =~ /Download:\s(.*)\sMbit\/s/ ? $1 : 'Error Retrieving Download Speed';
my $upload = $speedTestResults =~ /Upload:\s(.*)\sMbit\/s/ ? $1 : 'Error Retrieving Upload Speed';
my $now = DateTime->now;

my $outFile = 'out.csv';
if (!(-e $outFile)) 
{
    #Make the out file if not exist and write the headers as well as the data
    open(FILE, ">$outFile") || die("Error creating $outFile");
    print FILE "Date/Time,Ping ms,Download Mbit/s,Upload Mbit/s";
    print FILE "\n$now,$ping,$download,$upload";
    close(FILE);
}
else 
{
    #just write the new data
    open(FILE, ">>$outFile") || die("Error opening $outFile");
    print FILE "\n$now,$ping,$download,$upload";
    close(FILE);
}
