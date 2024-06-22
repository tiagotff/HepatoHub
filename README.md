# Projeto HepatoHub

### Descrição do Projeto
Esse projeto utiliza dados públicos do Ministério da Saúde sobre medicamentos específicos para o tratamento de doenças hepáticas. A plataforma, atualmente em desenvolvimento, permite que os usuários pesquisem por doenças hepáticas específicas ou por medicamentos, fornecendo informações básicas sobre os medicamentos disponíveis, localização e regras de aquisição, dentre outras informações relevantes.

Além disso, a plataforma também serve como uma referência confiável para a divulgação de artigos e outros conteúdos relevantes na área da saúde hepática.

### Modelagem Conceitual
<p align="center">
  <object data="https://github.com/tiagotff/HepatoHub/blob/main/1_Modelagem_Conceitual_HepatoHub.pdf" type="application/pdf" width="1000px" height="600px">
    <embed src="https://github.com/tiagotff/HepatoHub/blob/main/1_Modelagem_Conceitual_HepatoHub.pdf">
    </embed>
  </object>
</p>


### Normalização e Modelagem Lógica


### Modelagem Física


**Banco de Dados implementado**


**Tabelas**
>
>**Medicamento**: Armazena informações sobre os medicamentos.
>
>**Programa**: Contém dados sobre os programas de saúde relacionados aos medicamentos.
>
>**Programa_Medicamento**: Tabém que representa o relacionamento N:N das tabelas Medicamento e Programa.
>
>**Estoque**: Registra as informações de estoque dos medicamentos.
>
>**Uf**: Armazena dados sobre unidades federativas.
>
>**Municipio**: Armazena dados sobre as cidades.
>
>**Endereco**: Guarda informações sobre endereços.
>
>**Usuario**: Contém dados dos usuários da plataforma.
>
>**Estabelecimento_Farmaceutico**: Armazena informações sobre os estabelecimentos farmacêuticos.
>
>**Auditoria**: A tabela Auditoria registra todas as operações de inserção, atualização e exclusão realizadas nas tabelas principais para garantir a rastreabilidade e segurança dos dados.

**Dicionário de Dados**


<p align="center">
  <object data="https://github.com/seu-usuario/seu-repositorio/raw/main/3_6_Dicionario_de_Dados_HepatoHub_22_06_2024.pdf" type="application/pdf" width="1000px" height="600px">
    <embed src="https://github.com/seu-usuario/seu-repositorio/raw/main/3_6_Dicionario_de_Dados_HepatoHub_22_06_2024.pdf">
      <p>Este navegador não suporta visualização de PDF. Você pode <a href="https://github.com/seu-usuario/seu-repositorio/raw/main/3_6_Dicionario_de_Dados_HepatoHub_22_06_2024.pdf">baixar o PDF</a> diretamente.</p>
    </embed>
  </object>
</p>
