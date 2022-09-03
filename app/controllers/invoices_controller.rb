class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = all_invoices
  end

  # GET /invoices/1 or /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = new_invoice
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices or /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_url(@invoice), notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.fetch(:invoice, {})
    end

    def new_invoice
      url = URI("https://thentic.p.rapidapi.com/invoices/new")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'
      request.body = "{\r\n    \"key\": \"1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN\",\r\n    \"chain_id\": 97,\r\n    \"amount\": 0.2,\r\n    \"to\": \"<0x...>\"\r\n}"

      response = http.request(request)
      return response.read_body
    end

    def all_invoices
      url = URI("https://thentic.p.rapidapi.com/invoices/all?key='1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN'&chain_id=97")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'

      response = http.request(request)
      return response.read_body
    end
end
