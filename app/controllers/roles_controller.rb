class RolesController < ApplicationController
  before_filter :authenticate_user!
  # before_filter :load_permissions
  load_and_authorize_resource
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all#.keep_if{|i| i.name != "Super Admin"}
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
    @role = Role.find(params[:id])
    @permissions = @role.permissions
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
    @permissions = Permission.all#.keep_if{|i| ["Part"].include? i.subject_class}.compact
    @role_permissions = @role.permissions.collect{|p| p.id}
    # @permissions = Permission.all.keep_if{|i| ["Part"].include? i.subject_class}.compact
    # @role_permissions = @role.permissions.collect{|p| p.id}
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    @role = Role.find(params[:id])
    @role.permissions = []
    @role.set_permissions(params[:permissions]) if params[:permissions]
    if @role.save
      redirect_to roles_path and return
    end
    @permissions = Permission.all.keep_if{|i| ["Part"].include? i.subject_class}.compact
    render 'edit'
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name)
    end

    def is_super_admin?
      redirect_to root_path and return unless current_user.super_admin?
    end
end
