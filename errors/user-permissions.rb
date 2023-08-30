module Error
    class PermissionErr < StandardError
        def initialize(msg = "User Dont Have Permission to Acess")
            
        end
    end
end