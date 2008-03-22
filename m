From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Date: Sat, 22 Mar 2008 18:32:00 +0000
Subject: Re: [PATCH] 2/3 mtd: add support for flash on the SEGA Dreamcast Visual Memory Unit
Message-Id: <20080322183200.GD19347@logfs.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
	<1206209035.6324.29.camel@localhost.localdomain>
In-Reply-To: <1206209035.6324.29.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>, Paul Mundt <lethal@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, dwmw2 <dwmw2@infradead.org>

On Sat, 22 March 2008 18:03:55 +0000, Adrian McMenamin wrote:
>=20
> The SEGA Visual Memory Unit includes 128k of flash memory
> which can be read in blocks.
>=20
> The hardware specification is also capable of supporting
> partitions (though it is doubtful such devices exist).
>=20
> This driver supports block reads and writes, as well as
> queries of hardware capabilities, through the maple
> bus susbsystem.
>=20
> (It also implements a caching system so that, for instance, a
> read of 60 bytes will take 1/60th - or 1/50th in PAL regions -
> of a second instead of a second or 1.2 seconds.)

Without a doubt, buffering is useful.  However I question how useful it
is to implement this in individual device drivers instead of once in
mtd_core.c.

> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

Given that you have ignored most of my previous comments, NAK.  I don't
mind merging code that isn't up to our standards yet.  But I have a bad
feeling about a maintainer that does not understand review comments.
Since you had similar problems understanding Andrew, part of the blame
may sit on your side.

J=C3=B6rn

--=20
The key to performance is elegance, not battalions of special cases.
-- Jon Bentley and Doug McIlroy
