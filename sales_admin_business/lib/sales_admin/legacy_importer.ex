defmodule SalesAdmin.LegacyImporter do
  @moduledoc """
  This module imports the legacy spreadsheet where sales were managed before this system was created. It should be used to import all of the ad-hoc spreadsheets that exist in the company.

  This module shouldn't be used after the initial import process is done.

  It remains as documentation of the process that was made when we moved into the new system.
  """

  alias NimbleCSV.RFC4180, as: CSV

  @doc """
  It reads a csv file

  Returns  [Hash], parsed data 

  ## Params
    - path, String, path to file

  """
  def parse_csv(path) do
    case File.read(path) do
      {:ok, content} -> 
        content
        |> CSV.parse_string(skip_headers: false)
      {:error, reason} -> 
        #{:error, reason} 
        nil
      _ -> 
        raise("LegacyImporter: serious error  while parsing csv data")
    end

    @doc """
    Finds or creates a customer

    Returns %SalesAdmin.Customer{}

    ## Params
      - row, List, list with parsed legacy csv format
    """
    def get_customer(row) do
      data = Enum.at(row, 0) |> String.split " "
    


    end
  end
  
end
