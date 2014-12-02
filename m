From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Dec 2014 21:01:07 +0000
Subject: Re: [PATCH 5/5] ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]
Message-Id: <CAMuHMdWfF_e9h_ECgx_MK7ErRYL1J6o7GSDQOjdcNjQ5WgkS7A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417538146-23350-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417538146-23350-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Dec 2, 2014 at 5:35 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> There's no reason to name the only two available serial ports on the
> board ttySC6 and ttySC7 (apart from confusing userspace, which we should
> try to avoid).
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 990af167c551..bf58c79a6554 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -48,8 +48,8 @@
>         compatible = "renesas,koelsch", "renesas,r8a7791";
>
>         aliases {
> -               serial6 = &scif0;
> -               serial7 = &scif1;
> +               serial0 = &scif0;
> +               serial1 = &scif1;

Actually the labels on my Koelsch read "debug0" and "debug1".
Do we care?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
