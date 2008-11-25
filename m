From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 25 Nov 2008 18:47:27 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081125204821.11718952.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__25_Nov_2008_20_48_21_+0100_mm2ilheAeZFdL6pm"
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Tue__25_Nov_2008_20_48_21_+0100_mm2ilheAeZFdL6pm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Nov 2008 02:54:26 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Tue, Nov 25, 2008 at 07:40:39PM +0100, Kristoffer Ericson wrote:
> > On Sat, 22 Nov 2008 16:49:52 +0000
> > Matt Fleming <mjf@gentoo.org> wrote:
> >=20
> > > On Fri, Nov 21, 2008 at 04:34:45PM +0900, Paul Mundt wrote:
> > > >=20
> > > > So, pending a rewrite of hd64461, we should probably just leave the
> > > > __do_IRQ() dispatch as an option there, until someone gets around to
> > > > rewriting that mess. I will conditionalize it on !HD64461 for now.
> > >=20
> > > Kristoffer can you try the attached patch, please? It compiles OK but=
 I
> > > haven't had chance to test it on actual hardware.
> >=20
> > Sorry for the late reply, been having issues with my internet
> > connection. Anyhow, not sure if this solves anything since
> > I've already rewritten the IRQ part to be alot more
> > sensible. Basicly only wanting to get FB going
> > before I push it upstreams.
> >=20
> > What you think Paul?
> >=20
> Matt's patch should allow us to fix the __do_IRQ() problem, if you want
> to build on top of that, that is fine, but it is still helpful to know
> whether it works for you with CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ enabled.
>=20
> The only problematic thing I see is the lack of the base IRQ factoring,
> only the chained handlers for the multiplexed sources are defined. This
> is the way it should be, but it is possible that there will have to be
> another handler set up to at least get the hd64461 IRQ firing. This is
> the basis for that silly i =3D=3D 16 thing in the old demux code. Any user
> that depends on that behaviour deserves to be broken, though.

I've attached the code I got so far. You can atleast see my=20
approach to the issue.

 /*
  *
  * MFD driver for the Hitachi HD64461 companion chip
  *
  * HD64461 chip contains 8 interrupts handled by an demuxer
  * It controls pcmcia x 2, UART, IRDA, FB.
  *
  *
  * (C) 2008 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
  *
  *
  */
#include <linux/sched.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/param.h>
#include <linux/interrupt.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <linux/errno.h>
#include <linux/spinlock.h>
#include <linux/platform_device.h>
#include <linux/hd64461.h>

#include <asm/io.h>
#include <asm/irq.h>

struct hd64461_irq_list		*irq_master;
struct hd64461_devdata		*hd_master;

void hd64461_io_write16(u16 value, unsigned int reg)
{
    iowrite16(value, (hd_master->io_start + reg));
}

void hd64461_io_write8(u8 value, unsigned int reg)
{
    iowrite8(value, (hd_master->io_start + reg));
}

u16 hd64461_io_read16(unsigned int reg)
{
    return(ioread16(hd_master->io_start + reg));
}

u8 hd64461_io_read8(unsigned int reg)
{
    return(ioread8(hd_master->io_start + reg));
}
EXPORT_SYMBOL(hd64461_io_write16);
EXPORT_SYMBOL(hd64461_io_write8);
EXPORT_SYMBOL(hd64461_io_read16);
EXPORT_SYMBOL(hd64461_io_read8);

/*
 *	hd64461_irq_demask - find out what number our irq_mask equals
 *
 *=09
 *
 *	returns number between 1-16
 */
unsigned int hd64461_irq_demask(u16 mask)
{
    unsigned int i;

	for (i =3D 1; i < 16; i++)
		if ((1 << i) & mask)
		break;

	return i;
}

/*
 *	hd64461_irq_set_hand - set handler for hd64461 source
 *
 *
 *
 */
unsigned int hd64461_irq_set_hand(u16 mask, void (*fn)(int, void *))
{
    u16	number;
   =20
    number =3D hd64461_irq_demask(mask);
   =20
    if (irq_master->irq[number].fn =3D=3D NULL)
	irq_master->irq[number].fn =3D fn;
   =20
    return 0;
}   =20

/*
 *	hd64461_irq_enable - make the hd64461 source active
 *
 *	!note, handler should be installed before this!
 */
unsigned int hd64461_irq_enable(u16 mask)
{
    u16	nimr;
    u16 number;
   =20
    nimr =3D hd64461_io_read16(HD64461_NIMR);
    nimr |=3D mask;
   =20
    hd64461_io_write16(nimr, HD64461_NIMR);
   =20
    number =3D hd64461_irq_demask(mask);
    irq_master->irq[number].irq_enabled =3D 1;
    irq_master->irq[number].irq_mask =3D mask;
	   =20
    return 0;
}	=20

/*
 *
 *	hd64461_irq_disable - make the hd64461 source inactive
 */
