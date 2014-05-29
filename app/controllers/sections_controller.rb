class SectionsController < ApplicationController

  layout "admin"
  before_action :confirmed_logged_in

  def index
    @sections = Section.sorted
    @section_count = Section.count + 1
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:name => "Enter Section Name"})
    @section_count = Section.count + 1
  end

  def create
    # Instantiate a new object using form parameters
    @section = Section.new(section_params)
    # Save the object
    if @section.save
    # If save suceeds, redirect to the index action
    flash[:notice] ="Section created sucessfully."
    redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so user can fix problems
    @section_count = Section.count + 1
    render('new')
    end
  end


  def edit
     @section = Section.find(params[:id])
     @section_count = Section.count      
  end

  def update
    # find an existing object using an id
    @section = Section.find(params[:id])
    # update the object
    if @section.update_attributes(section_params)
    # If update suceeds, redirect to the index action
      flash[:notice] ="Section updated sucessfully."
      redirect_to(:action => 'show', :id => @section.id)
    else
    # If update fails, redisplay the form so that the user can fix the problems
      @section_count = Section.count
      render('edit')
    end
  end


  def delete
     @section = Section.find(params[:id])
  end

  def destroy
     section = Section.find(params[:id]).destroy
     flash[:notice] ="Section '#{section.name}' destroyed sucessfully."
     redirect_to(:action => 'index')
  end

end

private

def section_params
   params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
end