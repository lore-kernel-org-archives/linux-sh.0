From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Jan 2015 09:39:04 +0000
Subject: Re: [PATCH 1/3 v2][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <CAMuHMdUWbwLmQDNa9EzO=7NLxqv21RBS0cAZP82qXfFBKz+XHQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87iofpf140.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iofpf140.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Jan 30, 2015 at 3:33 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Current rcar-audmapp is assuming that CHCR value are specified
> from platform data or DTS bindings. but, it is possible to
> calculate CHCR settings from src/dst address.
> DTS bindings node can be reduced by this patch.
>
> For this update, new rcar-audmapp assumes DT has SSIU/DTCP/MLM/SCU
> register entry.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
>  - it assums DT has SSIU/DTCP/MLM/SCU reg on DT

Thanks, this is much better. Now the driver only knows about the offsets
w.r.t. the base, like other drivers do.

> --- a/drivers/dma/sh/rcar-audmapp.c
> +++ b/drivers/dma/sh/rcar-audmapp.c
> @@ -44,11 +44,19 @@
>  #define AUDMAPP_SLAVE_NUMBER   256
>  #define AUDMAPP_LEN_MAX                (16 * 1024 * 1024)
>
> +enum AUDMAPP_TGT_ADDR {
> +       AUDMAPP_TGT_SSIU = 0,
> +       AUDMAPP_TGT_DTCP,
> +       AUDMAPP_TGT_MLM,
> +       AUDMAPP_TGT_SCU,
> +
> +       AUDMAPP_TGT_MAX,
> +};
> +

> +               switch (i) {
> +               case AUDMAPP_TGT_SSIU:
> +                       table = ssi_id_table;
> +                       size = ARRAY_SIZE(ssi_id_table);
> +                       break;
> +               case AUDMAPP_TGT_DTCP:
> +                       table = dtcp_id_tabel;
> +                       size = ARRAY_SIZE(dtcp_id_tabel);
> +                       break;
> +               case AUDMAPP_TGT_MLM:
> +                       table = mlm_id_table;
> +                       size = ARRAY_SIZE(mlm_id_table);
> +                       break;
> +               case AUDMAPP_TGT_SCU:
> +                       table = scu_id_table;
> +                       size = ARRAY_SIZE(scu_id_table);
> +                       break;
> +               }
> +       }

You can put this logic in a table with entries like

    { "ssiu", ssi_id_table, ARRAY_SIZE(ssi_id_table)" }

and get rid of the switch() and the enum ...

> +       for (i = 0; i < AUDMAPP_TGT_MAX; i++) {
> +               res = platform_get_resource(pdev, IORESOURCE_MEM, i + 1);
> +               if (!res)
> +                       return -ENODEV;
> +
> +               if (!devm_request_mem_region(dev, res->start, resource_size(res),
> +                                       dev_name(dev)))

... and if the DT has "reg-names", you can use the first field (name) from
the table entry with platform_get_resource_byname().

> +                       return -EIO;
> +
> +               audev->tgt_addr[i] = res->start;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
