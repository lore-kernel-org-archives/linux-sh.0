From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 May 2012 06:20:39 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <CANqRtoRW4xtRkCYvDs89XD82R8ac_kAFdLp3tSfUv8HufTS1cQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520>
	<1337099546.7050.9.camel@joe2Laptop>
In-Reply-To: <1337099546.7050.9.camel@joe2Laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, linus.walleij@stericsson.com, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, grant.likely@secretlab.ca, lethal@linux-sh.org, olof@lixom.net

Hi Joe,

On Wed, May 16, 2012 at 1:32 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2012-05-16 at 00:43 +0900, Magnus Damm wrote:
>> This patch is V2 of the Emma Mobile GPIO driver.
>
> Just some trivial comments

Nice with feedback, thank you!

>> +++ work/drivers/gpio/gpio-em.c =A0 =A0 =A0 2012-05-16 00:07:20.00000000=
0 +0900
> []
>
> Adding pr_fmt before any #include prefixes all pr_<level> messages.
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Ok, good idea, will add.

>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
> []
>> +static int em_gio_irq_set_type(struct irq_data *d, unsigned int type)
>> +{
> []
>> + =A0 =A0 pr_debug("gio: sense irq =3D %d, mode =3D %d\n", offset, value=
);
>
> =A0 =A0 =A0 =A0pr_debug("sense irq =3D %d, mode =3D %d\n", offset, value);

Right, with the above pr_fmt() line.

> []
>> +static void __em_gio_set(struct gpio_chip *chip, unsigned int reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned shift, int value)
>> +{
>> + =A0 =A0 /* upper 16 bits contains mask and lower 16 actual value */
>> + =A0 =A0 em_gio_write(gpio_to_priv(chip), reg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << (shift + 16)) | (value << shi=
ft));
>> +}
>
> comment doesn't seem to match code unless
> value is a single bit, then value should
> probably be renamed.

Perhaps a bit odd, but the argument variable names match the GPIO API:

[include/linux/gpio.h]
..
static inline void gpio_set_value(unsigned int gpio, int value)

So I prefer to keep them as-is.

>> +static int em_gio_irq_domain_map(struct irq_domain *h, unsigned int vir=
q,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_numb=
er_t hw)
>> +{
>> + =A0 =A0 struct em_gio_priv *p =3D h->host_data;
>> +
>> + =A0 =A0 pr_debug("gio: map hw irq =3D %d, virq =3D %d\n", (int)hw, vir=
q);
>
> =A0 =A0 =A0 =A0pr_debug("map hw irq =3D %d, virq =3D %d\n", (int)hw, virq)
>
>> +static struct irq_domain_ops em_gio_irq_domain_ops =3D {
>
> const?

Sure, why not?

>> +static int __devinit em_gio_probe(struct platform_device *pdev)
> []
>> + =A0 =A0 p =3D kzalloc(sizeof(*p), GFP_KERNEL);
>> + =A0 =A0 if (!p) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate driver=
 data\n");
>
> OOM messages aren't necessary as k.alloc failures
> produce a dump_stack.

Ok!

Thanks for your feedback, I will address them in a separate
incremental feature patch.

/ magnus
