package com.mycompany.banco;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TesteConexao {
    
    public static void main(String[] args) {
        System.out.println("=== TESTE DE CONEXÃO SQL SERVER ===");
        
        // Configurações para testar
        String[] urls = {
            "jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=SistemaBancario;encrypt=true;trustServerCertificate=true;",
            "jdbc:sqlserver://localhost:1433;databaseName=SistemaBancario;encrypt=true;trustServerCertificate=true;",
            "jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=master;encrypt=true;trustServerCertificate=true;",
            "jdbc:sqlserver://localhost:1433;databaseName=master;encrypt=true;trustServerCertificate=true;"
        };
        
        String[] nomes = {
            "SQL Express - SistemaBancario",
            "SQL Padrão - SistemaBancario", 
            "SQL Express - Master",
            "SQL Padrão - Master"
        };
        
        String user = "sa";
        String password = "1234";
        
        for (int i = 0; i < urls.length; i++) {
            System.out.println("\nTeste " + (i+1) + ": " + nomes[i]);
            System.out.println("URL: " + urls[i]);
            
            try {
                Connection conn = DriverManager.getConnection(urls[i], user, password);
                System.out.println("✅ SUCESSO: Conexão estabelecida!");
                
                // Testar uma query simples
                var stmt = conn.createStatement();
                var rs = stmt.executeQuery("SELECT @@VERSION");
                if (rs.next()) {
                    System.out.println("Versão SQL Server: " + rs.getString(1).substring(0, 50) + "...");
                }
                
                conn.close();
                System.out.println("Esta configuração está funcionando!");
                break;
                
            } catch (SQLException e) {
                System.out.println("❌ ERRO: " + e.getMessage());
            }
        }
        
        System.out.println("\n=== FIM DO TESTE ===");
    }
}