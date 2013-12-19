module Fog
  module Rackspace
    class Monitoring
      class Real

        def get_processes_info(agent_id)
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "agents/#{agent_id}/host_info/processes"
          )
        end
      end

      class Mock
        def get_processes_info(agent_id)

          agent_id = Fog::Rackspace::MockData.uuid
          memory_major_faults = Fog::Mock.random_numbers(1).to_i
          memory_minor_faults = Fog::Mock.random_numbers(3).to_i
          memory_page_faults = memory_major_faults+memory_minor_faults

          if agent_id == -1
            raise Fog::Rackspace::Monitoring::NotFound
          end
          
          response = Excon::Response.new
          response.status = 200
          response.body = {
            "info"  => [
              {
                "pid"             => Fog::Mock.random_numbers(4).to_s,
                "exe_name"        => "/usr/share/nova-agent/0.0.1.38/sbin/nova-agent",
                "exe_cwd"         => "/",
                "exe_root"        => "/",
                "time_total"      => Fog::Mock.random_numbers(3).to_s,
                "time_sys"        => Fog::Mock.random_numbers(2).to_s,
                "time_user"       => Fog::Mock.random_numbers(2).to_s,
                "time_start_time" => Time.now.utc.to_i - 10000,
                "state_name"      => "nova-agent",
                "state_ppid"      => Fog::Mock.random_numbers(3).to_s,
                "state_priority"  => "15",
                "state_threads"   => Fog::Mock.random_numbers(1).to_s,
                "memory_size"     => Fog::Mock.random_numbers(9).to_s,
                "memory_resident" => Fog::Mock.random_numbers(7).to_s,
                "memory_share"    => Fog::Mock.random_numbers(6).to_s,
                "memory_major_faults"    => memory_major_faults.to_s,
                "memory_minor_faults"    => memory_minor_faults.to_s,
                "memory_page_faults"     => memory_page_faults.to_s,
                "cred_user"       => "root",
                "cred_group"      => "root"
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
