module ReserveDocsHelper
  def reserve_docs_collection_for_select
    return @project.reserve_docs.map {|r| [ '№ '+r.number+' Сумма: '+r.sum.to_s, r.id ] }
  end
end
