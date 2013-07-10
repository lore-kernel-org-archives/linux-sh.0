From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 01:12:45 +0000
Subject: Re: [PATCH 01/04] ARM: shmobile: No need to use INTC header on r8a7779
Message-Id: <20130710011244.GL32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709103944.1891.67462.sendpatchset@w520>
 <20130709103952.1891.92697.sendpatchset@w520>
In-Reply-To: <20130709103952.1891.92697.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 09, 2013 at 07:39:52PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Now when the intc-irqpin driver is used for external
> IRQ pins on r8a7779 it possible to get rid of unused
> INTC headers mach/intc.h and linux/sh_intc.h.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
