From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Wed, 31 Dec 2008 20:30:46 +0000
Subject: Problem with memcpy - cache alignment
Message-Id: <1230755446.6570.22.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Perhaps someone could give me some pointers to fixing this...

I am working on my VMU (flash memory) driver for the Dreamcast. Using
the caching mtdblock device abstraction in the kernel it seems it is
sometimes possible to get this to work (simply reading off the contents
of the VMU by typing cat /dev/mtdblock0 etc)

But more often than not it blows up on what seems to be a simple memcpy
operation - always at the same instruction in the assembly code itself.
It does this after reading a number of blocks and generally seems to do
it towards the end of the read.

This is the read code from the device driver...

/* Maple bus callback function for reads */
static void vmu_blockread(struct mapleq *mq)
{
	struct maple_device *mdev;
	struct memcard *card;
	struct mtd_info *mtd;
	struct vmu_cache *pcache;
	struct mdev_part *mpart;
	int partition;

	mdev = mq->dev;
	card = maple_get_drvdata(mdev);
	/* copy the read in data */
	memcpy(card->blockread, mq->recvbuf + 12, card->blocklen);
	card->read = 1;
	/* fill the cache for this block */
	mpart = card->mtd->priv;
	partition = mpart->partition;
	pcache = (card->parts[partition]).pcache;
	if (!pcache->buffer) {
		pcache->buffer = kmalloc(card->blocklen, GFP_KERNEL);
		/* If fail because of ENOMEM - wake up to cause failure */
		if (!pcache->buffer)
			goto wakeup;
	}
	memcpy(pcache->buffer, card->blockread, card->blocklen);
	pcache->block = ((unsigned char *)mq->recvbuf)[11];
	pcache->jiffies_atc = jiffies;
	pcache->valid = 1;
wakeup:
	wake_up_interruptible(&card->vmu_read);
}


Which generates this error at random intervals...

/* Maple bus callback function for reads */
static void vmu_blockread(struct mapleq *mq)
{
	struct maple_device *mdev;
	struct memcard *card;
	struct mtd_info *mtd;
	struct vmu_cache *pcache;
	struct mdev_part *mpart;
	int partition;

	mdev = mq->dev;
	card = maple_get_drvdata(mdev);
	/* copy the read in data */
	memcpy(card->blockread, mq->recvbuf + 12, card->blocklen);
	card->read = 1;
	/* fill the cache for this block */
	mpart = card->mtd->priv;
	partition = mpart->partition;
	pcache = (card->parts[partition]).pcache;
	if (!pcache->buffer) {
		pcache->buffer = kmalloc(card->blocklen, GFP_KERNEL);
		/* If fail because of ENOMEM - wake up to cause failure */
		if (!pcache->buffer)
			goto wakeup;
	}
	memcpy(pcache->buffer, card->blockread, card->blocklen);
	pcache->block = ((unsigned char *)mq->recvbuf)[11];
	pcache->jiffies_atc = jiffies;
	pcache->valid = 1;
wakeup:
	wake_up_interruptible(&card->vmu_read);
}

Which generates this (always the same) error at (random) intervals...


