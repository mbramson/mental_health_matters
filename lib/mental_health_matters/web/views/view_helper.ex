defmodule MentalHealthMatters.ViewHelpers do

  @spec data_as_select(List.t) :: [{binary(), integer()}]
  def data_as_select(data) do
    data
    |> Enum.map(&["#{&1.name}": &1.id])
    |> List.flatten
  end

end
