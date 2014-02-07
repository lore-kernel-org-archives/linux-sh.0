From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 07 Feb 2014 00:36:35 +0000
Subject: Re: [PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0 OVC/VBUS
Message-Id: <1869968.h64ujKRKE7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <CANqRtoTQF56e-zRGr0+wpE3Yxd2u-HtTfSD=-QMiKBxZ40nAKQ@mail.gmail.com>
 <20140207001541.GF19799@verge.net.au>
In-Reply-To: <20140207001541.GF19799@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Friday 07 February 2014 09:15:44 Simon Horman wrote:
> On Thu, Feb 06, 2014 at 10:34:27PM +0900, Magnus Damm wrote:
> > On Thu, Feb 6, 2014 at 8:01 PM, Laurent Pinchart wrote:
> > > On Friday 31 January 2014 12:10:05 Magnus Damm wrote:
> > >> On Fri, Jan 31, 2014 at 10:17 AM, Laurent Pinchart wrote:
> > >> > On Thursday 30 January 2014 08:10:19 Magnus Damm wrote:
> > >> >> From: Magnus Damm <damm@opensource.se>
> > >> >> 
> > >> >> Create a new group for the USB0 OVC/VBUS pin by itself. This
> > >> >> allows us to monitor PWEN as GPIO on the Lager board.
> > >> >> 
> > >> >> Signed-off-by: Magnus Damm <damm@opensource.se>

[snip]

> > > 
> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Thanks,
> 
> Thanks Magnus.
> 
> Laurent, with that in mind could you pick up this patch?

I was thinking about letting Linus pick up the PFC patches again now that the 
flood is over. Of course, if it can help, I can still pick the patches up and 
submit pull requests to Linus.

Linus, what's your opinion on this ? Would you rather pick the patches 
directly after I've acked them, or process pull requests ?

-- 
Regards,

Laurent Pinchart

