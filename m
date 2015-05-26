From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2015 19:24:03 +0000
Subject: Re: [PATCH 3/3] drm: rcar-du: Convert rcar_du_encoders_init_one() return value to 0/<0
Message-Id: <CAMuHMdWYUnY82cFeeZePOqu3VwLP_gq95a0K4qDJLGx+utLWJQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432652516-15085-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1432652516-15085-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1432652516-15085-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>

On Tue, May 26, 2015 at 5:01 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c

> @@ -640,14 +640,14 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
>         of_node_put(connector);
>
>         if (!ret)
> -               return 1;
> +               return 0;
>
>         if (ret != -EPROBE_DEFER)
>                 dev_warn(rcdu->dev,
>                          "failed to initialize encoder %s (%d), skipping\n",
>                          encoder->full_name, ret);
>
> -       return 0;
> +       return ret;
>  }

Perhaps just

        if (ret && ret != -EPROBE_DEFER)
                dev_warn(...);

       return ret;

?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
