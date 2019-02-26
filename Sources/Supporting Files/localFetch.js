 (function() {
    var existingFetch = window.fetch;
    window.fetch = function(uri, json) {
        if (uri.toLowerCase().indexOf('local://') !== -1) {
            return localFetchWrapper(uri, json);
        } else {
            return existingFetch(uri, json);
        }
    }

    function localFetchWrapper(uri, json) {
        json.uri = uri;
        var path = uri.replace(/local\:\/\//gi, '').split('/');
        var routeBase = path[0];
        var route = path[1];
        var method = json.method.toLowerCase();
        if (route) {
            eval('return ' + routeBase + '.' + method + capitalize(route) + '(json)');
        } else {
            throw new Error('route not found. Route base: ' + routeBase + ', route: ' + route);
        }
    }
                               
    function capitalize(str) {
        return str.charAt(0).toUpperCase() + str.slice(1);
    }
 })();
