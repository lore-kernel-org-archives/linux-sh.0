From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Jun 2014 20:24:37 +0000
Subject: Re: [PATCH 00/11] i2c: rcar: cleanup series
Message-Id: <20140601202437.GB3853@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jq0ap7NbKX2Kqbes"
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2014 at 09:44:35AM +0200, Wolfram Sang wrote:
> Here are some patches to let the rcar driver have a diet without losing
> functionality. IMO the code becomes more readable, too, although mileages=
 may
> vary about this or that change. Bus-free handling is improved, too. Teste=
d with
> renesas-devel-v3.15-rc7-20140526 on a Lager and Koelsch board. The git tr=
ee can
> be found here, including one proof-of-concept enablement patch:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rcar-=
cleanup
>=20
> Please test, review, comment.
>=20
> Thanks,
>=20
>    Wolfram
>=20
>=20
> Wolfram Sang (11):
>   i2c: rcar: not everything needs to be a function
>   i2c: rcar: no need to store irq number
>   i2c: rcar: refactor bus state machine
>   i2c: rcar: refactor irq state machine
>   i2c: rcar: check bus free before first message
>   i2c: rcar: refactor setting up msg
>   i2c: rcar: refactor status bit handling
>   i2c: rcar: remove spinlock
>   i2c: rcar: reuse status bits as enable bits
>   i2c: rcar: janitorial cleanup after refactoring
>   i2c: rcar: update copyright and license information
>=20

Applied to for-next, thanks!


--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTi4wFAAoJEBQN5MwUoCm2LEkQAJVuVUcxf+uHRKzppzTAarCT
VHg/odSTp9lNCs0H49dRU8WNabMNU/4c1fa/brFpPyH383XPFvUdYiW4OniaqxTY
5kVaX+BtmGxC4qXFry5fcrnWVSIJAOfKwzVwC+3vqFfPGP+CyGHgf6+CbXc0JlCC
g3bBn3EJ6ujPdi6/W8XbMoUoUD/rpVE556gN3wxCXWfnH2kV34f1Awe2LZpcEl9Q
GIPNLU8MsQlBPw5B3/+ldWUbWMx9FxENFdZ2E5tkk6u8BxJBh3Drcr/FInqh0aXQ
ge9zTh+UT8d3RwPdrAohdjdUN/sVmIqpeDKVINdeqJf+wxYJf35XVfxcyv61+cBk
x7GnSdB+xw+gsZpESuXJ2NZ6mrjeH77/ge5mCoY4OdMayaNs/Tp1SVSg5lBkL4Hv
p/iTqbFGyeVOqH07e2EsxsfhpCZgKBhdF3DM3Xhliy1y0E7AGT6muc/cEs29l9qt
SrkwdvokgO6qvH6+18M4+g+HLumR8QmfSpoUlqsJd+hG5NB4mOqvZVNPplH5yh4f
+a76gpX8hlCNOkGMLHi/6MQmm+O4LcynzaV/BQM8Hb0LlFRMcvxJ+qhUJ+h7/CV4
DIGBOdYQS4zxb6nrIZDwxb9ap0IXJB30EzSi2O+BizQ56LytJe2iJ8nv28EM+aS9
FdJ7g0B5Yve0SSKlTkvr
=le4Q
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
