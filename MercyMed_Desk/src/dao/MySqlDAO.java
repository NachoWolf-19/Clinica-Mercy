package dao;

import controller.MySqlCitaDAO;
import controller.MySqlConsultorioDAO;
import controller.MySqlEspecialidadDAO;
import controller.MySqlHorarioDAO;
import controller.MySqlMedicoDAO;
import controller.MySqlPacienteDAO;
import controller.MySqlReporteDAO;
import controller.MySqlUsuarioDAO;
import interfaces.CitaDAO;
import interfaces.ConsultorioDAO;
import interfaces.EspecialidadDAO;
import interfaces.HorarioDAO;
import interfaces.MedicoDAO;
import interfaces.PacienteDAO;
import interfaces.ReporteDAO;
import interfaces.UsuarioDAO;

public class MySqlDAO extends DAO {
	// PacienteDAOO
	@Override
	public PacienteDAO getPacienteDAO() {
		return new MySqlPacienteDAO();
	}

	// EspecialidadDAO
	@Override
	public EspecialidadDAO getEspecialidadDAO() {
		return new MySqlEspecialidadDAO();
	}

	// MedicoDAO
	@Override
	public MedicoDAO getMedicoDAO() {
		return new MySqlMedicoDAO();
	}

	// ConsultorioDAO
	@Override
	public ConsultorioDAO getConsultorioDAO() {
		return new MySqlConsultorioDAO();
	}

	// HorarioDAO
	@Override
	public HorarioDAO getHorarioDAO() {
		return new MySqlHorarioDAO();
	}

	// CitaDAO
	@Override
	public CitaDAO getCitaDAO() {
		return new MySqlCitaDAO();
	}

	// ReporteDAO
	@Override
	public ReporteDAO getReporteDAO() {
		return new MySqlReporteDAO();
	}

	// UsuarioDAO
	@Override
	public UsuarioDAO getUsuarioDAO() {
		return new MySqlUsuarioDAO();
	}
}
