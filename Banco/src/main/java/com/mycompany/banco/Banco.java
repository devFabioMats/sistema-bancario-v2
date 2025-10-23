package com.mycompany.banco;
import model.Usuario;
import model.Endereco;
import controller.ClienteControle;
import javax.swing.JFrame;
import view.ViewCriarUsuario;
import view.ViewTransferir;
import view.ViewCartao;
import view.Principal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Banco {
    public static String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String url="jdbc:sqlserver://localhost:1433;databaseName=banco;trustServerCertificate=true";
    public static String user="sa";
    public static String password="1234";
            
    public static void main(String[] args) {
        Principal tela = new Principal();
        tela.setVisible(true);

    }

}
