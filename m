From: Luca Santini <luca.santini@spesonline.com>
Date: Wed, 30 Jul 2008 16:23:10 +0000
Subject: Re: i2c_board_info use
Message-Id: <4890956E.2000800@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48906795.9040101@spesonline.com>
In-Reply-To: <48906795.9040101@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Thanks Manuel.
I'm trying the conversion.
A last (i hope for you) question: i cross-compiled alsa-lib and=20
alsa-utils but i don't know how to configure alsa without alsaconf and=20
alsamixer (no lspci, no lsmod, no ncurses avaiable)


Manuel Lauss wrote:
> Luca Santini wrote:
>>
>> can you suggest a new-style driver for inspiration?
>=20
> This might help. I wrote an AD1939 driver a year ago
> which went into the ASoC tree with old-style I2C probe code.
>=20
> Here's the version with old-style probing:
> http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-asoc.=
git;a=3Dblob;f=3Dsound/soc/codecs/ad1939.c;h=EEe858acddcb5a414a52f862204a6a=
2c4d519239;hb=15fbaddfbb16309c37f02341425b13046af3f215=20
>=20
>=20
> And here's a version with new-style probing.
> http://mlau.at/files/ad1939.c
>=20
> You should be able to use the differences in the i2c probe
> of the 2 versions as a template for wm8731 conversion.
>=20
> (I once had a patch to i2c-sh7760.c which implemented SMBus quick
>  in a crude, non-i2c-maintainer-compatible way, let me see if I
>  can dig it up again...)
>=20
> Good luck!
>     Manuel Lauss
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
