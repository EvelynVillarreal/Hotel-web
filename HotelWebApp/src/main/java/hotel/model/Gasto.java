package hotel.model;

import java.util.Date;

public class Gasto {
    private int idGasto;
    private Reserva reserva;
    private Servicio servicio;
    private int cantidad;
    private double total;
    private Date fecha;

    public Gasto() {
    }

    public Gasto(int idGasto, Reserva reserva, Servicio servicio, int cantidad, double total, Date fecha) {
        this.idGasto = idGasto;
        this.reserva = reserva;
        this.servicio = servicio;
        this.cantidad = cantidad;
        this.total = total;
        this.fecha = fecha;
    }

    public int getIdGasto() {
        return idGasto;
    }

    public void setIdGasto(int idGasto) {
        this.idGasto = idGasto;
    }

    public Reserva getReserva() {
        return reserva;
    }

    public void setReserva(Reserva reserva) {
        this.reserva = reserva;
    }

    public Servicio getServicio() {
        return servicio;
    }

    public void setServicio(Servicio servicio) {
        this.servicio = servicio;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
}
