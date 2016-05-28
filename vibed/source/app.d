import std.stdio;

import vibe.d;
import vibe.db.postgresql;

shared PostgresClient client;


interface ICompanyController {
  struct Company {
      string id;
      string name;
  }
  
  @path("/")
  Company[] getCompanies();
}

class CompanyController : ICompanyController {
  this() {}
  
  Company[] getCompanies() { 
    auto conn = client.lockConnection();
    immutable result = conn.execStatement("SELECT id, name from companies LIMIT 100", ValueFormat.TEXT);
    delete conn;
    
    import std.algorithm : map;
    import std.array : array;

    return result
      .rangify
      .map!(row => Company(row["id"].as!PGtext, row["name"].as!PGtext))
      .array;
  }
}

shared static this() {
    client = new shared PostgresClient("host=172.17.0.3 dbname=ecratum user=postgres password=postgres", 8);
    
	  auto router = new URLRouter;
    router.registerRestInterface(new CompanyController);

    auto settings = new HTTPServerSettings;
    settings.port = 8080;

    listenHTTP(settings, router);
}
