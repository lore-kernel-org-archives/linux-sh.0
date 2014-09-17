From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Sep 2014 14:51:20 +0000
Subject: Re: [PATCH 8/8] ARM: shmobile: koelsch: Enable DU device in DT
Message-Id: <CAMuHMdWovzXNgmHpDD=Ld-rZe98LdjWeWAbTrtGjrYw2QNh6DA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410963073-3176-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410963073-3176-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Sep 17, 2014 at 4:11 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -209,6 +209,46 @@
>                 states = <3300000 1
>                           1800000 0>;
>         };
> +
> +       panel {
> +               compatible = "mitsubishi,aa104xd12", "panel-dpi";

This device is not present on a stock Koelsch, so I don't think it belongs
in this DTS.

> +
> +               width-mm = <210>;
> +               height-mm = <158>;
> +
> +               panel-timing {
> +                       /* 1024x768 @65Hz */
> +                       clock-frequency = <65000000>;
> +                       hactive = <1024>;
> +                       vactive = <768>;
> +                       hsync-len = <136>;
> +                       hfront-porch = <20>;
> +                       hback-porch = <160>;
> +                       vfront-porch = <3>;
> +                       vback-porch = <29>;
> +                       vsync-len = <6>;
> +               };
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&du_out_lvds0>;
> +                       };
> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
