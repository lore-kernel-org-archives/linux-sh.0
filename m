From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2015 11:12:07 +0000
Subject: Re: [PATCH 06/11] ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
Message-Id: <CAMuHMdWajFgatD-aYryuMQZzoQgd08nbz9iL-tW-QOJXHxT2VA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370593329-27559-7-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370593329-27559-7-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 21, 2015 at 5:20 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Cameras, RTC, and ak4643 sound codec.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7778-bockw.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> index 7347223..280a922 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> @@ -59,6 +59,31 @@
>         };
>  };
>
> +&i2c0 {
> +       status = "okay";
> +
> +       ak4643: sound-codec@12 {
> +               compatible = "asahi-kasei,ak4643";
> +               #sound-dai-cells = <0>;
> +               reg = <0x12>;
> +       };
> +
> +       camera@41 {
> +               compatible = "oki,ml86v7667";

JFYI, "ml86v7667" should be added to
Documentation/devicetree/bindings/i2c/trivial-devices.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
