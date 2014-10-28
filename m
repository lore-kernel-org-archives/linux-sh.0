From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Oct 2014 09:23:08 +0000
Subject: Re: non-Multiplatform APE6EVM broken in v3.18-rc1
Message-Id: <20141028092305.GA11937@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141028004131.GA8280@verge.net.au>
In-Reply-To: <20141028004131.GA8280@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 28, 2014 at 08:59:28AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Oct 28, 2014 at 1:41 AM, Simon Horman <horms@verge.net.au> wrote:
> > I have noticed that there appears to be a regression between v3.17 and
> > v3.18-rc1 such that non-multiplatform APE6EVM (ape6evm_defconfig) no longer
> > boots.  This appears to be the case using both reference DT (MACH_APE6EVM)
> 
> How does it manifest itself?
> If you don't get any console output, have you tried my early debug patch?

IIRC, there was no console output.
I have not tried any out-of tree debug code :)

> > and Legacy-C (MACH_APE6EVM_REFERENCE).
> >
> > I have tried bisecting this problem but dew a blank: the problem
> > seems to arise on a merge commit.
> 
> Which merge commit?

Looking over things again my bisection seems bogus.
I can try again but it won't be today.

> > This problem also seems to be present in v3.18-rc2 and the devel and next
> > branches of my renesas tree (which are based on v3.18-rc2 and v3.18-rc1
> > respectively).
> >
> > To be clear this problem, whatever it is, does not seem to affect
> > multiplatform APE6EVM (shmobile_defconfig).
> 
> AFAIK, there's no APE6EVM support in multiplatform yet?

Yes, true. I must have imagined that part.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
