From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 09:08:16 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Convert to platform_get_*()
Message-Id: <CACRpkdbp6FccWH5+8FT=y_Es389_oCkVp9-Wveb1HG73a1719A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435225193-10078-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435225193-10078-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jun 25, 2015 at 11:39 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If the pin function controller (which can be a GPIO controller) is
> instantiated before the interrupt controllers, due to the ordering in
> the DTS, the irq domains for the interrupt controllers referenced by its
> "interrupts-extended" property cannot be found yet:
>
>     irq: no irq domain found for /interrupt-controller@e61c0000 !
>
> As the sh-pfc driver accesses the platform device's resources directly,
> it cannot find the (optional) IRQ resources, and thinks no interrupts
> are available. This may lead to failures later, when GPIOs are used as
> interupts:
>
>     gpio-keys keyboard: Unable to claim irq 0; error -22
>     gpio-keys: probe of keyboard failed with error -22
>
> To fix this, add support for deferred probing to sh-pfc, by converting
> the driver from direct platform device resource access to using the
> platform_get_resource() and platform_get_irq() helpers.
>
> Note that while this fixes the root cause worked around by commit
> e4ba0a9bddff3ba5 ("ARM: shmobile: r8a73a4: Move pfc node to work around
> probe ordering bug"), I strongly recommend against reverting the
> workaround now, as this would lead to lots of probe deferrals in drivers
> relying on pinctrl. This may be reconsidered once the DT code starts
> taking into account phandle dependencies during device instantation.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied with Laurent's ACK.

Yours,
Linus Walleij
