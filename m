From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 30 Mar 2015 11:38:56 +0000
Subject: Fwd: [PATCH 2/3] pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
Message-Id: <CAO3366wrMFNc0YrBMqKFdy6uh6WBdkn47j86PSv91s67na8sGg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 30, 2015 at 12:04 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Fri, Mar 20, 2015 at 1:30 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c

[...]
>
> > +static unsigned int r8a7778_pinmux_get_bias(struct sh_pfc *pfc,
> > +                                           unsigned int pin)
> > +{
> > +       void __iomem *addr;
> > +
> > +       BUG_ON(!pullups[pin].reg);
>
> This looks a bit strong to me.
>
> As pinconf_ops.pin_config_[gs]et() do return error codes, perhaps
> sh_pfc_soc_operations.[gs]et_bias() should be changed to allow the
> return of error codes, too, so you can return -ENOTSUPP here?
>
> If you really feel the need to scream, I'd use WARN_ON_ONCE() instead.


I don't know... These methods are only supposed to be called for pins
that are configured as biasable (with an SH_PFC_PIN_CFG_PULL_UP flag,
for instance). If a pin isn't, sh_pfc_pinconf_get() returns -ENOTSUPP.

So if we encounter a pin we don't know how to handle, either the flag
is set incorrectly, or the table is missing an entry. I'd call either
of these cases a bug.

CU
Uli
