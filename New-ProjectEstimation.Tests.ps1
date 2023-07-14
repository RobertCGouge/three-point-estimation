BeforeAll {
  . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe 'New-ProjectEstimation' {
  It 'Returns output' {
    New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 | Should -Not -BeNullOrEmpty
  }
  It 'Returns a string' {
    New-ProjectEstimation -BestCase 10 -MostLikely 50 -WorstCase 100 | Should -BeOfType [PSCustomObject]
  }
}
