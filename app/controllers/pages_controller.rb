class PagesController < ApplicationController
  
  layout "admin"
  before_action :confirmed_logged_in
  
  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])

  end

  def new
     @page = Page.new({:name => "Enter New Page"})
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
  end

  def create
    # Instantiate a new object using form parameters
    @page = Page.new(page_params)
    # Save the object
    if @page.save
    # If save suceeds, redirect to the index action
    flash[:notice] ="Page created sucessfully."
    redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so user can fix problems
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
    render('new')
    end
  end

  def edit
      @page = Page.find(params[:id])
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated sucessfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render('edit')
    end   
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page =Page.find(params[:id]).destroy
    flash[:notice] = "Page destroyed sucessfully"
    redirect_to(:action => 'index')
  end
end

def page_params
   params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
end
