From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 Aug 2014 14:34:40 +0000
Subject: Re: [PATCH 1/2] spi: rspi: Fix leaking of unused DMA descriptors
Message-Id: <CAMuHMdX4bDMogeSwmd3bxm_fKpjouxZJFT_dd5ErxgJkZ2U=cA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405094802-14401-1-git-send-email-geert+renesas@glider.be>
	<20140714185830.GE6800@sirena.org.uk>
In-Reply-To: <20140714185830.GE6800-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Mark,

On Mon, Jul 14, 2014 at 8:58 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 11, 2014 at 06:06:41PM +0200, Geert Uytterhoeven wrote:
>> If dmaengine_prep_slave_sg() or dmaengine_submit() fail, we may leak
>> unused DMA descriptors.
>
> This doesn't apply, I guess it may depend on some of your other DMA
> related patches but it's not immediately obvious and it's not been sent
> as part of a series.  Can you please check and/or clarify?

Indeed, this (and the rspi one) depended on the two "Handle
dmaengine_prep_slave_single() failures gracefully" patches.

Unless you recover them from e.g. patchwork, I'll resend them with my
next batch.

Sorry for the fuzz.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
