From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 28 Jul 2015 07:56:50 +0000
Subject: Re: [PATCH/RFC v2 00/29] serial: sh-sci: Miscellaneous and DMA Improvements
Message-Id: <55B735C2.2030905@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437070920-28069-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1437070920-28069-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert-san,

Thank you for the patches!

(2015/07/17 3:21), Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains various updates for the Renesas
> (H)SCI(F{,A,B}) driver, incl. DMA support for SCIF on R-Car Gen2.
> Some of these patches have been sent before. (Few) Changes are indicated
> in the individual patches.
> 
> This is definitely not a final series, that's why it's marked as RFC and
> sent to a limited audience:
>   - There are still some race conditions between e.g. RX DMA
>     completion(s) and the worker function,
>   - Under high load RX DMA breaks,
>   - The patch to add DT DMA support should be last, after all DMA fixes,
>     to avoid regressions,
>   - Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA
>     engine driver does not support resubmitting a DMA descriptor, so I
>     added a workaround to the sh-sci driver,
>   - This won't work with the old shdmac DMA engine driver anymore, due
>     to the lack of residue handling in shdmac (preliminary untested
>     patch sent, but it will need more work),
>   - There are issues with residual handling in general,
>   - ...
> 
> However, DMA is now usable for the serial console on r8a7791/koelsch.
> This also received light testing with scif3 and scifa5 on r8a7791/koelsch.
> 
> For your convenience, I've also pushed this to
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git#scif-dma-v2
> 
> Thanks for your comments!

I tested this scif-dma-v2 branch using r8a7790/lager.
If I enabled CONFIG_HIGHMEM, a WARNING and kernel panic happened.
(I copyed the log at end of this email.)

I investigated this issue and I could fix this issue using the following patch.
The patch can be applied on the top of your scif-dma-v2.
If possible, would you check the patch and merge your patch set to v3?

---

Subject: [PATCH] serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch fixes an issue that this driver causes a NULL pointer
dereference if the following conditions:
 - CONFIG_HIGHMEM and CONFIG_SERIAL_SH_SCI_DMA are enabled
 - This driver runs on the sci_dma_rx_push()

This issue was caused by virt_to_page(buf) in the sci_request_dma()
because this driver didn't check if the "buf" was valid or not.
So, this patch uses the "buf" from dma_alloc_coherent() as is, not page.

This patch also relves a WARNING issue that this driver runs on the
sci_rx_dma_release().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7e8fa37..e1ac4c3b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -113,6 +113,8 @@ struct sci_port {
 	struct scatterlist		sg_tx;
 	unsigned int			sg_len_tx;
 	struct scatterlist		sg_rx[MAX_BUF_RX];
+	void				*rx_chunk;
+	u8				*rx_buf[MAX_BUF_RX];
 	unsigned int			total_buf_len_rx;
 	unsigned int			nr_buf_rx;
 	struct work_struct		work_tx;
@@ -1307,8 +1309,7 @@ static void sci_dma_tx_complete(void *arg)
 }

 /* Locking: called with port lock held */
-static int sci_dma_rx_push(struct sci_port *s, struct scatterlist *sg,
-			   unsigned int count)
+static int sci_dma_rx_push(struct sci_port *s, u8 *buf, unsigned int count)
 {
 	struct uart_port *port = &s->port;
 	struct tty_port *tport = &port->state->port;
@@ -1323,7 +1324,7 @@ static int sci_dma_rx_push(struct sci_port *s, struct scatterlist *sg,
 		return room;

 	for (i = 0; i < room; i++)
-		tty_insert_flip_char(tport, ((u8 *)sg_virt(sg))[i], TTY_NORMAL);
+		tty_insert_flip_char(tport, buf[i], TTY_NORMAL);

 	port->icount.rx += room;

@@ -1357,7 +1358,7 @@ static void sci_dma_rx_complete(void *arg)

 	active = sci_dma_rx_find_active(s);
 	if (active >= 0)
-		count = sci_dma_rx_push(s, &s->sg_rx[active],
+		count = sci_dma_rx_push(s, s->rx_buf[active],
 					sg_dma_len(&s->sg_rx[active]));

 	mod_timer(&s->rx_timer, jiffies + s->rx_timeout);
@@ -1385,8 +1386,7 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 		s->cookie_rx[i] = -EINVAL;
 	if (sg_dma_address(&s->sg_rx[0])) {
 		dma_free_coherent(chan->device->dev, s->total_buf_len_rx,
-				  sg_virt(&s->sg_rx[0]),
-				  sg_dma_address(&s->sg_rx[0]));
+				  s->rx_chunk, sg_dma_address(&s->sg_rx[0]));
 		sg_dma_address(&s->sg_rx[0]) = 0;
 	}
 	dma_release_channel(chan);
@@ -1491,7 +1491,7 @@ static void work_fn_rx(struct work_struct *work)
 		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n", read,
 			s->active_rx);

-		count = sci_dma_rx_push(s, &s->sg_rx[new], read);
+		count = sci_dma_rx_push(s, s->rx_buf[new], read);

 		if (count)
 			tty_flip_buffer_push(&port->state->port);
@@ -1823,12 +1823,13 @@ static void sci_request_dma(struct uart_port *port)
 			return;
 		}

