const testUrl = "http://console.poliziadistato.localhost:81/fe/api/articles/1087";
let i = 0;

let message;

let timerId;
let id = setTimeout(function f() {
    fetch(testUrl, {
        method: "GET",
        headers: {
            Accept: "application/json",
        }
    }).then(function (response) {
        if (response.status < 499) {
            clearTimeout(timerId);
            console.log("...avviato");
            return true;
        }
        i += 1;
        console.log(`${i} In attesa dell'avvio di MySql...`);
        return response.text();
    }).then(function (t) {
        if (t !== true) {
            message = t;
            id = setTimeout(f, 1000);
        }
    }).catch(function (error) {
        clearTimeout(timerId);
        console.log(error);
        process.exit(1);
    });

}, 1000);

timerId = setTimeout(function () {
    clearTimeout(id);
    console.log(message);
    process.exit(1);
}, 3 * 60 * 1000);