From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Fri, 05 Dec 2008 13:03:53 +0000
Subject: Re: [PATCH] sh: Switch HD64461 from hw_interrupt_type to irq_chip
Message-Id: <20081205150447.d9087207.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__5_Dec_2008_15_04_47_+0100_yi_6orGNWGarIcKk"
List-Id: <linux-sh.vger.kernel.org>
References: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
In-Reply-To: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
To: linux-sh@vger.kernel.org

--Signature=_Fri__5_Dec_2008_15_04_47_+0100_yi_6orGNWGarIcKk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Dec 2008 15:40:46 +0900
"Magnus Damm" <magnus.damm@gmail.com> wrote:

> On Fri, Nov 28, 2008 at 5:58 PM, Matt Fleming <mjf@gentoo.org> wrote:
> > Use struct irq_chip for the interrupt handler for the HD64461. Also
> > convert some in{b,w} and out{b,w} calls to the equivalent __raw_* calls.
> > Include <linux/io.h> and not <asm/io.h> to stop checkpatch.pl
> > complaining.
> >
> > This change should now allow machines with HD64461 to define
> > GENERIC_HARDIRQS_NO__DO_IRQ.
> >
> > Acked-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> > Signed-off-by: Matt Fleming <mjf@gentoo.org>
>=20
> Hi Matt and Kristoffer,

Hi,

Sorry for my late reply, been away from school for
a week.

>=20
> > diff --git a/arch/sh/cchips/hd6446x/hd64461.c b/arch/sh/cchips/hd6446x/=
hd64461.c
> > index f1a4a07..27ceeb9 100644
> > --- a/arch/sh/cchips/hd6446x/hd64461.c
> > +++ b/arch/sh/cchips/hd6446x/hd64461.c
>=20
> [snip]
>=20
> > -       setup_irq(CONFIG_HD64461_IRQ, &irq0);
>=20
> It looks like the interrupt driving the hd64461 chip is changed from
> being requested with setup_irq()/request_irq() to using the machvec
> demux. So the interrupt is handled by hooking up hd64461_irq_demux()
> to the sh_machine_vector member mv_irq_demux in the
> arch/sh/boards/mach-hp6xx/setup.c.
>=20

Correct.

> Using the demux for IRL interrupts that cannot be acknowledged and
> masked by the processor is a good idea. The interrupt handling for the
> r2d board which can be found in arch/sh/boards/mach-r2d/irq.c may
> serve as an example. If the interrupt is a regular single IRQ pin
> configured in IRQ mode then you should not use the demux.
>=20

I'm fine with using a demuxer and maintaining the virtual
IRQ range. Would also simplify the mfd driver.

> Judging by the hp6xx board code you use IRQ3->0 in IRQ mode. If you
> should use IRL or IRQ can be determined by looking at the board
> schematics for your platform. If you can point me out where those are
> then i can help you figure that part out.

The code is somewhat misleading in that it uses
the term irq0 while requesting irq. The thought is
to think of irq0 as the base irq (for demux) and not
the actual mapping (IRQ0->IRQ5) on the hd64461.

It would be more correct to instead refer to the
hd64461 IRQ as IRQ4 (IRQ 36 on hp6xx).

We currently set IRQ0->IRQ3 to IRQ mode as you say,
we do not touch IRQ4 or IRQ5 at all. I'm not exactly
sure what the "default" puts it in. Whatever it starts
with seems to be the correct thing, we just need
to make sure it acks through IRR0 also.

You can access copies of the relevant datasheets
from :
http://jlime.com/downloads/development/datasheets/6xx/

>=20
> Now when you're using the demux function then the intc handler will
> never be invoked for your CONFIG_HD64461_IRQ interrupt. This means
> that you won't get any acknowledge from the intc code.
>

Oki,

=20
> If the hd64461 chip is hooked up to a single interrupt line in IRQ
> mode, then I recommend you to use set_irq_chained_handler() or
> set_irq_handler() to associate the interrupt line with a demux
> function. This should make the intc code acknowledge the interrupt for
> you.
>=20
> Cheers,
>=20
> / magnus


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Fri__5_Dec_2008_15_04_47_+0100_yi_6orGNWGarIcKk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk5NP8ACgkQPQls10ERAGdalQCgv1tK1q3KkHKMuAeRJZ3LeCiy
gwgAoMiHS4vkOjGugAW6+20i+CNH5wzP
=QNAb
-----END PGP SIGNATURE-----

--Signature=_Fri__5_Dec_2008_15_04_47_+0100_yi_6orGNWGarIcKk--
