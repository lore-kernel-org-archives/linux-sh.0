From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 16 May 2012 10:09:54 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <CANqRtoSSEb9jwEmvbhBuyHp-9BfUSRabQzqjrrVGTFDP-AHutQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520>
	<20120516072927.GN7988@linux-sh.org>
In-Reply-To: <20120516072927.GN7988@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, grant.likely@secretlab.ca, olof@lixom.net

On Wed, May 16, 2012 at 4:29 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, May 16, 2012 at 12:43:33AM +0900, Magnus Damm wrote:
>> +static int __devinit em_gio_irq_domain_init(struct em_gio_priv *p)
>> +{
>> + =A0 =A0 struct platform_device *pdev =3D p->pdev;
>> + =A0 =A0 struct gpio_em_config *pdata =3D pdev->dev.platform_data;
>> +
>> + =A0 =A0 p->irq_base =3D irq_alloc_descs(pdata->irq_base, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pd=
ata->number_of_pins, numa_node_id());
>> + =A0 =A0 if (IS_ERR_VALUE(p->irq_base)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "cannot get irq_desc\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>> + =A0 =A0 }
>> + =A0 =A0 pr_debug("gio: hw base =3D %d, nr =3D %d, sw base =3D %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->gpio_base, pdata->number_of_pins, p-=
>irq_base);
>> +
>> + =A0 =A0 p->irq_domain =3D irq_domain_add_legacy(pdev->dev.of_node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 pdata->number_of_pins,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 p->irq_base, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &em_gio_irq_domain_ops, p);
>> + =A0 =A0 if (!p->irq_domain) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 irq_free_descs(p->irq_base, pdata->number_of_p=
ins);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
> There's no reason to use a legacy domain here, this is a pretty
> straightforward candidate for a linear map. You can use ->to_irq() for
> the irq_create_mapping() invocation and then later look up the IRQ with
> irq_linear_revmap().

I believe I have my reasons for using the legacy domain, but I agree
that it is possible to use irq_create_mapping() and
irq_linear_revmap() in the case of linear mappings. Actually, it's
exactly what my DT prototype patch does. Please see this patch that
adds linear irq domain support in the DT case, and the patch
description also includes information about when the legacy irq domain
is used and when the linear one is:

http://groups.google.com/group/linux.kernel/browse_thread/thread/25a8d7e4d3=
11ab59?pli=3D1

> irq_domain_add_legacy() exists for existing static ranges, which there is
> really no reason to be adding in new board/platform support. You don't
> have to worry about virq overlap since irq_create_mapping() already wraps
> on top of irq_alloc_desc_xxx() for lookup.

So I intentionally made use of the legacy domain in the non-DT case.
This because I want to let the SoC code set the static IRQ ranges via
platform data.
>
>> +static void __devexit em_gio_irq_domain_cleanup(struct em_gio_priv *p)
>> +{
>> + =A0 =A0 struct gpio_em_config *pdata =3D p->pdev->dev.platform_data;
>> +
>> + =A0 =A0 irq_free_descs(p->irq_base, pdata->number_of_pins);
>> + =A0 =A0 /* FIXME: irq domain wants to be freed! */
>> +}
>> +
> After which point you can iterate and dispose of the virq mappings with
> irq_dispose_mapping(). The lack of irq domain teardown functionality does
> need to be addressed though.

I can't see any GPIO driver doing that yet, but yes, that is possible.

Thanks,

/ magnus
