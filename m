From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 01 Feb 2016 13:29:21 +0000
Subject: Re: [PATCH v2 1/3] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <20160201132920.GA10607@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
List-Id: <linux-sh.vger.kernel.org>
References: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
 <1452290210-20629-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452290210-20629-2-git-send-email-wsa@the-dreams.de>
To: dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Magnus Damm <magnus.damm@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 10:56:48PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The interrupts for EDID_READY or DDC_ERROR were never enabled in this
> driver, so reading EDID always timed out when chip was powered down and
> interrupts were used. Fix this and also remove clearing the interrupt
> flags, they are cleared in POWER_DOWN mode anyhow (unlike the interrupt
> enable flags) according to docs and my tests.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Archit Taneja <architt@codeaurora.org>

Unsure who is the right person to pick it up, adding Hans to CC...


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWr12wAAoJEBQN5MwUoCm2MAAP/2N2Ckfgya5J2D1P75sUv/Tj
oiBsr35JG6CzX/Z1UTSNJpTZuj0rD6TlOMqfroTd58w2icBM5XVHIop2bBYUBVHG
xMyfTIg0V085oqee7Lv6o0CTAaeIJqg1ihxTklvBWnB6GNWwXdA7KfzlPqCJml8t
XJqhPpDSSmZ1NDSI3Iffu32ZPD8Gm8gO1KZA+i6kUlBdwwZ0VxatV8/lcoNCTQHd
APriVttfLQs92VmbZIZIobSIarRSvvoMDo0sSPC1eOD81w0wBBgs+msOj/8l4yS9
+SwQ28FpSzqoOMhyZyOXZx8QXsRN1Aq7jANRdm3bmSoApUVzrMptdRfef1ofC4Q9
e4rqJaAAjSEhIzNfWfIlLAueBjJeornAgpFwBPmbdYR4Lahb4h14AXXr0+zo2MT5
07xNiOsJcvH1vfJzHkLlrnAKUM7wzt0lUvV9qt8CTcaadnu6NKYmfOE41Q18zvD2
vjuGr0UNTPbuto1JHXy9dRMJtvVe33ANBqVlqW/HQrVipzAF0kjEG5i0zfEeLfF1
xnr/BjwVYnr/4qAYUaskWXkeR/Lx8r/Yy82feBIDJ8AGj/uYHVhN7WnrzkC/SJls
KGJwirABiFjbwFFJQuIuAHsB7L6aY0FFksaCfV++w5NA/CCFG+bFqTEvc+4UUjY+
jpz40nDUBVsHt7PpskwI
=fuvc
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
