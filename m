From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Jul 2012 07:08:53 +0000
Subject: Re: [PATCH] sh: select the fixed regulator driver on several boards
Message-Id: <20120706070853.GA9317@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207051517430.30191@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207051517430.30191@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 06, 2012 at 08:36:59AM +0200, Guennadi Liakhovetski wrote:
> (added Rafael to CC, because this equally applies to the ARM Kconfig 
> patch)
> 
> On Fri, 6 Jul 2012, Paul Mundt wrote:
> 
> > On Thu, Jul 05, 2012 at 03:18:50PM +0200, Guennadi Liakhovetski wrote:
> > > On systems, using regulators to supply power to devices, if the REGULATOR
> > > Kconfig option is disabled, regulator API stubs will be used, which often
> > > suffices to bring a default configuration up. If REGULATOR is enabled but
> > > respective regulator drivers are inactive, the real regulator API calls
> > > will be used, which in the absence of drivers will fail to provide
> > > services. This patch prevents such a problem on sh-mobile boards by
> > > forcing REGULATOR_FIXED_VOLTAGE on if REGULATOR is selected.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > I suppose this just applies on top of your existing changes on the
> > sh/regulator topic branch?
> 
> It should be safe to apply to any state - before or after my patches. My 
> previous patches did not touch Kconfig, and this patch just selects the 
> fixed regulator, which certainly should cause no problems if no regulators 
> are used either.
> 
Ok, I wasn't sure if the symbol was provided there or not, but seems that
it's already upstream, so we don't have to worry about select causing
build noise regarding undefined symbols. I'll roll it on top of the
sh/regulator topic branch regardless, though.
