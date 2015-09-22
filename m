From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2015 07:32:46 +0000
Subject: Re: [PATCH v3] pinctrl: sh-pfc: r8a7794: add VIN pin groups
Message-Id: <CAMuHMdW_Rh7yk9hF8JjQAqq81w8se0CK4xH=dZX=mNjgJ87poQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<1628224.IIIbAo3i3M@wasted.cogentembedded.com>
In-Reply-To: <1628224.IIIbAo3i3M@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Sep 22, 2015 at 12:00 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> Add VIN0/1 pin groups to R8A7794 PFC driver.
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> [Sergei: rebased, renamed, added changelog, gathered 12 VIN1 data pins into a
> single pin group, added "vin1_data10" pin group.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
