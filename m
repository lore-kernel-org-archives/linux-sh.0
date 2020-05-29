From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 29 May 2020 10:35:08 +0000
Subject: Re: Build fails with unknown symbol __get_user_unknown with InifiniBand enabled
Message-Id: <60c9b069-0287-5d28-bb6c-6fdf7560f8e8@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
In-Reply-To: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 5/29/20 12:21 PM, Geert Uytterhoeven wrote:
>> Would this be fixed by Arnds patch series to remove SH-5 support by any =
chance?
>=20
> No, it won't. As this is uaccess_32.h, i.e. for sh32.
> All architectures are supposed to implement 64-bit get_user() accesses.

Ok, I assume we need an implementation like this then [1]?

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=B2f680380ddf2f003882e59e00acd6c1952f91fc

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
