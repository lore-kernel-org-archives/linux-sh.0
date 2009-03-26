From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 26 Mar 2009 18:16:22 +0000
Subject: Re: sh-2.6.git fails to compile with gcc-4.3 (warnings treated as errors)
Message-Id: <200903261416.23539.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6758651.CjVfebnPTR"
List-Id: <linux-sh.vger.kernel.org>
References: <49CBC30E.9020901@gentoo.org>
In-Reply-To: <49CBC30E.9020901@gentoo.org>
To: linux-sh@vger.kernel.org

--nextPart6758651.CjVfebnPTR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 26 March 2009 14:01:50 Ra=FAl Porcel wrote:
> cc1: warnings being treated as errors
> arch/sh/kernel/setup.c: In function 'early_parse_mem':
> arch/sh/kernel/setup.c:111: error: format not a string literal and no
> format arguments
>
> I just used the default sh7785lcr_defconfig .
>
> Paul said its easy to fix, so feel free to submit a patch.

a different patch has been posted but apparently not merged yet.
http://lkml.org/lkml/2009/2/4/259
=2Dmike

--nextPart6758651.CjVfebnPTR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iQIcBAABAgAGBQJJy8Z3AAoJEEFjO5/oN/WBoiYQAIzpomG7fwi+VPU2k67cwmXG
5K02u5HrE53aYnHOCYvWa+NFqjVvc76bWuHAYpGiT45wqpnXC0HsV1p0F0tf8auv
4wdHNB/MId1bu3pwqS6WakD0Bk6Ue2Ubbrk3G9LwDgsClty6RWyk8cZixqeIFnMg
rM375YsVIYY50Foma7/jGfxCIM/Ghgv6eOl77I6inhSMTChlgf8RHMbY/y2SXXQt
TMYadjhCe1XKkxNBTiJq7L9lEubwKa+3TyCDTu7wnHL/+jMhM8k8aBV2Z13pdJxu
jPasCmwMq7QIrVLUOJEsvSMWJka7mXigS/Wp/V/VZecYjVuIt9PlKz8gXmF2Pvx4
zj1pfYJApKA1wb86dC91hF8AnHoxeR+30/o1eP5Sjx+r755TSBh0J+PMcig5ckBy
Qii3p/n6GCv6xjcK1DBzIrCx1sS6swRJK4QuP/H+T6QM6RPxY9JxceHwmgv/1i6M
b/NCXXm4ixu/8g94WEY8ttHwu/CgZCITfSOMxGVaHPYWlc8XWN2b/japCqKy3NZv
RwqxTzl55p8/ogMRIKVgnP2sst4kLGmh5pF+SbIZIHSbcna0L8zty2Lm5MxxEKvi
ViBtNZ3jOl16J2kiz+g76g3n+9FsifvdDzUEoLJ9eK/wJpU7P0S1R6kPgzbjARMP
rOICIMyW7pW5t29f83Eb
=qZc4
-----END PGP SIGNATURE-----

--nextPart6758651.CjVfebnPTR--
