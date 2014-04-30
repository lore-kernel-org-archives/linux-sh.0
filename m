From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 Apr 2014 16:23:40 +0000
Subject: Re: [RFC/PATCH 5/6] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <3042921.YNIkMUtkoO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 30 April 2014 10:34:12 Simon Horman wrote:
> On Wed, Apr 30, 2014 at 10:29:23AM +0900, Simon Horman wrote:
> > On Wed, Apr 30, 2014 at 03:02:20AM +0200, Laurent Pinchart wrote:
> > > On Wednesday 30 April 2014 09:59:56 Simon Horman wrote:
> > > > On Wed, Apr 30, 2014 at 02:31:45AM +0200, Laurent Pinchart wrote:
> > > > > SCIF0 and SCIF1 are used as debug serial ports. Enable them and
> > > > > configure pinmuxing appropriately. We can now remove the clkdev
> > > > > registration hack for SCIF devices from the Lager reference board
> > > > > file.
> > > > > 
> > > > > As a side effect of switching to DT-based serial port instantiation,
> > > > > ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device
> > > > > tree source if now shared between lager and lager-reference, we need
> > > > > to update the serial ports in C code as well.
> > > > 
> > > > I believe the second paragraph is no longer correct.
> > > 
> > > Oops, you're right. If no other problem is found with the series, could
> > > you please just drop that paragraph ?
> > 
> > Yes. But could you look at my other comment below?
> 
> I mean yes with the following caveat.
> 
> It seems to me that each of patch 4 and 5 could applied independently
> of the earlier patches in the series. This seems nice.

I suppose you mean patches 5 and 6.

> It seems to me that patches 3 and 4 depend on patch 2 which in turn
> depends on patch 1. This is less fun. So I was thinking of waiting
> for at least patch 2 to be accepted (by Greg) before applying
> 3 and 4.

That's fine with me.

> With regards to patch 1. Perhaps it would be best for Greg to take
> that with patch 2?

That's fine with me as well.

-- 
Regards,

Laurent Pinchart

