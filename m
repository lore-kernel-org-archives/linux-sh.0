From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Jan 2019 09:21:44 +0000
Subject: Re: [PATCH 1/7] sh_eth: rename sh_eth_cpu_data::hw_checksum
Message-Id: <CAMuHMdUYH-UzmiMv6LUT=R3gmHSF7LvcaDXszUixtAeXgjTr_Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com> <b73763ac-5909-c95e-efa5-9d44fba9b9bf@cogentembedded.com>
In-Reply-To: <b73763ac-5909-c95e-efa5-9d44fba9b9bf@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Sergei,

Thanks for your patch!

On Sun, Jan 27, 2019 at 6:40 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Commit 62e04b7e0e3c ("sh_eth: rename 'sh_eth_cpu_data::hw_crc'") renamed
> the field to 'hw_checksum' for the Ether DMAC "intelligent checksum",
> however some Ether MACs implement a simpler checksumming scheme, so that
> name now seems misleading. Rename that filed to 'csmr' as the "intelligent
> checkmum" is always controlled by the CSMR register.

checksum

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Apart from that:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
> +++ net-next/drivers/net/ethernet/renesas/sh_eth.c

> @@ -793,7 +793,7 @@ static struct sh_eth_cpu_data r8a77980_d
>         .no_trimd       = 1,
>         .no_ade         = 1,
>         .xdfar_rw       = 1,
> -       .hw_checksum    = 1,
> +       .csmr           = 1,

Interestingly, I cannot find the CSMR register in the R-Car Gen3 docs?
Not introduced by this patch, though.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
