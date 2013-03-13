From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 17:37:03 +0000
Subject: Re: [PATCH/RFC 06/12] sh-pfc: Skip gpiochip registration when no GPIO resource is found
Message-Id: <CACRpkdbgk0kGZ31PbUVrWnt_JTk8OK-jFToBSnx096_38YetVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 10, 2013 at 7:58 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Boards/platforms that register dedicated GPIO devices will not supply a
> memory resource for GPIOs. Try to locate the GPIO memory resource at
> initialization time, and skip registration of the gpiochip if the
> resource can't be found.

Isn't this a bit misleading? By memory resource we usually understand
something that will pass a struct resource connected to e.g. a
platform_device, whereas...

(...)
> @@ -328,6 +314,7 @@ sh_pfc_add_gpiochip(struct sh_pfc *pfc, int(*setup)(struct sh_pfc_chip *))
>         if (unlikely(!chip))
>                 return ERR_PTR(-ENOMEM);
>
> +       chip->mem = mem;
>         chip->pfc = pfc;
>
>         ret = setup(chip);
> @@ -357,8 +344,24 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
>         if (pfc->info->data_regs = NULL)
>                 return 0;
>
> +       /* Find the memory window that contain the GPIO registers. Boards that
> +        * register a separate GPIO device will not supply a memory resource
> +        * that covers the data registers. In that case don't try to handle
> +        * GPIOs.
> +        */
> +       for (i = 0; i < pfc->num_windows; ++i) {
> +               struct sh_pfc_window *window = &pfc->window[i];
> +
> +               if (pfc->info->data_regs[0].reg >= window->phys &&
> +                   pfc->info->data_regs[0].reg < window->phys + window->size)
> +                       break;
> +       }

This "pfc" isn't quite a "resource". I would call that platform data or
something.

But maybe this could be refactored to actually be a number of
IOMEM resources?

> +       if (i = pfc->num_windows)
> +               return 0;

The ++i and this thing make the code pretty hard for me to
grasp. But maybe I'm just dumb? Could you explain here what
is happening, like with some small comment or so....

Yours,
Linus Walleij
