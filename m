From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 10 Mar 2010 07:58:28 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb SDHI0 platform data
Message-Id: <20100310075828.GE19518@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100310071528.5975.28821.sendpatchset@t400s>
In-Reply-To: <20100310071528.5975.28821.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 10, 2010 at 04:49:24PM +0900, Magnus Damm wrote:
> On Wed, Mar 10, 2010 at 4:36 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Wed, Mar 10, 2010 at 04:15:28PM +0900, Magnus Damm wrote:
> >> @@ -206,10 +207,38 @@ static struct platform_device keysc_devi
> >> ? ? ? },
> >> ?};
> >>
> >> +/* SDHI0 */
> >> +static struct sh_mobile_sdhi_info sdhi0_info = {
> >> +};
> >> +
> > Try again?
> 
> The sh_mobile_sdhi driver allows omitting the platform data, so
> perhaps that's a better idea.
> 
If the driver didn't allow for omitting platform data it would be crap,
and broken. We do not condone silly driver behaviour.

> >> +static struct resource sdhi0_resources[] = {
> >> + ? ? [0] = {
> >> + ? ? ? ? ? ? .name ? = "SDHI0",
> >> + ? ? ? ? ? ? .start ?= 0xe6850000,
> >> + ? ? ? ? ? ? .end ? ?= 0xe68501ff,
> >> + ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> >
> > If you aren't going to use a useful name for the resource, then the
> > name can just be left unset, this will ensure that the driver core
> > assigns the resource a name matching the device name/id pair.
> 
> The data sheet refers to this hardware block as SDHI0.
> 
> > So if left unset you would end up with "sh_mobile_sdhi.0" in /proc/iomem,
> > which could be more intuitive.
> 
> Sure, that's also an option. For sh7724 (and perhaps earlier
> SH-Mobile) most resources use the data sheet name for /proc/iomem.
> 
Leaving it as it is in the data sheet is of course fine, but many of
these blocks have absurdly generic names. Also note that in this case
/proc/iomem and /proc/interrupts and so on will have an inconsistency
between the naming, so we have a mixture of SDHI0 and sh_mobile_sdhi.0.

Perhaps some people find this separation useful, but it quickly turns in
to a mess with things like 12 TMU channels all using slightly different
naming conventions.
