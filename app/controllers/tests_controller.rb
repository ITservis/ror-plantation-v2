class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  permits :title, :subject_id, question_ids: []

  def index(subject_id: nil)
    if subject_id.present?
      @subjects = [Subject.includes(:tests => [:questions]).find(subject_id)]
    else
      @subjects = Subject.includes(:tests => [:questions]).all
    end
  end

  def generate_new(subject_id)
    @subject = Subject.by_code(:web).first # TODO make dynamic, move to before_action
    @templates = Template.for_subject(subject_id)
  end

  def generate(template_id)
    if Services::TestGenerator.new(template_id).generate!
      redirect_to tests_path, notice: 'Test was successfully generated.'
    else
      redirect_to tests_path, alert: 'Test generation failed.'
    end
  end

  def show
  end

  def new
    @test = Test.new
  end

  def edit
  end

  def create(test)
    @test = Test.new(test)

    if @test.save
      redirect_to tests_path, notice: 'Test was successfully created.'
    else
      render :new
    end
  end

  def update(test)
    if @test.update(test)
      redirect_to tests_path, notice: 'Test was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_url, notice: 'Test was successfully destroyed.'
  end

private
  def set_test(id)
    @test = Test.find(id)
  end
end
