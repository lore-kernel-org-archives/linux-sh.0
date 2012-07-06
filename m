From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 06 Jul 2012 06:36:59 +0000
Subject: Re: [PATCH] sh: select the fixed regulator driver on several boards
Message-Id: <Pine.LNX.4.64.1207060830560.29809@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207051517430.30191@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207051517430.30191@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

(added Rafael to CC, because this equally applies to the ARM Kconfig 
patch)

On Fri, 6 Jul 2012, Paul Mundt wrote:

> On Thu, Jul 05, 2012 at 03:18:50PM +0200, Guennadi Liakhovetski wrote:
> > On systems, using regulators to supply power to devices, if the REGULATOR
> > Kconfig option is disabled, regulator API stubs will be used, which often
> > suffices to bring a default configuration up. If REGULATOR is enabled but
> > respective regulator drivers are inactive, the real regulator API calls
> > will be used, which in the absence of drivers will fail to provide
> > services. This patch prevents such a problem on sh-mobile boards by
> > forcing REGULATOR_FIXED_VOLTAGE on if REGULATOR is selected.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> I suppose this just applies on top of your existing changes on the
> sh/regulator topic branch?

It should be safe to apply to any state - before or after my patches. My 
previous patches did not touch Kconfig, and this patch just selects the 
fixed regulator, which certainly should cause no problems if no regulators 
are used either.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
