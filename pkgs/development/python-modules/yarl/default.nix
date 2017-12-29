{ lib
, fetchurl
, buildPythonPackage
, multidict
, pytestrunner
, pytest
}:

let
  pname = "yarl";
  version = "0.16.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";
  src = fetchurl {
    url = "mirror://pypi/${builtins.substring 0 1 pname}/${pname}/${name}.tar.gz";
    sha256 = "47622985ecd9b15335d65c1acd54aeb3ba449e6d09b36e37ecfe334c7e7b8d0b";
  };

  buildInputs = [ pytest pytestrunner ];
  propagatedBuildInputs = [ multidict ];


  meta = {
    description = "Yet another URL library";
    homepage = https://github.com/aio-libs/yarl/;
    license = lib.licenses.asl20;
  };
}