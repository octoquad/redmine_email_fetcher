# frozen_string_literal: true

# Class responsible for handling EmailConfigurationsController model controller.
class EmailConfigurationsController < ApplicationController
  unloadable
  layout 'admin'

  # GET /email_configurations
  # GET /email_configurations.json
  def index
    @email_configurations = EmailConfiguration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @email_configurations }
    end
  end

  # GET /email_configurations/1
  # GET /email_configurations/1.json
  def show
    @email_configuration = EmailConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @email_configuration }
    end
  end

  # GET /email_configurations/new
  # GET /email_configurations/new.json
  def new
    @email_configuration = EmailConfiguration.new(configuration_params)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @email_configuration }
    end
  end

  # GET /email_configurations/1/edit
  def edit
    @email_configuration = EmailConfiguration.find(params[:id])
  end

  # POST /email_configurations
  # POST /email_configurations.json
  def create
    @email_configuration = EmailConfiguration.new(configuration_params)

    respond_to do |format|
      if @email_configuration.save
        format.html { redirect_to email_configurations_url, notice: l(:mgs_email_configuration_create_success) }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @email_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /email_configurations/1
  # PUT /email_configurations/1.json
  def update
    @email_configuration = EmailConfiguration.find(params[:id])

    respond_to do |format|
      if @email_configuration.update(configuration_params)
        format.html { redirect_to email_configurations_url, notice: l(:mgs_email_configuration_update_success) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @email_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_configurations/1
  # DELETE /email_configurations/1.json
  def destroy
    @email_configuration = EmailConfiguration.find(params[:id])
    @email_configuration.destroy

    respond_to do |format|
      format.html { redirect_to email_configurations_url, notice: l(:mgs_email_configuration_deleted_success) }
      format.json { head :no_content }
    end
  end

  # GET /email_configurations/1/fetch
  # GET /email_configurations/1/fetch.json
  def fetch
    @email_configuration = EmailConfiguration.find(params[:id])
    success, message = @email_configuration.test_and_fetch_emails

    if success
      respond_to do |format|
        format.html { redirect_to email_configurations_url, notice: message }
        format.json { head :no_content }
      end

    else
      flash[:error] = message
      respond_to do |format|
        format.html { redirect_to email_configurations_url }
        format.json { head :no_content }
      end
    end
  end

  # GET /email_configurations/1/test
  # GET /email_configurations/1/test.json
  def test
    @email_configuration = EmailConfiguration.find(params[:id])
    success, message = @email_configuration.test

    if success
      respond_to do |format|
        format.html { redirect_to email_configurations_url, notice: message }
        format.json { head :no_content }
      end
    else
      flash[:error] = message

      respond_to do |format|
        format.html { redirect_to email_configurations_url }
        format.json { head :no_content }
      end
    end
  end

  private

  def configuration_params
    params.fetch(:email_configuration, {}).permit(
      :allow_override, :apop, :category, :configuration_type, :default_group, :delete_unprocessed, :flg_active,
      :folder, :host, :last_fetch_at, :move_on_failure, :move_on_success, :no_account_notice, :no_permission_check,
      :password, :port, :priority, :project_id, :ssl, :tracker_id, :unknown_user, :username
    )
  end
end
