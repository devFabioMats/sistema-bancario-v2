package Factory;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException; 

public class ConnectionFactory {
    public Connection getConnection() {
        try {
            return DriverManager.getConnection("jdbc:sqlserver://localhost:1433;databaseName=banco;trustServerCertificate=true",
                    "sa","1234");
        }
        catch(SQLException excecao) {
            throw new RuntimeException(excecao);
        }
    }
}
