From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 03 Mar 2014 16:27:31 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <20140303162731.GA3732@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1569751.q5lJmQcb3K@avalon> <20140303091903.GA6531@katana>
 <1722697.3h0GnbWuD3@avalon>
In-Reply-To: <1722697.3h0GnbWuD3@avalon>
To: linux-arm-kernel@lists.infradead.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> While the parent is indeed selected at boot time only, and only one paren=
t is=20
> thus needed, parent selection could be performed by a DIP switch connecte=
d to=20
> MD_CLK on the board for instance. In that case both parents should be=20
> available in DT, as selection will be done by the kernel at boot time, no=
t at=20
> DT compile time.

OK, I understand the case. I still wonder about specifying two parents,
though. If a board uses USB_X1, it then has to spefify a dummy EXTAL
clock (or an empty one), just because USB_X1 is enumerated as second
entry?

> > Again, now that I already coded it, what is the gain to remove it? The
> > drawback is that other people might get encouraged to find reasons to
> > allow them sloppy practices.
>=20
> It will make the kernel binary smaller by removing code that is not neede=
d in=20
> practice.

Sounds like a micro-optimazation to me. If you insist, we should BUG()
right away in that case, to make the code comprehensible. Returning with
a leak and saying "we will probably fail somewhere" should really be
avoided IMO.


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTFK1zAAoJEBQN5MwUoCm2rMcQAK3nIH63aX8fsVtxTx0ASSMj
oSehQuSm7Nt4nVtExlIAFH+C1RqlgIfN53aeAB3MIC/M0mRQONgFAteNCoJz9ubT
pb1bTF17Kajf8QmwTLrCeoSfemMTicea3AyibzNqVPKzWj/MFvOumS1SjeeTGFFZ
8PinpGHxaQbfPPnjbM4F4xT784i8HxuuTe9iRIGXASrdRnE5ruYkt8sdnsabiJW+
BftfsH5fMmq0SfXHmy2JyMt/kxMTd5CzqBdQGNST2Y1VOc7EhxJZLEqnXwujJCTn
RsDF4IBAeDS5h0fIusS0XUIlNwmcWHIvILHHlbxo5cZDYQXgfIvx270M+WTo9d9E
pM78rWv7+shsivM/AGMb1wfEspLyICrFJvh26rMWGrg7wBhqNEza/Y8UARKAWA6O
s02HsgnBNU+MnZ/LL0ASAn9fOajf6N/Py/RoSS9swjV5CvGmTXXihY/LPnJ0QKBj
EjJ+RhSd48fHnETjWrtj/LoXqXWYo0QoMwG5gLJ4DWPnVc0l20TCR+pKFsZNSOaS
CodV5KBOUohYPAhT1RypKG0nf+rlqAfvuC1uahZ7GF4Z8I/NVHwEP6MCjC6J2Y2k
Ji9Wr7DkPqW0NkLPI3J6KUnB2iQ1XH1VdLBrZXtS6tWUqTMAXFFrPKMoNVtDsnEI
PxUVQ/TixH0S2WiYa6Hy
=r9uA
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
