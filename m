From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Tue, 29 Jan 2008 22:23:24 +0000
Subject: slab cache allocator problem?
Message-Id: <1201645404.6269.7.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

I suspect this is my code, but I cannot see what is wrong. I am using
SLUB.

I create the cache thus:

	maple_queue_cache 	    kmem_cache_create("maple_queue_cache", 0x400, 0x20,
			      SLAB_HWCACHE_ALIGN, NULL);


Then allocate objects like this:

	mq->recvbufdcsp =3D kmem_cache_zalloc(maple_queue_cache, GFP_KERNEL);
	mq->recvbuf =3D (void *) P2SEGADDR(mq->recvbufdcsp);


And free them like this:

	if (mq) {
		if (mq->recvbufdcsp)
			kmem_cache_free(maple_queue_cache, mq->recvbufdcsp);
		kfree(mq);


But when I allocate and free them via hotplugging maple devices, I get thin=
gs like this (after what appears to be a random number of hotplugs):

[   41.512498] Maple bus device detaching at (0, 2)
[   42.531304] Maple bus at (0, 2): Connected function 0x10
[   42.537436] No maple driver found for this device
[   44.527953] Maple bus device detaching at (0, 2)
[   46.551408] Maple bus at (0, 2): Connected function 0x10
[   46.557561] No maple driver found for this device
[   48.547964] Maple bus device detaching at (0, 1)
[   51.561406] Maple bus device detaching at (0, 2)
[   53.586601] Maple bus at (0, 2): Connected function 0x10
[   53.590137] No maple driver found for this device
[   55.594248] Maple bus device detaching at (0, 2)
[   57.619446] Maple bus at (0, 2): Connected function 0x10
[   57.625583] No maple driver found for this device
[   59.613890] Maple bus device detaching at (0, 2)
[   61.639544] Maple bus at (0, 2): Connected function 0x10
[   61.645684] No maple driver found for this device
[   63.633992] Maple bus device detaching at (0, 2)
[   66.664682] Maple bus at (0, 2): Connected function 0x10
[   66.666407] No maple driver found for this device
[   66.673767] Fault in unaligned fixup: 0000 [#1]
[   66.677050] Modules linked in: nbd
[   66.677050]=20
[   66.677050] Pid : 752, Comm:                udevd
[   66.677050] PC is at kmem_cache_alloc+0x46/0xc0
[   66.677050] PC  : 8c0606a6 SP  : 8c98be84 SR  : 400080f0 TEA : c0007344 =
   Not tainted
[   66.677050] R0  : 00000000 R1  : 00000000 R2  : 8c98bed8 R3  : 00000000
[   66.677050] R4  : 8c2343b0 R5  : 000080d0 R6  : 00007fff R7  : 8c0a09a8
[   66.677050] R8  : 00000000 R9  : 000080d0 R10 : ffffffff R11 : 8c2343f4
[   66.677050] R12 : 8c8860c0 R13 : 7ba3f5f8 R14 : 8c44adc0
[   66.677050] MACH: 00000002 MACL: 00000000 GBR : 29708440 PR  : 8c0a09a8
[   66.677050]=20
[   66.677050] Call trace:=20
[   66.677050] [<8c0a09a8>] show_stat+0x28/0x380
[   66.677050] [<8c081df8>] single_open+0x38/0xa0
[   66.677050] [<8c0a0980>] show_stat+0x0/0x380
[   66.677050] [<8c0a0d30>] stat_open+0x30/0xa0
[   66.677050] [<8c0a0d00>] stat_open+0x0/0xa0
[   66.677050] [<8c099b90>] proc_reg_open+0x90/0xc0
[   66.677050] [<8c0a0d00>] stat_open+0x0/0xa0
[   66.677050] [<8c099b98>] proc_reg_open+0x98/0xc0
[   66.677050] [<8c062d86>] __dentry_open+0x126/0x240
[   66.677050] [<8c099b00>] proc_reg_open+0x0/0xc0
[   66.677050] [<8c081622>] seq_read+0x102/0x340
[   66.677050] [<8c099794>] proc_reg_read+0x94/0xc0
[   66.677050] [<8c081520>] seq_read+0x0/0x340
[   66.677050] [<8c063cd8>] vfs_read+0x78/0xc0
[   66.677050] [<8c063ef4>] sys_read+0x34/0x80
[   66.677050] [<8c008240>] syscall_call+0xc/0x10
[   66.677050] [<8c063ec0>] sys_read+0x0/0x80
[   66.677050]=20
[   66.677050] Process: udevd (pid: 752, stack limit =3D 8c98a001)
[   66.677050] Stack: (0x8c98be84 to 0x8c98c000)
[   66.677050] be80:          8c0a09a8 00000001 8c44ad80 00000001 8c8860c0 =
8c44ad80 8c44adc0=20
[   66.677050] bea0: 00000000 8c081df8 8c0a0980 8c44ad80 fffffff4 8c608180 =
8c0a0d30 00000000=20
[   66.677050] bec0: 8c44ad80 8c0a0d00 8c44ad80 8c522000 8c099b90 8c0a0d00 =
8c957010 8c099b98=20
[   66.677050] bee0: 8c062d86 00000000 00000000 8c099b00 8c95708c 8c081622 =
8c44adc0 7ba3f5f8=20
[   66.677050] bf00: 00007fff 00000001 8c44ad80 00000001 8c8860c0 00000000 =
00000000 8c44ad80=20
[   66.677050] bf20: 00000000 8c98bf84 00000000 8c8860e0 8c099794 fffffffb =
8c98bf84 00007fff=20
[   66.677050] bf40: 7ba3f5f8 8c44ad80 8c081520 8cc039c0 8c063cd8 7ba3f5ec =
00000000 0041e8a0=20
[   66.677050] bf60: fffffff7 8c98bf84 7ba3f5f8 8c44ad80 8c063ef4 00007fff =
7ba3f5f8 8c44ad80=20
[   66.677050] bf80: 00000000 00000000 00000000 8c008240 ffffff0f 00000021 =
8c98bff8 8c063ec0=20
[   66.677050] bfa0: 00000000 00000440 fffffff9 00000003 00000007 7ba3f5f8 =
00007fff 0041cb3c=20
[   66.677050] bfc0: 00000007 7ba3f5f8 fffffffb 00000000 0041e8a0 00000000 =
7ba3f5ec 7ba3f5ec=20
[   66.677050] bfe0: 2962d174 00402b22 00000001 29708440 00000002 00000000 =
0000004c 00000160=20
[   66.703223] ---[ end trace 980183e2f79fb803 ]---

(You can see the maple code here: http://newgolddream.dyndns.info/cgi-bin/g=
itweb.cgi?p=3D.git;a=3Dblob;f=3Ddrivers/sh/maple/maple.c;h=FDf3ecb57043e6e7=
b42d905c5c13a177c42fd569;hb=C7b943a7ae92039458258da34acd233123637693 )

I really cannot see what I am doing wrong - any clues? Could it be some iss=
ue with the P2SEGADDR?

