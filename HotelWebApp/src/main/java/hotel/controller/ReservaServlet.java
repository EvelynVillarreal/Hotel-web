package hotel.controller;

import hotel.dao.ClienteDAO;
import hotel.dao.HabitacionDAO;
import hotel.dao.ReservaDAO;
import hotel.model.Cliente;
import hotel.model.Habitacion;
import hotel.model.Reserva;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ReservaServlet", urlPatterns = {"/reservas"})
public class ReservaServlet extends HttpServlet {
    
    private ReservaDAO reservaDAO = new ReservaDAO();
    private ClienteDAO clienteDAO = new ClienteDAO();
    private HabitacionDAO habitacionDAO = new HabitacionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Reserva> reservas = reservaDAO.listarTodos();
        List<Cliente> clientes = clienteDAO.listarTodos();
        List<Habitacion> habitaciones = habitacionDAO.listarTodos();
        
        request.setAttribute("listaReservas", reservas);
        request.setAttribute("listaClientes", clientes);
        request.setAttribute("listaHabitaciones", habitaciones);
        
        request.getRequestDispatcher("reservas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            int clienteId = Integer.parseInt(request.getParameter("cliente_id"));
            int habitacionId = Integer.parseInt(request.getParameter("habitacion_id"));
            String entradaStr = request.getParameter("fecha_entrada");
            String salidaStr = request.getParameter("fecha_salida");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date entrada = sdf.parse(entradaStr);
            Date salida = sdf.parse(salidaStr);
            
            Cliente c = new Cliente();
            c.setIdCliente(clienteId);
            
            Habitacion h = new Habitacion();
            h.setIdHabitacion(habitacionId);
            
            Reserva r = new Reserva(0, c, h, entrada, salida, "Confirmada");
            reservaDAO.insertar(r);
            
        } catch (ParseException | NumberFormatException e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("reservas");
    }
}
