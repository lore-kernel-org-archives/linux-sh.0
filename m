From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Sep 2014 15:25:24 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: sh73a0: Remove unnecessary SoC data allocation
Message-Id: <CAMuHMdWS2POnb3fSoYshaUM8PAuquELwtq=rPGpK_2YnmLtmrA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410355999-13266-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410355999-13266-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Sep 10, 2014 at 3:33 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The SoC data structure allocated at init time only holds a regulator
> pointer that is only used in the init function. Replace it with a local
> variable and get rid of the SoC data structure allocation altogether.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c

> -       pfc->soc_data = data;

Now soc_data is also unused, so it can be removed from struct sh_pfc.
Likewise for sh_pfc_soc_operations.exit(), which only used to exist for
freeing the data associated with soc_data.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
