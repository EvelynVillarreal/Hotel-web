<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Gestión - Hotel</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-gradient: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.1);
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --accent: #38bdf8;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background: var(--bg-gradient);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .dashboard-container {
            width: 90%;
            max-width: 1000px;
            padding: 40px;
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--card-border);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 600;
            margin: 0;
            background: linear-gradient(to right, #38bdf8, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .header p {
            color: var(--text-muted);
            font-size: 1.1rem;
            margin-top: 10px;
        }

        .modules-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 24px;
        }

        .module-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            padding: 30px 20px;
            text-align: center;
            text-decoration: none;
            color: var(--text-main);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .module-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(180deg, rgba(56, 189, 248, 0.1) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .module-card:hover {
            transform: translateY(-5px);
            border-color: var(--accent);
            box-shadow: 0 10px 25px -5px rgba(56, 189, 248, 0.2);
        }

        .module-card:hover::before {
            opacity: 1;
        }

        .module-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }

        .module-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="header">
            <h1>Panel de Administración</h1>
            <p>Seleccione un módulo para gestionar los recursos del hotel</p>
        </div>
        
        <div class="modules-grid">
            <a href="clientes" class="module-card">
                <span class="module-icon">👥</span>
                <h2 class="module-title">Clientes</h2>
            </a>
            
            <a href="habitaciones" class="module-card">
                <span class="module-icon">🏨</span>
                <h2 class="module-title">Habitaciones</h2>
            </a>
            
            <a href="reservas" class="module-card">
                <span class="module-icon">📅</span>
                <h2 class="module-title">Reservas</h2>
            </a>
            
            <a href="servicios" class="module-card">
                <span class="module-icon">🍽️</span>
                <h2 class="module-title">Servicios Extra</h2>
            </a>
        </div>
    </div>
</body>
</html>
