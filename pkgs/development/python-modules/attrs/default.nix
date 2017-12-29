{ lib, stdenv, buildPythonPackage, fetchPypi, pytest, hypothesis, zope_interface
, pympler, coverage, six, clang }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "attrs";
  version = "17.3.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "c78f53e32d7cf36d8597c8a2c7e3c0ad210f97b9509e152e4c37fa80869f823c";
  };

  # macOS needs clang for testing
  checkInputs = [
    pytest hypothesis zope_interface pympler coverage six
  ] ++ lib.optionals (stdenv.isDarwin) [ clang ];

  checkPhase = ''
    py.test
  '';

  # To prevent infinite recursion with pytest
  doCheck = false;

  meta = with lib; {
    description = "Python attributes without boilerplate";
    homepage = https://github.com/hynek/attrs;
    license = licenses.mit;
  };
}
