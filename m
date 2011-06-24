From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 07:33:05 +0000
Subject: Re: [PATCH] drivers: sh: late disabling of clocks V2
Message-Id: <20110624073304.GC26504@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110621075512.24672.78879.sendpatchset@t400s>
In-Reply-To: <20110621075512.24672.78879.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 07:32:36PM +0900, Simon Horman wrote:
> On Tue, Jun 21, 2011 at 04:55:12PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > This V2 patch changes the clock disabling behavior during boot.
> > Two different changes are made:
> > 
> > 1) Delay disabling of clocks until late in the boot process. 
> >    This fixes an existing issue where in-use clocks without
> >    software reference are disabled by mistake during boot.
> >    One example of this is the handling of the Mackerel serial
> >    console output that shares clock with the I2C controller.
> > 
> > 2) Write out the "disabled" state to the hardware for clocks
> >    that not have been used by the kernel. In other words, 
> >    make sure so far unused clocks actually get turned off.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > ---
> > 
> >  Changes since V1:
> >  - move out the spinlock and let it protect allow_disable
> > 
> >  Thanks to Simon Horman for code improvements.
> > 
> >  This would be useful to have in a topic branch so we can
> >  go through each platform and extend the clock framework
> >  to a more complete coverage.
> 
> Code improvement aspect
> Acked-by: Simon Horman <horms@verge.net.au>
> 
Applied to sh/clkfwk and subsequently rolled in to sh-latest. Lets see
what breaks..