[  116.557096] mtdblock: read on "vmu2.1.0" at 0x1be00, size 0x200
[  116.831468] Unable to handle kernel NULL pointer dereference at virtual address 000001e0
[  116.831542] pc = 8c0f0af0
[  116.831570] *pde = 00000000
[  116.831609] Oops: 0001 [#1]
[  116.831637] Modules linked in: evdev
[  116.831679] 
[  116.831707] Pid : 5, Comm:           events/0
[  116.831752] CPU : 0                  Not tainted  (2.6.28-03115-gc1eca7e-dirty #40)
[  116.831790] 
[  116.831834] PC is at memcpy+0x15c/0x28c
[  116.831898] PR is at vmu_blockread+0x2a/0xa4
[  116.831946] PC  : 8c0f0af0 SP  : 8cc23ecc SR  : 40008101 TEA : c0027454
[  116.832011] R0  : 00000000 R1  : 000001e0 R2  : 00000000 R3  : 00000000
[  116.832066] R4  : 00000000 R5  : ac9a0dec R6  : 00000000 R7  : 00000000
[  116.832119] R8  : 00000000 R9  : 00000000 R10 : 00000000 R11 : 00000000
[  116.832174] R12 : 00000001 R13 : 8c29573c R14 : 8cc23edc
[  116.832225] MACH: 00000019 MACL: 00000000 GBR : 00000000 PR  : 8c139df6
[  116.832269] 
[  116.832285] Call trace:
[  116.832334] [<8c0f0994>] memcpy+0x0/0x28c
[  116.832394] [<8c147942>] maple_dma_handler+0x1de/0x318
[  116.832461] [<8c00fb58>] add_preempt_count+0x0/0x64
[  116.832532] [<8c023c98>] run_workqueue+0xb0/0x17c
[  116.832594] [<8c00fb58>] add_preempt_count+0x0/0x64
[  116.832653] [<8c147764>] maple_dma_handler+0x0/0x318
[  116.832717] [<8c023de6>] worker_thread+0x82/0xbc
[  116.832779] [<8c0111a0>] complete+0x0/0x8c
[  116.832846] [<8c026fd4>] kthread_should_stop+0x0/0x20
[  116.832921] [<8c027768>] autoremove_wake_function+0x0/0x30
[  116.832999] [<8c027768>] autoremove_wake_function+0x0/0x30
[  116.833069] [<8c02702e>] kthread+0x3a/0x70
[  116.833126] [<8c023d64>] worker_thread+0x0/0xbc
[  116.833193] [<8c026fd4>] kthread_should_stop+0x0/0x20
[  116.833255] [<8c0038a8>] kernel_thread_helper+0x8/0x14
[  116.833336] [<8c026ff4>] kthread+0x0/0x70
[  116.833412] [<8c0038a0>] kernel_thread_helper+0x0/0x14
[  116.833455] 
[  116.833478] Code:
[  116.833507]   8c0f0aea:  mov.l     @(20,r5), r9
[  116.833607]   8c0f0aec:  mov.l     @(24,r5), r10
[  116.833691]   8c0f0aee:  mov.l     @(28,r5), r11
[  116.833775] ->8c0f0af0:  movca.l   r0, @r1
[  116.833859]   8c0f0af2:  mov.l     r3, @(4,r1)
[  116.833941]   8c0f0af4:  mov.l     r6, @(8,r1)
[  116.834023]   8c0f0af6:  mov.l     r7, @(12,r1)
[  116.834106]   8c0f0af8:  mov.l     r8, @(16,r1)
[  116.834188]   8c0f0afa:  add       #-32, r5
[  116.834250] 
[  116.834285] Process: events/0 (pid: 5, stack limit = 8cc22001)
[  116.834335] Stack: (0x8cc23ecc to 0x8cc24000)
[  116.834371] 3ec0:                            8c0f0994 8ca52860 8c719400 8cd4c260 8c147942 
[  116.834485] 3ee0: 8cc23ef8 8c00fb58 00000008 ac9a0c00 8c719400 8ca52860 8cc23f14 00000000 
[  116.834610] 3f00: 8cd4cc20 8c023c98 8cc23f24 00000000 8c00fb58 8c147764 8c2655b0 8cc02920 
[  116.834736] 3f20: 00000000 8c023de6 8cc23f40 fffffffc 8c0111a0 8c026fd4 8cc02920 8cc02928 
[  116.834862] 3f40: 00000000 8cc1da20 8c027768 8cc23f4c 8cc23f4c 00000000 8cc1da20 8c027768 
[  116.834985] 3f60: 8cc23f4c 8cc23f4c 8c02702e 8cc23f7c 8c023d64 8cc02920 8c026fd4 8c0038a8 
[  116.835115] 3f80: 8cc23f98 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
[  116.835226] 3fa0: 00000000 00000000 00000000 00000000 8cc15ef4 8c026ff4 00000000 00000000 
[  116.835339] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 8cc23fa0 
[  116.835452] 3fe0: 8c0038a0 00000000 40000000 00000000 00000000 00000000 00000000 00000000 
[  116.835679] ---[ end trace 68d2f606da5f3439 ]---

The fragment of assembly seems to relate to this (2:) bit of
memcpy-sh4.S:

	! Copy the cache line aligned blocks
	!
	! In use: r0, r2, r4, r5
	! Scratch: r1, r3, r6, r7
	!
	! We could do this with the four scratch registers, but if src
	! and dest hit the same cache line, this will thrash, so make
	! use of additional registers.
	!
	! We also need r0 as a temporary (for movca), so 'undo' the invariant:
	!   r5:	 src (was r0+r5)
	!   r1:	 dest (was r0)
	! this can be reversed at the end, so we don't need to save any extra
	! state.
	!
1:	mov.l	r8, @-r15	!  30 LS
	add	r0, r5		!  49 EX

	mov.l	r9, @-r15	!  30 LS
	mov	r0, r1		!   5 MT (latency=0)

	mov.l	r10, @-r15	!  30 LS
	add	#-0x1c, r5	!  50 EX

	mov.l	r11, @-r15	!  30 LS

	! 16 cycles, 32 bytes per iteration
2:	mov.l	@(0x00,r5),r0	! 18 LS (latency=2)
	add	#-0x20, r1	! 50 EX
	mov.l	@(0x04,r5),r3	! 18 LS (latency=2)
	mov.l	@(0x08,r5),r6	! 18 LS (latency=2)
	mov.l	@(0x0c,r5),r7	! 18 LS (latency=2)
	mov.l	@(0x10,r5),r8	! 18 LS (latency=2)
	mov.l	@(0x14,r5),r9	! 18 LS (latency=2)
	mov.l	@(0x18,r5),r10	! 18 LS (latency=2)
	mov.l	@(0x1c,r5),r11	! 18 LS (latency=2)
	movca.l	r0,@r1		! 40 LS (latency=3-7)
	mov.l	r3,@(0x04,r1)	! 33 LS
	mov.l	r6,@(0x08,r1)	! 33 LS
	mov.l	r7,@(0x0c,r1)	! 33 LS

	mov.l	r8,@(0x10,r1)	! 33 LS
	add	#-0x20, r5	! 50 EX

	mov.l	r9,@(0x14,r1)	! 33 LS
	cmp/eq	r2,r1		! 54 MT

	mov.l	r10,@(0x18,r1)	!  33 LS
	bf/s	2b		! 109 BR

	 mov.l	r11,@(0x1c,r1)	!  33 LS

	mov	r1, r0		!   5 MT (latency=0)

	mov.l	@r15+, r11	!  15 LS
	sub	r1, r5		!  75 EX

	mov.l	@r15+, r10	!  15 LS
	cmp/eq	r4, r0		!  54 MT

	bf/s	1f		! 109 BR
	 mov.l	 @r15+, r9	!  15 LS

	rts


Using sh-linux-addr2line gives the calling line in the driver as: 	mpart
= card->mtd->priv;


which obviously isn't doing much.

Any clues as to where I should be looking to fix this? 


Otherwise, happy new year to you all.

Adrian

