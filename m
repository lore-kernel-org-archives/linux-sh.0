From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 21 May 2009 17:52:12 +0000
Subject: Re: [PATCH] sh: CONFIG_SH_CLK_DISABLE_LEGACY V2
Message-Id: <20090521175212.GB2552@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090520135502.7742.12748.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090520135502.7742.12748.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 21, 2009 at 03:29:58PM +0900, Magnus Damm wrote:
> Invert legacy kconfig logic in clkfwk branch V2. Instead
> of building clock-cpg.c if CONFIG_SH_CLK_CPG_LEGACY is set,
> let CONFIG_SH_CLK_DISABLE_LEGACY be no by default and let
> upgraded processors use select to disable the legacy code.
> Always build clock-cpg.c but wrap legacy code in ifdefs to
> only build if CONFIG_SH_CLK_DISABLE_LEGACY is set to no.
> 
No, this is not the intention of the define. The intention was to keep it
as a place holder until I had time to ween the rest of the users off of
those clock definitions. As the vast majority of CPUs don't do much of
anything with their clock frameworks, that should be pretty easy to do
once SH7785 and the SH-Mobile bits have converged and settled.

Note that not building in the CPG clocks by default is behaviour we plan
on maintaining. There are ST40 parts that do not include the CPG at all
for example, and removing those legacy clocks are one of the only patches
needed against the generic clock.c to fix things up for those use cases.

The goal for clock-cpg.c on the other hand is to get a bit more generic
that most CPUs can tie their root clock information in to that to get
most of the useful bits out of the way. This has not happened yet as I
have been busy with PCI-Express.

In general, patches that invert logic are rarely useful. The logic was
generally done that way for a reason, whether it is immediately evident
or not. Bits in my topic branches may be a little less obvious than the
stuff in HEAD mostly since it is still in a high state of flux and not
yet ready for merging.
