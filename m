From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 12 Oct 2015 15:18:26 +0000
Subject: Re: [PATCH v3 3/6] dma: rcar-dma: check if complete DMA packet received but not processed
Message-Id: <20151012150625.GC27370@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-4-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-4-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 29, 2015 at 10:44:45PM +0200, hamzahfrq.sub@gmail.com wrote:
> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
> 
> At high speeds, DMA interrupts come very fast. If there's an interrupt
> pending before previous is handled, this method can help return actual

which method ??

> status of the DMA transaction by reading the hardware flag

-- 
~Vinod
