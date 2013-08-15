# encoding: utf-8

puts "adding states"

state_list = [["Acre", "AC"], ["Alagoas", "AL"], ["Amapá", "AP"], ["Amazonas", "AM"], ["Bahia", "BA"], ["Ceará", "CE"], ["Distrito Federal", "DF"], ["Espírito Santo", "ES"], ["Goiás", "GO"], ["Maranhão", "MA"], ["Mato Grosso", "MT"], ["Mato Grosso do Sul", "MS"], ["Minas Gerais", "MG"], ["Pará", "PA"], ["Paraíba", "PB"], ["Paraná", "PR"], ["Pernambuco", "PE"], ["Piauí", "PI"], ["Rio de Janeiro", "RJ"], ["Rio Grande do Norte", "RN"], ["Rio Grande do Sul", "RS"], ["Rondônia", "RO"], ["Roraima", "RR"], ["Santa Catarina", "SC"], ["São Paulo", "SP"], ["Sergipe", "SE"], ["Tocantins", "TO"]]

state_list.each do |st|
  state = State.find_or_initialize_by_name st[0]
  state.update_attribute(:acronym, st[1])
end
