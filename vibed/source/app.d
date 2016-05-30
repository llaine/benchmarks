import vibe.core.core;
import vibe.http.server;
import vibe.http.router;
import ddb.postgres;
import asdf : serializeToJson, jsonSerializer, serializeValue;

import std.algorithm : map;
import std.array : array;
import vibe.core.connectionpool;

ConnectionPool!PGConnection dbPool;


struct Company
{
    int id;
    string name;
}

void bench(scope HTTPServerRequest req, scope HTTPServerResponse res)
{
    auto conn = dbPool.lockConnection();
    auto cmd = new PGCommand(conn, "SELECT id, name from companies LIMIT 10");

    auto result = cmd.executeQuery!(Company)();
    Company[] companies = result.map!(a => cast(Company) a).array;

    //more complex but faster
    auto ser = jsonSerializer(a => res.writeBody(cast(string) a));
    ser.serializeValue(companies);
    ser.flush;

    //easier version
    //res.writeBody(companies.serializeToJson() ); 
    result.close();
}

shared static this()
{

    dbPool = new ConnectionPool!PGConnection({
        return new PGConnection(["host" : "127.0.0.1", "database" : "ecratum",
            "user" : "postgresql", "password" : ""]);
    });

    auto router = new URLRouter;

    router.get("/", &bench);
    auto settings = new HTTPServerSettings;
    settings.port = 8080;

    listenHTTP(settings, router);
}
