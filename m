From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 29 Jul 2013 13:22:18 +0000
Subject: Re: [PATCH v2 00/27] sh-pfc: Support pins with no associated GPIO port
Message-Id: <1540983.fSjrlCCbRj@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1373933479-17727-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373933479-17727-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Saturday 27 July 2013 01:14:10 Linus Walleij wrote:
> On Wed, Jul 24, 2013 at 3:28 PM, Laurent Pinchart wrote:
> > On Sunday 21 July 2013 00:19:36 Linus Walleij wrote:
> >> That's very helpful, I can then pull it in and inspect the files before
> >> and
> >> after this train of patches, which is probably the most efficient way to
> >> review it.
> > 
> > The patches can be found in my git tree at
> > 
> >         git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pin-no-gpio
> > 
> > If you have time, could you already review them ?
> 
> I'd like to pull this into the pinctrl tree but then I'd prefer if they were
> based on v3.11-rc1 if possible?

Sure. I've rebased

	git://linuxtv.org/pinchartl/fbdev.git pinmux/next/pin-no-gpio

on top of v3.11-rc1.

-- 
Regards,

Laurent Pinchart

