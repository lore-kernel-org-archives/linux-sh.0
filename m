From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Mar 2009 06:01:17 +0000
Subject: Re: [PATCH] sh: use P1 instead of P2 for kexec
Message-Id: <20090318060117.GA32000@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090318053452.4078.65405.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090318053452.4078.65405.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 18, 2009 at 02:34:52PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Use P1 instead of P2 to enable cache when
> moving data in the kexec assembly snippet.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Q: Maybe we need to flush data cache before jumping?
> 
We ought to just get rid of it completely. Almost every use of P1 and
P2SEGADDR in the kernel is useless on newer parts and should be killed.

>  arch/sh/kernel/machine_kexec.c   |    2 +-
>  arch/sh/kernel/relocate_kernel.S |    6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> --- 0005/arch/sh/kernel/machine_kexec.c
> +++ work/arch/sh/kernel/machine_kexec.c	2009-03-18 11:44:45.000000000 +0900
> @@ -100,7 +100,7 @@ void machine_kexec(struct kimage *image)
>  #endif
>  	/* now call it */
>  	rnk = (relocate_new_kernel_t) reboot_code_buffer;
> -	(*rnk)(page_list, reboot_code_buffer, P2SEGADDR(image->start));
> +	(*rnk)(page_list, reboot_code_buffer, P1SEGADDR(image->start));
>  }
>  
This should just be plain old image->start.

>  void arch_crash_save_vmcoreinfo(void)
> --- 0005/arch/sh/kernel/relocate_kernel.S
> +++ work/arch/sh/kernel/relocate_kernel.S	2009-03-18 11:45:14.000000000 +0900
> @@ -18,7 +18,7 @@ relocate_new_kernel:
>  	/* r6 = start_address      */
>  
>  	mov.l	10f,r8	  /* PAGE_SIZE */
> -	mov.l	11f,r9    /* P2SEG */
> +	mov.l	11f,r9    /* P1SEG */
>  
>  	/*  stack setting */
>  	add	r8,r5
> @@ -29,7 +29,7 @@ relocate_new_kernel:
>  0:
>  	mov.l	@r4+,r0	  /* cmd = *ind++ */
>  
> -1:	/* addr = (cmd | P2SEG) & 0xfffffff0 */
> +1:	/* addr = (cmd | P1SEG) & 0xfffffff0 */
>  	mov	r0,r2
>  	or	r9,r2
>  	mov	#-16,r1
> @@ -86,7 +86,7 @@ relocate_new_kernel:
>  10:
>  	.long	PAGE_SIZE
>  11:
> -	.long	P2SEG
> +	.long	P1SEG
>  
>  relocate_new_kernel_end:
>  
All of this P1/P2 crap in the assembly code should die. MIPS solves this
in a much cleaner fashion by looping over the page list and patching the
pointer with phys_to_virt() calls to accomplish the same thing:

	/*
	 * The generic kexec code builds a page list with physical
	 * addresses. they are directly accessible through KSEG0 (or
	 * CKSEG0 or XPHYS if on 64bit system), hence the
	 * pys_to_virt() call.
	 */
	for (ptr = &image->head; (entry = *ptr) && !(entry &IND_DONE);
	     ptr = (entry & IND_INDIRECTION) ?
	       phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
		if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
		    *ptr & IND_DESTINATION)
			*ptr = (unsigned long) phys_to_virt(*ptr);
	}

With this in place, all P1 and P2 references should be killable in the
assembly itself.
