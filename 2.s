.data
vetor: .word 7 0 0 5 3 0 0 5 6 4 3
.text
main:
la x12, vetor
addi x13, x0, 11
jal x1, verificadastro
beq x0,x0,FIM
##### START MODIFIQUE AQUI START #####
verificacpf:
# aloca memória na pilha e salva os parâmetros da função
addi sp, sp, -12
sw x12, 0(sp)
sw x13, 4(sp)
sw x1, 8(sp)
# verifica se o parâmetro que indica a quantidade de digitos está correto
addi x5, x0, 11
bne x5, x13, falso
# inicializa os valores que serão passados como parâmetro da função somatório
addi x13, x0, 10
addi x10, x0, 0
# chama a função somatório
jal x1, somatorio
# calcula a resto da divisão do somatório por 11
addi x5, x0, 11
rem x6, x10, x5
# verifica se o resto é menor que 2
addi x7, x0, 2
blt x5, x7, 1_menor_que_2_cpf
# calcula o primeiro dígito de verificação
sub x5, x5, x6
lw x6, 0(x12)
# verifica se o primeiro dígito de verificação está certo
bne x6, x5, falso
beq x0, x0, segundo_digito_cpf
1_menor_que_2_cpf:
lw x5, 0(x12)
bne x0, x5, falso
# inicia o cálculo do segundo dígito de verificação
segundo_digito_cpf:
# inicializa parâmetros da função somatório
lw x12, 0(sp)
addi x13, x0, 11
addi x10, x0, 0
# chama a função somatório
jal x1, somatorio
# calcula o resto da divisão por 11
addi x5, x0, 11
rem x6, x10, x5
# verifica se o resto é menor que 2
addi x7, x0, 2
blt x5, x7, 2_menor_que_2_cpf
# calcula o primeiro dígito de verificação
sub x5, x5, x6
lw x6, 0(x12)
# verifica se o primeiro dígito de verificação está correto
bne x6, x5, falso
beq x0, x0, fim_cpf
2_menor_que_2_cpf:
lw x5, 0(x12)
bne x0, x5, falso
# encerra a execução da função e retorna verdadeiro
fim_cpf:
lw x12, 0(sp)
lw x13, 4(sp)
lw x1, 8(sp)
addi x10, x0, 1
jalr x0, 0(x1)

verificacnpj:
# aloca memória na pilha e salva os parâmetros da função
addi sp, sp, -12
sw x12, 0(sp)
sw x13, 4(sp)
sw x1, 8(sp)
# verifica se o parâmetro que indica a quantidade de digitos está correto
addi x5, x0, 14
bne x5, x13, falso
# inicializa os valores que serão passados como parâmetro da função somatório
addi x13, x0, 5
addi x10, x0, 0
# acha o somatorio dos 4 primeiros dígitos do cnpj
jal x1, somatorio
# acha o somatorio dos 8 próximos dígitos do cnpj
addi x13, x0, 9
jal x1, somatorio
# calcula a resto da divisão do somatório por 11
addi x5, x0, 11
rem x6, x10, x5
# verifica se o resto é menor que 2
addi x7, x0, 2
blt x5, x7, 1_menor_que_2_cnpj
# calcula o primeiro dígito de verificação
sub x5, x5, x6
lw x6, 0(x12)
# verifica se o primeiro dígito de verificação está certo
bne x6, x5, falso
beq x0, x0, segundo_digito_cnpj
1_menor_que_2_cnpj:
lw x5, 0(x12)
bne x0, x5, falso
segundo_digito_cnpj:
# inicializa parâmetros da função somatório
lw x12, 0(sp)
addi x13, x0, 6
addi x10, x0, 0
# acha o somatorio dos 5 primeiros dígitos do cnpj
jal x1, somatorio
# acha o somatorio dos 8 próximos dígitos do cnpj
addi x13, x0, 9
jal x1, somatorio
# calcula o resto da divisão por 11
addi x5, x0, 11
rem x6, x10, x5
# verifica se o resto é menor que 2
addi x7, x0, 2
blt x5, x7, 2_menor_que_2_cnpj
# calcula o primeiro dígito de verificação
sub x5, x5, x6
lw x6, 0(x12)
# verifica se o primeiro dígito de verificação está correto
bne x6, x5, falso
beq x0, x0, fim_cnpj
2_menor_que_2_cnpj:
lw x5, 0(x12)
bne x0, x5, falso
# encerra a execução da função e retorna verdadeiro
fim_cnpj:
lw x12, 0(sp)
lw x13, 4(sp)
lw x1, 8(sp)
addi x10, x0, 1
jalr x0, 0(x1)

verificadastro:
# Nesta função, como não foi especificado em qual registrador seria passado o parâmetro que indica se a string é um cpf ou cnpj, foi assumido que o registrador x14 foi usado para isso
# escreve a qual posição deve retornar na pilha
addi sp, sp, -4
sw x1, 0(sp)
# verifica se a string recebida é um cpf ou cnpj e chama sua respectiva função de validação
beq x0, x14, cpf
jal x1, verificacnpj
beq x0, x0, terminacad
cpf:
jal x1, verificacpf
# encerra a execução da função
terminacad:
lw x1, 0(sp)
addi sp, sp, 4
jalr x0, 0(x1)

# função que recebe um vetor x12 e um número x13 como parâmetros
somatorio:
addi x6, x0, 2
loop:
lw x5, 0(x12)
mul x7, x5, x13
add x10, x10, x7
addi x13, x13, -1
addi x12, x12, 4
bge x13, x6, loop
jalr x0, 0(x1)

falso:
lw x12, 0(sp)
lw x13, 4(sp)
lw x1, 8(sp)
addi sp, sp, 12
addi x10, x0, 0
jalr x0, 0(x1)
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10