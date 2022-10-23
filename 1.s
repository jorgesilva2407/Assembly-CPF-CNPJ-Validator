.data
vetor: .word 1 2 3 4 5 6 7
.text
main:
la x12, vetor
addi x13, x0, 7
addi x13, x13, -1
slli x13, x13, 2
add x13, x13, x12
jal x1, inverte
beq x0, x0, FIM
##### START MODIFIQUE AQUI START #####
inverte:
blt x12, x13, swap
# caso a condição não seja satisfeita, significa que se chegou ao meio do vetor e já foram inveridos todos os valores
jalr x0, 0(x1)
# caso a condição seja satisfeita, ainda não se chegou ao meio do vetor e ainda existem valores a serem invertidos
swap:
# valores são pegos do vetor e armazenados em registradores
lw x5, 0(x12)
lw x6, 0(x13)
# valores são invertidos
add x5, x5, x6
sub x6, x5, x6
sub x5, x5, x6
# valores são armazenados novamente no vetor
sw x5, 0(x12)
sw x6, 0(x13)
# alocada memória para a pilha
addi sp, sp, -12
# parâmetros da função são salvos na pilha
sw x12, 0(sp)
sw x13, 4(sp)
sw x1, 8(sp)
# ponteiros agora apontam para os dois valores mais internos que os anteriores no vetor
addi x12, x12, 4
addi x13, x13, -4
# chamada recursiva da função para um subvetor mais interno do vetor anterior
jal x1, inverte
# valores da pilha são carregados
lw x12, 0(sp)
lw x13, 4(sp)
lw x1, 8(sp)
# memória da pilha é desalocada
addi sp, sp, 12
# retorna novamente
jalr x0, 0(x1)
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10