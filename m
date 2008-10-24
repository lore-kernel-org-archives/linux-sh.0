From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Fri, 24 Oct 2008 09:29:42 +0000
Subject: MigoR and Scif Serial
Message-Id: <800596.6344.qm@web23506.mail.ird.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Michael Trimarchi <trimarchi@gandalf.sssup.it>

Hi,

I find some problem in MigoR board using scif serial device and console too.

Looking at the setup-Sh7722.c, the platform sci port data has the irqs
line equal to one interrupt. In the driver this line is multiplexed and
using for manage all the interrupt (error, transmit, receive, etc...) but
the sci_mpxed_interrupt check the wrong status for interrupt and break=20
error. They are on a single bit. So modify the code like this, resolve
the issue.

 /* Error Interrupt */
 if ((ssr_status & 0x0080) && (scr_status & 0x08)) <-----
      sci_er_interrupt(irq, ptr);
 /* Break Interrupt */
 if ((ssr_status & 0x0010) && (scr_status & 0x08)) <-----
      sci_br_interrupt(irq, ptr);

Is there any reasons to multiplex the serial interrupt on sh7722?

Another question is:

It is correct to implement the tx_empty like this?

static unsigned int sci_tx_empty(struct uart_port *port)
{
        unsigned int ret =3D TIOCSER_TEMT;

        /* Detect for scif device */
        if (port->type =3D PORT_SCIF) {
                if (scif_txroom(port) =3D SCIF_TXROOM_MAX)
                        ret =3D TIOCSER_TEMT;
                else
                        ret =3D 0;
        }
        return ret;        =20
}

Regards Michael





      Scopri il blog di Yahoo! Mail:
Trucchi, novit=E0 e scrivi la tua opinione.
http://www.ymailblogit.com/blog
