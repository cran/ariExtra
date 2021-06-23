## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,comment = "#>")

## ----stitch_run, message = FALSE, echo = FALSE, eval = TRUE-------------------
library(tuneR)
library(ari)
library(ariExtra)
if (ari::have_ffmpeg_exec()) {
  result = ari_stitch(
    ari_example(c("mab1.png", "mab2.png")),
    list(noise(), noise()))
  print(isTRUE(result))
}

## ----stitch_out, message = FALSE, eval = FALSE--------------------------------
#  if (ari::have_ffmpeg_exec()) {
#    print(attributes(result)$outfile)
#  }

## ----stitch_out_run, message = FALSE, echo = FALSE, eval = TRUE---------------
if (ari::have_ffmpeg_exec()) {
  print(basename(attributes(result)$outfile))
}

## ----stitch_extra, message = FALSE, echo = FALSE, eval = TRUE-----------------
library(tuneR)
library(ari)
library(ariExtra)
result = pngs_to_ari(ari_example(c("mab1.png", "mab2.png")),
                     script = c("hey", "ho"))
result
readLines(result$output_file)

## -----------------------------------------------------------------------------
x = readLines(ari_example("ari_comments.Rmd"))
tail(x[ x != ""], 4)

## ----narr_show, eval = FALSE--------------------------------------------------
#  # Create a video from an R Markdown file with comments and slides
#  result = ariExtra::rmd_to_ari(
#    ari::ari_example("ari_comments.Rmd"),
#    capture_method = "iterative", open = FALSE)

## ----pptx_convert-------------------------------------------------------------
have_libreoffice = function() {
  x = try({docxtractr:::lo_assert()}, silent = TRUE)
  !inherits(x, "try-error")
}
if (have_libreoffice()) {
  pptx = tempfile(fileext = ".pptx")
  download.file(
    paste0("https://s3-eu-west-1.amazonaws.com/", 
           "pfigshare-u-files/16252631/ari.pptx"),
    destfile = pptx)
  result = try({
    pptx_to_ari(pptx, open = FALSE)
  }, silent = TRUE)
  soffice_config_issue = inherits(result, "try-error")
  if (soffice_config_issue) {
    ariExtra:::fix_soffice_library_path()
    result = try({
      pptx_to_ari(pptx, open = FALSE)
    }, silent = TRUE)    
  }
  if (!inherits(result, "try-error")) {
    print(result[c("images", "script")])
  }
}

## ---- message=FALSE-----------------------------------------------------------
gs_doc = ariExtra::gs_to_ari("14gd2DiOCVKRNpFfLrryrGG7D3S8pu9aZ")
gs_doc[c("images", "script")]

