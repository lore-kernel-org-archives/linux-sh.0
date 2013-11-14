From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Nov 2013 13:21:38 +0000
Subject: Re: [PATCH] irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
Message-Id: <8495916.mnEoCL81Af@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 14 November 2013 14:35:34 Simon Horman wrote:
> On Wed, Nov 13, 2013 at 12:29:13PM +0100, Laurent Pinchart wrote:
> > On Wednesday 13 November 2013 15:22:08 Simon Horman wrote:
> > > On Wed, Nov 13, 2013 at 01:14:37PM +0900, Magnus Damm wrote:
> > > > On Wed, Nov 13, 2013 at 9:54 AM, Simon Horman wrote:
> > > > > On Tue, Nov 12, 2013 at 02:24:34PM +0100, Laurent Pinchart wrote:
> > > > >> On Tuesday 12 November 2013 14:08:40 Simon Horman wrote:
> > > > >> > On Sat, Nov 09, 2013 at 01:18:01PM +0100, Laurent Pinchart wrote:
> > > > >> > > The SENSE register bitfield position is incorrectly computed
> > > > >> > > for SoCs that use 2-bit IRQ sense fields. Fix it.
> > > > >> > > 
> > > > >> > > Signed-off-by: Laurent Pinchart
> > > > >> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > >> > 
> > > > >> > Hi Laurent,
> > > > >> > 
> > > > >> > your change seems correct to me but I am wondering if it should
> > > > >> > be considered as a bug-fix?
> > > > >> 
> > > > >> It's a bug fix, but given that the bug hasn't had any consequence
> > > > >> so far, I'm not sure whether we really need to backport it to -
> > > > >> stable.
> > > > > 
> > > > > Thanks. I think the best thing would be to try and get it into v3.13
> > > > > as a fix but not worry about -stable.
> > > > > 
> > > > > I will see about making it so.
> > > > 
> > > > Thanks. Can you work with Laurent to briefly extend the commit message
> > > > with information about which SoCs this has been tested on and such? I
> > > > don't have any R-Car Gen1 boards myself so you guys will have to fix
> > > > that.
> > > 
> > > Yes of course.
> > > 
> > > Laurent, I have access to both a Marzen (H1) and Bockw (M1) board.
> > > Please let me know if you would like me to do any testing.
> > 
> > I've tested the patch on a Marzen board, not a Lager board as erroneously
> > stated in my e-mail. It would be worth it testing it on Bockw to make sure
> > we were not in a situation where two wrongs made a right.
> 
> Hi Laurent,
> 
> I have booted a bockw board using its defconfig with this patch applied
> on top of renesas-devel-v3.12-20131112. The boot was successful.
> 
> The attached boot log also includes the contents of /proc/interrupts
> not long after boot for reference.
> 
> Is this test sufficient? Assuming so can I propose the following
> updated changelog?

It is to me.

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
> 
> The SENSE register bitfield position is incorrectly computed for SoCs
> that use 2-bit IRQ sense fields. Fix it.
> 
> This has been tested on the Marzen (H1) and Bockw (M1) boards.
> 
> This bug has been present since the renesas-intc-irqpin driver was
> introduced by 443580486e3b9657 ("irqchip: Renesas INTC External IRQ pin
> driver") in v3.10-rc1.
> 
> This bug does not have any known run-time effect.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>

That looks good.

-- 
Regards,

Laurent Pinchart

