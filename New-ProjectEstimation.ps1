function New-ProjectEstimation {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$true, Position=0, HelpMessage="The Best Case estimate for the project in hours.")]
    [Int32]
    $BestCase,
    [Parameter(Mandatory=$true, Position=1, HelpMessage="The Most Likely estimate for the project in hours.")]
    [Int32]
    $MostLikely,
    [Parameter(Mandatory=$true, Position=2, HelpMessage="The Worst Case estimate for the project in hours.")]
    [Int32]
    $WorstCase,
    [Parameter(Mandatory=$false, Position=3, HelpMessage="Confidence level for the estimate.")]
    [PSDefaultValue(Help="Valid values are 68, 90, 95, and 99.7. Default is 95")]
    [ValidateSet(.68, .90, .95, .997)]
    [Float]
    $ConfidenceLevel = .95
  )

  Begin {
    Write-Verbose "Beginning execution of New-ProjectEstimation"
    Write-Debug "BestCase: $BestCase"
    Write-Debug "MostLikely: $MostLikely"
    Write-Debug "WorstCase: $WorstCase"
    Write-Debug "ConfidenceLevel: $ConfidenceLevel"
    $WeightedAverage = ($BestCase + (4 * $MostLikely) + $WorstCase) / 6
    Write-Debug "WeightedAverage: $WeightedAverage"
    $StandardDeviation = ($WorstCase - $BestCase) / 6
    Write-Debug "StandardDeviation: $StandardDeviation"
  }
  Process {
    Write-Debug "Selecting the formula for the estimate based on the ConfidenceLevel"
    switch ($ConfidenceLevel) {
      .68 {
        $EstimateUp = $WeightedAverage + $StandardDeviation
        $EstimateDown = $WeightedAverage - $StandardDeviation
      }
      .90 {
        $EstimateUp = $WeightedAverage + (1.645 * $StandardDeviation)
        $EstimateDown = $WeightedAverage - (1.645 * $StandardDeviation)
      }
      .95 {
        $EstimateUp = $WeightedAverage + (2 * $StandardDeviation)
        $EstimateDown = $WeightedAverage - (2 * $StandardDeviation)
      }
      .997 {
        $EstimateUp = $WeightedAverage + (3 * $StandardDeviation)
        $EstimateDown = $WeightedAverage - (3 * $StandardDeviation)
      }
      Default {}
    }
    Write-Verbose "Processing the estimate"
    Write-Debug "EstimateUp: $EstimateUp"
    Write-Debug "EstimateDown: $EstimateDown"
  }
  End {
    return  [PSCustomObject]@{
      WeightedAverage = [math]::Floor($WeightedAverage)
      StandardDeviation = [math]::Floor($StandardDeviation)
      Estimate = "Between $([math]::Floor($EstimateDown)) and $([math]::Ceiling($EstimateUp)) hours"
    }
  }
}
