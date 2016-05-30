import std.stdio;
import std.algorithm: map;

import vibe.d;
import ddb.postgres;

interface ICompanyController {
  struct Company {
      string id;
      string name;
  }
  
  @path("/")
  Company[] getCompanies();
}

class CompanyController : ICompanyController {
  private PostgresDB db;
  this(PostgresDB db) {
    this.db = db;
  }
  
  Company[] getCompanies() {
    auto conn = this.db.lockConnection();
    auto cmd = new PGCommand(conn, "SELECT id, name from companies LIMIT 100");

    auto result = cmd.executeQuery;
    
    import std.algorithm : map;
    import std.array : array;
    
    try {
      return result
          //.rangify
          .map!(row => Company(row["id"].toString(), row["name"].toString()))
          .array; 
    } finally {
      result.close;
    }
  }
}

shared static this() {
    PostgresDB client = new PostgresDB([
      "host": "172.17.0.4",
      "database": "ecratum",
      "user": "postgres",
      "password": "postgres"
    ]);
    
	  auto router = new URLRouter;
    router.registerRestInterface(new CompanyController(client));

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    
    listenHTTP(settings, router);
}
