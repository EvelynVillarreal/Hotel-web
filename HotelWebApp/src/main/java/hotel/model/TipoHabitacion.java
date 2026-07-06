package hotel.model;

public class TipoHabitacion {
    private int idTipo;
    private String nombre;
    private double precioBase;
    private int capacidad;

    public TipoHabitacion() {
    }

    public TipoHabitacion(int idTipo, String nombre, double precioBase, int capacidad) {
        this.idTipo = idTipo;
        this.nombre = nombre;
        this.precioBase = precioBase;
        this.capacidad = capacidad;
    }

    public int getIdTipo() {
        return idTipo;
    }

    public void setIdTipo(int idTipo) {
        this.idTipo = idTipo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getPrecioBase() {
        return precioBase;
    }

    public void setPrecioBase(double precioBase) {
        this.precioBase = precioBase;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }
}
