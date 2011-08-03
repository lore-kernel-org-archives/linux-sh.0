From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 03 Aug 2011 03:37:59 +0000
Subject: Re: [PATCH] serial: sh-sci: fix DMA build by including dma-mapping.h
Message-Id: <20110803033759.GE32513@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110802094254.2352.12648.sendpatchset@t400s>
In-Reply-To: <20110802094254.2352.12648.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 03, 2011 at 12:28:09PM +0900, Simon Horman wrote:
> On Tue, Aug 02, 2011 at 06:42:54PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Include dma-mapping.h to fix build of the sh-sci driver on
> > SH-Mobile ARM (sh73a0) when CONFIG_SERIAL_SH_SCI_DMA=y:
> > 
> > drivers/tty/serial/sh-sci.c: In function 'sci_rx_dma_release':
> > drivers/tty/serial/sh-sci.c:1182:3: error: implicit declaration of function 'dma_free_coherent'
> > drivers/tty/serial/sh-sci.c: In function 'work_fn_tx':
> > drivers/tty/serial/sh-sci.c:1333:2: error: implicit declaration of function 'dma_sync_sg_for_device'
> > drivers/tty/serial/sh-sci.c: In function 'sci_request_dma':
> > drivers/tty/serial/sh-sci.c:1498:3: error: implicit declaration of function 'dma_map_sg'
> > drivers/tty/serial/sh-sci.c:1527:3: error: implicit declaration of function 'dma_alloc_coherent'
> > drivers/tty/serial/sh-sci.c:1527:10: warning: assignment makes pointer from integer without a cast
> > make[3]: *** [drivers/tty/serial/sh-sci.o] Error 1
> > make[2]: *** [drivers/tty/serial] Error 2
> > make[1]: *** [drivers/tty] Error 2
> > make: *** [drivers] Error 2
> 
> Tested-by: Simon Horman <horms@verge.net.au>

Applied, thanks.
