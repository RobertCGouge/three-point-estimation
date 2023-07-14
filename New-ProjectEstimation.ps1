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
    [ValidateSet(68, 90, 95, 99.7)]
    [Float]
    $ConfidenceLevel = 95
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
    return  [PSCustomObject]@{
      WeightedAverage = $WeightedAverage
      StandardDeviation = $StandardDeviation
    }
  }
}
