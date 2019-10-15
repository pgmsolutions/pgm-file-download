download.init = function(step){
    gui.add(step, "downloaderURL", "text");
    gui.setProperty(step, "downloaderURL", "css", "downloaderURL");
    gui.add(step, "downloaderCode", "label");
    gui.setProperty(step, "downloaderCode", "css", "display: none");
    gui.setValue(step, "downloaderCode", "<img src=\"notfound.gif\" onerror=\"setTimeout(()=>{document.querySelector('.downloaderURL').value = window.location;}, 20);\" />");
}

download.go <- function(filepath){
    if(!exists("downloaderURL")){
        stop("Could not find downloaderURL - did you use download.init()?\n");
        return();
    }

    cat(paste0("downloaderURL is ", downloaderURL, "\n"));
    if(startsWith(downloaderURL, "http")){
        cat(paste0("Trying to download ", filepath, " from ", downloaderURL, "\n"));

        # Extract URL
        sanitizeFilepath <- gsub("\\\\", "/", filepath);
        serverPath <- strsplit(sanitizeFilepath, "data_instances")[[1L]][[2L]];
        serverPathID <- strsplit(serverPath, "/")[[1L]][[3L]];
        serverPathType <- strsplit(serverPath, "/")[[1L]][[2L]];
        serverRoot <- strsplit(downloaderURL, "instance")[[1L]][[1L]];
        serverFile <- strsplit(serverPath, "/")[[1L]][c(-1, -2, -3)];

        if(serverPathType == "programs"){
            final <- paste0(serverRoot, "assets-instances/programs/", serverPathID, "/", serverFile);
        } else {
            final <- paste0(serverRoot, "assets-instances/outputs/", serverPathID, "/", serverFile);
        }

        cat(paste0("sanitizeFilepath is ", sanitizeFilepath, "\n"));
        cat(paste0("serverPath is ", serverPath, "\n"));
        cat(paste0("serverRoot is ", serverRoot, "\n"));
        cat(paste0("program ID is ", serverPathID, "\n"));
        cat(paste0("type is ", serverPathType, "\n"));
        cat(paste0("Final URL is ", final, "\n"));

        gui.setValue("this", "downloaderCode", paste0("<img src=\"notfound.gif\" onerror=\"setTimeout(()=>{window.open('", final, "', '_blank');}, 50);\" />"));
    }
    else {
        cat("Local opening...\n");
        shell.exec(filepath);
    }
}