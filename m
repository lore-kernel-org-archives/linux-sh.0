From: Simon Horman <horms@verge.net.au>
Date: Tue, 11 Nov 2014 00:16:28 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: kzm9g: Build DTS for Multiplatform
Message-Id: <20141111001627.GC29665@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904022905.26216.71286.sendpatchset@w520>
In-Reply-To: <20140904022905.26216.71286.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 10, 2014 at 10:08:31AM +0100, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Thu, Sep 4, 2014 at 4:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > Build the sh73a0 KZM9G board DTB in case of Multiplatform.
> > The DT reference case will be removed in the future and
> > can be ignored for now.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > ---
> >
> >  arch/arm/boot/dts/Makefile |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > --- 0001/arch/arm/boot/dts/Makefile
> > +++ work/arch/arm/boot/dts/Makefile     2014-09-04 11:05:49.000000000 +0900
> > @@ -375,7 +375,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += eme
> >         r8a7791-henninger.dtb \
> >         r8a7791-koelsch.dtb \
> >         r8a7790-lager.dtb \
> > -       r8a7779-marzen.dtb
> > +       r8a7779-marzen.dtb \
> > +       sh73a0-kzm9g.dtb
> 
> But for now we do want to use sh73a0-kzm9g-reference.dtb, as it contains
> more meat?

My recollection is that for other boards this has been handled by first
syncing the dtb files.

> >  dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
> >         socfpga_cyclone5_socdk.dtb \
> >         socfpga_cyclone5_sockit.dtb \
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
