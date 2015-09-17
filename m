From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2015 10:04:14 +0000
Subject: Re: [PATCH v2 11/11] devicetree: bindings: Remove deprecated properties
Message-Id: <CAMuHMdV5rgk0rcCz-8w6Jmq66iAnbA6RTUoFyXNU9CV6PcU4Dw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917095325.5369.73893.sendpatchset@little-apple>
	<20150917095511.5369.41259.sendpatchset@little-apple>
In-Reply-To: <20150917095511.5369.41259.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Sep 17, 2015 at 11:55 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> The deprecated DT properies are part of the GIT history,

properties

> no need to keep them around any longer.

They're still in the driver because in-the-field R-Car Gen2 DTSes use them,
right? You may add a comment in the driver, to prevent a janitor from
re-adding them to the bindings.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Nevertheless
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
