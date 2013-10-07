From: Olof Johansson <olof@lixom.net>
Date: Mon, 07 Oct 2013 16:37:26 +0000
Subject: Re: [PATCH/RFC] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits
Message-Id: <20131007163726.GC15413@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20130925233709.16540.66903.sendpatchset@w520>
 <20130927044323.GC16541@verge.net.au>
In-Reply-To: <20130927044323.GC16541@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, khilman@linaro.org, arnd@arndb.de, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Fri, Sep 27, 2013 at 01:43:25PM +0900, Simon Horman wrote:
> On Thu, Sep 26, 2013 at 08:37:09AM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Based on request from Olof Johansson, move ARM mach-shmobile
> > clocksource entries to drivers/clocksource/Kconfig, and at
> > the same time make the SH architecture use these entries.
> > 
> > Kconfig entries for CMT, MTU2, TMU and STI are with this patch
> > now kept in one place. The SH SYS_SUPPORTS_nnn bits are dropped
> > to simplye let the user select the appropriate ones using Kconfig
> > instead of trying to filter available timers based on SoC.
> > 
> > Known issues:
> >  1) Not yet wrappend in menu/endmenu, populates the root driver menu
> >  -> proposal: Create separate patch to wrap all the clocksource entries?
> 
> That seems reasonable to me.
> 
> >  2) Should the entries be sorted?
> >  -> proposal: Ignore cosmetic bits
> 
> I propose that you sort the entries are adding
> but leave the rest of the entries as is.
> 
> >  3) What is correct dependency for multiplatform and single platform?
> >  -> proposal: Perhaps we should simply default to no?
> 
> I'm not sure that I understand the issue here.
> 
> >  4) Is single patch across 2 architectures and drivers/clocksource OK?
> >  -> proposal: Keep it like this if possible
> 
> Olof, I would like your opinion on this but from my pov this seems
> reasonable. Especially as one of the architectures (sh) is seeing very little
> change at this time.

(Sorry for the delayed response, the renesas volume email can be large and
I don't always read it when it comes in).


Yeah, as long as you have appropriate acks and don't expect conflicts.


-Olof
