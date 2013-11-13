From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Nov 2013 06:22:08 +0000
Subject: Re: [PATCH] irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
Message-Id: <20131113062207.GB25188@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 13, 2013 at 01:14:37PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Nov 13, 2013 at 9:54 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Nov 12, 2013 at 02:24:34PM +0100, Laurent Pinchart wrote:
> >> Hi Simon,
> >>
> >> On Tuesday 12 November 2013 14:08:40 Simon Horman wrote:
> >> > On Sat, Nov 09, 2013 at 01:18:01PM +0100, Laurent Pinchart wrote:
> >> > > The SENSE register bitfield position is incorrectly computed for SoCs
> >> > > that use 2-bit IRQ sense fields. Fix it.
> >> > >
> >> > > Signed-off-by: Laurent Pinchart
> >> > > <laurent.pinchart+renesas@ideasonboard.com>
> >> >
> >> > Hi Laurent,
> >> >
> >> > your change seems correct to me but I am wondering if it should
> >> > be considered as a bug-fix?
> >>
> >> It's a bug fix, but given that the bug hasn't had any consequence so far, I'm
> >> not sure whether we really need to backport it to -stable.
> >
> > Thanks. I think the best thing would be to
> > try and get it into v3.13 as a fix but not worry about -stable.
> >
> > I will see about making it so.
> 
> Thanks. Can you work with Laurent to briefly extend the commit message
> with information about which SoCs this has been tested on and such? I
> don't have any R-Car Gen1 boards myself so you guys will have to fix
> that.

Yes of course.

Laurent, I have access to both a Marzen (H1) and Bockw (M1) board.
Please let me know if you would like me to do any testing.
