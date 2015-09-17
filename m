From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2015 09:59:38 +0000
Subject: Re: [PATCH v2 10/11] clocksource: sh_cmt: Remove unused 32-bit CMT bindings
Message-Id: <CAMuHMdWqk+dYsOPQTGy+WcE8cVSoUD_0dv8YO7m3nEoXLc-EMQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
	<20150917095501.5369.97124.sendpatchset@little-apple>
In-Reply-To: <20150917095501.5369.97124.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Sep 17, 2015 at 11:55 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Remove the 32-bit CMT compat strings to reduce maintenance burden.
>
> It should be fine to break DT compatibility because the 32-bit
> 32-bit CMT DT binding was never part of any upstream DTS file.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
