defmodule MovieWagerApi.TestHelpers do
  import ExUnit.Assertions

  def assert_jsonapi_relationship(json, relationship_name, id) do
    assert json["data"]["relationships"][relationship_name]["data"]["id"] == Integer.to_string(id)
    json
  end

  def ids_from_response(response) do
    Enum.map response["data"], fn(attributes) ->
      String.to_integer(attributes["id"])
    end
  end

  def json_for(type, attributes) do
    attributes = normalize_json_attributes(attributes)
    %{
      "data" => %{
        "type" =>  Atom.to_string(type) |> String.replace("_", "-"),
        "attributes" => attributes,
      },
      "format" => "json-api"
    }
  end

  def json_for(type, attributes, %{} = relationships) do
    json = json_for(type, attributes)
    put_in json["data"]["relationships"], relationships
  end

  def json_for(type, attributes, id) do
    json = json_for(type, attributes)
    put_in json["data"]["id"], id
  end

  def sign_in(conn, %MovieWagerApi.User{} = user) do
    conn |> Plug.Conn.assign(:user, user)
  end

  defp normalize_json_attributes(attributes) do
    attributes = attributes
      |> Map.delete(:__meta__)
      |> Map.delete(:__struct__)

    Enum.reduce attributes, %{}, fn({key, value}, result) ->
      case normalize_json_attribute(key, value) do
        {key, value} -> Map.put(result, key, value)
        nil -> result
      end
    end
  end

  defp normalize_json_attribute(key, %Ecto.DateTime{} = value) do
    {key, Ecto.DateTime.to_iso8601(value)}
  end

  defp normalize_json_attribute(_key, %Ecto.Association.NotLoaded{} = _value), do: nil

  defp normalize_json_attribute(key, value), do: {key, value}

  def put_relationships(payload, record_1, record_2), do: put_relationships(payload, [record_1, record_2])

  def put_relationships(payload, records) do
    relationships = build_relationships(%{}, records)
    payload |> put_in(["data", "relationships"], relationships)
  end

  defp build_relationships(relationship_map, []), do: relationship_map
  defp build_relationships(relationship_map, [head | tail]) do
    relationship_map
    |> Map.put(get_record_name(head), %{data: %{id: head.id}})
    |> build_relationships(tail)
  end
  defp build_relationships(relationship_map, single_param) do
    build_relationships(relationship_map, [single_param])
  end

  defp get_record_name(record) do
    record.__struct__
    |> Module.split
    |> List.last
    |> Macro.underscore
    |> String.to_existing_atom
  end
end