+		s->rx_chunk = buf;
 		for (i = 0; i < s->nr_buf_rx; i++) {
 			struct scatterlist *sg = &s->sg_rx[i];

 			sg_init_table(sg, 1);
-			sg_set_page(sg, virt_to_page(buf), buflen[i],
-				    offset_in_page(buf));
+			s->rx_buf[i] = buf;
+			sg->length = buflen[i];
 			sg_dma_address(sg) = dma;

 			buf += buflen[i];
-- 
1.9.1

==== log (while my rootfs runs on runscripts) ====
WARNING: CPU: 1 PID: 1 at drivers/base/dma-mapping.c:334 dma_common_free_remap+0x48/0x6c()
trying to free invalid coherent area:   (null)
CPU: 1 PID: 1 Comm: init Tainted: G        W       4.2.0-rc2-00494-g359fbc3-dirty #388
Hardware name: Generic R8A7790 (Flattened Device Tree)
Backtrace:
[<c0012f84>] (dump_backtrace) from [<c001312c>] (show_stack+0x18/0x1c)
 r7:c05f0ee7 r6:ee8319c0 r5:00000009 r4:00000000
[<c0013114>] (show_stack) from [<c04b5ea8>] (dump_stack+0x78/0x94)
[<c04b5e30>] (dump_stack) from [<c0026260>] (warn_slowpath_common+0x88/0xb4)
 r5:00000009 r4:ee84fdc0
[<c00261d8>] (warn_slowpath_common) from [<c00262f8>] (warn_slowpath_fmt+0x38/0x40)
 r9:00040000 r8:c069d530 r7:00000000 r6:00001000 r5:20000008 r4:00000000
[<c00262c4>] (warn_slowpath_fmt) from [<c0280c00>] (dma_common_free_remap+0x48/0x6c)
 r3:00000000 r2:c05f0f02
[<c0280bb8>] (dma_common_free_remap) from [<c001b944>] (__arm_dma_free+0xd0/0xec)
 r7:00000000 r6:00000000 r5:ef5ba1c0 r4:00001000
[<c001b874>] (__arm_dma_free) from [<c001b9b0>] (arm_dma_free+0x24/0x2c)
 r9:00000100 r8:00000000 r7:00000000 r6:ee9db210 r5:ee9c6400 r4:c06c14c4
[<c001b98c>] (arm_dma_free) from [<c0236fc0>] (sci_rx_dma_release+0xcc/0xf4)
[<c0236ef4>] (sci_rx_dma_release) from [<c023758c>] (sci_shutdown+0x8c/0xe8)
 r9:edd9c09c r8:ee941700 r7:edd9c094 r6:00000013 r5:60000013 r4:c06c14c4
[<c0237500>] (sci_shutdown) from [<c022b8ac>] (uart_port_shutdown+0x34/0x40)
 r7:edd9c094 r6:00000013 r5:edd9c000 r4:c06c14c4
[<c022b878>] (uart_port_shutdown) from [<c022b984>] (uart_shutdown+0xcc/0xf8)
 r5:edd9c000 r4:c06c14c4
[<c022b8b8>] (uart_shutdown) from [<c022bf80>] (uart_close+0xec/0x1e0)
 r7:edd9c064 r6:c06c14c4 r5:ee036000 r4:edd9c000
[<c022be94>] (uart_close) from [<c0214684>] (tty_release+0x13c/0x468)
 r9:00000008 r8:ee941700 r7:ee440a18 r6:00000000 r5:00000000 r4:ee036000
[<c0214548>] (tty_release) from [<c00cabd0>] (__fput+0xe0/0x1a0)
 r10:ee941708 r9:00000008 r8:ee804f50 r7:ee440a18 r6:00000000 r5:ee441948
 r4:ee941700
[<c00caaf0>] (__fput) from [<c00cacf0>] (____fput+0x10/0x14)
 r10:00000000 r9:ee84e000 r8:c000fd84 r7:ee84e000 r6:c069e1ec r5:00000000
 r4:ee8319c0
[<c00cace0>] (____fput) from [<c003d694>] (task_work_run+0xbc/0xd0)
[<c003d5d8>] (task_work_run) from [<c0012bf4>] (do_work_pending+0x98/0xb0)
 r7:ee84e000 r6:ee84ffb0 r5:ee84e010 r4:c000fd84
[<c0012b5c>] (do_work_pending) from [<c000fc2c>] (work_pending+0xc/0x20)
 r7:00000006 r6:be863bac r5:be863ba8 r4:00000000
---[ end trace 22e848b5bb93dba4 ]---

==== log (after I input a charactor) ====
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd 000000
Internal error: Oops: 17 [#1] SMP ARM
CPU: 0 PID: 296 Comm: kworker/0:1 Tainted: G        W       4.2.0-rc2-00494-g359fbc3-dirty #388
Hardware name: Generic R8A7790 (Flattened Device Tree)
Workqueue: events work_fn_rx
task: ee0c7b00 ti: ee126000 task.ti: ee126000
PC is at sci_dma_rx_push+0x74/0xfc
LR is at page_address+0xa8/0xe8
pc : [<c0237160>]    lr : [<c00add70>]    psr: 60000093
sp : ee127e78  ip : ee127e50  fp : ee127ea4
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : c06c165c  r6 : edd9c000  r5 : c06c14c4  r4 : 00000001
r3 : 00000000  r2 : c06b5480  r1 : 60000093  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5307d  Table: 6df9406a  DAC: 00000015
Process kworker/0:1 (pid: 296, stack limit = 0xee126210)
Stack: (0xee127e78 to 0xee128000)
7e60:                                                       ee127ea4 ee127e88
7e80: c06c16a4 c06c16a4 c06c14c4 20000013 00000000 00000000 ee127ee4 ee127ea8
7ea0: c0239cbc c02370f8 c066d4e0 00000000 ee127f0c 00000001 00000017 0000007f
7ec0: c00391b8 eeb04800 eef907c0 c06c16a4 00000000 eef94000 ee127f24 ee127ee8
7ee0: c003950c c0239bfc eef907c0 eef907c0 c066a100 eef907d4 eeb04818 eeb04800
7f00: eef907c0 eef907c0 c066a100 eef907d4 eeb04818 00000000 ee127f5c ee127f28
7f20: c0039964 c0039334 c0039678 00000000 00000000 ee077880 00000000 eeb04800
7f40: c0039678 00000000 00000000 00000000 ee127fac ee127f60 c003e808 c0039684
7f60: 00000000 00000000 00000000 eeb04800 00000000 00000000 ee127f78 ee127f78
7f80: 00000000 00000000 ee127f88 ee127f88 ee077880 c003e728 00000000 00000000
7fa0: 00000000 ee127fb0 c000fc88 c003e734 00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 a0111455 4a189946
Backtrace:
[<c02370ec>] (sci_dma_rx_push) from [<c0239cbc>] (work_fn_rx+0xcc/0x1d0)
 r9:00000000 r8:00000000 r7:20000013 r6:c06c14c4 r5:c06c16a4 r4:c06c16a4
[<c0239bf0>] (work_fn_rx) from [<c003950c>] (process_one_work+0x1e4/0x31c)
 r8:eef94000 r7:00000000 r6:c06c16a4 r5:eef907c0 r4:eeb04800
[<c0039328>] (process_one_work) from [<c0039964>] (worker_thread+0x2ec/0x440)
 r10:00000000 r9:eeb04818 r8:eef907d4 r7:c066a100 r6:eef907c0 r5:eef907c0
 r4:eeb04800
[<c0039678>] (worker_thread) from [<c003e808>] (kthread+0xe0/0xf4)
 r10:00000000 r9:00000000 r8:00000000 r7:c0039678 r6:eeb04800 r5:00000000
 r4:ee077880
[<c003e728>] (kthread) from [<c000fc88>] (ret_from_fork+0x14/0x2c)
 r7:00000000 r6:00000000 r5:c003e728 r4:ee077880
Code: e3c00003 ebf9dadb e5973004 e0800009 (e7d03003)
---[ end trace 22e848b5bb93dbae ]---

Best regards,
Yoshihiro Shimoda
