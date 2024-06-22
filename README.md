# 1.Projeto HepatoHub

### Descrição do Projeto
Esse projeto utiliza dados públicos do Ministério da Saúde sobre medicamentos específicos para o tratamento de doenças hepáticas. A plataforma, atualmente em desenvolvimento, permite que os usuários pesquisem por doenças hepáticas específicas ou por medicamentos, fornecendo informações básicas sobre os medicamentos disponíveis, localização e regras de aquisição, dentre outras informações relevantes.

Além disso, a plataforma também serve como uma referência confiável para a divulgação de artigos e outros conteúdos relevantes na área da saúde hepática.

# 2.Banco de Dados hepatohub_bd

Um banco de dados bem-estruturado é fundamental para organizar e armazenar informações de forma eficiente, garantindo acesso rápido, confiabilidade e integridade dos dados. Ele proporciona uma base sólida para aplicações e sistemas, facilitando a recuperação precisa de informações, a análise de dados e a geração de relatórios. Além disso, um banco de dados bem projetado ajuda na redução de redundâncias e inconsistências, melhorando a qualidade dos dados e facilitando a manutenção ao longo do tempo. Isso resulta em sistemas mais robustos, escaláveis e menos propensos a erros, promovendo a eficiência operacional e a tomada de decisões baseadas em dados confiáveis. Diante deste contexto, neste trabalho tomamos o cuidado para contemplar todas as exigência para obtermos um Banco de Dados de qualidade.

## Modelagem Conceitual

Na modelagem conceitual de banco de dados, o foco está na representação abstrata das entidades, seus atributos e relacionamentos sem detalhes de implementação. Essa fase permite capturar a estrutura essencial do banco de dados, garantindo uma compreensão clara das entidades envolvidas e como estão inter-relacionadas, o  que é essencial para o projeto de um banco de dados eficiente, bem estruturados e representativo.

<p align="center">
  <img src="https://github.com/tiagotff/HepatoHub/blob/main/Imagens/1_Modelagem_Conceitual_HepatoHub-1.png" alt="Modelagem Conceitual">
</p>


## Normalização e Modelagem Lógica

Uma normalização minimamente recomendada é a 3ª Forma Normal. Vejamos as condições para atendimento da 1ª, 2ª e 3ª Forma Normal:
ª Forma Normal (1FN): É uma condição na qual os dados de uma tabela de banco de dados estão organizados em colunas com tipos de dados definidos, e cada coluna contém apenas valores atômicos (indivisíveis). Isso significa que não deve haver conjuntos repetitivos de valores ou estruturas complexas em uma única coluna.

2ª Forma Normal (2FN): Uma tabela está na 2ª Forma Normal quando atende às exigências da 1ª Forma Normal e, além disso, todos os atributos não chave são totalmente dependentes da chave primária. Isso significa que nenhum atributo deve depender apenas de uma parte da chave primária, mas sim da chave inteira.

3ª Forma Normal (3FN): Uma tabela está na 3ª Forma Normal se estiver na 2ª Forma Normal e todos os atributos não chave são transitivamente dependentes apenas da chave primária. Em outras palavras, não deve haver dependências transitivas não triviais entre os atributos não chave.

Feito isso, avança-se para a Modelagem Lógica.
Modelagem Lógica: Refere-se à representação estruturada e detalhada de um banco de dados, utilizando modelos de dados que especificam como os dados são armazenados e organizados. A modelagem lógica envolve a tradução da modelagem conceitual (como o Modelo Entidade-Relacionamento) em um modelo de dados específico do sistema de gerenciamento de banco de dados (SGBD), como esquemas de tabelas normalizados, tipos de dados, relacionamentos e restrições.

<p align="center">
  <img src="Imagens/2_Normalizacao_e_Modelagem_Logica_versao_final_22_06_2024.png" alt="Normalização e Modelagem Lógica">
</p>


## Modelagem Física

A modelagem física em bancos de dados é o processo de traduzir o modelo lógico de dados em estruturas físicas específicas dentro de um Sistema de Gerenciamento de Banco de Dados (SGBD). Isso inclui a definição de tabelas, índices, chaves primárias e estrangeiras, restrições de integridade, tipos de dados detalhados e otimizações de desempenho. O objetivo da modelagem física é garantir que o banco de dados seja eficiente, seguro e capaz de atender aos requisitos de armazenamento e recuperação de dados da aplicação de forma adequada.
Nesse contexto, um dos diagrmas mais relevantes é o Diagrama EER (Diagrama Entidade-Relacionamento Estendido).

### Importância do Diagrama EER

O Diagrama EER é crucial no desenvolvimento de bancos de dados porque, dentre outros aspectos relevantes:

**Visualização Clara**: Facilita a compreensão das estruturas de dados e das relações complexas entre entidades.
**Projeto Eficiente**: Ajuda os designers a identificar requisitos de dados, estabelecer restrições de integridade e definir as estruturas físicas do banco de dados.
**Comunicação**: Serve como uma ferramenta de comunicação entre os stakeholders, incluindo desenvolvedores, analistas e clientes, para garantir que todos tenham uma compreensão compartilhada do modelo de dados.
**Base para Implementação**: Fornece a base para a criação física do banco de dados usando um Sistema de Gerenciamento de Banco de Dados (SGBD), como MySQL, PostgreSQL ou Oracle.

Em resumo, o Diagrama EER é essencial para a modelagem de dados eficiente e precisa, permitindo aos desenvolvedores criar bancos de dados que atendam às necessidades específicas de uma aplicação ou sistema.

<p align="center">
  <img src="Imagens/3_1_Modelagem_Fisica_EER_HepatoHub-1.png" alt="Modelagem Física">
</p>

## Dicionário de Dados

Um Dicionário de Dados é fundamental na gestão e desenvolvimento de sistemas de informação, pois ele atua como um guia completo e estruturado que define todos os elementos de dados utilizados no contexto de um projeto. A importância reside em sua capacidade de oferecer uma fonte única de verdade sobre a estrutura, definição, significado e relacionamentos dos dados dentro de um sistema. Isso facilita a comunicação entre os membros da equipe técnica e os stakeholders, assegura a consistência e precisão dos dados ao longo do ciclo de vida do sistema, e contribui para a manutenção, evolução e documentação eficazes do sistema de informação.

Para acessar o Dicionário de Dados completo, [clique aqui](Documentos/Dicionario_de_Dados_HepatoHub_22_06_2024.pdf).


## Banco de Dados implementado
A seguir é exibida uma cópia de tela do Banco de Dados implementado utilizando o MySQL WorkBench.

<p align="center">
  <img src="Imagens/3_5_Modelagem_Fisica_Banco_de_Dados_Implementado-1.png" alt="Banco de Dados implementado">
</p>



