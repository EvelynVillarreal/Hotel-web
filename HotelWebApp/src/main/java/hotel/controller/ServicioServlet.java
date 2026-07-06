package hotel.controller;

import hotel.dao.GastoDAO;
import hotel.dao.ReservaDAO;
import hotel.dao.ServicioDAO;
import hotel.model.Gasto;
import hotel.model.Reserva;
import hotel.model.Servicio;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ServicioServlet", urlPatterns = {"/servicios"})
public class ServicioServlet extends HttpServlet {
    
    private GastoDAO gastoDAO = new GastoDAO();
    private ReservaDAO reservaDAO = new ReservaDAO();
    private ServicioDAO servicioDAO = new ServicioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Gasto> gastos = gastoDAO.listarTodos();
        List<Reserva> reservas = reservaDAO.listarTodos();
        List<Servicio> servicios = servicioDAO.listarTodos();
        
        request.setAttribute("listaGastos", gastos);
        request.setAttribute("listaReservas", reservas);
        request.setAttribute("listaServicios", servicios);
        
        request.getRequestDispatcher("servicios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        int reservaId = Integer.parseInt(request.getParameter("reserva_id"));
        int servicioId = Integer.parseInt(request.getParameter("servicio_id"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        double total = Double.parseDouble(request.getParameter("total"));
        
        Reserva r = new Reserva();
        r.setIdReserva(reservaId);
        
        Servicio s = new Servicio();
        s.setIdServicio(servicioId);
        
        Gasto g = new Gasto(0, r, s, cantidad, total, null);
        gastoDAO.insertar(g);
        
        response.sendRedirect("servicios");
    }
}
