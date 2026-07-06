<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="hotel.model.Reserva"%>
<%@page import="hotel.model.Cliente"%>
<%@page import="hotel.model.Habitacion"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Reservas</title>
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
        input, select { background: rgba(0,0,0,0.2); border: 1px solid rgba(255,255,255,0.1); color: white; padding: 12px; border-radius: 8px; font-family: 'Inter', sans-serif; }
        input:focus, select:focus { outline: none; border-color: #38bdf8; }
        input[type="date"]::-webkit-calendar-picker-indicator { filter: invert(1); }
        .submit-btn { background: #38bdf8; color: #0f172a; border: none; padding: 12px; border-radius: 8px; font-weight: 600; cursor: pointer; grid-column: span 2; margin-top: 10px; font-size: 1rem; }
        .submit-btn:hover { background: #0ea5e9; }

        .table-container { background: rgba(255,255,255,0.03); border-radius: 12px; border: 1px solid rgba(255,255,255,0.1); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 15px 20px; border-bottom: 1px solid rgba(255,255,255,0.05); }
        th { background: rgba(0,0,0,0.2); font-weight: 600; color: #38bdf8; }
        tr:hover { background: rgba(255,255,255,0.02); }
        .badge { padding: 4px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .badge.confirmada { background: rgba(34,197,94,0.2); color: #22c55e; }
        .action-btn { background: rgba(56,189,248,0.1); color: #38bdf8; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 0.9rem; font-weight: 600; margin-right: 5px; }
        .action-btn.delete { background: rgba(239,68,68,0.1); color: #ef4444; }
    </style>
</head>
<body>
    <div class="header-bar">
        <a href="index.jsp" class="back-btn">← Volver al Panel</a>
        <h1>📅 Gestión de Reservas</h1>
    </div>
    
    <form action="reservas" method="POST" class="form-container">
        <div class="form-group">
            <label>Cliente</label>
            <select name="cliente_id" required>
                <option value="">Seleccione un cliente...</option>
                <%
                    List<Cliente> clientes = (List<Cliente>) request.getAttribute("listaClientes");
                    if (clientes != null) {
                        for (Cliente c : clientes) {
                %>
                <option value="<%= c.getIdCliente() %>"><%= c.getNombre() %> <%= c.getApellido() %> (<%= c.getDni() %>)</option>
                <%      }
                    } %>
            </select>
        </div>
        <div class="form-group">
            <label>Habitación</label>
            <select name="habitacion_id" required>
                <option value="">Seleccione una habitación...</option>
                <%
                    List<Habitacion> habitaciones = (List<Habitacion>) request.getAttribute("listaHabitaciones");
                    if (habitaciones != null) {
                        for (Habitacion h : habitaciones) {
                            if (!h.getEstado().equals("Disponible")) continue;
                %>
                <option value="<%= h.getIdHabitacion() %>">Num: <%= h.getNumero() %> - <%= h.getTipo().getNombre() %></option>
                <%      }
                    } %>
            </select>
        </div>
        <div class="form-group">
            <label>Fecha de Entrada</label>
            <input type="date" name="fecha_entrada" required>
        </div>
        <div class="form-group">
            <label>Fecha de Salida</label>
            <input type="date" name="fecha_salida" required>
        </div>
        <button type="submit" class="submit-btn">Crear Reserva</button>
    </form>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cliente</th>
                    <th>Habitación</th>
                    <th>Entrada</th>
                    <th>Salida</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Reserva> reservas = (List<Reserva>) request.getAttribute("listaReservas");
                    if (reservas != null && !reservas.isEmpty()) {
                        for (Reserva r : reservas) {
                %>
                <tr>
                    <td><%= r.getIdReserva() %></td>
                    <td><%= r.getCliente().getNombre() %> <%= r.getCliente().getApellido() %></td>
                    <td><%= r.getHabitacion().getNumero() %></td>
                    <td><%= r.getFechaEntrada() %></td>
                    <td><%= r.getFechaSalida() %></td>
                    <td><span class="badge confirmada"><%= r.getEstado() %></span></td>
                    <td>
                        <a href="#" class="action-btn">Editar</a>
                        <a href="#" class="action-btn delete">Cancelar</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="7" style="text-align: center; color: #94a3b8;">No hay reservas registradas.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
