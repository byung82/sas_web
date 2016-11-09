module Api
  module V1
    module Manager
      class StoresController < Api::ApplicationController

        # skip_before_action :doorkeeper_authorize!, :create_log

        def index
          item = Api::V1::Manager::Store::Request.create(params)

          raise ActiveRecord::RecordInvalid, item if !item.valid?

          response = Api::V1::Manager::Store::Response.search(item)

          render json: response, serializer: Api::V1::Manager::StoresSerializer

        rescue => e
          process_exception(e)
        end

        def show
          item = ::Store.find_by(id:  params[:id])

          render json: {
              item: item
          }
        end

        def create

          ::Store.transaction do

            @item = ::Store.new create_param

            @item.save!
          end

          render json: @item
        rescue => e
          render json: {
              error: @item.errors
          }, status: 422
        end

        private
        def create_param
          params.require(:store).permit(:store_name,
                                        :ceo_name,
                                        :email,
                                        :phone_no,
                                        :zone_code,
                                        :addr1,
                                        :addr2,
                                        :sales_yn,
                                        :business_no
          )
        end
      end
    end
  end
end
