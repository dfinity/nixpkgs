{ stdenv, buildPythonPackage, fetchPypi
, nose, chai, simplejson
, dateutil }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "arrow";
  version = "0.12.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a15ecfddf334316e3ac8695e48c15d1be0d6038603b33043930dcf0e675c86ee";
  };

  checkPhase = ''
    nosetests --cover-package=arrow
  '';

  buildInputs = [ nose chai simplejson ];
  propagatedBuildInputs = [ dateutil ];

  meta = with stdenv.lib; {
    description = "Python library for date manipulation";
    license     = "apache";
    maintainers = with maintainers; [ thoughtpolice ];
  };
}
