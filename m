From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Nov 2014 17:08:25 +0000
Subject: Re: [PATCH] i2c: core: Fix probing of i2c slaves without interrupts
Message-Id: <CAOMZO5BsfCfP+bMfYWZ9C=Sp0sWkEr6WoRRygw18EfW2T_k3oQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416224580-4782-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416224580-4782-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Nov 17, 2014 at 9:43 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Since commit 2fd36c55264926e2 ("i2c: core: Map OF IRQ at probe time"),
> i2c slaves without interrupts (e.g. da9210 and at24 on r8a7791/koelsch)
> fail to probe:
>
>     at24: probe of 2-0050 failed with error -22
>
>     da9210: probe of 6-0068 failed with error -22
>
> This happens because the call to of_irq_get() in i2c_device_probe()
> returns -EINVAL.
>
> If a device node does not have an "interrupts" property,
> of_irq_parse_one() fails. Unlike irq_of_parse_and_map(), of_irq_get()
> does not ignore errors from of_irq_parse_one(), but forwards them.
>
> Make i2c_device_probe() ignore all errors but -EPROBE_DEFER to fix this,
> just like platform_get_irq() and platform_get_irq_byname() already do.
>
> Fixes: 2fd36c55264926e2 ("i2c: core: Map OF IRQ at probe time")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

With this patch applied my codec and PMIC can be probed again:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
