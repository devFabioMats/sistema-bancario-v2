package controller;
import model.CartaoVirtual;
import model.Conta;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

public class CartaoControle {
    public static String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String url="jdbc:sqlserver://localhost:1433;databaseName=banco;trustServerCertificate=true";
    public static String user="sa";
    public static String password="1234";
    Conta conta = new Conta();
         
    public void gerarCartão(CartaoVirtual cartao, int login, String senha) {
        Connection conexao = null;
        PreparedStatement ps = null;
        ResultSet ls = null;
        Statement st = null;
        Random gerador = new Random();
        
        // Gerar os valores do cartão
        int numeroCartao = gerador.nextInt(89999) + 1000;
        int cvv = gerador.nextInt(899) + 100;
        
        try{
            Class.forName(driver);
        }catch(Exception ex){
            System.out.println(ex);
        }
        try{
            conexao = DriverManager.getConnection(url,user,password); 
            String sql3 = "SELECT * FROM Conta Where cpfUsuario='" + login + "'";
            st = conexao.createStatement();            
            ls = st.executeQuery(sql3);
            while(ls.next()){
                conta.setNumero(ls.getInt(1));
                conta.setCpfUsuario(ls.getInt(4));
            }
            conexao.close();
        }catch(Exception  ex){
            System.out.println(ex);
        } 
        try{
            conexao = DriverManager.getConnection(url,user,password);
            String sql = "INSERT INTO Cartao(numCartao,cvv,limite,numConta,cpfUsuario) VALUES(?,?,?,?,?);";
            ps = conexao.prepareStatement(sql);
            ps.setInt(1, numeroCartao);
            ps.setInt(2, cvv);
            ps.setFloat(3, cartao.getLimite());
            ps.setInt(4, conta.getNumero());
            ps.setInt(5, conta.getCpfUsuario());
            ps.execute();
            ps.close();
            conexao.close();
            
            // Definir os valores gerados no objeto cartão para que possam ser acessados na view
            cartao.setCartao(numeroCartao);
            cartao.setCvv(cvv);
            
        }catch(Exception  ex){
            System.out.println(ex);
        }
        System.out.println("Cartão criado com sucesso");
    }
}
