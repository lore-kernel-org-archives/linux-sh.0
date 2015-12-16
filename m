From: Felipe Balbi <balbi@ti.com>
Date: Wed, 16 Dec 2015 15:49:34 +0000
Subject: Re: [PATCH] usb: gadget: renesas_usb3: add support for Renesas USB3.0 peripheral controller
Message-Id: <87wpsefl69.fsf@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <1450162472-6664-1-git-send-email-yoshihiro.shimoda.uh@renesas.com> <7989573.HuGUrIYJy9@wuerfel>
In-Reply-To: <7989573.HuGUrIYJy9@wuerfel>
To: Arnd Bergmann <arnd@arndb.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
>> +struct renesas_usb3;
>> +struct renesas_usb3_request {
>> +	struct usb_request	req;
>> +	struct list_head	queue;
>> +};
>
> There is already a list_head in struct usb_request. Could you use that?
> (I don't know, just asking because this looks odd)

no, no. Don't do that. The list_head in usb_request is for use by the
gadget drivers and the gadget drivers only.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcYgPAAoJEIaOsuA1yqREpyoP/RqwNfttuepxwlFZT6HPQ/Yb
4tsUau3lDz9DasWSD0S/aFCz2Jw2rJHWvcLh9YsEBCpn9jzc3al2wkF9pr0GFKtu
hczDtxStN4R6G6GC6apfAi8+0DTaEVxWFFS+IgAH7jpXMNHsW3aMipTUdVMh4oKn
GcihTxU3eYgyfQq01j4h/JyJcbuXwkDTVmmlazjKVAg424S6fJkOUZJn7oelzc+A
B+nzqXlYuh05SprqmUYcw7mjJtcrQE+y2YnC32Qt2r2fcW6f+nP5Re8Ty47SV6MH
PNIS+aDMiKQ8tA7Zx3gCcb26WVxVdH7KK11nG3Mp8XkoPwHUu27dDlgaXy+qGdLZ
++L2c0H+6TVGxRg9ueQjuTJTrxFFKWqru6eIYsI5MXK9s83lRwBeqpCEZ9Fad9bq
xIXFzXsVW8xoaS+N1Fr2qveQt2IERJ7wJlCqBLSr/MxuE32CrgfCVuckBCeZ/ARw
4vgpNuKLnOR5cDGSCt41Q3mzzedErp3hdT5K4+efcAxKFOMLSSjNrgAEmxPcDJtV
rk6XB5cMrSJOkBgXAknzPG9GJH8k0HizDnYnzu+FB3o1oNgRe0F9DRTMkOsEJyIP
ilk51SYrGoc1j7oOpRkD1n4G4RjDZPfQWA5lKoH4ZJp09manyGr2Uk8mU54TJKKs
icWUSmqc+7VqWvlD/X9z
=A0lP
-----END PGP SIGNATURE-----
--=-=-=--
