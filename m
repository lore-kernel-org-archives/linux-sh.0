From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jul 2015 00:12:45 +0000
Subject: Re: [PATCH v2 0/5] enable I2C on Renesas EMEV2 and KZM9D board
Message-Id: <20150715001245.GC30642@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
 <20150714111857.GC1517@katana>
In-Reply-To: <20150714111857.GC1517@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ian Molton <ian.molton@codethink.co.uk>

On Tue, Jul 14, 2015 at 01:18:58PM +0200, Wolfram Sang wrote:
> On Sat, Jul 11, 2015 at 09:46:21AM +0200, Wolfram Sang wrote:
> > So, I picked up the old series from Ian and reworked it significantly. While
> > his series was already an improvement from the driver found in the BSP, it was
> > still not ready for upstream. It should be now :) My idea was to start simple
> > and improve incrementally, so e.g. clock handling was broken, so clocks are
> > always on for starters. Major changes include:
> > 
> > * clock handling simplified and adapted to current EMEV clock handling
> > * switch from wait_event to completion mechanism. The old one was basically
> >   some kind of completion with custom code around wait_events
> > * dropped using signals; they always cause trouble with I2C
> > * simplified the bus free logic. If it turns out to be too simple, we'd need
> >   to switch to the bus_recovery infrastructure probably. But we'd need a test
> >   case for that
> > * error handling improved to match subsystem standards
> > * removed some BSP angst code
> > * lots of refactoring to make code simpler, more readable...
> > * bugfixes
> > 
> > I also added all the glue code to add clocks, disable reset etc which was
> > missing before. I'd prefer to take the first three patches via i2c myself,
> > and the latter two via Simon's tree.
> > 
> > Since V1, there are minor updates fixing issues found in reviews. Thanks!
> > 
> > A branch for testing can be found here:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/emma-i2c
> > 
> > Please test, comment...
> > 
> > Thanks!
> > 
> >    Wolfram
> > 
> > Wolfram Sang (5):
> >   clk: shmobile: emev2: deassert reset for IIC0/1
> >   i2c: emev2: add binding documentation
> >   i2c: emev2: add driver
> 
> Those patches applied to for-next...
> 
> 
> >   ARM: shmobile: emev2: add IIC cores to dtsi
> >   ARM: shmobile: emev2: kzm9d: enable IIC busses
> 
> ... so Simon, you can pick up these, I'd say.

Thanks for the reminder; done.

