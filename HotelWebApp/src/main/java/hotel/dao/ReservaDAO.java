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
import hotel.model.Habitacion;
import hotel.model.Reserva;

public class ReservaDAO {
    
    public boolean insertar(Reserva r) {
        String sql = "INSERT INTO reservas (cliente_id, habitacion_id, fecha_entrada, fecha_salida, estado) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, r.getCliente().getIdCliente());
            stmt.setInt(2, r.getHabitacion().getIdHabitacion());
            stmt.setDate(3, new java.sql.Date(r.getFechaEntrada().getTime()));
            stmt.setDate(4, new java.sql.Date(r.getFechaSalida().getTime()));
            stmt.setString(5, r.getEstado());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Reserva> listarTodos() {
        List<Reserva> lista = new ArrayList<>();
        String sql = "SELECT r.id_reserva, r.fecha_entrada, r.fecha_salida, r.estado, " +
                    "c.id_cliente, c.nombre AS cliente_nombre, c.apellido, " +
                    "h.id_habitacion, h.numero " +
                    "FROM reservas r " +
                    "JOIN clientes c ON r.cliente_id = c.id_cliente " +
                    "JOIN habitaciones h ON r.habitacion_id = h.id_habitacion " +
                    "ORDER BY r.id_reserva DESC";
        try (Connection conn = DatabaseConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("cliente_nombre"));
                c.setApellido(rs.getString("apellido"));
                
                Habitacion h = new Habitacion();
                h.setIdHabitacion(rs.getInt("id_habitacion"));
                h.setNumero(rs.getString("numero"));
                
                Reserva r = new Reserva(
                    rs.getInt("id_reserva"),
                    c,
                    h,
                    rs.getDate("fecha_entrada"),
                    rs.getDate("fecha_salida"),
                    rs.getString("estado")
                );
                lista.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
