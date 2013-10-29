From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 29 Oct 2013 05:03:37 +0000
Subject: Re: [PATCH 03/19] i2c: sh_mobile: Enable the driver on all ARM platforms
Message-Id: <20131029050337.GB2643@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E39vaYmALEf/7YXx"
List-Id: <linux-sh.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383004027-25036-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2013 at 12:46:51AM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

I wonder if those two Kconfig patches couldn't be squashed, but other
than that:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSb0GpAAoJEBQN5MwUoCm2qsAP/j1P8JqMfRLQBzym+XBcvCBC
lbdQ3pYEJH+tvVOsKV026h+yBlwKOKa2tWokwFzxCk8xmzOH84Js93UeAaOkBXza
stGIffpl1kvnwISUV14OYogCl2TOiC0dcTMwUDeyDkVd7B3aTu98iq4zh5ykqaqi
in9GTJ3/pLFHKDezzOId1cIaSfWEQQBLXzP6y9/gLd8Q7XZg66ao25Eyw7tccToh
JquE1CtIArPjKm4q5j7CBeyEKBi3wpVU/06vBTOelN7onjIAe/n6MQqiFlgT2pJy
/B73RTkg5jK9rccwaij9U2SOz7udgN+CyPDimnktdlGBqBOs3NYa2OyjnpUxaIjz
cM/Y/KhWXmOgDj5pAaOIoLF/caOTSBaYGT8ULVoNY4tQusw8J41s5oy/yjkbxvRg
fevbVCsmayUbcSFItJjS3LBejFcNEnZy217nJwmCs1J9Yoc98RrvI4736KLtmNEL
xRpCMWf+ZlABxzNGCj1I2vVpJgkC/NAWYRTflFL8MMdfFtI9XwXILafyuJxr3EEj
R7JR+/67GrfBRVeFCDnxVebmmapP2Q7RACsAbFoLCU3NA0YOTs4n5E9alLCgNcS2
RWQ5wSqJRrMySujUKE2jx7XHuywWjJbEzkg7CHSnVh4B0P2NUgZQ8oP0dzoMQCFJ
W8wOL00zPIDt0jhVq4yB
=dMA+
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
