From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Aug 2015 07:13:08 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: Board specific serial port order
Message-Id: <CAMuHMdWWBGt7=omM6LB4UE_8J6XijgWtFHtiKiW4_y_07q_u7A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150807024533.25666.34925.sendpatchset@little-apple>
In-Reply-To: <20150807024533.25666.34925.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Fri, Aug 7, 2015 at 4:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Convert Marzen to use board-specific serial0 and serial1 instead
> of the older shared SoC-specific SCIF index.

Thank you for your patch!

Please note that this is a user-visible change.
Hardcoded "ttySC2" in e.g. kernel boot command line and /etc/inittab must be
changed to ttySC0.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Nevertheless:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- 0001/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ work/arch/arm/boot/dts/r8a7779-marzen.dts   2015-08-07 11:04:37.432366518 +0900
> @@ -19,12 +19,12 @@
>         compatible = "renesas,marzen", "renesas,r8a7779";
>
>         aliases {
> -               serial2 = &scif2;
> -               serial4 = &scif4;
> +               serial0 = &scif2;
> +               serial1 = &scif4;
>         };
>
>         chosen {
> -               bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";

The "console=..." part can indeed be removed, now legacy marzen is gone.

> +               bootargs = "ignore_loglevel root=/dev/nfs ip=on";
>                 stdout-path = &scif2;
>         };




-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
