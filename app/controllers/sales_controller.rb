class SalesController < ApplicationController
           
    def new
        @sale= Sale.new
    end
    
    def index
        @sale = Sale.all
    end
    
    def calc
        @sale = Sale.connection.select_all("select t1.ProductID,sum(t1.sum*t2.Rate) 
                                        from(select t1.ProductID,t1.DT,t1.Price*t1.Quantity sum, max(t2.DT) mdt 
                                        from sales t1 
                                        join rates t2 on t1.ProductID=t2.ProductID 
                                        where t1.DT >=t2.DT 
                                        group by t1.ProductID,t1.DT,sum
                                        ) t1 join rates as t2 on t1.ProductID=t2.ProductID 
                                        and t1.mdt=t2.DT group by t1.ProductID")
    end
    
    
    def show
        @sale = Sale.find(params[:id])
    end
    
    def create
        @sale = Sale.new(sale_params)
        @sale.save
        redirect_to sale_path(@sale)
    end
    
    def edit
        @sale = Sale.find(params[:id])
    end
    
    def destroy
        @sale = Sale.find(params[:id])
        @sale.destroy
        flash[:notice] = "Sale was successfully deleted"
        redirect_to sales_path
    end
    
    def update
        @sale = Sale.find(params[:id])
        if @sale.update(sale_params)
            flash[:notice] = "Sale was successfully updated"
            redirect_to sale_path(@sale)
            else
        render 'edit'
    end

end

private

    def sale_params
        params.require(:sale).permit(:DT, :ProductID, :Price, :Quantity)
    end
    
end
