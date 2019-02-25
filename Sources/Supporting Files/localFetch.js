(function())
    var existingFetch = window.fetch;
    window.fetch = function(uri, json) {
        if (uri.toLowerCase().indexOf('local://') !== -1) {
            return localFetchWrapper(uri, json);
        } else {
            return existingFetch(uri, json);
        }
    }

    var localFetchWrapper = function(uri, json) {
        json.uri = uri;
        return localFetch.load(json);
    }
 })();
