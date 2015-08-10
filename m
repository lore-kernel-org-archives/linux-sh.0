From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 10 Aug 2015 14:00:22 +0000
Subject: Re: [PATCH 08/10] i2c: support 10 bit and slave addresses in sysfs 'new_device'
Message-Id: <20150810140022.GA7159@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
 <1439066007-13951-9-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWfL3SwzZ=Wu5X96Npf9RHmVWc7o7R+uLfvuiRRSpQR9w@mail.gmail.com>
In-Reply-To: <CAMuHMdWfL3SwzZ=Wu5X96Npf9RHmVWc7o7R+uLfvuiRRSpQR9w@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2015 at 03:17:03PM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Sat, Aug 8, 2015 at 10:33 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > diff --git a/Documentation/i2c/slave-interface b/Documentation/i2c/slav=
e-interface
> > index 2dee4e2d62df19..61ed05cd95317f 100644
> > --- a/Documentation/i2c/slave-interface
> > +++ b/Documentation/i2c/slave-interface
> > @@ -31,10 +31,13 @@ User manual
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >  I2C slave backends behave like standard I2C clients. So, you can insta=
ntiate
> > -them as described in the document 'instantiating-devices'. A quick exa=
mple for
> > -instantiating the slave-eeprom driver from userspace at address 0x64 o=
n bus 1:
> > +them as described in the document 'instantiating-devices'. The only di=
fference
> > +is that i2c slave backends have their own address space. So, you have =
to add
> > +0x1000 to the address you would originally request. An example for
> > +instantiating the slave-eeprom driver from userspace at the 7 bit addr=
ess 0x64
> > +on bus 1:
> >
> > -  # echo slave-24c02 0x64 > /sys/bus/i2c/devices/i2c-1/new_device
> > +  # echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-1/new_device
>=20
> Does 0x64 still work? It's an ABI since v4.1.

Yes, you'll see the warning from patch 9.


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyK52AAoJEBQN5MwUoCm2y9MQAI7nuC0161zwS78vkVB11cyc
5JGtvoN0qwSBYMZrYp0GKRGby3bV2OnJLpepa3/0UwRWdYCh12Z334dHwV5XQJ7d
ZqLzUioVA0P21y4MDX2BG8BfpWuqDIPmSmspQTgVFMM8Ei1l4qpx8qBGLlFqsPZq
qtMNk7ELjM3LPAFYHscGJlxHWomomqQlq2pfZ1V9eJTkAOKq9zratpAAk2QUmSBT
EaJL8fOEQ6VfQSVDSiCR/vdRn5AK1RDzKRC8o2iCg4TwYme0sJx4ggfd5n9YplNP
SfcapIufhRZkgaiToGUP+Srjtn4x9G85DpHDaKe3jUUUyHBtKIoPCBZZIuhSgXMr
bvXHlj0TefvLk+kBuZlKMkrWy0mx5GlXFRr7S2FBt8rAegEsT5IGfLw7pb9q7YTZ
QUnv6bIkHTRknOzdiZg60+fei9vjt6+rAyyGLVcdbInYD9jS/0gP4fZLpngayoXU
vVZuG+QTneylO66FpF8zzWW04omf+5q5JiLrY7Ik4PvVsCaH2+SS4e3JY2BHJNmu
OMdtuUhZDqo54OuN/zHUOgTeuOVmWKYa7OB3LM1f3KS5C0UZELb0e6h2pPgwrsnI
txTRHOFZYHGorWmBF8xx6YzCHriJeoH4KSyRCgsgu83Z62UPRlqI+Gcy01j2mbzv
JycFSVIFOJpQYQHGVma7
=AbSy
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
