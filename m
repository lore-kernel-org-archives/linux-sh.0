From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Sep 2011 05:33:26 +0000
Subject: Re: [PATCH 5/7] fbdev: sh_mipi_dsi: add extra dcs settings for platform
Message-Id: <20110905053326.GG22142@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87vctmt9t1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vctmt9t1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 29, 2011 at 10:45:37AM +0200, Guennadi Liakhovetski wrote:
> On Mon, 29 Aug 2011, Magnus Damm wrote:
> > I do however wonder if this array is the best approach to adding board
> > specific code. My personal take would be to use something like the SYS
> > bus support for the LCDC, see callbacks in struct
> > sh_mobile_lcdc_sys_bus_ops located in
> > include/video/sh_mobile_lcdc.h and board/panel code like
> > arch/sh/boards/mach-migor/lcd_qvga.c.
> 
> I don't like that array either, but if we want to do this _right_, 
> callbacks wouldn't be my preference either. I'm not familiar with the set 
> up: are those values wpecific to the LCD panel or to the board? If it's 
> the LCD panel, then ideally one would want a display driver for them. 
> Backlight controlling would want a proper driver too.
> 
> > Also, if your board/panel specific code is dealing with backlight on
> > MIPI-DSI, perhaps there is a chance this is generic enough to be
> > broken out and reused somehow.
> 
> Exactly, however, lately I'me coming to an unfortunate conclusion, that 
> due to a vast variety of embedded systems and their components, many 
> hardware blocks will ever be only used on a single embedded platform, 
> running Linux, and only be exposed to a handful of users. So, creating and 
> maintaining a proper driver for each such block has a good chance to be 
> considered an overkill...
> 
That's true, but I'm not sure I see how that matters for the case at
hand. MIPI is hardly SH-Mobile specific, it just happens to be the place
where a lot of the work is being done for the moment (OMAP DSS being
another). There is already a lot of duplication between the different
MIPI users in-tree today, and it's reasonable to expect that sooner or
later there will be some consolidation effort.

Given that all of the SH-Mobile parts are also using it going forward (at
least for the moment) it's certainly worth trying to get right. Throwing
on some opaque "extras" pointer at the end of the structure is just
asking for abuse, particularly if the only purpose it's serving is more
or less common functionality we can expect to see on upcoming platforms.

While the SYS bus bits were pretty much stillborn, this wasn't so much a
problem of the abstraction (or lack thereof -- and I'm certainly not
endorsing the SYS bus abstraction, either) as general timing. At the time
most of that work happened it was still playing catch up to support a
platform that would be obsolete by the time support was sufficiently far
enough for anyone to make use of it. The present line of SH-Mobile CPUs
don't really suffer from the same sort of knee-jerk IP block scizophrenia
usually associated with the device team (even if it seems like we're
sometimes suffering from CPU or board of the week syndrome), so I would
certainly lean towards doing it right, even if it's going to take a bit
longer to hash out the abstraction.

Your comments about a proper backlight driver and so on are accurate as
well, and this is something we were also discussing with the SYS bus
bits, it simply wasn't bothered with since the platform was basically
abandoned before anyone really cared.
