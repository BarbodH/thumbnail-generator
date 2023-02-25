# Thumbnail Generator

The script (`gather_metadata.sh`) finds all images in a directory and creates helper files that identify the data in those images, such as metadata and thumbnails.

## Description

The script will be called with one optional argument, corresponding to the directory where the search is to take place. If the script is called with no arguments, the current working directory (`./`) is expected to be used instead. The script ensures that the provided argument is indeed a directory and that reading and executing permissions are available for this directory. If the argument is not a directory, the following message would be sent to the standard error (replacing `<DIR>` with the argument value):

```Bash
<DIR> is not a directory.
```

If the argument is a directory but does not have read or execute permissions, the following message should be sent to the standard error (replacing <DIR> with the argument value):

```Bash
<DIR> is not readable or executable.
```

Once it is determined that the argument refers to a valid directory with appropriate permissions, the script will search for all images in the directory and any of its subdirectories, recursively. In particular, it will find all files whose names include one of the following extensions: `jpg`, `jpeg`, `png`, `tif`, `tiff`, `bmp`, and `gif`. Case is ignored in searching for extensions, i.e., upper-case versions of these extensions are included as well (e.g., files like `image.jpg`, `IMAGE.JPG`, or `Image.Jpg` are all included).

For each of these files, the script will perform the following tasks:
- In the same directory that the image is found, `.thumbs` directory is created, if it does not exist.
- Inside the `.thumbs` directory, up to three files are created, corresponding to a conversion of the image files to a lower resolution.
- In the same directory that the image is found, `.metadata` directory is created, if it does not exist.
- Inside the `.metadata` directory, a text file containing a representation of the basic metadata of the file is created.

For the thumbnail files: up to 3 files will be created. The files will contain the original image converted to a new size, with the maximum height and weight of each file corresponding to 128 pixels for the first file, 256 pixels for the second file, and 512 pixels for the third file. The original aspect ratio of the image must be preserved, so for images that are wider than they are tall, the width will correspond to the maximum width above, while the height will have a proportionally smaller value; for images that are taller than they are wide, the height uses the maximum value.

Thumbnail files will be named based on the file's original base name, but adding the corresponding dimension to the name, before the extension. So, for example, for file `dir/subdir/image.jpg`, the files to be created must be named: `dir/subdir/.thumbs/image-128.jpg` (for 128 pixels), `dir/subdir/.thumbs/image-256.jpg` (for 256 pixels), and `dir/subdir/.thumbs/image-512.jpg` (for 512 pixels). A thumbnail file will only be created if the original file has a size larger than what the thumbnail would provide.

Finally, the names of all input image files that were found and processed by the script will be printed on the standard output. If no files are found, no output is expected. The program will not include any files that are directly inside a `.thumbs` directory as input files. This allows the script to run the same program multiple times and obtain a similar result.

## Dependencies

For the image manipulation operations above, the script uses the ImageMagick library, in particular, the `convert` and `identify` commands. Imagemagick can be installed in a local linux environment as follows:

```Bash
apt  install imagemagick # In Debian/Ubuntu-based systems
yum  install ImageMagick # In CentOS-based systems
brew install imagemagick # In Mac OS X
```
