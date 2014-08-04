From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Aug 2014 13:33:34 +0000
Subject: Re: SH 7619 CHCR values
Message-Id: <CAMuHMdW=zbGnTEY0EnaNU_Z1hRjaF0QaKR8C-6qVJt_bQkpr1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <760230076.57448.1406841700324.open-xchange@webmail.nmp.skynet.be>
In-Reply-To: <760230076.57448.1406841700324.open-xchange@webmail.nmp.skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabian Frederick <fabf@skynet.be>
Cc: Richard Weinberger <richard@nod.at>, Paul Bolle <pebolle@tiscali.nl>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jul 31, 2014 at 11:21 PM, Fabian Frederick <fabf@skynet.be> wrote:
>  Could you tell me where I could find SH 7619 CHCR values in order to solve the
> following errors ?
>
> arch/sh/drivers/dma/dma-sh.c: In function 'calc_xmit_shift':
> arch/sh/drivers/dma/dma-sh.c:97:21: error: 'CHCR_TS_LOW_MASK' undeclared (first
> use in this function)
> arch/sh/drivers/dma/dma-sh.c:97:21: note: each undeclared identifier is reported
> only once for each function it appears in
> arch/sh/drivers/dma/dma-sh.c:97:42: error: 'CHCR_TS_LOW_SHIFT' undeclared (first
> use in this function)
> arch/sh/drivers/dma/dma-sh.c:98:12: error: 'CHCR_TS_HIGH_MASK' undeclared (first
> use in this function)
> arch/sh/drivers/dma/dma-sh.c:98:34: error: 'CHCR_TS_HIGH_SHIFT' undeclared
> (first use in this function)
> arch/sh/drivers/dma/dma-sh.c: In function 'sh_dmac_configure_channel':
> arch/sh/drivers/dma/dma-sh.c:145:10: error: 'CHCR_TS_LOW_SHIFT' undeclared
> (first use in this function)
> arch/sh/drivers/dma/dma-sh.c:145:10: error: 'CHCR_TS_HIGH_SHIFT' undeclared
> (first use in this function)
>
> I guess it should be added in a new dma-register.h in arch/sh/include/cpu-sh2 ?

Google told me:
http://www.alldatasheet.com/datasheet-pdf/pdf/249585/RENESAS/SH7619.html

The values seem to be the same as for sh3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
