% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cache.R, R/pipe.R
\docType{methods}
\name{Cache}
\alias{Cache}
\alias{Cache,ANY-method}
\alias{\%<\%}
\title{Cache method that accommodates environments, S4 methods, Rasters, & nested caching}
\usage{
Cache(FUN, ..., notOlderThan = NULL, objects = NULL,
  outputObjects = NULL, algo = "xxhash64", cacheRepo = NULL,
  length = getOption("reproducible.length", Inf),
  compareRasterFileLength, userTags = c(), digestPathContent,
  omitArgs = NULL, classOptions = list(), debugCache = character(),
  sideEffect = FALSE, makeCopy = FALSE,
  quick = getOption("reproducible.quick", FALSE),
  verbose = getOption("reproducible.verbose", FALSE), cacheId = NULL,
  useCache = getOption("reproducible.useCache", TRUE),
  showSimilar = NULL)

\S4method{Cache}{ANY}(FUN, ..., notOlderThan = NULL, objects = NULL,
  outputObjects = NULL, algo = "xxhash64", cacheRepo = NULL,
  length = getOption("reproducible.length", Inf),
  compareRasterFileLength, userTags = c(), digestPathContent,
  omitArgs = NULL, classOptions = list(), debugCache = character(),
  sideEffect = FALSE, makeCopy = FALSE,
  quick = getOption("reproducible.quick", FALSE),
  verbose = getOption("reproducible.verbose", FALSE), cacheId = NULL,
  useCache = getOption("reproducible.useCache", TRUE),
  showSimilar = NULL)

lhs \%<\% rhs
}
\arguments{
\item{FUN}{Either a function or an unevaluated function call (e.g., using
\code{quote}.}

\item{...}{Arguments of \code{FUN} function .}

\item{notOlderThan}{load an artifact from the database only if it was created after notOlderThan.}

\item{objects}{Character vector of objects to be digested. This is only applicable
if there is a list, environment (or similar) named objects
within it. Only this/these objects will be considered for caching,
i.e., only use a subset of
the list, environment or similar objects.}

\item{outputObjects}{Optional character vector indicating which objects to
return. This is only relevant for list, environment (or similar) objects}

\item{algo}{The algorithms to be used; currently available choices are
    \code{md5}, which is also the default, \code{sha1}, \code{crc32},
    \code{sha256}, \code{sha512}, \code{xxhash32}, \code{xxhash64} and
    \code{murmur32}.}

\item{cacheRepo}{A repository used for storing cached objects.
This is optional if \code{Cache} is used inside a SpaDES module.}

\item{length}{Numeric. If the element passed to Cache is a \code{Path} class
object (from e.g., \code{asPath(filename)}) or it is a \code{Raster} with
file-backing, then this will be
passed to \code{digest::digest}, essentially limiting the number of bytes
to digest (for speed). This will only be used if \code{quick = FALSE}.
Default is \code{getOption("reproducible.length")},
which is set to \code{Inf}.}

\item{compareRasterFileLength}{Being deprecated; use \code{length}.}

\item{userTags}{A character vector with Tags. These Tags will be added to the repository along with the artifact.}

\item{digestPathContent}{Being deprecated. Use \code{quick}.}

\item{omitArgs}{Optional character string of arguments in the FUN to omit from the digest.}

\item{classOptions}{Optional list. This will pass into \code{.robustDigest} for
specific classes. Should be options that the \code{.robustDigest} knows what
to do with.}

\item{debugCache}{Character or Logical. Either \code{"complete"} or \code{"quick"} (uses
partial matching, so "c" or "q" work). \code{TRUE} is
equivalent to \code{"complete"}.
If \code{"complete"}, then the returned object from the Cache
function will have two attributes, \code{debugCache1} and \code{debugCache2},
which are the entire \code{list(...)} and that same object, but after all
\code{.robustDigest} calls, at the moment that it is digested using
\code{fastdigest}, respectively. This \code{attr(mySimOut, "debugCache2")}
can then be compared to a subsequent call and individual items within
the object \code{attr(mySimOut, "debugCache1")} can be compared.
If \code{"quick"}, then it will return the same two objects directly,
without evalutating the \code{FUN(...)}.}

\item{sideEffect}{Logical or path. Determines where the function will look for
new files following function completion. See Details.
\emph{NOTE: this argument is experimental and may change in future releases.}}

\item{makeCopy}{Logical. If \code{sideEffect = TRUE}, and \code{makeCopy = TRUE},
a copy of the downloaded files will be made and stored in the \code{cacheRepo}
to speed up subsequent file recovery in the case where the original copy
of the downloaded files are corrupted or missing. Currently only works when
set to \code{TRUE} during the first run of \code{Cache}. Default is \code{FALSE}.
\emph{NOTE: this argument is experimental and may change in future releases.}}

\item{quick}{Logical. If \code{TRUE},
little or no disk-based information will be assessed, i.e., mostly its
memory content. This is relevant for objects of class \code{character},
\code{Path} and \code{Raster} currently. For class \code{character}, it is ambiguous
whether this represents a character string or a vector of file paths. The function
will assess if it is a path to a file or directory first. If not, it will treat
the object as a character string. If it is known that character strings should
not be treated as paths, then \code{quick = TRUE} will be much faster, with no loss
of information. If it is file or directory, then it will digest the file content,
or \code{basename(object)}. For class \code{Path} objects, the file's metadata
(i.e., filename and file size)
will be hashed instead of the file contents if \code{quick = TRUE}.
If set to \code{FALSE} (default),
the contents of the file(s) are hashed.
If \code{quick = TRUE}, \code{length} is ignored. \code{Raster} objects are treated
as paths, if they are file-backed.}

\item{verbose}{Logical. This will output much more information about the internals of
Caching, which may help diagnose Caching challenges.}

\item{cacheId}{Character string. If passed, this will override the calculated hash
of the inputs, and return the result from this cacheId in the cacheRepo.
Setting this is equivalent to manually saving the output of this function, i.e.,
the object will be on disk, and will be recovered in subsequent
This may help in some particularly finicky situations
where Cache is not correctly detecting unchanged inputs. This will guarantee
the object will be identical each time; this may be useful in operational code.}

\item{useCache}{Logical or \code{"overwrite"}. If \code{FALSE},
then the entire Caching mechanism is bypassed
and the function is evaluated as if it was not being Cached.
Default is \code{getOption("reproducible.useCache")}),
which is \code{FALSE} by default, meaning use the Cache mechanism. This
may be useful to turn all Caching on or off in very complex scripts and
nested functions. If \code{"overwrite"} (which can be set with
\code{options("reproducible.useCache" = "overwrite")}),
then the function invoke the caching mechanism but will purge
any entry that is matched, and it will be replaced with the
results of the current call.}

\item{showSimilar}{A logical or numeric. Useful for debugging.
If \code{TRUE} or \code{1}, then if the Cache
does not find an identical archive in the cacheRepo, it will report (via message)
the next most similar archive, and indicate which argument(s) is/are different.
If a number larger than \code{1}, then it will report the N most similar archived
objects.}

\item{lhs}{A name to assign to.}

\item{rhs}{A function call}
}
\value{
As with \code{\link[archivist]{cache}}, returns the value of the
function call or the cached version (i.e., the result from a previous call
to this same cached function with identical arguments).
}
\description{
Cache method that accommodates environments, S4 methods, Rasters, & nested caching

The special assign operator \code{\%<\%} is equivalent to Cache. See examples at the end.
}
\details{
Caching R objects using \code{\link[archivist]{cache}} has five important limitations:
\enumerate{
  \item the \code{archivist} package detects different environments as different;
  \item it also does not detect S4 methods correctly due to method inheritance;
  \item it does not detect objects that have file-base storage of information
        (specifically \code{\link[raster]{RasterLayer-class}} objects);
  \item the default hashing algorithm is relatively slow.
  \item heavily nested function calls may want Cache arguments to propagate through
}
This version of the \code{Cache} function accommodates those four special,
though quite common, cases by:
\enumerate{
  \item converting any environments into list equivalents;
  \item identifying the dispatched S4 method (including those made through
        inheritance) before hashing so the correct method is being cached;
  \item by hashing the linked file, rather than the Raster object.
        Currently, only file-backed \code{Raster*} objects are digested
        (e.g., not \code{ff} objects, or any other R object where the data
        are on disk instead of in RAM);
  \item using \code{\link[fastdigest]{fastdigest}} internally when the object
        is in RAM, which can be up to ten times faster than
        \code{\link[digest]{digest}}. Note that file-backed objects are still
        hashed using \code{\link[digest]{digest}}.
  \item Cache will save arguments passed by user in a hidden environment. Any
        nested Cache functions will use arguments in this order 1) actual arguments
        passed at each Cache call, 2) any inherited arguments from an outer Cache
        call, 3) the default values of the Cache function. See section on \emph{Nested
        Caching}.
}

