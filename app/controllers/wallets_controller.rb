class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[ show edit update destroy ]

  # GET /wallets or /wallets.json
  def index
    @wallets = all_wallets
  end

  # GET /wallets/1 or /wallets/1.json
  def show
  end
  
  # GET /wallets/new
  def new
    @wallet = new_wallet
  end

  # GET /wallets/1/edit
  def edit
  end

  # POST /wallets or /wallets.json
  def create
    @wallet = Wallet.new(wallet_params)

    respond_to do |format|
      if @wallet.save
        format.html { redirect_to wallet_url(@wallet), notice: "Wallet was successfully created." }
        format.json { render :show, status: :created, location: @wallet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wallets/1 or /wallets/1.json
  def update
    respond_to do |format|
      if @wallet.update(wallet_params)
        format.html { redirect_to wallet_url(@wallet), notice: "Wallet was successfully updated." }
        format.json { render :show, status: :ok, location: @wallet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wallet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wallets/1 or /wallets/1.json
  def destroy
    @wallet.destroy

    respond_to do |format|
      format.html { redirect_to wallets_url, notice: "Wallet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.fetch(:wallet, {})
    end

    def all_wallets
      url = URI("https://thentic.p.rapidapi.com/wallets/all?key=1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'

      response = http.request(request)
      return response.read_body
    end

    def new_wallet
      url = URI("https://thentic.p.rapidapi.com/wallets/new")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'
      request.body = "{\r\n    \"key\": \"1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN\"\r\n}"

      response = http.request(request)
      return response.read_body
    end
end
