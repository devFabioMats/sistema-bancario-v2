package controller;
import model.Extrato;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ExtratoControle {
    public static String driver="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    public static String url="jdbc:sqlserver://localhost:1433;databaseName=banco;trustServerCertificate=true";
    public static String user="sa";
    public static String password="1234";
    
    public List<Extrato> pegarExtrato(int login, String senha){
        Connection conexao = null;
        ResultSet ps = null;
        PreparedStatement rs=null;
        List<Extrato> extratos = new ArrayList<>();
        try{
            Class.forName(driver);
        }catch(Exception ex){
            System.out.println(ex);
        }
        try{
            conexao = DriverManager.getConnection(url,user,password); 
            String sql = "SELECT valor, tipo, numConta, cpfUsuario FROM Extrato WHERE cpfUsuario = ?";
            rs = conexao.prepareStatement(sql);
            rs.setInt(1, login);
            ps = rs.executeQuery();
            while(ps.next()){
                Extrato extrato = new Extrato();
                extrato.setValor(ps.getFloat("valor"));
                extrato.setTipo(ps.getString("tipo"));
                extrato.setNumero(ps.getInt("numConta"));
                extrato.setCpf(ps.getInt("cpfUsuario"));
                extratos.add(extrato);
            }
            rs.close();
            ps.close();
            conexao.close();
        }catch(Exception  ex){
            System.out.println(ex);
        }
        return extratos;
    }
}
