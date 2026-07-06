<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="hotel.model.Cliente"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Clientes</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; font-family: 'Inter', sans-serif; background: #0f172a; color: #f8fafc; padding: 40px; }
        .header-bar { display: flex; align-items: center; gap: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 20px; margin-bottom: 30px; }
        .back-btn { text-decoration: none; color: #38bdf8; background: rgba(56,189,248,0.1); padding: 10px 20px; border-radius: 8px; font-weight: 600; transition: all 0.2s; }
        .back-btn:hover { background: rgba(56,189,248,0.2); }
        h1 { margin: 0; font-weight: 600; }
        
        .form-container { background: rgba(255,255,255,0.02); padding: 25px; border-radius: 12px; border: 1px solid rgba(255,255,255,0.1); margin-bottom: 30px; display: grid; gap: 15px; grid-template-columns: 1fr 1fr; }
        .form-group { display: flex; flex-direction: column; gap: 8px; }
        label { font-size: 0.9rem; color: #94a3b8; }
        input { background: rgba(0,0,0,0.2); border: 1px solid rgba(255,255,255,0.1); color: white; padding: 12px; border-radius: 8px; font-family: 'Inter', sans-serif; }
        input:focus { outline: none; border-color: #38bdf8; }
        .submit-btn { background: #38bdf8; color: #0f172a; border: none; padding: 12px; border-radius: 8px; font-weight: 600; cursor: pointer; grid-column: span 2; margin-top: 10px; font-size: 1rem; }
        .submit-btn:hover { background: #0ea5e9; }

        .table-container { background: rgba(255,255,255,0.03); border-radius: 12px; border: 1px solid rgba(255,255,255,0.1); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 15px 20px; border-bottom: 1px solid rgba(255,255,255,0.05); }
        th { background: rgba(0,0,0,0.2); font-weight: 600; color: #38bdf8; }
        tr:hover { background: rgba(255,255,255,0.02); }
        .action-btn { background: rgba(56,189,248,0.1); color: #38bdf8; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 0.9rem; font-weight: 600; margin-right: 5px; }
        .action-btn.delete { background: rgba(239,68,68,0.1); color: #ef4444; }
    </style>
</head>
<body>
    <div class="header-bar">
        <a href="index.jsp" class="back-btn">← Volver al Panel</a>
        <h1>👥 Gestión de Clientes</h1>
    </div>
    
    <form action="clientes" method="POST" class="form-container">
        <div class="form-group">
            <label>Nombre</label>
            <input type="text" name="nombre" placeholder="Ej. Juan" required>
        </div>
        <div class="form-group">
            <label>Apellido</label>
            <input type="text" name="apellido" placeholder="Ej. Pérez" required>
        </div>
        <div class="form-group">
            <label>DNI / Pasaporte</label>
            <input type="text" name="dni" placeholder="Ej. 123456789" required>
        </div>
        <div class="form-group">
            <label>Teléfono</label>
            <input type="text" name="telefono" placeholder="Ej. +34 600 000 000" required>
        </div>
        <div class="form-group" style="grid-column: span 2;">
            <label>Email</label>
            <input type="email" name="email" placeholder="Ej. juan@email.com" required>
        </div>
        <button type="submit" class="submit-btn">Guardar Cliente</button>
    </form>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre y Apellido</th>
                    <th>DNI</th>
                    <th>Email</th>
                    <th>Teléfono</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Cliente> clientes = (List<Cliente>) request.getAttribute("listaClientes");
                    if (clientes != null && !clientes.isEmpty()) {
                        for (Cliente c : clientes) {
                %>
                <tr>
                    <td><%= c.getIdCliente() %></td>
                    <td><%= c.getNombre() %> <%= c.getApellido() %></td>
                    <td><%= c.getDni() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getTelefono() %></td>
                    <td>
                        <a href="#" class="action-btn">Editar</a>
                        <a href="#" class="action-btn delete">Eliminar</a>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; color: #94a3b8;">No hay clientes registrados en la base de datos.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
