From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 31 Jan 2014 07:42:25 +0000
Subject: Re: [PATCH] arm: shmobile: r7s72100: really add i2c clocks
Message-Id: <20140131074225.GA2739@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
List-Id: <linux-sh.vger.kernel.org>
References: <1388117724-11103-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1388117724-11103-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2014 at 09:00:12AM +0900, Simon Horman wrote:
> On Thu, Jan 30, 2014 at 10:11:33AM +0100, Wolfram Sang wrote:
> >=20
> > > > >> From: Wolfram Sang <wsa@sang-engineering.com>
> > > > >>
> > > > >> Due to a merge conflict, addition of the clocks was lost. Tested=
 with
> > > > >> RIIC2 on a genmai board. Others untested but hopefully trivial e=
nough to
> > > > >> be added.
> > > > >>
> > > > >> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> > > > >
> > > > > Thanks, I will queue this up.
> > > >=20
> > > > This still seems to be missing?
> > >=20
> > > Thanks, I have now queued it up.
> >=20
> > It is not upstream yet?

Ah, okay. Well, I'd think this is a bugfix for

d85bcfa916ffdf078f188aeab60f738b290f4309 arm: shmobile: r7s72100: add i2c c=
locks

since without it i2c can't be used with 3.14. But your call, after all.

Thanks,

    Wolfram


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS61PhAAoJEBQN5MwUoCm2pyQP/3PuWljULVncFIv/n6De1s3g
g/6KGg5V35hXQvo0qIWlvkaWDeuv2Uq6oakzXp2l6Q9lKHYMrGDmtn1xNfG5yHv7
Osud9xLonRmhIFkLEeBFtpRktU0+2Cix14NW0PzVUX9K6by/vOnmobOAEcSPuA+n
TCOHhpaEBW0BitvYLlyVwGeg0YSE7Baa8Urw4xPS0qcfr4SQK5LwFw4HEgSsr0T6
gTDMKG+NVSmo3tx3vOerXpMbieYlmJc8SpOLpehZEaq6UF8zmXf/QQLaEcu/WQHP
QGgRXLgt+CUFUV9YNqsDQjtv4gXC2MjwvFji4DF9Y7DCqPn2ON0X4D49IBFIpffh
+55vTFuFmAbkWj9iIP18VKjvXkOwRFtyMyL/OfFEp7ktelawkeEDpnOrVI5PmO6O
+OfA4uWlLZRSdw+2FVTpIEPkmPhJKAqkC3/2SK2TdGFpDCXlAf7zHbSdWe3Up1wc
Zkp7NsFvQPx64mP2fUcgmNggfvIXiBX1lUm/VODKbPdxP6dnYhtYl6p8hFu83hGE
d0ZVsUotFs2/oxijr/Q1F0lu+341rglW7NRZTIexRXL5/LzCD67axSdFGYvoKT5o
8wtOoPjs/EqmJrNjg8hW3mnLN387mIJ8oCpayBJbQyJqRCIH0CkOu4rQH+DIqBuu
vuxsyMB7WZMXqOirS3ME
=1W/E
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
