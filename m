From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Mar 2014 10:48:36 +0000
Subject: Re: [PATCH 0/2][RFC] ASoC: fsi/rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <20140313104836.GN366@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="b/Q3JWIUAuLE0ZFy"
List-Id: <linux-sh.vger.kernel.org>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2014 at 11:47:36PM -0700, Kuninori Morimoto wrote:
>=20
> Hi Mark, Simon
>=20
> These patches fixup Renesas fsi/rcar driver's
> SND_SOC_DAIFMT_CBx_CFx flag settings.
>=20
> I had misunderstand these settings...
> But this is still [RFC], since it modifies DT side code too.
>=20
> >> Mark
>=20
> #1 patch depends on Jyri's
> "Fix simple-card *-master DT parameter handling"
> if it was accepted
>=20
> >> Simon
>=20
> Can you check #1 patch which modifys SH-ARM platform ?

So, we need to do something quickly here since this affects DT bindings
but it would be *much* better to avoid having to set the master flags on
both ends of the link since that's going to make the binding confusing
if we're stuck with it as an ABI.

Simon, are you OK with the arch side of cleanups for this going via my
tree?

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIY0BAAoJELSic+t+oim9gtYP/Rrwc7orr733cewkV8fNN4u0
9IHWleWqE5JxA6/OZvVf6T2S0H3vNRbdZNl3i9JrFInsAl1743WybQenBM3yuA1j
wUV1CMxvY5Gn0favBWJj1RKS6fE35+dlN0OO0iEEbo0V1NDodpEzuxF+TwqTl5nH
9MeCKA8QXepfD1oWdg2pXLh833BIl2uesUXj2VfUnrvg9oAKURjzQ4ISR2uGLR+P
HRYgrEt+RyJX4PdjoGWlo/efgENtHINQ+9B8BZPgfIHN3L7TVkBamJW9l8H4YODd
+loh8rkn7XZcSdfJ0ObYXi0r9Vv1L+tY6jsxj4acN8QKtJ1crziM7PYE6mN4R8TU
Qz+hBDk48+6PPSTL/BlbY8nrTGNWBiZdmL4P6nvrxnw7nLZdoSvhe5dEeST7OFgG
pelYIm6bd/TB0hkzbmKKu4LAHVNPDk/vqKdSj2rpK+a51tur5bSuM43uHgl/hAc1
GDtbvNwHzFRbpkRt1vufG7QbxYjGHNrD5nNo0S2YIEzuavoFCCagkPsRxLFI4pF7
Vzqwffqup+KybnfrSVDN+vDverOUZFqIc9Ce2E6j66pPJL4Q89MjC86aI8MeEb0l
I3O9to/rxw6AGsUufJzJ5DdrWjB0Gw0D4EhDIoqQHOPyBdf5DDR+KbjWX65xGKO5
t3TkpLNFzBA7TpJwW8Yb
=iA/6
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
