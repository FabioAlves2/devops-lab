from app import app, soma

def test_soma():
    assert soma(1,2) == 3

def test_soma_negativos():
    assert soma(-1,-2) == -3

def test_soma_zero():
    assert soma(0,0) == 0


def test_home():
    response = app.test_client().get('/')
    assert response.status_code == 200
    assert b"Calculadora" in response.data

def test_health():
    response = app.test_client().get('/health')
    assert response.status_code == 200
    assert response.data == b'OK'

def test_soma_route():
    response = app.test_client().get('/soma?a=1&b=2')
    assert response.status_code == 200
    assert response.get_json() == {"a": 1, "b": 2, "resultado": 3}

def test_soma_route_default_values():
    response = app.test_client().get('/soma')
    assert response.status_code == 200
    assert response.get_json() == {"a": 0, "b": 0, "resultado": 0}