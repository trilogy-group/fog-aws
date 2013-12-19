module Fog
  module Rackspace
    class Monitoring
      class Real

        def get_memory_info(agent_id)
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "agents/#{agent_id}/host_info/memory"
          )
        end
      end

      class Mock
        def get_memory_info(agent_id)

          agent_id = Fog::Rackspace::MockData.uuid

          if agent_id == -1
            raise Fog::Rackspace::Monitoring::NotFound
          end

          response = Excon::Response.new
          response.status = 200
          response.body = {
            "info"  => [
              {
                "actual_free"     => Fog::Mock.random_numbers(9).to_s,
                "actual_used"     => Fog::Mock.random_numbers(8).to_s,
                "free"            => Fog::Mock.random_numbers(7).to_s,
                "used"            => Fog::Mock.random_numbers(9).to_s,
                "total"           => Fog::Mock.random_numbers(10).to_s,
                "ram"           => Fog::Mock.random_numbers(4).to_s,
                "swap_total"      => Fog::Mock.random_numbers(10).to_s,
                "swap_used"       => Fog::Mock.random_numbers(8).to_s,
                "swap_free"       => Fog::Mock.random_numbers(10).to_s,                
                "swap_page_in"    => Fog::Mock.random_numbers(3).to_s,
                "swap_page_out"   => Fog::Mock.random_numbers(3).to_s,
              }
            ],
            "metadata" => {
              "count"       => 1,
              "limit"       => 100,
              "marker"      => nil,
              "next_marker" => nil,
              "next_href"   => nil
            }
          }
          response.headers = {
            "Date"                  => Time.now.utc.to_s,
            "Content-Type"          => "application/json; charset=UTF-8",
            "X-RateLimit-Limit"     => "50000",
            "X-RateLimit-Remaining" => "49627",
            "X-RateLimit-Window"    => "24 hours",
            "X-RateLimit-Type"      => "global",
            "X-Response-Id"         => "j23jlk234jl2j34j",
            "X-LB"                  => "dfw1-maas-prod-api0",
            "Vary"                  => "Accept-Encoding",
            "Transfer-Encoding"     => "chunked"
          }
          response.remote_ip = Fog::Mock.random_ip({:version => :v4})
          response
        end
      end
    end
  end
end
