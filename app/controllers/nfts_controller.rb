class NftsController < ApplicationController
  before_action :set_nft, only: %i[ show edit update destroy ]

  # GET /nfts or /nfts.json
  def index
    @nfts = all_nfts
  end

  def contracts
    @nfts = all_nfts_contracts
  end

  # GET /nfts/1 or /nfts/1.json
  def show
  end

  # GET /nfts/new
  def new
    @nft = new_nft_contract
  end

  def transfer_nft
    @nft = nft_transfer
  end

  def mint_nft
    @nft = nft_mint
  end

  # GET /nfts/1/edit
  def edit
  end

  # POST /nfts or /nfts.json
  def create
    @nft = Nft.new(nft_params)

    respond_to do |format|
      if @nft.save
        format.html { redirect_to nft_url(@nft), notice: "Nft was successfully created." }
        format.json { render :show, status: :created, location: @nft }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nfts/1 or /nfts/1.json
  def update
    respond_to do |format|
      if @nft.update(nft_params)
        format.html { redirect_to nft_url(@nft), notice: "Nft was successfully updated." }
        format.json { render :show, status: :ok, location: @nft }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nfts/1 or /nfts/1.json
  def destroy
    @nft.destroy

    respond_to do |format|
      format.html { redirect_to nfts_url, notice: "Nft was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nft
      @nft = Nft.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nft_params
      params.fetch(:nft, {})
    end

    def all_nfts_contracts
      url = URI("https://thentic.p.rapidapi.com/contracts?key=1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN&chain_id=97")
      
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'
      
      response = http.request(request)
      return response.read_body
    end

    def new_nft_contract
      url = URI("https://thentic.p.rapidapi.com/nfts/contract")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'
      request.body = "{\r\n    \"key\": \"1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN\",\r\n    \"chain_id\": 97,\r\n    \"name\": \"Thentic NFT\",\r\n    \"short_name\": \"TNFT\"\r\n}"

      response = http.request(request)
      return response.read_body
    end


    def all_nfts
      url = URI("https://thentic.p.rapidapi.com/nfts?key=1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN&chain_id=97")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'

      response = http.request(request)
      puts response.read_body
    end

    def nft_mint
      url = URI("https://thentic.p.rapidapi.com/nfts/mint")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'
      request.body = "{\r\n    \"key\": \"1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN\",\r\n    \"chain_id\": 97,\r\n    \"contract\": \"0xb38419461a06B689589DE8574a344225E5c74737\",\r\n    \"nft_id\": 1,\r\n    \"nft_data\": \"\",\r\n    \"to\": \"0x4cb253f190e81Fa0fbFE70CDcD67149362Ea74Af\"\r\n}"

      response = http.request(request)
      return response.read_body
    end

    def nft_transfer
      url = URI("https://thentic.p.rapidapi.com/nfts/transfer")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["content-type"] = 'application/json'
      request["X-RapidAPI-Key"] = 'SIGN-UP-FOR-KEY'
      request["X-RapidAPI-Host"] = 'thentic.p.rapidapi.com'
      request.body = "{\r\n    \"key\": \"1DpqFg5huXDpPOodUjUuT3m3DwaMBNtN\",\r\n    \"chain_id\": 97,\r\n    \"contract\": \"0xb38419461a06B689589DE8574a344225E5c74737\",\r\n    \"nft_id\": 1,\r\n    \"from\": \"0xb38419461a06B689589DE8574a344225E5c74737\",\r\n    \"to\": \"0x4cb253f190e81Fa0fbFE70CDcD67149362Ea74Af\"\r\n}"

      response = http.request(request)
      return response.read_body
    end
end
