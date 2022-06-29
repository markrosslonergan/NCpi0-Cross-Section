#pragma once

// Standard library includes
#include <memory>
#include <set>
#include <stdexcept>

// Simple container for the output of Unfolder::unfold()
struct UnfoldedMeasurement {
  UnfoldedMeasurement( TMatrixD* unfolded_signal, TMatrixD* cov_matrix )
    : unfolded_signal_( unfolded_signal ), cov_matrix_( cov_matrix ) {}

  std::unique_ptr< TMatrixD > unfolded_signal_;
  std::unique_ptr< TMatrixD > cov_matrix_;
};

// Abstract base class for objects that implement an algorithm for unfolding
// measured background-subtracted event counts from reco space to
// true space, possibly with regularization.
class Unfolder {

  public:

    Unfolder() {}

    // Function that actually implements a specific unfolding algorithm.
    // If the TMatrix* provided as the last argument is not a nullptr,
    // it will be filled with the elements of the "measurement error
    // propagation matrix," i.e., the matrix which can be used to
    // transform the reco-space covariance matrix into the one describing
    // the unfolded result.
    virtual UnfoldedMeasurement unfold( const TMatrixD& data_signal,
      const TMatrixD& data_covmat, const TMatrixD& smearcept,
      const TMatrixD& prior_true_signal, TMatrixD* err_prop = nullptr )
      const = 0;

  protected:

    // Helper function that does some sanity checks on the dimensions of the
    // input matrices passed to unfold()
    static void check_matrices( const TMatrixD& data_signal,
      const TMatrixD& data_covmat, const TMatrixD& smearcept,
      const TMatrixD& prior_true_signal );
};

void Unfolder::check_matrices( const TMatrixD& data_signal,
  const TMatrixD& data_covmat, const TMatrixD& smearcept,
  const TMatrixD& prior_true_signal )
{
  // Check the matrix dimensions for sanity
  int num_ordinary_reco_bins = smearcept.GetNrows();
  int num_true_signal_bins = smearcept.GetNcols();

  if ( data_signal.GetNcols() != 1 ) {
    throw std::runtime_error( "The background-subtracted data event counts"
      " must be expressed as a column vector" );
  }

  if ( prior_true_signal.GetNcols() != 1 ) {
    throw std::runtime_error( "The prior true signal event counts must be"
      " expressed as a column vector" );
  }

  if ( data_signal.GetNrows() != num_ordinary_reco_bins ) {
    throw std::runtime_error( "Reco bin mismatch between background-"
      "subtracted data and the smearceptance matrix" );
  }

  if ( data_covmat.GetNrows() != num_ordinary_reco_bins
    || data_covmat.GetNcols() != num_ordinary_reco_bins )
  {
    throw std::runtime_error( "Dimension mismatch between data covariance"
      " matrix and the smearceptance matrix" );
  }

  if ( prior_true_signal.GetNrows() != num_true_signal_bins ) {
    throw std::runtime_error( "Dimension mismatch between prior true signal"
      " event counts and the smearceptance matrix" );
  }

}
