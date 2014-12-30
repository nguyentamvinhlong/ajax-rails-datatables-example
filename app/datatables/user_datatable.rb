class UserDatatable < AjaxDatatablesRails::Base
  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    # @sortable_columns ||= []
    @sortable_columns ||= ['users.name' ,'users.phone', 'users.address']
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    # @searchable_columns ||= []
    @searchable_columns ||= ['users.name' ,'users.phone', 'users.address']
  end

  private

  def data
    # records = User.all
    records.map do |record|
      [
        # comma separated list of the values for each cell of a table row
        # example: record.attribute,
        record.name,
        record.phone,
        record.address
      ]
    end
  end

  def get_raw_records
    # insert query here
    # start = params[:start].present? ? params[:start] : 0
    # length = params[:length].present? ? params[:length] : 1
    # keyword = params[:search][:value].present? && !params[:search][:value].nil? ? params[:search][:value] : ''
    # User.where("name LIKE '%#{keyword}%' OR phone LIKE '%#{keyword}%' OR address LIKE '%#{keyword}%'").offset(start).limit(length)
    User.all
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
