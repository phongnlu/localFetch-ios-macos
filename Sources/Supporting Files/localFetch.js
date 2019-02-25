var existingFetch = window.fetch;
window.fetch = function(uri, json) {
    if (uri.toLowerCase().indexOf('local://') !== -1) {
        return localFetch.load(uri, json);
    } else {
        return existingFetch(uri, json);
    }
}
