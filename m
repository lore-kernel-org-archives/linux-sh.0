From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 03 Jan 2014 12:04:33 +0000
Subject: Re: [PATCH v2] sh_eth: coding style fixes
Message-Id: <CAMuHMdX-0ZkGqewJ91CN7xWpmzmv-6XSXd0j_g0yT6VNRPPKZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201401031552.22847.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201401031552.22847.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Jan 3, 2014 at 1:52 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> @@ -2739,7 +2734,7 @@ static int sh_eth_drv_probe(struct platf
>
>         /* print device information */
>         pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
> -              (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
> +               (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);

Hint for the next patch: use 0x%lx and kill the cast.

Thx! ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
