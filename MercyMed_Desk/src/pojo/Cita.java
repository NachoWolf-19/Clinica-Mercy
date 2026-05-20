package pojo;

import java.time.LocalDateTime;

public class Cita {
	private final int citaID;
	private double citaPrecio;
	private String citaTipo;
	private LocalDateTime citaFechaRegistro;
	private Paciente p;
	private Horario h;

	public Cita() {
		this.citaID = 0;
	}

	public Cita(int citaID, double citaPrecio, String citaTipo, LocalDateTime citaFechaRegistro, Paciente p,
			Horario h) {
		this.citaID = citaID;
		this.citaPrecio = citaPrecio;
		this.citaTipo = citaTipo;
		this.citaFechaRegistro = citaFechaRegistro;
		this.p = p;
		this.h = h;
	}

	public Cita(double citaPrecio, String citaTipo, LocalDateTime citaFechaRegistro, Paciente p, Horario h) {
		this.citaID = 0;
		this.citaPrecio = citaPrecio;
		this.citaTipo = citaTipo;
		this.citaFechaRegistro = citaFechaRegistro;
		this.p = p;
		this.h = h;
	}

	public double getCitaPrecio() {
		return citaPrecio;
	}

	public void setCitaPrecio(double citaPrecio) {
		this.citaPrecio = citaPrecio;
	}

	public String getCitaTipo() {
		return citaTipo;
	}

	public void setCitaTipo(String citaTipo) {
		this.citaTipo = citaTipo;
	}

	public LocalDateTime getCitaFechaRegistro() {
		return citaFechaRegistro;
	}

	public void setCitaFechaRegistro(LocalDateTime citaFechaRegistro) {
		this.citaFechaRegistro = citaFechaRegistro;
	}

	public Paciente getPaciente() {
		return p;
	}

	public void setPaciente(Paciente p) {
		this.p = p;
	}

	public Horario getHorario() {
		return h;
	}

	public void setHorario(Horario h) {
		this.h = h;
	}

	public int getCitaID() {
		return citaID;
	}
}
