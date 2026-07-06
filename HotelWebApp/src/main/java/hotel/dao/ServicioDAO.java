package hotel.dao;

import hotel.config.DatabaseConnection;
import hotel.model.Servicio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServicioDAO {
    
    public List<Servicio> listarTodos() {
        List<Servicio> lista = new ArrayList<>();
        String sql = "SELECT * FROM servicios ORDER BY id_servicio";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
             
            while (rs.next()) {
                lista.add(new Servicio(
                    rs.getInt("id_servicio"),
                    rs.getString("descripcion"),
                    rs.getDouble("precio")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
