From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2015 09:38:13 +0000
Subject: Re: [PATCH 01/08] devicetree: bindings: Remove sh7372 CMT binding
Message-Id: <CAMuHMdUTh0bHVgEZ+W31Q2A=37k4k+oGssWAdXSCZ=bt1My71g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
	<20150621080915.10187.97464.sendpatchset@little-apple>
In-Reply-To: <20150621080915.10187.97464.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Magnus,

On Sun, Jun 21, 2015 at 10:09 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Remove the sh7372 CMT compat string to reduce maintenance burden.
>
> It should be fine to break DT compatibility because:
> 1) The sh7372 SoC support has been removed from upstream
> 2) The sh7372 CMT DT binding was never part of upstream DTS
> 3) The CMT driver never matches on the sh7372 binding
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  Documentation/devicetree/bindings/timer/renesas,cmt.txt |    2 --
>  1 file changed, 2 deletions(-)
>
> --- 0001/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> +++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt        2015-06-20 13:47:59.922366518 +0900
> @@ -32,8 +32,6 @@ Required Properties:
>                 (CMT[234] on sh7372, sh73a0 and r8a7740)
>                 This is a fallback for the above renesas,cmt-32-fast-* entries.
>
> -    - "renesas,cmt-48-sh7372" for the sh7372 48-bit CMT
> -               (CMT1)

You forgot to remove the reference to sh7372 in the "renesas,cmt-48"
fallback section, and the "renesas,cmt-32-sh7372" and
"renesas,cmt-32-fast-sh7372" bindings.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
