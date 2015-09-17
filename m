From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2015 08:24:49 +0000
Subject: Re: [PATCH 01/03] irqchip: renesas-irqc: Add r8a7795 IRQC DT documentation
Message-Id: <CAMuHMdUjG8FRFM9GsB+K2pSoJz1QmpckWN243Z5fdxMM9W3Euw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917071230.29299.32326.sendpatchset@little-apple>
	<20150917071239.29299.75042.sendpatchset@little-apple>
In-Reply-To: <20150917071239.29299.75042.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Magnus,

On Thu, Sep 17, 2015 at 9:12 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add r8a7795 to the IRQC DT binding document.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Perhaps you want to clarify this is called "INTC-EX" (not "IRQC") on R-Car
Gen3?

Nevertheless
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
