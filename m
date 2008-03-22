From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 22 Mar 2008 18:39:07 +0000
Subject: Re: [PATCH] 2/3 mtd: add support for flash on the SEGA Dreamcast
Message-Id: <1206211147.6324.48.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
	<1206209035.6324.29.camel@localhost.localdomain>
	<20080322183200.GD19347@logfs.org>
In-Reply-To: <20080322183200.GD19347@logfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>, Paul Mundt <lethal@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, dwmw2 <dwmw2@infradead.org>


On Sat, 2008-03-22 at 19:32 +0100, J=C3=B6rn Engel wrote:
> On Sat, 22 March 2008 18:03:55 +0000, Adrian McMenamin wrote:
> >=20

> Without a doubt, buffering is useful.  However I question how useful it
> is to implement this in individual device drivers instead of once in
> mtd_core.c.


Well, it's obviously useful to this device. Are you making best the
enemy of better?


>=20
> Given that you have ignored most of my previous comments, NAK.=20


Not good enough, frankly. What comments have I ignored? I didn't
implement your suggestion that a void* memory type become be32* because
it was totally inappropriate for a type that is passed in both be32 and
le32 and as u8.


>  I don't
> mind merging code that isn't up to our standards yet.  But I have a bad
> feeling about a maintainer that does not understand review comments.
> Since you had similar problems understanding Andrew, part of the blame
> may sit on your side.
>=20

I'm sorry that you feel that way, but as you took the hump when I said
that this:

"Possibly the big-endian annotations need to trickly though the layers
here as well."

Isn't good english (and it's not) and asked you - twice - to explain
what you meant. I cannot accept your summary.


Adrian

