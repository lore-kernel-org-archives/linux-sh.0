From: Rich Felker <dalias@libc.org>
Date: Thu, 13 Oct 2016 19:48:47 +0000
Subject: Re: [PATCH v8 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161013194847.GX19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1475990489.git.dalias@libc.org>
 <588ea0a3175fcf5d409ca32249f24760f2f6f839.1475990489.git.dalias@libc.org>
 <20161011181812.GA1697@mai>
 <20161011202850.GK19318@brightrain.aerifal.cx>
 <20161012092711.GC1697@mai>
 <20161012170236.GP19318@brightrain.aerifal.cx>
 <20161012213126.GA1508@mai>
 <20161013192542.GW19318@brightrain.aerifal.cx>
In-Reply-To: <20161013192542.GW19318-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

On Thu, Oct 13, 2016 at 03:25:42PM -0400, Rich Felker wrote:
> On Wed, Oct 12, 2016 at 11:31:26PM +0200, Daniel Lezcano wrote:
> > > > --> System Type
> > > > 
> > > > That is what you are looking for, a SUPERH config option selecting all the
> > > > common options and then a JCORE config option adding the different missing
> > > > bits, namely the CLKSRC_JCORE_PIT.
> > > 
> > > We do have something like "system type" in arch/sh, and it's what I'm
> > > trying to deprecate since it's the switch to select between all the
> > > hard-coded board files, _or_ device tree.
> > > 
> > > Since part of the goal of my DT overhaul is to be able (but not
> > > forced) to produce kernels that run on a wide range of hardware,
> > > rather than having a "system type (select one)" option, what about
> > > individual boolean options like:
> > > 
> > > config JCORE_SOC
> > > 	bool "Support for J-Core SoCs"
> > > 	select CLKSRC_JCORE_PIT
> > > 	select JCORE_AIC
> > > 	...
> > 
> > I'm perfectly fine with this.
> 
> Does this adequately ensure that dependencies for the clocksource and
> irq driver are met? If not, what else do I need to do?

I've checked and it seems the dependencies are always met for arch/sh,
at least with device tree enabled (on which JCORE_SOC will depend), so
it shouldn't matter.

Rich
