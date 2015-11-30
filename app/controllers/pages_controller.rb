class PagesController < ApplicationController

    
    def show
        @sale = Sale.connection.select_all("select t1.ProductID,sum(t1.sum*t2.Rate) 
                                        from(select t1.ProductID,t1.DT,t1.Price*t1.Quantity sum, max(t2.DT) mdt 
                                        from sales t1 
                                        join rates t2 on t1.ProductID=t2.ProductID 
                                        where t1.DT >=t2.DT 
                                        group by t1.ProductID,t1.DT,sum
                                        ) t1 join rates as t2 on t1.ProductID=t2.ProductID 
                                        and t1.mdt=t2.DT group by t1.ProductID")
    end
    
    def about
    end
end