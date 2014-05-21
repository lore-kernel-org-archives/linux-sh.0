From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 21 May 2014 11:00:19 +0000
Subject: Re: [PATCH] i2c: sh_mobile: Don't start transfers when suspending
Message-Id: <20140521110019.GS2708@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0blaZc+aUkVqY8MO"
List-Id: <linux-sh.vger.kernel.org>
References: <1360862257-10807-1-git-send-email-hechtb+renesas@gmail.com>
 <CANqRtoSzyAj=pDmtDy1gh=Pxrom644tM07z15b4S=DX4Cby=MQ@mail.gmail.com>
 <CABYn4szejurs2gBVOx_+geOxw13r9KvoShfRiM7OOF5wVvDPLA@mail.gmail.com>
 <20130221091434.GA22806@the-dreams.de>
 <CABYn4swuDgTvvyigjnabcg46rcze-DnGhv2Rh7WEFdwkXcHR4Q@mail.gmail.com>
In-Reply-To: <CABYn4swuDgTvvyigjnabcg46rcze-DnGhv2Rh7WEFdwkXcHR4Q@mail.gmail.com>
To: Bastian Hecht <hechtb@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org


--0blaZc+aUkVqY8MO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2013 at 08:54:06AM -0600, Bastian Hecht wrote:
> Hi Wolfram,
>=20
> oh yes I can gladly do so. To make a realistic estimation it might
> take a few weeks until I find time for it though. If we can wait so
> long, count on me.

Ping. Still interested?

>=20
> Best,
>=20
>  Bastian
>=20
> 2013/2/21 Wolfram Sang <wsa@the-dreams.de>:
> > Hi Bastian,
> >
> >> > Also, do you know the reason why this isn't handled in the i2c layer
> >> > by default? I ask because your comment mentions that i2c-tegra.c does
> >> > the same thing and I can't see anything in this patch that is actual=
ly
> >> > related to our I2C hardware.
> >>
> >> Yes, many drivers have a similar scheme and to me it more looked like
> >> all drivers need to take care about this case unrelated to different
> >> hardware. So the question arises if this can't be handled in the core
> >> - or if I get something wrong here.
> >
> > I don't see any reason why this couldn't be handled in the core. If you
> > want to have a take on this issue (after the other bug is fixed), this
> > will be highly appreciated.
> >
> > Thanks,
> >
> >    Wolfram
> >

--0blaZc+aUkVqY8MO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfIdDAAoJEBQN5MwUoCm2ABsP/1CHLgithUJ+bvOdv1kMdpcD
ZlaxnxNLK69Vw5us2yWE6UR1yl50pH7Z/V1IazTfSYr2owt6wbBZrfvug6ypcd1H
9okqJIiOGYReaN/QXiywqyCKfUHYHzQI7Jl5dfGNsgJdljoQDDTrVSUfY3FY60q2
MW/ijbZmVpQT+Gt3+Jp+hKi4kOT6Zw3Z8bNT6pUE+6Owogo/Jr1YPjrH7XRFt+wT
X7oT4eN3cGhOILF0OQcyl7Jyx7JA3CHwZpP/0i+cDjgpE5cUBJG5DoEWgn4pNHDc
Z/1Ojb4q5CRdFhudapWP9t/BEEDP8wHu0/RYIARjtZmpiN2ldDHqB3cqwW4NeefJ
MXOUhxKcOHnZeYoc59XFsqhNr01CW66z2LKGxwzJjhzgkdg3DR6EgzdadTan8K5P
9b4vwHDK0pv+OGp2yo52PVNlP0zLM8/oTb+YurVNJnZLuF33nKAIZG1kJtB2LH2X
ch2kDGpHy6OsnrlAJEbCsC8nGKrAz+X8Gb2ylmK116ewkSWukBgFblB/2FFGT5JM
iQpiPvvs7GGAyzJQcBlyydwgPOYELyXeUv7UmkfHKqexi29gbvAe54B/88Pd2xrL
kwlY9pVpnkwCziySvf3Fn6V9Z2qYJ+Fb5L+LbJvazTbiTgO+F7vqMGsJEvPlOnQD
qBLxiTngqVVOmdiNMDw8
=ZbWS
-----END PGP SIGNATURE-----

--0blaZc+aUkVqY8MO--
