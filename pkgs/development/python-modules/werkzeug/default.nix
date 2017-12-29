{ stdenv, buildPythonPackage, fetchPypi
, itsdangerous
, pytest, requests, glibcLocales }:

buildPythonPackage rec {
  name = "${pname}-${version}";
  pname = "Werkzeug";
  version = "0.13";

  src = fetchPypi {
    inherit pname version;
    sha256 = "6246e5fc98a505824113fb6aca993d45ea284a2bcffdc2c65d0c538e53e4abd3";
  };

  LC_ALL = "en_US.UTF-8";

  propagatedBuildInputs = [ itsdangerous ];
  buildInputs = [ pytest requests glibcLocales ];

  meta = with stdenv.lib; {
    homepage = http://werkzeug.pocoo.org/;
    description = "A WSGI utility library for Python";
    license = licenses.bsd3;
  };
}
