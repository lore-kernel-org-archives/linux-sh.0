From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 22 Jun 2014 08:06:08 +0000
Subject: Re: [PATCH 5/5] spi: sh-msiof: Add DMA support
Message-Id: <CAMuHMdXB4U=tkGgV=UE5KRBgP7jqyB8Wpjn1x6ei-wq-MYkLqQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1403259380-13634-6-git-send-email-geert+renesas@glider.be>
	<20140621101959.GM5099@sirena.org.uk>
In-Reply-To: <20140621101959.GM5099-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Mark,

On Sat, Jun 21, 2014 at 12:19 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jun 20, 2014 at 12:16:20PM +0200, Geert Uytterhoeven wrote:
>> Add DMA support to the MSIOF driver using platform data.
>
> This doesn't apply against current code, can you please check and
> resend?

My patches were based on your for-next branch, which has
commit 1e8231b79ccbb3e6e7b3f6af9f998dca16b00efe
Author: Jingoo Han <jg1.han@samsung.com>
Date:   Tue Apr 29 17:21:25 2014 +0900

    spi: sh-msiof: remove unnecessary OOM messages

(from topic/cleanup), but topic/sh-msiof hasn't.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
