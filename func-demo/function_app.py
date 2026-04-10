import azure.functions as func
import logging

app = func.FunctionApp()

@app.route(route="testfunc", methods=["GET", "POST"])
def testfunc(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Function triggered")

    try:
        if req.method == "GET":
            name = req.params.get("name", "Guest")
            return func.HttpResponse(f"Hello {name}")

        if req.method == "POST":
            data = req.get_json()
            repo = data.get("repository", {}).get("name", "unknown")
            user = data.get("pusher", {}).get("name", "unknown")

            return func.HttpResponse(f"Push from {user} in {repo}")

    except Exception as e:
        return func.HttpResponse(f"Error: {str(e)}", status_code=500)