unsigned int hd64461_irq_disable(u16 mask)
{
    u16 nimr;
    u16 number;
   =20
    nimr =3D hd64461_io_read16(HD64461_NIMR);
    nimr &=3D ~mask;
    hd64461_io_write16(nimr, HD64461_NIMR);

    number =3D hd64461_irq_demask(mask);
    irq_master->irq[number].irq_enabled =3D 0;
    irq_master->irq[number].irq_mask =3D 0;

    /* TODO HANDLER */

    return 0;
}

/*
 *	hd64461_irq_trigger - set irq trigger for hd64461 source
 */
unsigned int hd64461_irq_trigger(u16 mask, u16 trigger_mask)
{
    if (!(mask & HD64461_PCC0_MASK) || !(mask & HD64461_PCC1_MASK)) {
	printk(KERN_INFO "this interrupt doesn't support trigger settings\n");
	return 0;
    }
   =20
    /* TODO */
    return 0;
}   =20

void hd64461_irq_request(u16 mask, void (*fn)(int, void *), u16 trigger_mas=
k)
{
    hd64461_irq_set_hand(mask, fn);
    hd64461_irq_trigger(mask, trigger_mask);
    hd64461_irq_enable(mask);
}

static irqreturn_t hd64461_irq_handler(int irq, void *devid)
{
    unsigned short	bit;
    int			i;
    u16			value;
    u16			nimr;

    value =3D 0xffff;

    printk(KERN_INFO "Entering interrupt!\n");

    /* read -> inactivate */
    nimr =3D hd64461_io_read16(HD64461_NIMR);
    hd64461_io_write16(value, HD64461_NIMR);=20
       =20
    /*  run through the source/s and check=20
     *  which one is causing the interrupt.
     *  only run handler if we are sure=20
     *  one exists and is enabled (by us).=20
     */

    for (i =3D 0, bit =3D 1; i < 16; bit <<=3D 1, i++)
	if (nimr & irq_master->irq[i].irq_mask) {
	    if (irq_master->irq[i].irq_enabled)
		irq_master->irq[i].fn(i, devid);
	    else=20
		printk(KERN_INFO "spurious interrupt detected from interrupt mask %x\n", =
irq_master->irq[i].irq_mask);
	}
   =20
    return IRQ_HANDLED;
}

static struct irqaction irq0 =3D {
    .handler	=3D hd64461_irq_handler,
    .flags	=3D IRQF_DISABLED,
    .mask	=3D CPU_MASK_NONE,
    .name	=3D "hd64461-mfd",
};

static int __init hd64461_probe(struct platform_device *pdev)
{
    struct resource	*res;
    unsigned int	ret;

    ret =3D -ENOMEM;

    printk(KERN_INFO "hd64461-mfd: driver starting\n");

    /* Allocate the memory for devdata */
    hd_master =3D kzalloc(sizeof(struct hd64461_devdata), GFP_KERNEL);
    if (!hd_master) {
	goto fault_0;
    }
   =20
    irq_master =3D kzalloc(sizeof(struct hd64461_irq_list), GFP_KERNEL);
    if (!irq_master) {
	goto fault_1;
    }
   =20
    /* We get our IRQ from the driver resource */
    res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
    if (!res)
	goto fault_1;

    hd_master->master_irq =3D res->start;

    res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
    if (!res)
	goto fault_1;

    hd_master->io_start =3D 0xb0000000;
//    hd_master->io_end	=3D res->end;
//  ioremap(res->start, (res->end - res->start) - 1);
//    platform_set_drvdata(pdev, hd_master);

    setup_irq(36, &irq0);

//    ret =3D request_irq(hd_master->master_irq, hd64461_irq_handler, IRQF_=
DISABLED, "hd64461-mfd", hd_master);
    return 0;

fault_0:
    return ret;

fault_1:
    kfree(hd_master);
    return ret;
}

static int __exit hd64461_remove(struct platform_device *pdev)
{

return 0;
}

static struct platform_driver hd64461_mfd_driver =3D {
    .driver	=3D {
	.name	=3D "hd64461-mfd",
	.owner  =3D THIS_MODULE,
    },
    .probe	=3D hd64461_probe,
    .remove	=3D __exit_p(hd64461_remove),
};

static int __init hd64461_init(void)
{
    return platform_driver_probe(&hd64461_mfd_driver, hd64461_probe);
}

static void __exit hd64461_exit(void)
{
    platform_driver_unregister(&hd64461_mfd_driver);
}
module_init(hd64461_init)
module_exit(hd64461_exit)

MODULE_AUTHOR("Kristoffer Ericson <kristoffer.ericson@gmail.com>");
MODULE_DESCRIPTION("Core Driver for HD64461");
MODULE_LICENSE("GPL v2");




--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__25_Nov_2008_20_48_21_+0100_mm2ilheAeZFdL6pm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkksVoUACgkQPQls10ERAGdNnQCeLvW7g8gwl7mwWSSXDt9D2j3S
FbsAoKptLp8ws5felc8CxXCR0hFaCqKK
=+LRV
-----END PGP SIGNATURE-----

--Signature=_Tue__25_Nov_2008_20_48_21_+0100_mm2ilheAeZFdL6pm--
