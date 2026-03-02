class IngredientsController < ApplicationController
  before_action :require_authentication
  before_action :set_ingredient, only: %i[ show edit update destroy ]

  # GET /ingredients or /ingredients.json
  def index
    @ingredients = current_user.ingredients
  end

  # GET /ingredients/1 or /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    # Version 1: @ingredient = Ingredient.new
    # Version 2: @ingredient = current_user.ingredients.build
    # Version 3: @ingredient = current_user&.ingredients&.build || Ingredient.new
    @ingredient = current_user.ingredients.build
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients or /ingredients.json
  def create
    @ingredient = current_user.ingredients.build(ingredient_params)  # Was: Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to @ingredient, notice: "Ingredient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ingredients/1 or /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient, notice: "Ingredient was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1 or /ingredients/1.json
  def destroy
    @ingredient.destroy!

    respond_to do |format|
      format.html { redirect_to ingredients_path, notice: "Ingredient was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = current_user.ingredients.find(params[:id])  # Was: Ingredient.find(params[:id])
    end

    def authenticate_user!
      if current_user.nil?
        redirect_to new_session_path, alert: "You must be signed in to do that."
      end
    end

    # Only allow a list of trusted parameters through.
    def ingredient_params
      params.require(:ingredient).permit(:name, :category, :description, :notes, :photo, tag_ids: [])
    end
end
