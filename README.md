# Achtergrondwaarden

To prevent soil pollution in the Netherlands, Dutch national legislation defines 
reference values for many substances, like heavy metals,
organic pollatants, etc. These reference values includes
the so called 'background values', or 'achtergrondwaarden' in Dutch. These
background values are soil concentrations and used to assess the quality
of undisturbed soils. From a policy point of view, soils with concentrations
below the background value are considered clean.

The background values are broadly based on the 95-percentile of measured
soil concentrations from a representative set of soil samples from a
defined area. While nationwide background values exists, local
authorities can determine their own background values, if needed. For
example in the case of specific soils or circumstances.

The choice for the 95-percentile is based on the chance that if one
takes a sample from a clean soil, that only 5%, i.e. 1 in 20 cases,
should fail the test.

Conceptually, the calculation of a 95-percentile, a rank order statistic,
is relatively simple. However the implementation can be cumbersome
considering that datasets ussually have less than 100 samples, 
and do contain outlying and censored values.

The purpose of this package is to provide several methods to estimate
a rank order statistic, often the 95 percentile, but other percentiles
are also possible. Besides this 95-percentile, confidence intervals of
this percentile are also calculated.

## Purpose of this package

This package contains wrapper functions around estimation functions
from the boot and fitdistrplus packages. This package aims at making
it easy to do many estimations for large datasets containing many
susbstances. One can collect the results of the estimations into a
single data.frame, which can be used for further analyses.


# Licence

Copyright (C) 2020 RIVM

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published
by the Free Software Foundation, either version 3 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

