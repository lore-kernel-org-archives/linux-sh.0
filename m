From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Fri, 22 Feb 2008 11:47:17 +0000
Subject: Re: IRQ3 seems to work now for SH7709
Message-Id: <20080222124717.7904781d.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080221212912.c7ebeb94.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080221212912.c7ebeb94.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, 22 Feb 2008 17:30:07 +0900
"Magnus Damm" <magnus.damm@gmail.com> wrote:

> Hi Kristoffer,
>=20
> I think you are right. IRQn pins may need some special care on sh3.
> But only if the pins are in individual mode (as IRQn - not IRLn) _and_
> configured as edge triggered. I think you are about the only person on
> this planet who is using the upstream kernel on sh3. Thanks for
> testing. =3D)
>=20

Probably :)

> You are seeing this because you probably used plat_irq_setup_pins() to
> select IRQ mode and edge triggered happens to be the default unless
> ICR1 is changed. And the current code doesn't do anything with ICR1
> since the irq doesn't support sense selection. Yet.
>=20
> We may need to come up with a fix for edge triggered mode... Such a
> fix is of course cpu specific but it probably needs to be implemented
> right in the middle of the generic intc code so I'm not so happy to
> add it unless it's absolutely necessary.

Can understand that.
>=20
> What about if you use level triggered mode instead? Not sure if your
> device hooked up to the IRQ pin supports that though.

I've been bugtracking this for over a week now and nothing has worked. Seem=
s like
whatever setting (ICR1) I use, masking the IRR0 code will be needed. Level =
aren't supposed to need
the masking but when I try it I get the endless loop and are unable to mask=
 it out.
I've also checked with the older 2.6.17 kernel which had everything working=
 for hp6xx and uses
level triggerd.=20

So in short, level =3D endless loop without being able to disable it, edge =
=3D endless loop, but can be disabled with masking.

>=20
> Apply the attached patch and request the irq using IRQF_TRIGGER_LOW.
> If I'm right then that should configure IRQ sensing for you in ICR1 -
> look in intc.c for IRQ_TYPE_LEVEL_LOW. You can also play around with
> different edge trigger modes - and then you probably need a fix like
> the one you posted - just remember that high level isn't available on
> sh770x but there are no checks in the intc code for that at the
> moment...

I'll test the patch today.

>=20
> / magnus
>=20
> On Fri, Feb 22, 2008 at 5:29 AM, Kristoffer Ericson
> <kristoffer.ericson@gmail.com> wrote:
> > Greetings,
> >
> >  IRQ0->IRQ5 needs to be silenced by first setting priority 0 and then m=
ask out the affected bit in IRR0. This was done previously in 2.6.17 in the=
 ipr handler. This is also according to SH7709 manual.
> >
> >  This can be found inside 2.6.17 with linuxsh patches applied :
> >
> >  static void mask_and_ack_ipr(unsigned int irq)
> >
> >   89 {
> >   90         disable_ipr_irq(irq);
> >   91
> >   92 #if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTY=
PE_SH7709) || \
> >   93     defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTY=
PE_SH7705)
> >   94         /* This is needed when we use edge triggered setting */
> >   95         /* XXX: Is it really needed? */
> >   96         if (IRQ0_IRQ <=3D irq && irq <=3D IRQ5_IRQ) {
> >   97                 /* Clear external interrupt request */
> >   98                 int a =3D ctrl_inb(INTC_IRR0);
> >   99                 a &=3D ~(1 << (irq - IRQ0_IRQ));
> >   100                 ctrl_outb(a, INTC_IRR0);
> >   101         }
> >   102 #endif
> >   103 }
> >
> >  (you can access entire file at http://www.jlime.org/gitweb?p=3Djlime-s=
table.git;a=3Dblob;f=3Darch/sh/kernel/cpu/irq/ipr.c;h=E55150ed085619d5962e0=
39e1ebb2a4fdc2e9b15;hb?3554525f5c300a6e41d0aae01673c45e9098c3)
> >
> >  I added minor code to intc_disable() just to test it
> >
> >  #ifdef CONFIG_CPU_SUBTYPE_SH7709
> >         if (irq =3D 35) {                <--- my touchscreen IRQ
> >                 int a =3D inb(IRR0);
> >                 a &=3D ~(1 << 3);
> >                 outb(a, IRR0);
> >         }
> >  #endif
> >
> >  And the result was that the interrupt no longer keeps feeding data ins=
tead only when touchscreen is actually touched, so seems valid.
> >
> >  Best wishes
> >  Kristoffer
> >
>=20
