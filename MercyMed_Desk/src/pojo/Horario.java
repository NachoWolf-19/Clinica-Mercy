package pojo;

import java.time.LocalDate;
import java.time.LocalTime;

public class Horario {
	private final int horarioID;
	private LocalDate horarioFecha;
	private LocalTime horarioInicio;
	private String horarioEstado;
	private Medico m;
	private Consultorio c;

	public Horario() {
		this.horarioID = 0;
	}

	public Horario(int horarioID, LocalDate horarioFecha, LocalTime horarioInicio, String horarioEstado, Medico m,
			Consultorio c) {
		this.horarioID = horarioID;
		this.horarioFecha = horarioFecha;
		this.horarioInicio = horarioInicio;
		this.horarioEstado = horarioEstado;
		this.m = m;
		this.c = c;
	}

	public Horario(LocalDate horarioFecha, LocalTime horarioInicio, String horarioEstado, Medico m, Consultorio c) {
		this.horarioID = 0;
		this.horarioFecha = horarioFecha;
		this.horarioInicio = horarioInicio;
		this.horarioEstado = horarioEstado;
		this.m = m;
		this.c = c;
	}

	public LocalDate getHorarioFecha() {
		return horarioFecha;
	}

	public void setHorarioFecha(LocalDate horarioFecha) {
		this.horarioFecha = horarioFecha;
	}

	public LocalTime getHorarioInicio() {
		return horarioInicio;
	}

	public void setHorarioInicio(LocalTime horarioInicio) {
		this.horarioInicio = horarioInicio;
	}

	public String getHorarioEstado() {
		return horarioEstado;
	}

	public void setHorarioEstado(String horarioEstado) {
		this.horarioEstado = horarioEstado;
	}

	public Medico getMedico() {
		return m;
	}

	public void setMedico(Medico m) {
		this.m = m;
	}

	public Consultorio getConsultorio() {
		return c;
	}

	public void setConsultorio(Consultorio c) {
		this.c = c;
	}

	public int getHorarioID() {
		return horarioID;
	}
}
