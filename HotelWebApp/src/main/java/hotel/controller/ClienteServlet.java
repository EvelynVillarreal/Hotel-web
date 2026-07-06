package hotel.controller;

import hotel.dao.ClienteDAO;
import hotel.model.Cliente;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/clientes"})
public class ClienteServlet extends HttpServlet {
    
    private ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener la lista de clientes de la base de datos
        List<Cliente> clientes = clienteDAO.listarTodos();
        
        // Pasar la lista al JSP
        request.setAttribute("listaClientes", clientes);
        request.getRequestDispatcher("clientes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Leer datos del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String dni = request.getParameter("dni");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        
        // Crear el objeto y guardarlo
        Cliente nuevoCliente = new Cliente(0, nombre, apellido, dni, email, telefono);
        clienteDAO.insertar(nuevoCliente);
        
        // Redirigir de vuelta a la lista (hace un GET automáticamente)
        response.sendRedirect("clientes");
    }
}
