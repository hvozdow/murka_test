class RatesController < ApplicationController
       
    def new
        @rate= Rate.new
    end
    
    def index
        @rate = Rate.all
    end
    
    def fill
        @rate = Sale.find_by_sql("select t1.productID,sum(t1.sum*t2.rate) 
                                    from(select t1.productid,t1.DT,t1.price*t1.quantity sum, max(t2.DT) mdt 
                                        from sales t1 
                                        join rates t2 on t1.productid=t2.productid 
                                        where t1.DT >=t2.DT 
                                        and t1.DT between @ReportStart and @ReportEnd
                                        group by t1.productId,t1.DT,sum
                                        ) t1 join rates as t2 on t1.productID=t2.ProductId 
                                        and t1.mdt=t2.DT group by t1.productID")
    end
    
    def show
        @rate = Rate.find(params[:id])
    end
    
    def create
        @rate = Rate.new(rate_params)
        @rate.save
        redirect_to rate_path(@rate)
    end
    
    def edit
        @rate = Rate.find(params[:id])
    end
    
    def destroy
        @rate = Rate.find(params[:id])
        @rate.destroy
        flash[:notice] = "Rate was successfully deleted"
        redirect_to rates_path
    end
    
    def update
        @rate = Rate.find(params[:id])
        if @rate.update(rate_params)
            flash[:notice] = "Rate was successfully updated"
            redirect_to rate_path(@rate)
            else
        render 'edit'
    end

end

private

    def rate_params
        params.require(:rate).permit(:DT, :ProductID, :Rate)
    end
    
end
