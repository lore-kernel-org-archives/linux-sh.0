From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Feb 2010 09:28:14 +0000
Subject: Re: [PATCH 00/03] sh: SDHI vector merge
Message-Id: <20100209092814.GC17722@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100209064940.31154.52216.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100209064940.31154.52216.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 09, 2010 at 03:49:40PM +0900, Magnus Damm wrote:
> [PATCH 01/03] sh: sh7722/Migo-R SDHI vector merge
> [PATCH 02/03] sh: sh7723/AP325 SDHI vector merge
> [PATCH 03/03] sh: sh7724/Ecovec24/KFR2R09/MS7724SE SDHI vector merge
> 
> These patches merge the SDHI interrupt vectors in the INTC tables
> for sh7722, sh7723 and sh7724 processors. The interrupt number in
> Linux is also changed to the first of the vectors, so the board
> specific platform data is also updated for a bunch of boards.
> 
> With these patches in place we are one step closer to SDHI hotplug.

On Tue, Feb 09, 2010 at 04:17:20PM +0900, Magnus Damm wrote:
> This patch updates the shared INTC code to use
> set_irq_chained_handler() for intc_redirect_irq().
> 
> With this in place request_irq() on a merged irq
> which has been redirected will now return -EINVAL
> instead of 0 together with a crash. This thanks to
> the protection of the IRQ_NOREQUEST flag set for
> chained interrupt handlers.

On Tue, Feb 09, 2010 at 05:22:30PM +0900, Magnus Damm wrote:
> Break out sh7723 div4 clocks for SIU and IRDA as
> reparent / enable clocks. Similar to the SIU clock
> patch for sh7722 by Guennadi.

All applied, thanks.
