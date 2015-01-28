class LinesController < ApplicationController
  def update
    @line = Line.find params[:id]

    respond_to do |format|
      if @line.update_attributes(line_params)
        format.html { redirect_to(@line.report, :notice => 'sale price was successfully updated.') }
        format.json { respond_with_bip(@line) }
      else
        format.json { respond_with_bip(@line) }
      end
    end
  end

  private
  def line_params
    params.require(:line).permit(:sale_price, :list_price, :original_list_price)
  end
end
