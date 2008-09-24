From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Wed, 24 Sep 2008 15:57:03 +0000
Subject: Re: SH7722 serial scif
Message-Id: <519871.40680.qm@web26201.mail.ukl.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
In-Reply-To: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,



----- Messaggio originale -----
> Da: Paul Mundt <lethal@linux-sh.org>
> A: Michael Trimarchi <trimarchimichael@yahoo.it>
> Cc: linux-sh@vger.kernel.org
> Inviato: Mercoled=EC 24 settembre 2008, 17:49:01
> Oggetto: Re: SH7722 serial scif
>=20
> On Wed, Sep 24, 2008 at 02:52:05PM +0000, Michael Trimarchi wrote:
> > I find a problem releated to the scif serial device. Using scif2 on the
> > MigoR, the kernel block on the second open of the device when it try to
> > register irq line. So in the shutdown sequence I add:
> >=20
> >  sci_out(port, SCSCR, 0x00);
> >=20
> > and in the startup squence:
> >=20
> >  sci_out(port, SCSCR, SCSCR_INIT(port));
> >=20
> > The version is 2.6.24.2 but I think is present in the latest release to=
o.
> >=20
> > My idea is to post a patch to register and enable and disable for the
> > scif port on the SH7722. Can be a problem for other micro?
> >=20
> I'm not entirely sure I follow what the problem is, so yes, a patch would
> help. It sounds like you are running in to a problems trying to do multip=
le
> opens on the same port where request_irq() returns -EBUSY or some such
> thing? I don't immediately see how that would be happening, so perhaps
> I'm misunderstanding your problem.

The problem is much simple. The code does't exit from the request_irq. I su=
ppose,
that kernel receive a very high number of interrupt requests. So this is th=
e sequence:

---->uart_open(2)
           |
             \-------request_irq
          |
          \------- start_tx

The first time the code run without problem. ( I recevive a packet of one b=
yte every 60ms)

The simple program exit without problem.

I run again the program with this result:
---->uart_open(2)
            |
           \------request_irq

Never exist. So I think is releated to the shutdown sequence and startup. A=
dding
the code above the problem disappear.=20

Is ok now this description?

Regards Michael

__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto =
spazio gratuito per i tuoi file e i messaggi=20
http://mail.yahoo.it=20
