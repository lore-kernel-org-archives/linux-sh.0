From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 05 Sep 2015 07:31:43 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <20150905073143.GA1616@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <5464456.UnsMOS3MTx@avalon>
 <20150903204000.GB1574@katana>
 <CANqRtoRo7jemt52=mcmu=mf5dGsqwWKWA5aBYd7L=vFas6d+NQ@mail.gmail.com>
In-Reply-To: <CANqRtoRo7jemt52=mcmu=mf5dGsqwWKWA5aBYd7L=vFas6d+NQ@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-I2C <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2015 at 01:33:39PM +0900, Magnus Damm wrote:
> Hi Wolfram,
>=20
> On Fri, Sep 4, 2015 at 5:40 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> > So I refactored the driver to setup new messages in interrupt contex=
t, too.
> >> > This avoids the race for b) because we are now setting up the new me=
ssage
> >> > before we release the i2c bus clock (before we released the clock an=
d set up
> >> > the message in process context).
> >>
> >> Could this fix the HDMI EDID read issue on Koelsch ?
> >
> > I surely hope so. I can't test because I don't have Koelsch.
>=20
> FYI, I have enabled Koelsch remote access on port 8001 if you want to
> give it a shot!

Thanks! Is there a HDMI monitor connected?


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6ppfAAoJEBQN5MwUoCm2RsEP/jNcSgCMrG5jt+1cl/tQQ/l3
9BhoxnZH/L84wY5lUf3YZcxGA/6llknAos8Fu0+tvEJl9rEtAukWG4uhkcK+aMvP
+YAqSmpOyFw3c5JWIt+kUg4F08VFquwnQPKnRtd/ygIiE5o+MAuZN2rI9Vips4aJ
DeepAAUU3TDQ4t51p16JSpOHvKxD7sv2I4sbX1XTd0IuaPNcN7nN2ZSO343DgpJT
fBE+8XP5cwvfgXcbIiwiPt4vUbnjOl+X7EJQ4R0GYb0APKTabadIfERjHq/bLlyJ
Ojpove0MfV8vbWWis1uWIQxmh06pCxxB/XhqgJKJK1Pje40F8KU4vLz9nwOLzdFZ
R+7nZqEp/oyPeAk+nWD2RDlcr/Jm4Npw9ripMF42cAHlIxv6yNQ/EocgzakmkC92
KxFJgkPoxBc4K4fbYXYRTB6KMsZOqXfQUYR2hs0ZzCTmWFwTZJC7D8+BncF88iCq
L/LyVFnw9qjGHmcKsg9Qg4oCeAM4ARpS+HwhV3i4LSe7/LLXtdlD/qf5J6PKxetJ
fFq29wBHBt2gVWNYpPqKL20UsIVFOvu0227K6bUN+7mpzft0kAc/qwjoCNOPcvHJ
nwYym1SzAX1A756CweckmXeKNt7Fo5nd4+PcSdLV4We9LCOarElAF9aCKK+mkA5Z
1B8nnKhlN8SW9u7rFDJa
=je2l
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
