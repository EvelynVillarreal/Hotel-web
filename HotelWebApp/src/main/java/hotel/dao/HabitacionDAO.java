package hotel.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import hotel.config.DatabaseConnection;
import hotel.model.Habitacion;
import hotel.model.TipoHabitacion;

public class HabitacionDAO {
    
    public boolean insertar(Habitacion h) {
        String sql = "INSERT INTO habitaciones (numero, tipo_id, estado) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, h.getNumero());
            stmt.setInt(2, h.getTipo().getIdTipo());
            stmt.setString(3, h.getEstado());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Habitacion> listarTodos() {
        List<Habitacion> lista = new ArrayList<>();
        String sql = "SELECT h.id_habitacion, h.numero, h.estado, t.id_tipo, t.nombre, t.precio_base, t.capacidad " +
                    "FROM habitaciones h JOIN tipos_habitacion t ON h.tipo_id = t.id_tipo ORDER BY h.id_habitacion DESC";
        try (Connection conn = DatabaseConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                TipoHabitacion tipo = new TipoHabitacion(
                    rs.getInt("id_tipo"),
                    rs.getString("nombre"),
                    rs.getDouble("precio_base"),
                    rs.getInt("capacidad")
                );
                Habitacion h = new Habitacion(
                    rs.getInt("id_habitacion"),
                    rs.getString("numero"),
                    tipo,
                    rs.getString("estado")
                );
                lista.add(h);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
