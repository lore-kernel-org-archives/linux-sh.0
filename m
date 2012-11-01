From: Michal Nazarewicz <mpn@google.com>
Date: Thu, 01 Nov 2012 16:29:38 +0000
Subject: Re: [PATCH 1/6] arch: Change defconfigs to point to g_mass_storage.
Message-Id: <xa1tobjhwakt.fsf@mina86.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.44L0.1211011033170.1762-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1211011033170.1762-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Wed, 31 Oct 2012, Michal Nazarewicz wrote:
>> --- a/arch/arm/configs/qil-a9260_defconfig
>> +++ b/arch/arm/configs/qil-a9260_defconfig
>> @@ -108,7 +108,6 @@ CONFIG_ROOT_NFS=3Dy
>>  CONFIG_NLS_CODEPAGE_437=3Dy
>>  CONFIG_NLS_CODEPAGE_850=3Dy
>>  CONFIG_NLS_ISO8859_1=3Dy
>> -CONFIG_DEBUG_KERNEL=3Dy
>>  CONFIG_DEBUG_USER=3Dy
>>  CONFIG_DEBUG_LL=3Dy
>>  # CONFIG_CRYPTO_HW is not set

On Thu, Nov 01 2012, Alan Stern wrote:
> This seems to have crept in by mistake.

Yes, obviously, thanks!

I have updated version prepared, will send it tomorrow in case someone
have some more comments.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQkqNyAAoJECBgQBJQdR/0YTEP/jnfvfot7qkoowcjQ5v+QRHg
Ixubb3k2W/hiSvgttLx2Wek3OLmEXVG/6EAZT/1I/m2ddilFri5HAUm9Hd7YoH8U
bkjhIyHJyRDQkGSN4znlxHglnwdqk0hxIemcei/FjBGCCqDysIgXDX3HWbYKkTwO
N6MI7zbEXK9nV+AkGXz1AUa7xTw88M5X6TK28DIt9AIDpXpD4cI+Dv2l39EZirom
D2gHZc18wcvdYrNEm36ePn2RHETe6HDijOWrxRmN0sf4S/sxHhpR/OwAlXuOSlir
gvu3P+nzCDCKNTpg2eGbrkJxwL2B36YQwIm8CZOaE6p/3QBi/mWKCDzqgLyUsy3I
peYosUiRPtzNJ8h5nSm1LX+xRU0B6oxKYYzBdJPeGIsmZn44Shn7UN+3PZw4r6fu
8rb+WyFr4U5abHzpEmOf0PMr5EexTf1HPayLcEKpapEiCzW6p3okJCSLCbMLmB1Y
qGOMO0rVB8gw2zuh2L+fuHwN8uZ0wxrvFWgWIDNwSVIy6xRvN5qKrJ0MtRYhDZ1D
szTEisr5qr9Frj1nAuZVwo2ZiCEwvDX6DLT294NP8On27BaNVhELT6716NMqozAv
LP84gnqJBA0T5UHxLp0zCTI3t/ctIz8n49BCuDP3dk3koNUwlT/8bpr5FJkxm9we
bPkmNPz32ukFI26OiI/R
=zLzH
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
