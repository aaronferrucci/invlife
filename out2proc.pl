use strict;
use warnings;

while (my $line = <>) {
  next if $line =~ /\s*%/;

  chomp $line;
  print "// $line\n" if $line =~ /^[mn]\s*=/;

  if ($line =~ /^end_grid=/ .. $line =~ /\|\];$/) {
    if ($line =~ /^end_grid=/) {
      print "int[][] start = {\n";
    } else {
      if ($line =~ /\];/) {
        $line =~ s/\];//;

      }
      $line =~ s/\]//;
      $line =~ s/\|/,/;

      print "  {$line },\n";
    }

  }
}
print "};\n";

