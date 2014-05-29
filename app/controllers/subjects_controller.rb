class SubjectsController < ApplicationController

  layout "admin"
  before_action :confirmed_logged_in

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Enter First Name"})
    @subject_count = Subject.count+ 1
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
    # If save suceeds, redirect to the index action
    flash[:notice] ="Subject created sucessfully."
    redirect_to(:action => 'index')
    else
    # If save fails, redisplay the form so user can fix problems
    @subject_count = Subject.count 
    render('new')
    end
  end


  def edit
     @subject = Subject.find(params[:id])
     @subject_count = Subject.count
  end

  def update
    # find an existing object using an id
    @subject = Subject.find(params[:id])
    # update the object
    if @subject.update_attributes(subject_params)
    # If update suceeds, redirect to the index action
      flash[:notice] ="Subject updated sucessfully."
      redirect_to(:action => 'show', :id => @subject.id)
    else
    # If update fails, redisplay the form so that the user can fix the problems
      @subject_count = Subject.count
      render('edit')
    end
  end


  def delete
     @subject = Subject.find(params[:id])
  end

  def destroy
     subject = Subject.find(params[:id]).destroy
     flash[:notice] ="Subject '#{subject.name}' destroyed sucessfully."
     redirect_to(:action => 'index')
  end

end

private

def subject_params
   params.require(:subject).permit(:name, :position, :visible, :created_at)
end
