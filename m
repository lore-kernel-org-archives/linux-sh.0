From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 29 Nov 2015 19:26:10 +0000
Subject: Re: [PATCH] ravb: add R8A7791 support
Message-Id: <CAMuHMdWE_G2WqsGZEaa4Ck3zziTLGVPfaVdU2gbnLA5zWpmR1w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6051623.qN4lqSyZKg@wasted.cogentembedded.com>
In-Reply-To: <6051623.qN4lqSyZKg-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: "netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Sergei,

On Fri, Nov 27, 2015 at 11:06 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add support  for yet another ARM member of the R-Car family, R-Car M2, also

R-Car M2-W?

> known as R8A7791.

There's also R-Car M2-N, aka R8A7793, but you probably know that ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
