From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 21 Feb 2008 20:29:12 +0000
Subject: IRQ3 seems to work now for SH7709
Message-Id: <20080221212912.c7ebeb94.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Greetings,

IRQ0->IRQ5 needs to be silenced by first setting priority 0 and then mask o=
ut the affected bit in IRR0. This was done previously in 2.6.17 in the ipr =
handler. This is also according to SH7709 manual.

This can be found inside 2.6.17 with linuxsh patches applied :

static void mask_and_ack_ipr(unsigned int irq)

  89 {
  90         disable_ipr_irq(irq);
  91=20
  92 #if defined(CONFIG_CPU_SUBTYPE_SH7707) || defined(CONFIG_CPU_SUBTYPE_S=
H7709) || \
  93     defined(CONFIG_CPU_SUBTYPE_SH7300) || defined(CONFIG_CPU_SUBTYPE_S=
H7705)
  94         /* This is needed when we use edge triggered setting */
  95         /* XXX: Is it really needed? */
  96         if (IRQ0_IRQ <=3D irq && irq <=3D IRQ5_IRQ) {
  97                 /* Clear external interrupt request */
  98                 int a =3D ctrl_inb(INTC_IRR0);
  99                 a &=3D ~(1 << (irq - IRQ0_IRQ));
 100                 ctrl_outb(a, INTC_IRR0);
 101         }
 102 #endif
 103 }

(you can access entire file at http://www.jlime.org/gitweb?p=3Djlime-stable=
.git;a=3Dblob;f=3Darch/sh/kernel/cpu/irq/ipr.c;h=E55150ed085619d5962e039e1e=
bb2a4fdc2e9b15;hb?3554525f5c300a6e41d0aae01673c45e9098c3)

I added minor code to intc_disable() just to test it

#ifdef CONFIG_CPU_SUBTYPE_SH7709
	if (irq =3D 35) {                <--- my touchscreen IRQ
		int a =3D inb(IRR0);
		a &=3D ~(1 << 3);
		outb(a, IRR0);
	}
#endif

And the result was that the interrupt no longer keeps feeding data instead =
only when touchscreen is actually touched, so seems valid.

Best wishes
Kristoffer
