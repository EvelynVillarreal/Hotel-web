<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="hotel.model.Gasto"%>
<%@page import="hotel.model.Reserva"%>
<%@page import="hotel.model.Servicio"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Servicios y Gastos Extra</title>
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
        .submit-btn { background: #38bdf8; color: #0f172a; border: none; padding: 12px; border-radius: 8px; font-weight: 600; cursor: pointer; grid-column: span 2; margin-top: 10px; font-size: 1rem; }
        .submit-btn:hover { background: #0ea5e9; }

        .table-container { background: rgba(255,255,255,0.03); border-radius: 12px; border: 1px solid rgba(255,255,255,0.1); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 15px 20px; border-bottom: 1px solid rgba(255,255,255,0.05); }
        th { background: rgba(0,0,0,0.2); font-weight: 600; color: #38bdf8; }
        tr:hover { background: rgba(255,255,255,0.02); }
        .action-btn { background: rgba(239,68,68,0.1); color: #ef4444; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 0.9rem; font-weight: 600; margin-right: 5px; }
    </style>
    <script>
        function calcularTotal() {
            var selectServicio = document.getElementById("servicioSelect");
            var cantidad = document.getElementById("cantidadInput").value;
            var precio = 0;
            if (selectServicio.selectedIndex > 0) {
                precio = selectServicio.options[selectServicio.selectedIndex].getAttribute("data-precio");
            }
            document.getElementById("totalInput").value = (precio * cantidad).toFixed(2);
        }
    </script>
</head>
<body>
    <div class="header-bar">
        <a href="index.jsp" class="back-btn">← Volver al Panel</a>
        <h1>🍽️ Gestión de Servicios y Gastos Extra</h1>
    </div>
    
    <form action="servicios" method="POST" class="form-container">
        <div class="form-group">
            <label>Reserva Activa</label>
            <select name="reserva_id" required>
                <option value="">Seleccione reserva...</option>
                <%
                    List<Reserva> reservas = (List<Reserva>) request.getAttribute("listaReservas");
                    if (reservas != null) {
                        for (Reserva r : reservas) {
                %>
                <option value="<%= r.getIdReserva() %>">Reserva #<%= r.getIdReserva() %> - <%= r.getCliente().getNombre() %> <%= r.getCliente().getApellido() %></option>
                <%      }
                    } %>
            </select>
        </div>
        <div class="form-group">
            <label>Servicio</label>
            <select name="servicio_id" id="servicioSelect" onchange="calcularTotal()" required>
                <option value="">Seleccione servicio...</option>
                <%
                    List<Servicio> servicios = (List<Servicio>) request.getAttribute("listaServicios");
                    if (servicios != null) {
                        for (Servicio s : servicios) {
                %>
                <option value="<%= s.getIdServicio() %>" data-precio="<%= s.getPrecio() %>"><%= s.getDescripcion() %> ($<%= s.getPrecio() %>)</option>
                <%      }
                    } %>
            </select>
        </div>
        <div class="form-group">
            <label>Cantidad</label>
            <input type="number" name="cantidad" id="cantidadInput" value="1" min="1" onchange="calcularTotal()" onkeyup="calcularTotal()" required>
        </div>
        <div class="form-group">
            <label>Total Estimado ($)</label>
            <input type="text" name="total" id="totalInput" placeholder="0.00" readonly style="background: rgba(0,0,0,0.4);">
        </div>
        <button type="submit" class="submit-btn">Añadir Gasto a la Reserva</button>
    </form>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID Gasto</th>
                    <th>Reserva / Cliente</th>
                    <th>Servicio</th>
                    <th>Cant.</th>
                    <th>Total</th>
                    <th>Fecha</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Gasto> gastos = (List<Gasto>) request.getAttribute("listaGastos");
                    if (gastos != null && !gastos.isEmpty()) {
                        for (Gasto g : gastos) {
                %>
                <tr>
                    <td><%= g.getIdGasto() %></td>
                    <td>#<%= g.getReserva().getIdReserva() %> - <%= g.getReserva().getCliente().getNombre() %> <%= g.getReserva().getCliente().getApellido() %></td>
                    <td><%= g.getServicio().getDescripcion() %></td>
                    <td><%= g.getCantidad() %></td>
                    <td>$<%= g.getTotal() %></td>
                    <td><%= g.getFecha() != null ? g.getFecha().toString().substring(0, 16) : "" %></td>
                    <td>
                        <a href="#" class="action-btn">Eliminar</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="7" style="text-align: center; color: #94a3b8;">No hay gastos registrados.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
