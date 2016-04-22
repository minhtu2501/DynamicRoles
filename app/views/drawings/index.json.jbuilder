json.array!(@drawings) do |drawing|
  json.extract! drawing, :id, :sheet_number, :part_id
  json.url drawing_url(drawing, format: :json)
end
