From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 17 Dec 2014 15:34:27 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <4867206.TqKlRJif4N@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20141216094854.22639.69181.sendpatchset@w520>
In-Reply-To: <20141216094854.22639.69181.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wednesday 17 December 2014 16:43:09 Laurent Pinchart wrote:
> On Wednesday 17 December 2014 14:59:21 Geert Uytterhoeven wrote:
> > On Wed, Dec 17, 2014 at 1:14 PM, Laurent Pinchart wrote:
> > >>> What are we missing ?
> > >>> 
> > >>> - The DIV6 multiparent series has been merged by Mike, and the sh73a0
> > >>> CCF is nearly ready.
> > >> 
> > >> Yep.
> > >> 
> > >>> - We need proper BSC support to get LAN working, although it could be
> > >>> worked around temporarily by specifying the BSC clock in the LAN node
> > >>> if I recall correctly.
> > >> 
> > >> Working on that. I hope to send out v2 later today...
> > >> 
> > >>> - Accelerometer and RTC have no DT bindings, but they should work with
> > >>> the I2C core OF match support.
> > >> 
> > >> I have RTC in my DTS, and it works.

I'll test compass, touch screen and accelerometer.

> > > Great.
> > > 
> > > I can help with at least some of the remaining pieces if you share your
> > > working branch.
> > 
> > I pushed my local working branch to
> > https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log
> > /? h=wip
> > 
> > Please wear sun glasses, and keep the kbuild test robot away ;-)
> 
> I will :-) Thank you. Is there a way to selectively keep kbuild away from
> branches by the way ?
> 
> Do avoid duplicating work, what do you plan to work on in the context of
> multiplatform kzm9g ?
> 
> Magnus, how much time do you think would be worth spending on DT support for
> the lcdc drm driver ?

-- 
Regards,

Laurent Pinchart

