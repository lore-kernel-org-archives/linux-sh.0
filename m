From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 08:37:11 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Convert to platform_get_*()
Message-Id: <CACRpkdYAtrp-tk1+0WGS3UJy3ZJvKAMkAF=Kky3MwHBd4Fk=sg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435225193-10078-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435225193-10078-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

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
> ---
> This patch is against next-20150625
>
> "[PATCH] [RFC] OF: probe order dependency aware of_platform_populate"
> (https://www.marc.info/?l=DEvicetree&m=141873189825553&w=3D1) is a first
> step, but it doesn't postpone the instantiation of the pfc.
>
> Tested:
>   - r8a73a4/ape6evm (with pfc before/after irqc in DT),
>   - sh73a0/kzm9g (with pfc before/after intc-irqpin in DT).
>
> Regression-tested:
>   - r8a7791/koelsch (pfc doesn't have interrupts),
>   - r8a7740/armadillo (pfc after intc-irqpin in DT),
>   - r8a7740/armadillo-legacy (gpio-keys wired to pfc),
>   - sh73a0/kzm9g-legacy (gpio-keys not wired to pfc).
>
> Compile-tested:
>   - sh/se7724_defconfig.

Waiting for Laurent's ACK on this.

Yours,
Linus Walleij
