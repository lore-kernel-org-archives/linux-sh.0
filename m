From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Apr 2014 10:45:04 +0000
Subject: Re: [PATCH 1/6] mmc: sh-mmcif: print bus clock rate on probe
Message-Id: <CAMuHMdXSif2ZhiQphW0cMeuRgM7t6fWR2=JVqxL8QQX505wuwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
	<1396347954-13740-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396347954-13740-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk

On Tue, Apr 1, 2014 at 12:25 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> -       dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
> +       dev_info(&pdev->dev, "driver version %s, clock rate %ldMHz\n",
> +                DRIVER_VERSION, clk_get_rate(host->hclk) / 1000000);

%lu (soon the clocks won't fit in unsigned 32-bit anymore, though...)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
