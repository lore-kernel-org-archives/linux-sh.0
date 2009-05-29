From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 29 May 2009 05:51:05 +0000
Subject: Re: [PATCH 01/04] Driver Core: Add platform device arch data
Message-Id: <20090529055105.GD1122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100633.29671.83531.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100633.29671.83531.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 29, 2009 at 02:07:35PM +0900, Magnus Damm wrote:
> 2009/5/29 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 27 May 2009, Magnus Damm wrote:
> >> --- 0001/arch/Kconfig
> >> +++ work/arch/Kconfig 2009-05-15 14:51:35.000000000 +0900
> >> @@ -112,3 +112,6 @@ config HAVE_DMA_API_DEBUG
> >>
> >> ?config HAVE_DEFAULT_NO_SPIN_MUTEXES
> >> ? ? ? bool
> >> +
> >> +config HAVE_PLATFORM_DEVICE_ARCHDATA
> >
> > Hmm. ?Do we really need yet another CONFIG_ option for that?
> 
> I don't think we need a total of 3 different config options for the
> platform device pm stuff, but I do think it makes sense to handle the
> platform archdata separately. Not sure which is the best way though,
> the #ifdefery is not very pretty. Maybe the best solution is just to
> drop the Kconfig stuff and add empty structures to all architecture
> versions of asm/device.h.
> 
A stub in asm-generic/device.h will cover the majority of cases. That is
much cleaner than adding to the Kconfig mess.
