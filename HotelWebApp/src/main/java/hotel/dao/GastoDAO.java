package hotel.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import hotel.config.DatabaseConnection;
import hotel.model.Cliente;
import hotel.model.Gasto;
import hotel.model.Reserva;
import hotel.model.Servicio;

public class GastoDAO {
    
    public boolean insertar(Gasto g) {
        String sql = "INSERT INTO gastos (reserva_id, servicio_id, cantidad, total) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, g.getReserva().getIdReserva());
            stmt.setInt(2, g.getServicio().getIdServicio());
            stmt.setInt(3, g.getCantidad());
            stmt.setDouble(4, g.getTotal());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Gasto> listarTodos() {
        List<Gasto> lista = new ArrayList<>();
        String sql = "SELECT g.id_gasto, g.cantidad, g.total, g.fecha, " +
                    "s.id_servicio, s.descripcion, " +
                    "r.id_reserva, " +
                    "c.nombre AS cliente_nombre, c.apellido " +
                    "FROM gastos g " +
                    "JOIN servicios s ON g.servicio_id = s.id_servicio " +
                    "JOIN reservas r ON g.reserva_id = r.id_reserva " +
                    "JOIN clientes c ON r.cliente_id = c.id_cliente " +
                    "ORDER BY g.id_gasto DESC";
        try (Connection conn = DatabaseConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Servicio s = new Servicio();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setDescripcion(rs.getString("descripcion"));
                
                Cliente c = new Cliente();
                c.setNombre(rs.getString("cliente_nombre"));
                c.setApellido(rs.getString("apellido"));
                
                Reserva r = new Reserva();
                r.setIdReserva(rs.getInt("id_reserva"));
                r.setCliente(c);
                
                Gasto g = new Gasto(
                    rs.getInt("id_gasto"),
                    r,
                    s,
                    rs.getInt("cantidad"),
                    rs.getDouble("total"),
                    rs.getTimestamp("fecha")
                );
                lista.add(g);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
