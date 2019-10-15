download.init(rpgm.step("main", "gui"));

myButton <- function(){
    # download.go(rpgm.pgmFilePath("giphy.gif"));

    # Test when in output folder
    file.copy(rpgm.pgmFilePath("giphy.gif"), rpgm.outputFile("test.gif"));
    download.go(rpgm.outputFile("test.gif"));
}