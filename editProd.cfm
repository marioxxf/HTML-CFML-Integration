<cprocessingdirective pageencoding = "utf-8"/>

<cfif isDefined('form.hdnSalvar') and '#form.hdnSalvar#' eq 1>
    <cfquery datasource="#dataBase#">
        update prodMario
        set     descricao       = '#form.descricao#',
                datavalidade   = '#form.datavalidade#',
                preco           = '#form.preco#',
                qtd             = '#form.qtd#',
                fornecedor      = '#form.fornecedor#'
                where        id_prod = '#url.id_prod#'
    </cfquery>
    <script>
        alert('Editado com sucesso!');
    </script>
</cfif>

<cfif isDefined('form.hdnDel') and '#form.hdnDel#' eq 1>
    <cfquery datasource="#dataBase#">
        delete from prodMario
        where id_prod = '#url.id_prod#'
    </cfquery>

    <script>
        alert('Excluído com sucesso!');
        window.location.href = 'adressHere/cadProd.cfm';
    </script>
</cfif>

<cfquery name="consultaProdutos" datasource="#dataBase#">
    select * from prodMario
    where id_prod = '#url.id_prod#'   
</cfquery>

<html lang="en">
    <head>
        <style type="text/css">
        </style>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edição de Produtos</title>

        <!-- Imports -->
        <!-- Utilizando dados de fonte externa - JQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

        <!-- Utilizando dados de fonte externa - Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

        <!-- Imports do Tela Consulta -->
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://cdn.datatables.net/1.11.3/css/dataTables.bootstrap5.min.css"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.3/js/dataTables.bootstrap5.min.js"></script>
    </head>

    <body>
        <div class="container" style="margin-top: 1%" align="center">
            <div class="col-6">
                <h1>Edição de produtos</h1>

                <form id="formulario" name="formulario" action="" method="POST">
                    <div class="form-group">
                        <label>Descrição do produto</label>
                        <input type="hidden" name="hdnSalvar" id="hdnSalvar" value="0"/>
                        <input type="hidden" name="hdnDel" id="hdnDel" value="0"/>
                        <input class="form-control" type="text" name="descricao" id="descricao" placeholder="Insira a descrição do produto..." value="<cfoutput>#consultaProdutos.descricao#</cfoutput>"> <br>
                    </div>

                    <div class="form-group">
                        <label>Preço</label>
                        <input class="form-control" type="text" name="preco" id="preco" placeholder="Insira o valor do produto..." value="<cfoutput>#consultaProdutos.preco#</cfoutput>"> <br>
                    </div>

                    <div class="form-group">
                        <label>Data de validade</label>
                        <input class="form-control" type="text" name="datavalidade" id="datavalidade" placeholder="Digite a data de validade do produto..." value="<cfoutput>#consultaProdutos.datavalidade#</cfoutput>">  <br>
                    </div>

                    <div class="form-group">
                        <label>Fabricante</label>
                        <input class="form-control" type="text" name="fornecedor" id="fornecedor" placeholder="Digite o nome do fabricante..." onkeypress="alert('Testando...')" value="<cfoutput>#consultaProdutos.fornecedor#</cfoutput>">  <br>
                    </div>

                    <div class="form-group">
                        <label>Quantidade disponível</label>
                        <input class="form-control" type="text" name="qtd" id="qtd" placeholder="Insira a quantidade disponível em estoque..." value="<cfoutput>#consultaProdutos.qtd#</cfoutput>"> <br>
                    </div>

                    <div class="form-group text-center">
                        <button name="botaoeditar" id="botaoeditar" type="submit" class="btn btn-primary" onclick="editarCadastro()">Editar produto</button>
                        <button name="botaoexcluir" id="botaoexcluir" type="submit" class="btn btn-primary" onclick="excluirCadastro()">Excluir produto</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- Fim do formulário para cadastro -->

        <!-- Início da tabela para consulta de produtos registrados -->
        <div class="container" style="margin-top:1%" align="center">
            <h1 id="titulo">Consulta de produtos cadastrados</h1>
            <table id="tabela" class="table table-striped" style="width:100%">
                <thead>
                    <tr>
                        <th>Descrição do produto</th>
                        <th>Preço</th>
                        <th>Data de validade</th>
                        <th>Quantidade disponível</th>
                        <th>Fabricante</th>
                    </tr>
                </thead>
                <tbody>
                    <cfloop query="consultaProdutos">
                        <tr onclick="getCliente(<cfoutput>#consultaProdutos.id_prod#</cfoutput>)">
                            <th><cfoutput>#consultaProdutos.descricao#</cfoutput></th>
                            <th><cfoutput>#consultaProdutos.preco#</cfoutput></th>
                            <th><cfoutput>#consultaProdutos.datavalidade#</cfoutput></th>
                            <th><cfoutput>#consultaProdutos.qtd#</cfoutput></th>
                            <th><cfoutput>#consultaProdutos.fornecedor#</cfoutput></th>
                        </tr>
                    </cfloop>
                </tbody>
            </table>
        </div>
        <!-- Fim da tabela para consulta de produtos registrados -->
    </body>
</html>

<script>
    function editarCadastro(){
        document.getElementById('hdnSalvar').value = '1';
        document.getElementById('formulario').submit();
    }
</script>

<script>
    function validarEdicao(){
        var descricao = document.getElementById("descricao");
        var preco = document.getElementById("preco");
        var datavalidade = document.getElementById("datavalidade");
        var fabricante = document.getElementById("fabricante");
        var qtd = document.getElementById("qtd");

        if(descricao.value != "" && preco.value != "" && datavalidade.value != "" && fabricante.value != "" && qtd.value != ""){
            editarCadastro();
        }

        if(descricao.value == "" || preco.value == "" || datavalidade == "" || fabricante == "" || qtd == ""){
                alert("Preencha todas as informações para conseguir editar o produto.");
                return;
           }
        }
</script>

<!-- Método responsável por realizar a leitura do Data Table que consulta os clientes no banco de dados -->
<script>
    $(document).ready(function() {
        $('#tabela').DataTable();
    } );
</script>

<script>
    function excluirCadastro(){
        document.getElementById('hdnDel').value = '1';
        document.getElementById('formulario').submit();
    }
</script>

<!-- Importação de biblioteca JQuery para utilização de máscaras -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>


        