package hotel.controller;

import hotel.dao.HabitacionDAO;
import hotel.dao.TipoHabitacionDAO;
import hotel.model.Habitacion;
import hotel.model.TipoHabitacion;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HabitacionServlet", urlPatterns = {"/habitaciones"})
public class HabitacionServlet extends HttpServlet {
    
    private HabitacionDAO habitacionDAO = new HabitacionDAO();
    private TipoHabitacionDAO tipoHabitacionDAO = new TipoHabitacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Habitacion> habitaciones = habitacionDAO.listarTodos();
        List<TipoHabitacion> tipos = tipoHabitacionDAO.listarTodos();
        
        request.setAttribute("listaHabitaciones", habitaciones);
        request.setAttribute("listaTipos", tipos);
        
        request.getRequestDispatcher("habitaciones.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String numero = request.getParameter("numero");
        int tipoId = Integer.parseInt(request.getParameter("tipo_id"));
        String estado = request.getParameter("estado");
        
        TipoHabitacion tipo = new TipoHabitacion();
        tipo.setIdTipo(tipoId);
        
        Habitacion h = new Habitacion(0, numero, tipo, estado);
        habitacionDAO.insertar(h);
        
        response.sendRedirect("habitaciones");
    }
}
