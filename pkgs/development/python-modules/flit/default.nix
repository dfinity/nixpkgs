{ lib
, buildPythonPackage
, fetchPypi
, fetchurl
, isPy3k
, docutils
, requests
, requests_download
, zipfile36
, pythonOlder
, pytest
, testpath
, responses
}:

# Flit is actually an application to build universal wheels.
# It requires Python 3 and should eventually be moved outside of
# python-packages.nix. When it will be used to build wheels,
# care should be taken that there is no mingling of PYTHONPATH.

buildPythonPackage rec {
  pname = "flit";
  version = "0.13";
  name = "${pname}-${version}";

#   format = "wheel";

  src = fetchPypi {
    inherit pname version;
#     url = https://files.pythonhosted.org/packages/24/98/50a090112a04d9e29155c31a222637668b0a4dd778fefcd3132adc50e877/flit-0.10-py3-none-any.whl;
    sha256 = "26bf9a3a9b743fed085420b4eed24f78341c0d2103a5f726980f7e7750400e81";
  };

  disabled = !isPy3k;
  propagatedBuildInputs = [ docutils requests requests_download ] ++ lib.optional (pythonOlder "3.6") zipfile36;

  checkInputs = [ pytest testpath responses ];

  # Disable test that needs some ini file.
  checkPhase = ''
    py.test -k "not test_invalid_classifier"
  '';

  meta = {
    description = "A simple packaging tool for simple packages";
    homepage = https://github.com/takluyver/flit;
    license = lib.licenses.bsd3;
    maintainers = [ lib.maintainers.fridh ];
  };
}
