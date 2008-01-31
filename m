From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 31 Jan 2008 23:39:08 +0000
Subject: Re: slab cache allocator problem?
Message-Id: <1201822748.6376.7.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1201645404.6269.7.camel@localhost.localdomain>
In-Reply-To: <1201645404.6269.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Thu, 2008-01-31 at 13:19 +0900, Paul Mundt wrote:
> On Tue, Jan 29, 2008 at 10:23:24PM +0000, Adrian McMenamin wrote:
> > Then allocate objects like this:
> > 
> > 	mq->recvbufdcsp = kmem_cache_zalloc(maple_queue_cache, GFP_KERNEL);
> > 	mq->recvbuf = (void *) P2SEGADDR(mq->recvbufdcsp);
> > 
> [snip]
> 
> > 
> > But when I allocate and free them via hotplugging maple devices, I get
> > things like this (after what appears to be a random number of
> > hotplugs):
> > 
> This sort of abuse of P2SEGADDR is really not what you want to be doing
> in the first place. I'd really like to just get rid of the P1/P2SEGADDR
> wrappers completely, as people do nothing but abuse them, and more often
> than not depend on the wrappers to deal with all of their problems,
> rather than thinking about what they actually want to do.
> 
> If you need to do a cacheflush after the copy, then do so explicitly. You
> can probably even get away with just doing an invalidation in the read
> path and a write-back in the write path, which will be faster than always
> accessing it uncached. Trying to hack around dealing with the cache
> management directly is nasty at best.
> 
> My guess is that ->recvbufdcsp is hitting a cached slab object that still
> has cachelines associated with it which you are hitting after a few
> iterations. The way to fix this is to make the cache management explicit,
> both for ->recvbufdcsp and ->recvbuf. I would also wager that once this
> is done, you should be able to do away with ->recvbufdcsp completely and
> just use ->recvbuf.


I am not sure that this is it - unless I've misunderstood you.

I've put in some really crude cache flushing:

Flushed on every time a packet is added to the write queue...

void maple_add_packet(struct mapleq *mq)
{
	mutex_lock(&maple_list_lock);
	list_add(&mq->list, &maple_waitq);
	mutex_unlock(&maple_list_lock);
	flush_cache_all();
}

Flushed on every read....


