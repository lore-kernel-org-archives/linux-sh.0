From: Felipe Balbi <balbi@ti.com>
Date: Tue, 30 Apr 2013 10:37:27 +0000
Subject: Re: [PATCH v6 7/9] rcar-phy: add platform data
Message-Id: <20130430103727.GE12161@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="maH1Gajj2nflutpK"
List-Id: <linux-sh.vger.kernel.org>
References: <201304231933.00604.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304231933.00604.sergei.shtylyov@cogentembedded.com>
To: linux-sh@vger.kernel.org

--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2013 at 07:33:00PM +0400, Sergei Shtylyov wrote:
> Currently the driver hard-codes USBPCTRL0 register to 0.  It is wrong sin=
ce this
> register contains board-specific USB ports configuration and so its value=
 should
> be somehow passed via the platform data.  Add <linux/usb/rcar-phy.h> file=
 with
> the 'struct rcar_phy_platform_data' containing various bit fields describ=
ing
> USB pin configuration.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> ---
> Changes since version 3:
> - moved USBPCTRL0 register bit #define's to patch #9;
> - replaced USBPCTRL0 register value in the platform data structure by a s=
et of
>   bit fields describing the configuration of the board, rewrote changelog;
>=20
> Changes since version 2:
> - added #include <linux/types.h>;
> - added ACKs from Simon Horman and Kuninori Morimoto.
>=20
>  include/linux/usb/rcar-phy.h |   26 ++++++++++++++++++++++++++

the new location for platform_data is include/linux/platform_data/

In fact, musb.h should move there eventually.

--=20
balbi

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRf57nAAoJEIaOsuA1yqREJUUP/2bfPEUUvl+6MRKF8QycgoOJ
/ExE5yiADHoAu3VUJFXCArAPZ2vLfJlLjhYrWSHRHQWpKF4odIuEdJ7vkToU1S61
DJ373RVMBWN/foXBngK0avnAxy4Xs/YB64YeL7YMqQXfsCze9HtJz2P58fDxBeWW
MuBjTz4RbbpkQU7oFnINJB8crlTXSI//syNpn6JrCb0SA9upD8af7OMKGPYZhkRy
EW00DpqHtPtXDKs8idQHS52gLbBog8oBVXpWoCGw/vjHekAuRvijpfQj5y9xUe6C
QQ0ddTVxsghgNitYB1ob5KwDvERsO2En08jKZ7TvH3W+elYREYQeK4CkT8gmpzzZ
2al29Whcwo2y2jGWWNZDs4l8gYyjS5VNOl4+km8rdDCT2JcZQPOtZqWyQSdGkFel
pF4eOcFj2BxWDff0sx+x3kLzCUhDne6T0fR8kdRWFZcOcqxVYodKnQsbt4R8z9fb
iVN/JGwdOP5a1F2p3Ns+lyG8T0NqbQ3+bKrK6nJbZDGi/evLeytAJPEF8goFV+qm
17GwgVoQhrkrIZJUYHipHOW7vxdR7UkRLcgU6waYsJHKeAKeNFAGKcg9zVmFHj1a
dqXy32ZE/BbGzZwb5iN1nPGojGfdfVMSWzuWeMLV2n6FNig3xv7wkQ3Avf+O2OpK
nmaSFkwc+/MDxjblrjna
=x+AR
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
