From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 24 May 2012 08:56:32 +0000
Subject: Re: [PATCH] sh: switch various MSTP PM clocks to device-ID look-up
Message-Id: <Pine.LNX.4.64.1205240950520.1462@axis700.grange>
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
> connection IDs. We use connection IDs particularly in cases where there
> is ambiguity, or multiple clocks for the same device, which we want to
> toggle at different times. We won't be blindly moving off of connection
> IDs where that behaviour is desirable if there is insufficiently granular
> infratructure to migrate to.
> 
> Likewise having these sorts of arbitrary policy decisions offline is
> completely pointless. If you wish to put forward a concrete proposal for
> moving off of connection IDs, then send it to the list and let it stand
> on its own merit.

Sorry for an almost one month long pause. Maybe we could close this thread 
by verifying my current understanding and checking your preferences.

1. The drivers I was looking at: SDHI, MMCIF, MSIOF all do clk_get(dev, 
   "name%d"); where name%d is sdhi%d, mmc%d and msiof%d respectively.
2. Some other drivers, like i2c do just clk_get(dev, NULL);
3. Others yet, e.g., sci do clk_get(dev, name), where name is fixed - it 
   doesn't have the interface number in it. The sci driver uses two clocks 
   with connection IDs "sci_ick" and "sci_fck."

This seems a bit messy to me, but, well, as long as it works - no need to 
change anything there:-) My understanding would be, that a preferred 
scheme would be to either use no connection ID at all or use a fixed one - 
without an index. On the platform side:

1. The runtime PM acquires clocks per clk_get(dev, NULL)
2. Some platforms like sh7724, sh7722 on the sh side, all ARM SoCs use 
   mostly CLKDEV_DEV_ID() and CLKDEV_CON_ID() entries in their clk lookup 
   tables.
3. CLKDEV_ICK_ID() entries are used occasionally, mostly, when more than 
   one clock per device is registered
4. On other platforms, like those, affected by this patch, mainly or 
   exclusively CLKDEV_CON_ID() entries are used.

Here my understanding is, that for clocks, that should be referenced from 
the runtime PM a device reference is compulsory, so, CLKDEV_ICK_ID() or 
CLKDEV_DEV_ID() should be used. For clocks, used by drivers with an 
indexed connection ID, CLKDEV_CON_ID() entries will work too. This means, 
that at least the runtime PM on platforms, touched by this patch, is 
disabled for affected devices, but I personally have no idea how much of a 
problem that is, I don't work with any of them.

So, if this situation is acceptable, no problem with me, we can drop this 
series. If, however, we want to change something in this, would be nice to 
know your opinion. If my this patch-set can be adjusted to fulfill any of 
your wishes in this area - we could try to do that:-)

Thanks
Guennadi

> > Another thing to note - I didn't convert TMU entries on sh7343 and sh7366. 
> > On both these platforms currently there's one tmu clock look-up entry with 
> > just a "tmu_fck" connection ID, but platforms themselves register multiple 
> > tmu devices. Without datasheets I have no idea, whether some clock entries 
> > are missing from the lookup table, or that entry controlls all TMU clocks, 
> > or only one (#0?) TMU clock can be switched on and off.
> > 
> Most TMU clocks are grouped in pairs of 3 or 4, so one MSTP bit will
> control channels 0 .. 3, etc.
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
