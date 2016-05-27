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
  private Company[] companies;

  this() {}
  
   Company[] getCompanies() { 
    auto conn = client.lockConnection();
    immutable result = conn.execStatement("SELECT id, name from companies LIMIT 10000", ValueFormat.TEXT);
    delete conn;
    
    for (auto i = 0; i < result.length; ++i) {
      companies ~= Company(result[i]["id"].as!PGtext, result[i]["name"].as!PGtext);
    }
          
    return companies;    
  }
}

shared static this() {
    client = new shared PostgresClient("host=172.17.0.3 dbname=ecratum user=postgres password=postgres", 4);
    
	  auto router = new URLRouter;
    router.registerRestInterface(new CompanyController);

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    listenHTTP(settings, router);
}
