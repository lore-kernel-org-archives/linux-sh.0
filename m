From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 07 Jan 2015 08:19:48 +0000
Subject: Re: [PATCH v3 resend] clk-rcar-gen2: ADSP clock support
Message-Id: <CAMuHMdUui=Ucjo-dxtjkBF2faF4mbvV4EAAT+CyZ_2ix9Nxp+Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <355163371.fkynKV0U5x@wasted.cogentembedded.com>
In-Reply-To: <355163371.fkynKV0U5x-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Jan 6, 2015 at 11:39 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the ADSP clock support to the R-Car generation 2 CPG driver.  This clock
> gets derived from  PLL1.  The layout of the ADSPCKCR register is  similar to
> those of the clocks supported by the 'clk-div6' driver but the divider encoding
> is non-linear, so can't be supported by that driver...
>
> Based on the original patch by Konstantin Kozhevnikov
> <konstantin.kozhevnikov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
