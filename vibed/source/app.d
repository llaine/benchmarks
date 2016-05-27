import vibe.d;
import dpq.connection;
import dpq.value;
import dpq.attributes;
import dpq.query;
import dpq.result;

interface ICompanyController {
  struct Company {
      int id;
      string name;
  }
  
  @path("/companies")
  Company[] getCompanies();
}

class CompanyController : ICompanyController {
  private Company[] companies;
  private Connection database;

  this(Connection database) {
    this.database = database;
  }
  
   Company[] getCompanies() {
    Query q = Query(database, "SELECT id, name from companies LIMIT 10000");
    Result r = q.run();
    
    foreach (row; r) {
      Company company = Company(row["id"].as!int, row["name"].as!string);
      companies ~= company;
    }

    return companies;
  }
}

shared static this()
{
    Connection database = Connection("host=172.17.0.3 dbname=ecratum user=postgres password=postgres");
    
	  auto router = new URLRouter;
    router.registerRestInterface(new CompanyController(database));

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    listenHTTP(settings, router);
}