/* maple dma end bottom half - implemented via workqueue */
static void maple_dma_handler(struct work_struct *work)
{
	struct mapleq *mq, *nmq;
	struct maple_device *dev;
	char *recvbuf;
	enum maple_code code;

	if (!maple_dma_done())
		return;
	flush_cache_all();
	ctrl_outl(0, MAPLE_ENABLE);
	if (!list_empty(&maple_sentq)) {
		list_for_each_entry_safe(mq, nmq, &maple_sentq, list) {
			recvbuf = mq->recvbuf;
			code = recvbuf[0];
			dev = mq->dev;
			switch (code) {
			case MAPLE_RESPONSE_NONE:

Flushed on every removal...


static void maple_release_device(struct device *dev)
{
	struct maple_device *mdev;
	struct mapleq *mq;
	flush_cache_all();
	if (!dev)
		return;
	mdev = to_maple_dev(dev);
	mq = mdev->mq;
	if (mq) {
		if (mq->recvbufdcsp)
			kmem_cache_free(maple_queue_cache, mq->recvbufdcsp);
		kfree(mq);
		mq = NULL;
	}
	kfree(mdev);
}

Still broken...

[   80.720876] Maple bus device detaching at (0, 2)
[   82.746010] Maple bus at (0, 2): Connected function 0x10
[   82.750588] No maple driver found for this device
[   84.740817] Maple bus device detaching at (0, 2)
[   86.765960] Maple bus at (0, 2): Connected function 0x10
[   86.770655] No maple driver found for this device
[   87.755778] Maple bus device detaching at (0, 2)
[   89.780908] Maple bus at (0, 2): Connected function 0x10
[   89.782706] No maple driver found for this device
[   91.771272] Maple bus device detaching at (0, 2)
[   93.796837] Maple bus at (0, 2): Connected function 0x10
[   93.798743] No maple driver found for this device
[   93.805650] Fault in unaligned fixup: 0000 [#1]
[   93.809477] Modules linked in: nbd
[   93.809477] 
[   93.809477] Pid : 751, Comm:                udevd
[   93.809477] PC is at kmem_cache_alloc+0x46/0xc0
[   93.809477] PC  : 8c0606a6 SP  : 8cd8de84 SR  : 400080f0 TEA : c0007344    Not tainted
[   93.809477] R0  : 00000000 R1  : 00000000 R2  : 8cd8ded8 R3  : 00000000
[   93.809477] R4  : 8c2343b0 R5  : 000080d0 R6  : 00007fff R7  : 8c0a09a8
[   93.809477] R8  : 00000000 R9  : 000080d0 R10 : ffffffff R11 : 8c2343f4
[   93.809477] R12 : 8cf504c0 R13 : 7ba9c5f8 R14 : 8cf92840
[   93.809477] MACH: 00000002 MACL: 00000000 GBR : 29708440 PR  : 8c0a09a8
[   93.809477] 
[   93.809477] Call trace: 
[   93.809477] [<8c0a09a8>] show_stat+0x28/0x380
[   93.809477] [<8c081df8>] single_open+0x38/0xa0
[   93.809477] [<8c0a0980>] show_stat+0x0/0x380
[   93.809477] [<8c0a0d30>] stat_open+0x30/0xa0
[   93.809477] [<8c0a0d00>] stat_open+0x0/0xa0
[   93.809477] [<8c099b90>] proc_reg_open+0x90/0xc0
[   93.809477] [<8c0a0d00>] stat_open+0x0/0xa0
[   93.809477] [<8c099b98>] proc_reg_open+0x98/0xc0
[   93.809477] [<8c062d86>] __dentry_open+0x126/0x240
[   93.809477] [<8c099b00>] proc_reg_open+0x0/0xc0
[   93.809477] [<8c081622>] seq_read+0x102/0x340
[   93.809477] [<8c099794>] proc_reg_read+0x94/0xc0
[   93.809477] [<8c081520>] seq_read+0x0/0x340
[   93.809477] [<8c063cd8>] vfs_read+0x78/0xc0
[   93.809477] [<8c063ef4>] sys_read+0x34/0x80
[   93.809477] [<8c008240>] syscall_call+0xc/0x10
[   93.809477] [<8c063ec0>] sys_read+0x0/0x80
[   93.809477] 
[   93.809477] Process: udevd (pid: 751, stack limit = 8cd8c001)
[   93.809477] Stack: (0x8cd8de84 to 0x8cd8e000)
[   93.809477] de80:          8c0a09a8 00000001 8cf92800 00000001 8cf504c0 8cf92800 8cf92840 
[   93.809477] dea0: 00000000 8c081df8 8c0a0980 8cf92800 fffffff4 8cf19100 8c0a0d30 00000000 
[   93.809477] dec0: 8cf92800 8c0a0d00 8cf92800 8cecd000 8c099b90 8c0a0d00 8c427010 8c099b98 
[   93.809477] dee0: 8c062d86 00000000 00000000 8c099b00 8c42708c 8c081622 8cf92840 7ba9c5f8 
[   93.809477] df00: 00007fff 00000001 8cf92800 00000001 8cf504c0 00000000 00000000 8cf92800 
[   93.809477] df20: 00000000 8cd8df84 00000000 8cf504e0 8c099794 fffffffb 8cd8df84 00007fff 
[   93.809477] df40: 7ba9c5f8 8cf92800 8c081520 8cc039c0 8c063cd8 7ba9c5ec 00000000 0041e8a0 
[   93.809477] df60: fffffff7 8cd8df84 7ba9c5f8 8cf92800 8c063ef4 00007fff 7ba9c5f8 8cf92800 
[   93.809477] df80: 00000000 00000000 00000000 8c008240 ffffff0f 00000021 8cd8dff8 8c063ec0 
[   93.809477] dfa0: 00000000 00000440 fffffff9 00000003 00000007 7ba9c5f8 00007fff 0041cb3c 
[   93.809477] dfc0: 00000007 7ba9c5f8 fffffffb 00000000 0041e8a0 00000000 7ba9c5ec 7ba9c5ec 
[   93.809477] dfe0: 2962d174 00402b22 00000001 29708440 00000002 00000000 0000004c 00000160 
[   93.839430] ---[ end trace 77b901cc5d0edc23 ]---

