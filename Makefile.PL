use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'vpopmail',
    'VERSION_FROM' => 'vpopmail.pm', # finds $VERSION
    'LIBS'	=> ['-L/usr/local/vpopmail/lib -lvpopmail'],   # e.g., '-lm' 
    'DEFINE'	=> '',     # e.g., '-DHAVE_SOMETHING' 
    'INC'	=> '-I/usr/local/vpopmail/include', 
);
