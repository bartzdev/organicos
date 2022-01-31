class PesquisaGeralDAO {
/*
select 
prod.id, prod.nome,
p.id, p.nome, p.telefone, p.latitude, p.longitude,
pv.id, pv.nome, pv.latitude, pv.longitude
from produto prod
join produtor_produto pp on pp.produto_id = prod.id 
join produtor p on pp.produtor_id = p.id
left join  pontovenda pv on pv.id = pp.pontovenda_id
where 
  prod.registro_ativo = 1 and p.registro_ativo = 1 and pp.pausado = 0 and 
  lower(concat(trim(concat(trim(coalesce(prod.nome, '')), trim(coalesce(p.nome, '')), trim(coalesce(pv.nome, '')))))) like '%%'
  order by lower(prod.nome), prod.id, lower(p.nome), p.id, lower(pv.nome), pv.id 
*/

}
