From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Thu, 03 May 2012 10:05:35 +0000
Subject: Re: [PATCH v3 02/10] ARM: sh-mobile: mackerel: Add error IRQ resource
Message-Id: <1336039535.13013.17.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-e0CcKH7bpd6wrTUxE1cc"
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335951710-9390-3-git-send-email-hechtb@gmail.com>
 <201205022249.30426.rjw@sisk.pl> <1336024825.2056.2.camel@koala>
 <1336024908.2056.3.camel@koala>
 <CABYn4szWZP4zZcz1MJ1xk5oCxiWh0nyJczcHGUqw4wE5MfJunA@mail.gmail.com>
In-Reply-To: <CABYn4szWZP4zZcz1MJ1xk5oCxiWh0nyJczcHGUqw4wE5MfJunA@mail.gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Brian Norris <computersforpeace@gmail.com>


--=-e0CcKH7bpd6wrTUxE1cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-03 at 11:29 +0200, Bastian Hecht wrote:
>=20
> Am 03.05.2012 08:01 schrieb "Artem Bityutskiy" <dedekind1@gmail.com>:
> >
> > On Thu, 2012-05-03 at 09:00 +0300, Artem Bityutskiy wrote:
> > > On Wed, 2012-05-02 at 22:49 +0200, Rafael J. Wysocki wrote:
> > > > On Wednesday, May 02, 2012, Bastian Hecht wrote:
> > > > > Supply the platform data for the FLSTEI error IRQ.
> > > > >
> > > > > Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> > > >
> > > > I'm going to take this patch into the renesas.git tree and push
> it
> > > > upstream throuch arm-soc, if that's not a problem.
> > >
> > > It is already in the MTD tree with the rest of the 10 patches...
> >
> > Ops, sorry, this is not true. Then Bastian should separate it out
> and
> > not send it to the MTD tree.
>=20
> Alright I'll do. I need to fix the compiler warnings of the mtd
> patches anyway. So the board code is independant and can be pushed
> already by Rafael, right? How is it supposed to work in general? I
> think the sh-mobile list wants to be informed when I change something
> in the flctl code. Would the right approach be to send 2 patchsets -
> posted on both MLs so that Artem can take the mtd portions and Rafael
> the mackerel ones?

If the patches are completely independent, post them separately. I think
it is also OK to CC more than one mailing list.

--=20
Best Regards,
Artem Bityutskiy

--=-e0CcKH7bpd6wrTUxE1cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPolhvAAoJECmIfjd9wqK0eBcQALXc5hFJbk7QdZfAIkq/X529
bkQQ1TTbXmZsVAmXH2qOkXT6PT0ClHP4FpTcIfgxZbPS57U08IrUYWRrdY8XFqfi
gYGQ2umGKzUlLYPde/QtmsmEw7cbA7PdmV/ml+jQJyZdxxXt5GgIsr3ftLAbQA8o
HO/RVsXUnBB7GvcK1L0koYJ/2crBLEtUmsP265AK1gOOiQ0ZQpSlSQUqQBmNRs3P
/A/H+o30rknEbPuCXJqnsw0W55uB01w0vpXOJg01+D63VAGR9pZBxU1bQCFkLIBk
twdj6ekFDve48uxZ8I42KYog/U3NaTwLDb43af82dXaQOZqVSFIpmDMLSNbwdXY+
UrjSMdEZrs/Lk7JeE2kJCT7PZwJyGbA9gArHRJMahjFO/pd3W1hDo4opGR3qDCon
OtJ3yiFP7gSlYwFJqKKVyxvjQtaiHKyh1kKTBL9rdhMUd1H1EqvjJAiWpIQMXf/P
CJbnb0Z/q0D1YRAR05VpqSGKb4zq9huiF2+kpHFjFDWYOvGAjHlUltWHUtTg7ir0
19s56vVInN46exhUwmqcHb7qM4gVw4FvJi1V4Vs7G1AOM+AP36s5sRmUOX+yrpW7
EDNQtgPFlkibJ9AvylTd4rsITmm6lCYZWFfN/i8rPnKW25j6Kwa2eE+VA129+Fl4
Px+Og6jlkFaK6dkwzzR7
=3yLB
-----END PGP SIGNATURE-----

--=-e0CcKH7bpd6wrTUxE1cc--