If \code{Cache} is called within a SpaDES module, then the cached entry will automatically
get 3 extra \code{userTags}: \code{eventTime}, \code{eventType}, and \code{moduleName}.
These can then be used in \code{clearCache} to selectively remove cached objects
by \code{eventTime}, \code{eventType} or \code{moduleName}.

\code{Cache} will add a tag to the artifact in the database called \code{accessed},
which will assign the time that it was accessed, either read or write.
That way, artifacts can be shown (using \code{showCache}) or removed (using
\code{clearCache}) selectively, based on their access dates, rather than only
by their creation dates. See example in \code{\link{clearCache}}.
\code{Cache} (uppercase C) is used here so that it is not confused with, and does
not mask, the \code{archivist::cache} function.
}
\note{
As indicated above, several objects require pre-treatment before
caching will work as expected. The function \code{.robustDigest} accommodates this.
It is an S4 generic, meaning that developers can produce their own methods for
different classes of objects. Currently, there are methods for several types
of classes. See \code{\link{.robustDigest}}.

See \code{\link{.robustDigest}} for other specifics for other classes.
}
\section{Nested Caching}{

Commonly, Caching is nested, i.e., an outer function is wrapped in a \code{Cache}
function call, and one or more inner functions are also wrapped in a \code{Cache}
function call. A user \emph{can} always specify arguments in every Cache function
call, but this can get tedious and can be prone to errors. The normal way that
\emph{R} handles arguments is it takes the user passed arguments if any, and
default arguments for all those that have no user passed arguments. We have inserted
a middle step. The order or precedence for any given \code{Cache} function call is
1. user arguments, 2. inherited arguments, 3. default arguments. At this time,
the top level \code{Cache} arguments will propagate to all inner functions unless
each individual \code{Cache} call has other arguments specified, i.e., "middle"
nested \code{Cache} function calls don't propagate their arguments to further "inner"
\code{Cache} function calls.  See example.

\code{userTags} is unique of all arguments: its values will be appended to the
inherited \code{userTags}.
}

