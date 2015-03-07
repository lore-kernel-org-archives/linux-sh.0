From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 01:08:12 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: ape6evm: Fix GPIO keys and wake-up
Message-Id: <20150307010811.GL19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425059319-13403-1-git-send-email-geert+renesas@glider.be>
 <5844551.UVahD0ukvm@avalon>
 <20150306113028.GB27105@verge.net.au>
 <1533426.PtrGHiBojg@avalon>
In-Reply-To: <1533426.PtrGHiBojg@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Mar 06, 2015 at 01:33:05PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 06 March 2015 20:30:29 Simon Horman wrote:
> > On Thu, Mar 05, 2015 at 12:42:07PM +0200, Laurent Pinchart wrote:
> > > On Thursday 05 March 2015 09:34:33 Simon Horman wrote:
> > >> On Fri, Feb 27, 2015 at 06:48:37PM +0100, Geert Uytterhoeven wrote:
> > >>> 	Hi Simon, Magnus,
> > >>> 
> > >>> This patch series adds the missing pull-up bias configuration for the
> > >>> switches on the r8a73a4/ape6evm development board, and configures the
> > >>> custom switch as a wake-up source.
> > >>> 
> > >>> After this, the keys actually work, and the system can be resumed from
> > >>> s2ram by pressing the custom switch.
> > >>> 
> > >>> This depends functionally on "[PATCH 1/4] pinctrl: sh-pfc: Do not
> > >>> overwrite bias configuration" in the series "[PATCH 0/4] pinctrl:
> > >>> sh-pfc: Fix pin bias and cleanups" which I've just sent. But as this
> > >>> is DTS, it can be applied independently.
> > >>> 
> > >>> Thanks for your comments!
> > >> 
> > >> Hi Geert,
> > >> 
> > >> this seems fine to me. But I am reluctant to queue it up before the PFC
> > >> changes are accepted, lest there be some change in direction.
> > >> 
> > >> Please repost once the PFC changes have been accepted.
> > > 
> > > I've acked the dependency, but we should probably wait for Linus to apply
> > > it.
> >
> > Thanks Laurent, of course that plan is fine by me.
> 
> Linus has just applied it, so I think you can go forward with this series.

Thanks, done.
