From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Dec 2014 13:49:18 +0000
Subject: Re: [RFC 0/2] i2c: sh_mobile: don't regress on deferred probing
Message-Id: <CAMuHMdUwsUakz7S_7xCob4__wR-PXcdpZKTGx0i_6ZatDeSvXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418217709-26392-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Hi Wolfram,

On Wed, Dec 10, 2014 at 2:21 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Okay, here is my take on solving the problem found by Geert. I still don't like
> it much but it is not as bad as I expected it to be ;) Let me know what you
> think.

Thanks, it's indeed less ugly than I would have expected ;-)

Note that in spi-rspi.c and spi-sh-msiof, any error returned by *_request_dma()
is considered an error, and -EPROBE_DEFER is not handled specially.
So it won't retry if the DMA engine driver isn't available, but just use PIO
(until unbind/bind).

Now we have a nice sample implementation, perhaps I should port it to
spi-rspi and spi-sh-msiof, too?

Let's wait and see for other comments...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
