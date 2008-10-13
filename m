From: Cuong Dang Phu <cuongdp@Cybersoft-VN.com>
Date: Mon, 13 Oct 2008 04:18:20 +0000
Subject: Booting kernel problem !
Message-Id: <loom.20081013T035846-303@post.gmane.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi,

I'm having a problem when booting Linux kernel on sh7727, this is what I did:

Kernel start booting with head.s:
[/linux-2.6.22.11/arch/sh/boot/compressed/head.s]
…
	/* Set the initial pointer. */
	mov.l	init_stack_addr, r0
	mov.l	@r0, r15
	/* Decompress the kernel */
	mov.l	decompress_kernel_addr, r0
	jsr	@r0
	nop
…

And jump to “decompress_kernel”:
[/linux-2.6.22.11/arch/sh/boot/compressed/misc.c]
…
void decompress_kernel(void)
{
	output_data = 0;
	output_ptr = P2SEGADDR((unsigned long)&_text+PAGE_SIZE);
	free_mem_ptr = (unsigned long)&_end;
	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;

	makecrc();
	puts("Uncompressing Linux... ");
	gunzip();
	puts("Ok, booting the kernel.\n");
}
…

And it crash when execute “makecrc();”
I don’t why it crash here, could you give me you ideas, 

Best regards


