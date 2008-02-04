From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 04 Feb 2008 08:25:07 +0000
Subject: Re: Various section mismatches
Message-Id: <1202113507.6489.4.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202080862.9936.4.camel@localhost.localdomain>
In-Reply-To: <1202080862.9936.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Mon, 2008-02-04 at 10:12 +0900, Paul Mundt wrote:
> On Sun, Feb 03, 2008 at 11:21:02PM +0000, Adrian McMenamin wrote:
> >   LD      arch/sh/kernel/cpu/built-in.o
> > WARNING: arch/sh/kernel/cpu/built-in.o(.cpuinit.text+0x164): Section mismatch in reference from the function sh_cpu_init() to the function .init.text:detect_cpu_and_cache_system()
> > The function __cpuinit sh_cpu_init() references
> > a function __init detect_cpu_and_cache_system().
> > If sh_cpu_init is only used by detect_cpu_and_cache_system then
> > annotate sh_cpu_init with a matching annotation.
> > 
> Something seems to be wrong with your mailer, as a patch was strangely
> missing.

As the first line made clear there wasn't going to be a patch, I think
you need to change your spectacle subscription.

Last time I checked users/testers were encouraged to post up errors as
well as patches. When was that changed?

