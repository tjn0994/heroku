class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.paginate(page: params[:page])
      .order_date_desc.per_page(Settings.per_page.category)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "delete_success"
    else
      flash[:warning] = t "delete_fail"
    end
    redirect_to admin_categories_path
  end

  private
    def category_params
      params.require(:category).permit :name
    end

    def load_category
      @category = Category.find_by_id params[:id]
      if @category.nil?
        flash[:warning] = t "id_not_exist"
        redirect_to admin_categories_path
      end
    end
end
