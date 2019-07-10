describe 'Cadastrar' do 
def login(field_email, field_password)
    @body = {
        session: {
            email: field_email,
            password: field_password
        }
    }.to_json
    @login = Login.post('/sessions', body: @body)
    # puts @login.body
end

    context 'tarefas' do
        before {login('brunobatista66@gmail.com', '123456')}

        it 'com sucesso' do
            @header = {
                'Content-Type': 'application/json',
                Accept: 'application/vnd.tasksmanager.v2',
                Authorization: @login.parsed_response['data']['attributes']['auth-token']
    
            }
           
            @body = {
                task: {
                    title: 'Tarefa teste2',
                    description: 'Descrição da tarefa teste2',
                    deadline: '2019-07-08 21:30:00',
                    done: true
                }
            }.to_json

            @tarefas = Cadastrar.post('/tasks', headers: @header, body: @body)
            # puts @tarefas
            expect(@tarefas.parsed_response['data']['attributes']['title']).to eql 'Tarefa teste2'
        end
    end
end