\section{Caching Speed}{

Caching speed may become a critical aspect of a final product. For example,
if the final product is a shiny app, rerunning the entire project may need
to take less then a few seconds at most. There are 3 arguments that affect
Cache speed: \code{quick}, \code{length}, and
\code{algo}. \code{quick} is passed to \code{.robustDigest}, which currently
only affects \code{Path} and \code{Raster*} class objects. In both cases, \code{quick}
means that little or no disk-based information will be assessed.
}

\section{Filepaths}{

If a function has a path argument, there is some ambiguity about what should be
done. Possibilities include:
\enumerate{
  \item hash the string as is (this will be very system specific, meaning a
        \code{Cache} call will not work if copied between systems or directories);
  \item hash the \code{basename(path)};
  \item hash the contents of the file.
}
If paths are passed in as is (i.e,. character string), the result will not be predictable.
Instead, one should use the wrapper function \code{asPath(path)}, which sets the
class of the string to a \code{Path}, and one should decide whether one wants
to digest the content of the file (using \code{quick = FALSE}),
or just the filename (\code{(quick = TRUE)}). See examples.
}

\section{Stochasticity}{

In general, it is expected that caching will only be used when stochasticity
is not relevant, or if a user has achieved sufficient stochasticity (e.g., via
sufficient number of calls to \code{experiment}) such that no new explorations
of stochastic outcomes are required. It will also be very useful in a
reproducible workflow.
}

\section{\code{sideEffect}}{

If \code{sideEffect} is not \code{FALSE}, then metadata about any files that
added to \code{sideEffect} will be added as an attribute to the cached copy.
Subsequent calls to this function
       will assess for the presence of the new files in the \code{sideEffect} location.
       If the files are identical (\code{quick = FALSE}) or their file size is
       identical (\code{quick = TRUE}), then the cached copy of the function will
       be returned (and no files changed). If there are missing or incorrect files,
       then the function will re-run. This will accommodate the situation where the
       function call is identical, but somehow the side effect files were modified.
       If \code{sideEffect} is logical, then the function will check the
       \code{cacheRepo}; if it is a path, then it will check the path. The function will
       assess whether the files to be downloaded are found locally
       prior to download. If it fails the local test, then it will try to recover from a
       local copy if (\code{makeCopy} had been set to \code{TRUE} the first time
       the function was run. Currently, local recovery will only work if\code{makeCOpy} was
       set to \code{TRUE} the first time \code{Cache}
       was run). Default is \code{FALSE}.
}

\examples{
tmpDir <- file.path(tempdir())

# Basic use
ranNumsA <- Cache(rnorm, 10, 16, cacheRepo = tmpDir)

# All same
ranNumsB <- Cache(rnorm, 10, 16, cacheRepo = tmpDir) # recovers cached copy
ranNumsC <- rnorm(10, 16) \%>\% Cache(cacheRepo = tmpDir) # recovers cached copy
ranNumsD <- Cache(quote(rnorm(n = 10, 16)), cacheRepo = tmpDir) # recovers cached copy
# For more in depth uses, see vignette
\dontrun{
  browseVignettes(package = "reproducible")
}
# Equivalent
a <- Cache(rnorm, 1)
b \%<\% rnorm(1)

}
\seealso{
\code{\link[archivist]{cache}}, \code{\link{.robustDigest}}
}
\author{
Eliot McIntire
}
