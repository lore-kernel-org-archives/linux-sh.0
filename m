From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Aug 2015 15:39:25 +0000
Subject: Re: [PATCH 2/2] sh_eth: propagate platform_get_irq() error upstream
Message-Id: <CAMuHMdUQv5OwnD9FNxnuXmCGn9Aaa2DLv27XMRTZhCSktiF2Lw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9944836.IRPmWk4iN8@wasted.cogentembedded.com>
	<1774140.R12mtes975@wasted.cogentembedded.com>
In-Reply-To: <1774140.R12mtes975@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On Fri, Aug 28, 2015 at 3:56 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The driver overrides the error returned by platform_get_irq() with -ENODEV
> which e.g. precludes the deferred  probing from working. Propagate the real
> error code to the driver core instead.
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
