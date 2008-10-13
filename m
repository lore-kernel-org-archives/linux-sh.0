From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Oct 2008 13:13:47 +0000
Subject: Re: Booting kernel problem !
Message-Id: <20081013131347.GE10579@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <loom.20081013T035846-303@post.gmane.org>
In-Reply-To: <loom.20081013T035846-303@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 13, 2008 at 04:18:20AM +0000, Cuong Dang Phu wrote:
> I'm having a problem when booting Linux kernel on sh7727, this is what I did:
> 
> Kernel start booting with head.s:
> [/linux-2.6.22.11/arch/sh/boot/compressed/head.s]
> ???
> 	/* Set the initial pointer. */
> 	mov.l	init_stack_addr, r0
> 	mov.l	@r0, r15
> 	/* Decompress the kernel */
> 	mov.l	decompress_kernel_addr, r0
> 	jsr	@r0
> 	nop
> ???
> 
> And jump to ???decompress_kernel???:
> [/linux-2.6.22.11/arch/sh/boot/compressed/misc.c]
> ???
> void decompress_kernel(void)
> {
> 	output_data = 0;
> 	output_ptr = P2SEGADDR((unsigned long)&_text+PAGE_SIZE);
> 	free_mem_ptr = (unsigned long)&_end;
> 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
> 
> 	makecrc();
> 	puts("Uncompressing Linux... ");
> 	gunzip();
> 	puts("Ok, booting the kernel.\n");
> }
> ???
> 
> And it crash when execute ???makecrc();???
> I don???t why it crash here, could you give me you ideas, 
> 
It sounds like you may have to fix up your BOOT_LINK_OFFSET or some
related settings. makecrc() itself is harmless and only does some simple
computation for preparing a table, so it is likely that your initial
stack pointer is having issues.
