class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /bills
  # GET /bills.json
  def index
    # turn user's list of bills:
    # [bill1, bill2, bill3]
    # into this list of bill occurrences (combo of bill and date):
    # [[bill1_date1, bill1_date2, bill1_date3], [bill2_date1, bill2_date2, bill2_date3], [bill3_date1, bill3_date2, bill3_date3]]
    # flattened:
    # [bill1_date1, bill1_date2, bill1_date3, bill2_date1, bill2_date2, bill3_date3, bill3_date1, bill3_date2, bill3_date3]
    @bill_occurrences = current_user.bills.map { |bill|
      # bill = each user's bill
      bill.dates.map { |date|
        # date = an occurrence date for a bill
        bill_occurrence = bill.clone
        bill_occurrence.date = date
        # bill_occurrence = the occurrence of a bill
        bill_occurrence
      }
    }.flatten
    @bills_by_date = @bill_occurrences.group_by(&:date)

    @date = params[:date] ? Date.parse(params[:date]) : Date.today

    #Added search feature below
    @bills = Bill.search(params[:search])

  end

  def list
      @bills = Bill.search(params[:search])
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @date = params[:date]
    @providers = Provider.all
    @edit = false
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
    @edit = true
  end

  # POST /bills
  # POST /bills.json

  def create
    @bill = Bill.new(bill_params)
    #sets new bill equal to the id of the current user signed in.
    @bill.user_id = current_user.id
   
    
    respond_to do |format|
      if @bill.save 
        send_text_message
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_index_path, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:name, :duedate, :category_id, :provider_id, :paid, :every, :interval, :contact_method, :notes)
    end
end
