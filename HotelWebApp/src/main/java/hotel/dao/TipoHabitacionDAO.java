package hotel.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import hotel.config.DatabaseConnection;
import hotel.model.TipoHabitacion;

public class TipoHabitacionDAO {
    public List<TipoHabitacion> listarTodos() {
        List<TipoHabitacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM tipos_habitacion ORDER BY id_tipo";
        try (Connection conn = DatabaseConnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                lista.add(new TipoHabitacion(
                    rs.getInt("id_tipo"),
                    rs.getString("nombre"),
                    rs.getDouble("precio_base"),
                    rs.getInt("capacidad")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
