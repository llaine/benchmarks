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
        immutable result = conn.execStatement("SELECT id, name from companies LIMIT 10000", ValueFormat.BINARY);
        delete conn;

        Company[] companies;
        companies.length = result.length;

        foreach (i; 0 .. result.length)
            companies[i] = Company(result[i]["id"].as!PGtext, result[i]["name"].as!PGtext);

        return companies;
    }
}

shared static this() {
    client = new shared PostgresClient("host=172.17.0.3 dbname=ecratum user=postgres password=postgres", 8);

    auto router = new URLRouter;
    router.registerRestInterface(new CompanyController);

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.options |= HTTPServerOption.distribute;

    listenHTTP(settings, router);
}
