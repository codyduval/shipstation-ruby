module ShipStationRuby
  class Collection

    attr_accessor :client, :resource

    def initialize(client, resource)
      @client = client
      @resource = resource
    end

    def find(id)
      @resource.find(@client, id)
    end

    def all
      @resource.all(@client)
    end

    def where(filters={})
      @resource.where(@client, filters)
    end

  end
end
