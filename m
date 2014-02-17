From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Feb 2014 12:14:53 +0000
Subject: Re: [PATCH v2] MAINTAINERS: Mark SuperH orphan
Message-Id: <CAMuHMdXG+L1umNA1eBMizJnvw599Z-qbcSpSt8PsNyk1YESBjA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392586619-27018-1-git-send-email-geert@linux-m68k.org>
	<20140217115540.GA23509@verge.net.au>
In-Reply-To: <20140217115540.GA23509@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Paul Mundt <paul.mundt@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Bolle <pebolle@tiscali.nl>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Hi Simon,

On Mon, Feb 17, 2014 at 12:55 PM, Simon Horman <horms@verge.net.au> wrote:
> The change includes the maintenance of drivers/sh/ and I believe that
> the CPG driver in drivers/sh/clk, the INTC driver in drivers/sh/intc and
> the code in pm_runtime.c is used by Renesas ARM based SoCs.
> It seems somewhat unsatisfactory to orphan that code.

Indeed, everything but drivers/sh/intc/balancing.c, drivers/sh/maple/
and drivers/sh/superhyway/ is also used on ARM/SHMOBILE.
But that's in-se unrelated to marking the SuperH architecture as orphaned.

> What I propose is adding entries for them, either stand-alone or part of
> the SHMOBILE (a.k.a. Renesas ARM based SoCs) entry so that are maintained
> by someone.  I am happy for my name to go against that.

Apparently the "ARM/SHMOBILE ARM ARCHITECTURE" entry already
has drivers/sh/ listed, so you (and Magnus) are already in charge.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
