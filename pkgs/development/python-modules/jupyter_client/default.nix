{ lib
, buildPythonPackage
, fetchPypi
, nose
, traitlets
, jupyter_core
, pyzmq
, dateutil
, isPyPy
, py
}:

buildPythonPackage rec {
  pname = "jupyter_client";
  version = "5.2.0";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "ca30cf1786047925ebacd6f6faa3a993efaa004b584f7d83bc8b807f7cd3f6bb";
  };

  buildInputs = [ nose ];
  propagatedBuildInputs = [traitlets jupyter_core pyzmq dateutil] ++ lib.optional isPyPy py;

  checkPhase = ''
    nosetests -v
  '';

  # Circular dependency with ipykernel
  doCheck = false;

  meta = {
    description = "Jupyter protocol implementation and client libraries";
    homepage = http://jupyter.org/;
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ fridh ];
  };
}