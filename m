From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2015 08:57:43 +0000
Subject: Re: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <CAMuHMdVgVDzsnaQ8G7PLjO+CcJDt1iz93XNCb8GQnfZmC3Yiqg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150120113800.11062.65299.sendpatchset@little-apple>
In-Reply-To: <20150120113800.11062.65299.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Jan 21, 2015 at 12:50 AM, Simon Horman <horms@verge.net.au> wrote:
> My na=C3=AFve guess is that the GIC setup for the r8a73a4 is somehow
> more complex or than calling gic_init() and that this is reflected
> in its DT - which seems more complex than for the r8a77{40,98,99} which
> we have been fixed in a manner very close to the patch you propose here.

According to the bindings, the extra 2 reg property ranges are for the
virtualization extensions, which we don't use.

> * renesas-devel-20150119-v3.19-rc5+patched+earlyprintk: This is
>   a boot of renesas-devel-20150119-v3.19-rc5 with your patch applied,

| Unable to handle kernel paging request at virtual address f1001004

So the GIC's registers are not mapped.

Ape6evm doesn't provide machine_desc.map_io(), so you have to map the
GIC yourself. Does the below work?

-       void __iomem *gic_dist_base =3D IOMEM(0xf1001000);
-       void __iomem *gic_cpu_base =3D IOMEM(0xf1002000);
+       void __iomem *gic_dist_base =3D ioremap_nocache(0xf1001000, 0x1000);
+       void __iomem *gic_cpu_base =3D ioremap_nocache(0xf1002000, 0x1000);

On sh73a0 this is mapped in sh73a0_map_io().
On r8a7740, r8a7778, and r8a7779 the GIC is mapped manually, too.

>   and earlyprintk specified on the command line and
>   CONFIG_DEBUG_RCAR_GEN2_SCIF0 enabled in its config. Without the latter
>   two enhancements there is no console output at all.

DEBUG_RMOBILE_SCIFA0, I assume?
If not, arch/arm/Kconfig.debug must be fixed.
But the ape6evm Mother Board Hardware Specification says SCIFA0
is used for the console...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
