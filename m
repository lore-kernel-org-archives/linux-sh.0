From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 May 2012 13:10:06 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver
Message-Id: <CACRpkdaVsBswz8uO_nTjbfbzt+T+YcxunpvoDvOn4+=DTwjG3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120511094103.16423.51840.sendpatchset@w520>
In-Reply-To: <20120511094103.16423.51840.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, grant.likely@secretlab.ca, lethal@linux-sh.org, olof@lixom.net

On Fri, May 11, 2012 at 11:41 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> +config GPIO_EM
> + =A0 =A0 =A0 tristate "Emma Mobile GPIO"
> + =A0 =A0 =A0 depends on ARM

ARM really? Why should all ARM systems have the option of configuring in an=
 Emma
controller?

> +static inline unsigned long em_gio_read(struct em_gio_priv *p, int offs)
> +{
> + =A0 =A0 =A0 if (offs < GIO_IDT0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread32(p->base0 + offs);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioread32(p->base1 + (offs - GIO_IDT0=
));
> +}
> +
> +static inline void em_gio_write(struct em_gio_priv *p, int offs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned lo=
ng value)
> +{
> + =A0 =A0 =A0 if (offs < GIO_IDT0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(value, p->base0 + offs);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(value, p->base1 + (offs - GIO_IDT=
0));
> +}

Isn't ioread()/iowrite() some ISA I/O-space operations? What's wrong with
readl_[relaxed] and writel_[relaxed]()?

> +static struct em_gio_priv *irq_to_priv(unsigned int irq)
> +{
> + =A0 =A0 =A0 struct irq_chip *chip =3D irq_get_chip(irq);
> + =A0 =A0 =A0 return container_of(chip, struct em_gio_priv, irq_chip);
> +}

Should this be inline maybe?

> +
> +static void em_gio_irq_disable(struct irq_data *data)
> +{
> + =A0 =A0 =A0 struct em_gio_priv *p =3D irq_to_priv(data->irq);
> + =A0 =A0 =A0 int offset =3D data->irq - p->irq_base;
> +
> + =A0 =A0 =A0 em_gio_write(p, GIO_IDS, 1 << offset);

Suggest:
#include <linux/bitops.h>
em_gio_write(p, GIO_IDS, BIT(offset));

(No big deal, just having fun...)

> +static void em_gio_irq_enable(struct irq_data *data)
> +{
> + =A0 =A0 =A0 struct em_gio_priv *p =3D irq_to_priv(data->irq);
> + =A0 =A0 =A0 int offset =3D data->irq - p->irq_base;
> +
> + =A0 =A0 =A0 em_gio_write(p, GIO_IEN, 1 << offset);
> +}

Dito.

> + =A0 =A0 =A0 /* disable the interrupt in IIA */
> + =A0 =A0 =A0 tmp =3D em_gio_read(p, GIO_IIA);
> + =A0 =A0 =A0 tmp &=3D ~(1 << offset);

Dito.
(etc)

> +static irqreturn_t em_gio_irq_handler(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct em_gio_priv *p =3D dev_id;
> + =A0 =A0 =A0 unsigned long tmp, status;
> + =A0 =A0 =A0 unsigned int offset;
> +
> + =A0 =A0 =A0 status =3D tmp =3D em_gio_read(p, GIO_MST);
> + =A0 =A0 =A0 if (!status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE;
> +
> + =A0 =A0 =A0 while (status) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D __ffs(status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic_handle_irq(p->irq_base + offset);

Pleas use irqdomain to translate the IRQ numbers.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status &=3D ~(1 << offset);
> + =A0 =A0 =A0 }

We've recently patched a log of IRQ handlers to re-read the IRQ
status register on each iteration. I suspect that is needed here
as well.

while (status =3D em_gio_read(p, GIO_MST)) {

> +
> + =A0 =A0 =A0 em_gio_write(p, GIO_IIR, tmp);

And then I guess this would need to be moved into the
loop to clear one bit at the time instead.

> +static struct em_gio_priv *gpio_to_priv(struct gpio_chip *chip)
> +{
> + =A0 =A0 =A0 return container_of(chip, struct em_gio_priv, gpio_chip);
> +}

inline?

> +static int __devinit em_gio_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct gpio_em_config *pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 struct em_gio_priv *p;
> + =A0 =A0 =A0 struct resource *io[2], *irq[2];
> + =A0 =A0 =A0 struct gpio_chip *gpio_chip;
> + =A0 =A0 =A0 struct irq_chip *irq_chip;
> + =A0 =A0 =A0 const char *name =3D dev_name(&pdev->dev);
> + =A0 =A0 =A0 int k, ret;
> +
> + =A0 =A0 =A0 p =3D kzalloc(sizeof(*p), GFP_KERNEL);

Use devm_kzalloc() and friends?

Which makes the error path all much simpler.

> + =A0 =A0 =A0 p->base0 =3D ioremap_nocache(io[0]->start, resource_size(io=
[0]));
> + =A0 =A0 =A0 if (!p->base0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap low I/=
O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 p->base1 =3D ioremap_nocache(io[1]->start, resource_size(io=
[1]));
> + =A0 =A0 =A0 if (!p->base1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to remap high I=
/O memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
> + =A0 =A0 =A0 }

I usually also request the memory region request_mem_region(),
I don't know if I'm particularly picky though.

Isn't there a new nice inline that will both request and
remap a piece of memory?

> + =A0 =A0 =A0 p->irq_base =3D irq_alloc_descs(pdata->irq_base, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 pdata->number_of_pins, numa_node_id());
> + =A0 =A0 =A0 if (IS_ERR_VALUE(p->irq_base)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot get irq_desc\n"=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("gio: hw base =3D %d, nr =3D %d, sw base =3D %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->gpio_base, pdata->number_of_pins,=
 p->irq_base);
> +
> + =A0 =A0 =A0 irq_chip->name =3D name;
> + =A0 =A0 =A0 irq_chip->irq_mask =3D em_gio_irq_disable;
> + =A0 =A0 =A0 irq_chip->irq_unmask =3D em_gio_irq_enable;
> + =A0 =A0 =A0 irq_chip->irq_enable =3D em_gio_irq_enable;
> + =A0 =A0 =A0 irq_chip->irq_disable =3D em_gio_irq_disable;
> + =A0 =A0 =A0 irq_chip->irq_set_type =3D em_gio_irq_set_type;
> + =A0 =A0 =A0 irq_chip->flags =3D IRQCHIP_SKIP_SET_WAKE;
> +
> + =A0 =A0 =A0 for (k =3D p->irq_base; k < (p->irq_base + pdata->number_of=
_pins); k++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_set_chip_and_handler_name(k, irq_chip, =
handle_level_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 "level");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_flags(k, IRQF_VALID); /* kill me no=
w */
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (request_irq(irq[0]->start, em_gio_irq_handler, 0, name,=
 p)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request low =
IRQ\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (request_irq(irq[1]->start, em_gio_irq_handler, 0, name,=
 p)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request high=
 IRQ\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err5;
> + =A0 =A0 =A0 }

Can you try to use irqdomain for IRQ translation of the base?

Yours,
Linus Walleij
