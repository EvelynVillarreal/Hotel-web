<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="hotel.model.Habitacion"%>
<%@page import="hotel.model.TipoHabitacion"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Habitaciones</title>
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
        .badge { padding: 4px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .badge.disponible { background: rgba(34,197,94,0.2); color: #22c55e; }
        .badge.ocupada { background: rgba(239,68,68,0.2); color: #ef4444; }
        .badge.mantenimiento { background: rgba(234,179,8,0.2); color: #eab308; }
        .action-btn { background: rgba(56,189,248,0.1); color: #38bdf8; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 0.9rem; font-weight: 600; margin-right: 5px; }
    </style>
</head>
<body>
    <div class="header-bar">
        <a href="index.jsp" class="back-btn">← Volver al Panel</a>
        <h1>🏨 Gestión de Habitaciones</h1>
    </div>
    
    <form action="habitaciones" method="POST" class="form-container">
        <div class="form-group">
            <label>Número de Habitación</label>
            <input type="text" name="numero" placeholder="Ej. 101" required>
        </div>
        <div class="form-group">
            <label>Tipo de Habitación</label>
            <select name="tipo_id" required>
                <option value="">Seleccione un tipo...</option>
                <%
                    List<TipoHabitacion> tipos = (List<TipoHabitacion>) request.getAttribute("listaTipos");
                    if (tipos != null) {
                        for (TipoHabitacion t : tipos) {
                %>
                <option value="<%= t.getIdTipo() %>"><%= t.getNombre() %> ($<%= t.getPrecioBase() %>/noche)</option>
                <%      }
                    } %>
            </select>
        </div>
        <div class="form-group" style="grid-column: span 2;">
            <label>Estado</label>
            <select name="estado" required>
                <option value="Disponible">Disponible</option>
                <option value="Ocupada">Ocupada</option>
                <option value="Mantenimiento">Mantenimiento</option>
            </select>
        </div>
        <button type="submit" class="submit-btn">Guardar Habitación</button>
    </form>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Número</th>
                    <th>Tipo</th>
                    <th>Capacidad</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Habitacion> habitaciones = (List<Habitacion>) request.getAttribute("listaHabitaciones");
                    if (habitaciones != null && !habitaciones.isEmpty()) {
                        for (Habitacion h : habitaciones) {
                            String cssClass = "disponible";
                            if (h.getEstado().equalsIgnoreCase("Ocupada")) cssClass = "ocupada";
                            else if (h.getEstado().equalsIgnoreCase("Mantenimiento")) cssClass = "mantenimiento";
                %>
                <tr>
                    <td><%= h.getIdHabitacion() %></td>
                    <td><%= h.getNumero() %></td>
                    <td><%= h.getTipo().getNombre() %></td>
                    <td><%= h.getTipo().getCapacidad() %> Personas</td>
                    <td><span class="badge <%= cssClass %>"><%= h.getEstado() %></span></td>
                    <td>
                        <a href="#" class="action-btn">Editar</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="6" style="text-align: center; color: #94a3b8;">No hay habitaciones registradas.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
