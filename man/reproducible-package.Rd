% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reproducible-package.R
\docType{package}
\name{reproducible-package}
\alias{reproducible}
\alias{reproducible-package}
\title{The \code{reproducible} package}
\description{
Built on top of \pkg{git2r} and \pkg{archivist}, this package aims at making
high-level, robust, machine and OS independent tools for making deeply
reproducible and reusable content in R. This extends beyond the package
management utilities of \pkg{packrat} and \pkg{checkpoint} by including
tools for caching, and accessing GitHub repositories.
}
\section{Package options}{


\code{reproducible} has the following \code{\link{options}} to configure behaviour:

\itemize{
  \item \code{reproducible.cachePath}: The default path for repositories if not
  passed as an argument. The default is the \code{tempdir()} of the session.

  \item \code{reproducible.useMemoise}: Default is \code{TRUE}. When
  the Cache mechanism determines that it has already run a particular function
  based on the digest (hash) of its input parameters, it will load the object
  from disk (an .rda file indexed in an SQLite database), but it will
  memoise that step. Thus, the third time the function is run with identical
  arguments, it will use the memoised copy (i.e., RAM copy) which can be
  substantially faster. Since memoising is session specific, the memoised
  version won't be retrieved until the second time in a session. \code{clearCache}
  of any sort will cause all memoising to be 'forgotten' (\code{memoise::forget}).

  \item \code{reproducible.quick}: Default is \code{FALSE}. This means that
  all hashing will be run on full objects but only \code{file.size} for any file paths.
  If \code{TRUE}, then full objects and file content will be hashed.
  Because the hash will be different between \code{quick = TRUE} and
  \code{quick = FALSE}, hashing will effectively be independent between the two states.

  \item {reproducible.useragent}: User agent for downloads using this package.
  Default is \code{"http://github.com/PredictiveEcology/reproducible"}.

  \item \code{reproducible:verbose}: Default is \code{FALSE}. This is the
  normal setting. If set to \code{TRUE} then every Cache call will show a summary
  of the objects being cached, their object.size and the time it took to digest
  them and also the time it took to run the call and save the call to the
  cache repository or load the cached copy from the repository.

}
}

\seealso{
Useful links:
\itemize{
  \item \url{http://reproducible.predictiveecology.org}
  \item \url{https://github.com/PredictiveEcology/reproducible}
  \item Report bugs at \url{https://github.com/PredictiveEcology/reproducible/issues}
}

}
\author{
\strong{Maintainer}: Eliot J B McIntire \email{eliot.mcintire@canada.ca} (0000-0002-6914-8316)

Authors:
\itemize{
  \item Alex M Chubaty \email{alex.chubaty@gmail.com} (0000-0001-7146-8135)
}

Other contributors:
\itemize{
  \item Tati Micheletti \email{tati.micheletti@gmail.com} (0000-0003-4838-8342) [contributor]
  \item Ceres Barros \email{cbarros@mail.ubc.ca} (0000-0003-4036-977X) [contributor]
  \item Ian Eddy \email{ian.eddy@canada.com} (0000-0001-7397-2116) [contributor]
  \item Her Majesty the Queen in Right of Canada, as represented by the Minister of Natural Resources Canada [copyright holder]
}

}
