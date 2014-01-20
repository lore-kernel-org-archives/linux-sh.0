From: Simon Horman <horms@verge.net.au>
Date: Mon, 20 Jan 2014 00:11:40 +0000
Subject: Re: [PATCH] MAINTAINERS: Add dts files for r8 series to SHMOBILE
Message-Id: <20140120001139.GC9752@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057071-12455-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390057071-12455-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jan 18, 2014 at 05:07:30PM +0100, Geert Uytterhoeven wrote:
> On Sat, Jan 18, 2014 at 3:57 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1239,6 +1239,8 @@ Q:        http://patchwork.kernel.org/project/linux-sh/list/
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
> >  S:     Supported
> >  F:     arch/arm/mach-shmobile/
> > +F:     arch/arm/boot/dts/r8*
> 
> While you're at it, can you please also include r7s*?

There is also sh73* and emev2*.

And while we are opening this topic, are the defconfigs of interest too?

> 
> > +F:     arch/arm/boot/dts/include/dt-bindings/clock/r8a*
> 
> This is a symlink, so shouldn't that be include/dt-bindings/clock/r8a?
> 
> Thanks!
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
