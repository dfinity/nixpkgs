{ stdenv, fetchPypi, buildPythonPackage, numpy, isPy3k, dateutil, dateutil_1_5 }:

buildPythonPackage rec {
  pname = "pycollada";
  version = "0.6";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "fcd6f38fd981e350f9ec754d9671834017accd600e967d6d299a6cfdae5ba4f4";
  };

  buildInputs = [ numpy ] ++ (if isPy3k then [dateutil] else [dateutil_1_5]);

  # Some tests fail because they refer to test data files that don't exist
  # (upstream packaging issue)
  doCheck = false;

  meta = with stdenv.lib; {
    description = "Python library for reading and writing collada documents";
    homepage = http://pycollada.github.io/;
    license = "BSD"; # they don't specify which BSD variant
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [ bjornfor ];
  };
}
