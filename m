From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 24 Mar 2008 23:11:21 +0000
Subject: Re: [PATCH] 2/3 mtd: add support for flash on the SEGA Dreamcast
Message-Id: <1206400281.10173.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1206211147.6324.48.camel@localhost.localdomain>
	<20080322185600.GE19347@logfs.org>
	<1206207805.6324.13.camel@localhost.localdomain>
	<1206209035.6324.29.camel@localhost.localdomain>
	<20080322183200.GD19347@logfs.org>
	<1206211147.6324.48.camel@localhost.localdomain>
	<20080324020832.GA13935@linux-sh.org>
	<1206360384.6283.11.camel@localhost.localdomain>
	<20080324132101.GA2899@logfs.org>
	<1206367120.6283.15.camel@localhost.localdomain>
	<20080324141043.GB2899@logfs.org>
In-Reply-To: <20080324141043.GB2899@logfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: Paul Mundt <lethal@linux-sh.org>, MTD <linux-mtd@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>


On Mon, 2008-03-24 at 15:10 +0100, J=C3=B6rn Engel wrote:
> On Mon, 24 March 2008 13:58:40 +0000, Adrian McMenamin wrote:
> >=20
> > Tempting as it is to continue the war, discretion will be the better
> > part of valour here and I will give you the last word.
> >=20
> > Of course I don't mind you sending patches. Indeed it would be very
> > helpful and generous of you to do so.
>=20
> Good.  The first four shouldn't change any behaviour.  Number five flips
> positive error returns into negative ones.  I believe the old behaviour
> is a bug.  Worth a second look to make sure.
>=20
> All five patches are attached.  Hope that doesn't cause any problems.

Just to keep you informed...

I have patched and tested four of these without any problem.

I haven't patched with the return/goto one as I think that needs more
work.

Other patches (the ones that have a chance of working) will be tested in
due course.

