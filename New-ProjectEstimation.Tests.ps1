BeforeAll {
  . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'New-ProjectEstimation' {
  It 'Returns output' {
    New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 | Should -Not -BeNullOrEmpty
  }
  It 'Returns an object' {
    New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 | Should -BeOfType [PSCustomObject]
  }
  It 'Returns the correct WeightedAverage at Default ConfidenceLevel' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 | Select-Object -Property WeightedAverage
    $value.WeightedAverage | Should -Be 51.00
  }
  It 'Returns the correct StandardDeviation at Default ConfidenceLevel' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 | Select-Object -Property StandardDeviation
    $value.StandardDeviation | Should -Be 15.00
  }
  It 'Returns the correct Estimate at Default ConfidenceLevel' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 | Select-Object -Property Estimate
    $value.Estimate | Should -Be 'Between 21 and 82 hours'
  }
  It 'Returns the correct WeightedAverage at 68% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .68 | Select-Object -Property WeightedAverage
    $value.WeightedAverage | Should -Be 51.00
  }
  It 'Returns the correct StandardDeviation at 68% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .68 | Select-Object -Property StandardDeviation
    $value.StandardDeviation | Should -Be 15.00
  }
  It 'Returns the correct Estimate at 68% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .68 | Select-Object -Property Estimate
    $value.Estimate | Should -Be 'Between 36 and 67 hours'
  }
  It 'Returns the correct WeightedAverage at 90% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .90 | Select-Object -Property WeightedAverage
    $value.WeightedAverage | Should -Be 51.00
  }
  It 'Returns the correct StandardDeviation at 90% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .90 | Select-Object -Property StandardDeviation
    $value.StandardDeviation | Should -Be 15.00
  }
  It 'Returns the correct Estimate at 90% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .90 | Select-Object -Property Estimate
    $value.Estimate | Should -Be 'Between 26 and 77 hours'
  }
  It 'Returns the correct WeightedAverage at 99.7% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .997 | Select-Object -Property WeightedAverage
    $value.WeightedAverage | Should -Be 51.00
  }
  It 'Returns the correct StandardDeviation at 99.7% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .997 | Select-Object -Property StandardDeviation
    $value.StandardDeviation | Should -Be 15.00
  }
  It 'Returns the correct Estimate at 99.7% Confidence' {
    $value = New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 -ConfidenceLevel .997 | Select-Object -Property Estimate
    $value.Estimate | Should -Be 'Between 6 and 97 hours'
  }
}
