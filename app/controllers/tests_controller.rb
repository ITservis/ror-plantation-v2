class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  permits :title, :subject_id, question_ids: []

  def index
    @tests = Test.all
  end

  def generate_new

  end

  def generate(template_id)

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
