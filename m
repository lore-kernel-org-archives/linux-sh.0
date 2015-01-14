From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Jan 2015 14:20:59 +0000
Subject: Re: [PATCH] dmaengine: of: bail out early if "dmas" property is not present
Message-Id: <CAMuHMdWw6mu1+Da6+HSPrAcrkDc84m2pe=fA+8nL6Zn=3AY=fA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421244988-11794-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1421244988-11794-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jan 14, 2015 at 3:16 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> And don't print an error: not configured is not an error.
>
> Reported-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
