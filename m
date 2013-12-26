From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Dec 2013 21:25:39 +0000
Subject: Re: [PATCH V2 2/5] arm: shmobile: r7s72100: add i2c clocks
Message-Id: <20131226212539.GA2561@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
List-Id: <linux-sh.vger.kernel.org>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-3-git-send-email-wsa@the-dreams.de>
 <20131224024855.GC22401@verge.net.au>
 <CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2013 at 10:20:23PM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 24, 2013 at 3:48 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Dec 18, 2013 at 10:31:58PM +0100, Wolfram Sang wrote:
> >> From: Wolfram Sang <wsa@sang-engineering.com>
> >>
> >> Tested with RIIC2 on a genmai board. Others untested but hopefully
> >> trivial enough to be added.
> >>
> >> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> >> Acked-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >> V2: adapt to established sorting
> >
> > Thanks. This seems safe enough and I will queue it up.
>=20
> Note that after dropping these lines:
>=20
>        CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
>        CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
>        CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
>        CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
>=20
> i2c stopped working.

??? Why do you want to drop these lines?

If the i2c clocks are not registered, you won't get i2c support? Am I
missing something?


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSvJ7TAAoJEBQN5MwUoCm22EsP/3R08ReJJU1BStBhjZb2km8Q
aoDwySKopLVd0xtmLHcnwbcjfsxvHRgkcq1sZxVVKixxl3LWHR+BbFFJwQ1xZFfV
hGICGhJn3JLtqAiJoh4GZA56H5SFqSjqem85B4Ld9/BomWeYB3rYW6J7U8KAT2hl
VKOFQbMfs452LuIo3OtyYxSOaoemWKgd/lwOZdGm9ul5wafV2nYtcVarQlIWWN1u
SrB+TR3OY6Th6927fzkfMHeWY+WwdIqsl1q0ag4OhgIrKa3sGLMK8rTe9p+H+Ev3
wD0tEQDYPzPbRanj4l/dr3YkI/nA7bIT5mY7BgjyOjWH0cjLVK6J5Yp+o+4z9EJQ
/39uviq+XkPAjkfJspmpFu96QsszbTGE4EI+cIvEsus14a+ojtf4U1KRD5sX+KLR
SErr4nAIIDnygY2NGGVSeq5+obV25ho5+OoUUT7JjormREZbpInCL3BhpJ5/1HeY
aLr3l1BOzp/maNZuPgEk4iVyFOl+x8YNSA/h0y50pFboQRTRBMtPYezGQu5NPw08
MCoGwoLHJby29TiWSzgPmB+XRRHGqotGcegESr3lL0DJ+CSej9Bo4tTikzbdKTNe
ZatI29H5WxoSVaJ1+RFU4DuCNmaJy40iI5ygrR4zjnCnnZK0IpNAu+uWyx/pQRpO
47o8LstY9GQQAsnkFOeY
=92Kf
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
