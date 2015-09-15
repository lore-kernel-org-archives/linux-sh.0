From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Sep 2015 13:58:22 +0000
Subject: Re: [PATCH/RFC v2 2/5] arm64: dts: r8a7795: add EthernetAVB device node
Message-Id: <CAMuHMdVZ7cFSK2Sm87zeoE351WJNaQn8A3Rt2-6EFcdk7Q+u6A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441936996-18437-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1441936996-18437-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 11, 2015 at 4:03 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -297,6 +297,47 @@
>                         /* Empty node for now */
>                 };
>
> +               avb: ethernet@e6800000 {

> +                       clocks = <&mstp8_clks R8A7795_CLK_ETHERAVB>;

Now we have CPG/MSTP Clock Domain support, this lacks

        power-domains = <&cpg_clocks>;

Interestingly, Ethernet seems to work for me while the ETHERAVB MSTP
clock is gated. Strange...

> +                       phy-mode = "rgmii-id";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
