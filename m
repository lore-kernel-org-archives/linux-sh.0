From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Jul 2015 09:35:25 +0000
Subject: Re: Build regressions/improvements in v4.2-rc1
Message-Id: <CAMuHMdVm+_KyHLx=--0tm5iTgJ4nfMkhxCkoUqhqpbQL6gO82Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436174858-10254-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1436174858-10254-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Jul 6, 2015 at 11:27 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.2-rc1[1] compared to v4.1[2].
>
> Summarized:
>   - build errors: +11/-51

> [1] http://kisskb.ellerman.id.au/kisskb/head/9102/ (all 254 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/9038/ (all 254 configs)
>
>
> *** ERRORS ***
>
> 11 regressions:
>   + /home/kisskb/slave/src/arch/m68k/include/asm/irq.h: error: expected '=
=3D', ',', ';', 'asm' or '__attribute__' before 'void':  =3D> 77:12
>   + /home/kisskb/slave/src/arch/m68k/include/asm/irq.h: error: unknown ty=
pe name 'atomic_t':  =3D> 78:1

m68k-allmodconfig

As G{ue,=C3=BC}nter already reported, fixed by
"staging:lustre: remove irq.h from socklnd.h [2]" by James Simmons
[2] https://lkml.org/lkml/2015/6/25/621

>   + /home/kisskb/slave/src/drivers/net/ethernet/via/via-rhine.c: error: i=
mplicit declaration of function 'pci_iomap' [-Werror=3Dimplicit-function-de=
claration]:  =3D> 1098:2
>   + /home/kisskb/slave/src/drivers/net/ethernet/via/via-rhine.c: error: i=
mplicit declaration of function 'pci_iounmap' [-Werror=3Dimplicit-function-=
declaration]:  =3D> 1119:2

sh-allmodconfig
sh-allyesconfig

sh doesn't use <asm-generic/pci_iomap.h>, and doesn't provide dummies of
pci_io{,un}map().

>   + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  =
=3D> N/A

i386-randconfig

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
