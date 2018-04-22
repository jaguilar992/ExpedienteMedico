import requests
def postear(data, url):
    return requests.post('http://127.0.0.1/syme/BackEnd/services/'+url+'.php', data=data).content

url='ConsultaExterna'
data={
  'accion':'crear',
  'idConsultorio': None,
  'idExpediente': None,
  'idMedico': None,
  'fechaHora': None,
  'sintomas': None,
  'diagnostico': None,
  'observacion': None,
}
print postear(data,url)
print

url='ConsultaExterna'
data={
  'accion':'listarPorPaciente',
  'idExpediente': None,
}
print postear(data,url)
print

url='ConsultaExterna'
data={
  'accion':'listarPorHoy',
}
print postear(data,url)
print

url='ConsultaExterna'
data={
  'accion':'listarPorConsultorio',
  'idConsultorio': None,
}
print postear(data,url)
print

url='ConsultaExterna'
data={
  'accion':'listarPorMedico',
  'idMedico': None,
}
print postear(data,url)
print

url='ConsultaExterna'
data={
  'accion':'actualizar',
  'idConsulta': None,
  'idExpediente': None,
  'idConsultorio': None,
  'idMedico': None,
  'fechaHora': None,
  'sintomas': None,
  'diagnostico': None,
  'observ': None,
}
print postear(data,url)
print

url='ConsultaExterna'
data={
  'accion':'listarPorCentroMedico',
  'idCentroMedico': None,
  'nombreCentro': None,
}
print postear(data,url)
print

url='ConsultaExterna'
data={
  'accion':'listarPorCentroMedicoFecha',
  'idCentroMedico': None,
  'fechaHora': None,
}
print postear(data,url)
print
