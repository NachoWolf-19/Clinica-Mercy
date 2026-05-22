package dao;

import interfaces.CitaDAO;
import interfaces.ConsultorioDAO;
import interfaces.EspecialidadDAO;
import interfaces.HorarioDAO;
import interfaces.MedicoDAO;
import interfaces.PacienteDAO;
import interfaces.ReporteDAO;
import interfaces.UsuarioDAO;

public abstract class DAO {
	// PacienteDAO
	public abstract PacienteDAO getPacienteDAO();

	// EspecialidadDAO
	public abstract EspecialidadDAO getEspecialidadDAO();

	// MedicoDAO
	public abstract MedicoDAO getMedicoDAO();

	// HorarioDAO
	public abstract HorarioDAO getHorarioDAO();

	// ConsultorioDAO
	public abstract ConsultorioDAO getConsultorioDAO();

	// CitaDAO
	public abstract CitaDAO getCitaDAO();

	// ReporteDAO
	public abstract ReporteDAO getReporteDAO();

	// UsuarioDAO
	public abstract UsuarioDAO getUsuarioDAO();

	public static DAO getDaoFactory() {
		return new MySqlDAO();
	}
}
