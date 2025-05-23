#include <asm/asm.h>
#include <mmu.h>

.text
.globl	_start
/* Lab 1 Key Code "enter-kernel" */
_start:
	/* initialize */
	#if !defined(LAB) || LAB >= 3
	la      a0, exc_gen_entry
	csrwr   a0, csr_eentry
	#endif
	#if !defined(LAB) || LAB >= 2
	la      a1, tlb_miss_entry
	li.w    a0, 0x1fffffff
	and     a1, a1, a0
	csrwr   a1, csr_tlbrentry
	#endif

	/* disable interrupts and enable memory map */
	li.w    a0, 0xb0     // PLV = 0, ID = 0, DA = 0, PG = 1, DATF = DATM = 01
	csrwr   a0, csr_crmd

	/* set page size 2^12B=4KB for tlb */
	li.w    a0, 0x0c000000
	csrwr   a0, csr_tlbidx

	/* initialize timer */
	li.w    t0, ESTAT_TI
	csrwr   t0, csr_ectl
/* End of Key Code "enter-kernel" */

	/* hint: you can refer to the memory layout in include/mmu.h */
	/* set up the kernel stack */
	/* Exercise 1.3: Your code here. (1/2) */

	/* clear bss segment for C env. */
	la      t0, .bss
	la      t1, bss_end
bss_loop:
	beq     t0, t1, bss_loop_end
	st.b    zero, t0, 0
	addi.w  t0, t0, 1
	b       bss_loop
bss_loop_end:
	/* jump to la32r_init */
	/* Exercise 1.3: Your code here. (2/2) */

	nop
