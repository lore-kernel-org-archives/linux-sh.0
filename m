From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Mar 2014 16:23:37 +0000
Subject: Re: [PATCH 2/3] spi: sh-msiof: Convert to spi core auto_runtime_pm framework
Message-Id: <CAMuHMdVOUuFsObEag_MwUT_jaqfOHMEcUScrkbaTEitmyJr+NQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org>
	<1394531952-3905-2-git-send-email-geert@linux-m68k.org>
	<1802214.NxZUiJcWLG@avalon>
In-Reply-To: <1802214.NxZUiJcWLG@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi Laurent,

On Tue, Mar 11, 2014 at 4:55 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Does this require drivers/sh/pm_runtime.c to be compiled in ?

Let's check...

My koelsch-legacy kernel has drivers/sh/pm_runtime.c compiled in.
My koelsch-reference kernel hasn't.

However, under the -reference kernel many MSTP clocks (incl. MSIOF)
seem to be enabled all the time, while under -legacy they are enabled and
disabled on demand.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
