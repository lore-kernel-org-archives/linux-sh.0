From: Rich Felker <dalias@libc.org>
Date: Thu, 13 Oct 2016 19:25:42 +0000
Subject: Re: [PATCH v8 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161013192542.GW19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1475990489.git.dalias@libc.org>
 <588ea0a3175fcf5d409ca32249f24760f2f6f839.1475990489.git.dalias@libc.org>
 <20161011181812.GA1697@mai>
 <20161011202850.GK19318@brightrain.aerifal.cx>
 <20161012092711.GC1697@mai>
 <20161012170236.GP19318@brightrain.aerifal.cx>
 <20161012213126.GA1508@mai>
In-Reply-To: <20161012213126.GA1508@mai>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Oct 12, 2016 at 11:31:26PM +0200, Daniel Lezcano wrote:
> > > --> System Type
> > > 
> > > That is what you are looking for, a SUPERH config option selecting all the
> > > common options and then a JCORE config option adding the different missing
> > > bits, namely the CLKSRC_JCORE_PIT.
> > 
> > We do have something like "system type" in arch/sh, and it's what I'm
> > trying to deprecate since it's the switch to select between all the
> > hard-coded board files, _or_ device tree.
> > 
> > Since part of the goal of my DT overhaul is to be able (but not
> > forced) to produce kernels that run on a wide range of hardware,
> > rather than having a "system type (select one)" option, what about
> > individual boolean options like:
> > 
> > config JCORE_SOC
> > 	bool "Support for J-Core SoCs"
> > 	select CLKSRC_JCORE_PIT
> > 	select JCORE_AIC
> > 	...
> 
> I'm perfectly fine with this.

Does this adequately ensure that dependencies for the clocksource and
irq driver are met? If not, what else do I need to do?

Rich
