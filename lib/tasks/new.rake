namespace  :new do 
    desc "Registro de transacciones"
    task puts: :environment do 


        identificacion = ENV["identificacion"]
        email =ENV["email"]
        password = ENV["password"]
        require 'aws-sdk-dynamodb'
        Aws.config.update({
            region: 'localhost',
            credentials: Aws::Credentials.new('yyd8cr', '4kjhn'),
        })

        client = Aws::DynamoDB::Client.new(endpoint: 'http://localhost:8000')
        item = {
            'identificacion' => identificacion,
            'sk' => 'metadata2',
            'email' => email,
            'password' => password
        }

        client.put_item({
            table_name: 'amazon',
            item: item
        })

        puts "Registro Exitoso en DynamoDB"
    rescue Aws::DynamoDB::Errors::ServiceError => f 
        puts "La Transaccion No Se Guardo Correctamente"
    end
end
