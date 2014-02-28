From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 28 Feb 2014 19:55:53 +0000
Subject: Re: [PATCH 01/03] ARM: shmobile: Introduce shmobile_clk_workaround()
Message-Id: <20140228195553.GA2517@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
List-Id: <linux-sh.vger.kernel.org>
References: <20140224072921.3522.55023.sendpatchset@w520>
 <20140224072930.3522.54629.sendpatchset@w520>
In-Reply-To: <20140224072930.3522.54629.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 04:29:30PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
>=20
> Introduce a new clock workaround function used by DT reference
> code on the mach-shmobile subarchitecture. The new function
> shmobile_clk_workaround() is used to configure clkdev to
> allow DT and platform devices to coexist. It is possible for
> the DT reference board code to also request enabling of the clock
> in case the driver does not implement clock control.
>=20
> Signed-off-by: Magnus Damm <damm@opensource.se>

Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
Tested-by: Wolfram Sang <wsa@sang-engineering.com>

I use it for r7s72100, too, meanwhile.


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTEOnIAAoJEBQN5MwUoCm2N5gP/1iPtARxOUg0+DA01Z+kA1NK
mVibjfj/RMqcZ28nU4la27EvM//EJrb0ZYVHg/WbQitfFjwJlFBL8iYoDT5lJqCr
oc6l88kJ6JsShL05XtlwHvcpR/4KNv4ZRjdpOuR1v/aDNVDUQtiz4+fOSHnPCLMg
/UDyX0Xqq5GC5DJSyP44hgBekNTzNFSy/6UbxMt0dRfpYKEC38r/PGX8OyBpk7ti
CDWrSP6s7JZjw/WUE9LmYBJKburOEljEjZsmfXzqCII+8sTtSbi8OKRLGiPAELF7
xgoyeurnPR4w4diNdt+dMLdrzvxY3tJY+ot/3SADL+JvbZJPn14jDx8+Yg/CVRay
MDi/dLqMekHb3BZVBFp86eMQOtDj17P1wM2czDqzvvPPlx6CevjPLCAwctUNyYGs
86KKoxCckGV6yq+iQBDY76r6+2fsNpjH9qZeefgoXYCV8aj02pENu45VCiPrMpTT
hmYOB4qVmr48nGnWSq2s1dpEb3yXjlAq3wamyscjgXaDDeG1LcFTfiWigbjM63I0
Aii05E6xNlZ9VBunl6p8K05uUAvtzqfw1zyDSX1Escz7o/5/3Dc2eHK+I6rlCPOJ
rKJtjNQxwmdCm7x/Dsagd+qDK0ji4O1B4SeBIZnylPiWeTPo6JI3JtfRuXHYg8go
1bjQB8ogm7OIrbYE61qh
=qzim
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
