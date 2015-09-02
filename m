From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 14:58:19 +0000
Subject: Re: [PATCH 8/9] sh-pfc: Initial R8A7795 PFC support
Message-Id: <CAMuHMdW58Z7BKpADWCz_ofoxn_gtjvaGLCr=9r2-OHzPo=4ugA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
	<878u8pjmfb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u8pjmfb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Wed, Sep 2, 2015 at 9:47 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Add PFC base support for the R8A7795 SoC.
>
> Original patch was created by Takeshi Kihara, and
> Kuninori Morimoto updated it.

> --- /dev/null
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c

> +/* IPSRx */            /* 0 */                 /* 1 */         /* 2 */                 /* 3 */                         /* 4 */         /* 5 */         /* 6 */                 /* 7 */         /* 8 */                 /* 9 */         /* A */         /* B */         /* C - E */
> +#define IP0_3_0                FM(AVB_MDC)             F_(0,0)         FM(MSIOF2_SS2_C)        F_(0,0)                         F_(0,0)         F_(0,0)         F_(0,0)                 F_(0,0)         F_(0,0)                 F_(0,0)         F_(0,0)         F_(0,0)         F_(0,0) F_(0,0) F_(0,0)

The 16th column ("F") is missing for all IPx_y_z macros.

Each IPx_y_z macro is supposed to provide the values for a 4-bit field,
i.e. it should provide 16 values, not 15.

Without this, only the functions selected by IPSRx[31:28] are configured
correctly. For other functions, the wrong values and fields are written.

E.g. for SCIF2, 0xa resp. 0x9 were written to IPSR12 fields 5 resp. 6,
instead of 0 to both IPSR12 fields 6 and 7, breaking console input.

I've sent a patch in the thread where I reported the console problem initially
("Re: topic/gen3-latest").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
