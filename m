From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 27 Apr 2012 07:26:20 +0000
Subject: Re: [PATCH] sh: switch various MSTP PM clocks to device-ID look-up
Message-Id: <Pine.LNX.4.64.1204270854540.31986@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204262327080.32219@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204262327080.32219@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul

On Fri, 27 Apr 2012, Paul Mundt wrote:

> On Thu, Apr 26, 2012 at 11:48:32PM +0200, Guennadi Liakhovetski wrote:
> > Most SH drivers, accessing clocks, used for their devices, directly, have
> > been converted to not use connection IDs for clock look-up. The runtime PM
> > subsystem does the same. This means, that clock look-up entries for such
> > devices with non-NULL connection IDs are useless. This patch converts such
> > clock look-up entries to correct device IDs.
> > 
> This seems more like a failure in runtime PM than an issue with
> connection IDs.

This can be discussed, however, this is how it is today: sh-mobile runtime 
PM isn't using clock connection ID to identify PM related clocks. The API 
itself has this ability and OMAP1 is using it.

> We use connection IDs particularly in cases where there
> is ambiguity, or multiple clocks for the same device, which we want to
> toggle at different times.

Of course.

> We won't be blindly moving off of connection
> IDs where that behaviour is desirable if there is insufficiently granular
> infratructure to migrate to.

I'm not proposing that. All the cases, that I modified in this patch only 
have one clock per device, so, there's no ambiguity. And in such simple 
cases it seems logical to simply drop connection IDs. We have several 
cases with multiple clocks per device, like audio, HDMI, maybe some 
others. There we do use connection IDs.

> Likewise having these sorts of arbitrary policy decisions offline is
> completely pointless. If you wish to put forward a concrete proposal for
> moving off of connection IDs, then send it to the list and let it stand
> on its own merit.

As I said, I'm not proposing to move off connection IDs globally, only for 
non-ambiguous cases.

> > Another thing to note - I didn't convert TMU entries on sh7343 and sh7366. 
> > On both these platforms currently there's one tmu clock look-up entry with 
> > just a "tmu_fck" connection ID, but platforms themselves register multiple 
> > tmu devices. Without datasheets I have no idea, whether some clock entries 
> > are missing from the lookup table, or that entry controlls all TMU clocks, 
> > or only one (#0?) TMU clock can be switched on and off.
> > 
> Most TMU clocks are grouped in pairs of 3 or 4, so one MSTP bit will
> control channels 0 .. 3, etc.

Interesting... Indeed, upon a closer look at sh7724

	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[HWBLK_TMU0]),
	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[HWBLK_TMU0]),
	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.2", &mstp_clks[HWBLK_TMU0]),

does create 3 lookup entries for one clock with the same connection and 
different device IDs. That's probably also what has to be done for sh7343 
and sh7366.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
