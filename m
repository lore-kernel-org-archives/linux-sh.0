From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Dec 2014 16:23:53 +0000
Subject: Re: [PATCH] i2c: sh_mobile: optimize irq entry
Message-Id: <CAMuHMdV_LnaiY-dErSC3yfeS+Vd+KRTh=WA2RYMj7mUS=xrQVw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417710049-6894-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1417710049-6894-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

On Thu, Dec 4, 2014 at 5:20 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> We can simply pass the pointer to the private structure to the irq
> routine instead of passing the platform device and looking up its
> driver_data.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
