From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 14 May 2014 12:21:26 +0000
Subject: Re: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock support
Message-Id: <20140514222126.5d10212f@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/rcrTsY_iTidXVJye7rrFJ9h"
List-Id: <linux-sh.vger.kernel.org>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
 <20140513000513.5943.68810@quantum>
 <CAMuHMdWK1WAePx3N_ybPkWcoTtP_6PdcEPNEyBv02A9zOZSWOg@mail.gmail.com>
In-Reply-To: <CAMuHMdWK1WAePx3N_ybPkWcoTtP_6PdcEPNEyBv02A9zOZSWOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--Sig_/rcrTsY_iTidXVJye7rrFJ9h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, 14 May 2014 12:26:38 +0200 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> On Tue, May 13, 2014 at 2:05 AM, Mike Turquette <mturquette@linaro.org> w=
rote:
> > Quoting Wolfram Sang (2014-04-29 03:03:32)
> >> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>
> >> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > Acked-by: Mike Turquette <mturquette@linaro.org>
> >
> > No need to take this through the clk tree. Feel free to send it with the
> > rest through arm-soc.
>=20
> (merging in clk/clk-next)
>=20
> Note that this will cause a conflict for you, as Mike applied commit
> 5483bf698f42a6f0467463b064084eb888298232 ("clk: shmobile: r8a7779:
> Add MSTP clock support"), which adds a line at the exact same spot.
>=20
> Resolution: both lines should be kept.

Thanks.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/rcrTsY_iTidXVJye7rrFJ9h
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTc1/MAAoJEMDTa8Ir7ZwV2lwP/iyh749f31wRz5cQsPeAgszO
n3xhIcqRBJzz1HZVEqCmmM3jkPTYr0p5sFPZOKqojVImPHhXIVfFVqmAuR6i+U4I
/Rz0I1bBiCpW4HydT9Zee1/yrEtKIPtP6bR7bA0l6GcGWzu2JHbm0353ZOYGIJ9A
+tKL6VgkkBTiOFFaHpLq2bW9A9T4XCWGcKssR/mLpyrmEv/4U2rl7gNMbDBVVjvK
ioI32fjF5zHearqteoM55MfS5JeK7DoA75N9rz9rf8u57JZc5sfVViOuuiGmVEIy
XE91CQfr/Mv8iVD9v8m/TaROQqduOE5qwPpKdRdxP6en9z/CfFpFJk2QkRQNbpFL
d2juug0cHGHG1EN6jT2hIB2YT+O32P7rnLBtS08oF03t7z3YUdFHioWd82DyJdcU
JwijIOk6On9/fyRKVJ2ZtcqqSxx7Ap1OHANLx7uOOwXow/rJ+UY1Y4//mg5yc66t
EcmHkMkd4Zcb42HyEbyKQqkHn3wmKXptsDEMNOVOIslFdHK7KWM0jroyTRbDSsSg
sufP98k+bokYLvjN7+mmpgfUvUJnN/26PTkzgzSGtIWTnCYMgbIgUfpcerH6kDTs
w4+60kt3P9MY5oauD8xlsh6Od+QyguIf1Mu//XnY6fVgvWaSkt+AIH7C+6tkSovw
eenaurdx5ArrXcmzGNTV
=4dfw
-----END PGP SIGNATURE-----

--Sig_/rcrTsY_iTidXVJye7rrFJ9h--
