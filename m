From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Dec 2015 10:27:36 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups
Message-Id: <CAMuHMdX_XDdhV1GXhUkppvHKFeJDno02B=2mvH_6gkJK_hyZMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<4277494.6KPmCjaGvB@wasted.cogentembedded.com>
In-Reply-To: <4277494.6KPmCjaGvB@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Mon, Dec 14, 2015 at 11:06 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the EtherAVB pin groups to the R8A7791 PFC driver.
>
> Also add the copyright for all the Cogent Embedded's past work on this file.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thank you, queued for v4.5.

> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.
>
> Changes in version 2:
> - added AVB_TX_ER pin to the AVB MII group;
> - added Cogent Embedded's copyright;
> - refreshed the patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
