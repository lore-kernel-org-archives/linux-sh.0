From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 04 Jan 2016 16:10:22 +0000
Subject: Re: [PATCH RESEND 2/3] drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
Message-Id: <20160104161022.GA1599@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
List-Id: <linux-sh.vger.kernel.org>
References: <1451874827-2531-1-git-send-email-wsa@the-dreams.de>
 <1451874827-2531-2-git-send-email-wsa@the-dreams.de>
 <2199297.HWp4hEOABu@avalon>
In-Reply-To: <2199297.HWp4hEOABu@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> A small note though, even though the patch is correct, it will be of limi=
ted=20
> use as the EDID_READ_CTRL register is never accessed by the driver.

It was useful to me when debugging and looking at the register set in
debugfs.


--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWipltAAoJEBQN5MwUoCm2+KgQAK/22d4jVWP+p7BuN5maNzfC
8mQEi7Nt3VvC9i6AlK1iy/BF5cbmcI9GoOzOrzEh2D515wbnAqTNLBoHS6ygp72s
xAjhcQJRg/88URND+3vsmYNKoCc6BMW03K9EHQxCXhWYHQyFPCqxcLDticYjFnry
EAno5NWsOf/LeCbsFENXg1lAGVHG66EsE/VfouvIr1h+tLSJ51f4EwZSB+izPzJS
ztxRuBvS7p4fum1FUSeso4Zeoy6Fs7dYZpNhJ8vXkNmZ48oaUzq0AVB8U6UU3adt
TVTTh3fKER95ft/vYzIDCU00kyjwpxXvg6mDAcL4tzMAIsWanRKbMNDByPQo60w4
zJPhgn4UYegaS4Spfcj+Jf6vWoFhC/0VFjDbveQ3Yjc7UepfSTb7wuDpLuG5AGu5
IoQMTEfPUhzPThHCXtbDOV4RFS+1ySfNSdx81CGp0WCwQKrUzmd4XBY5Bz1Hp8hi
rb29BoyL0yWOYuWjTMwJxKcAEAIpEBiJSG42OOeJmot4buI29LCwtFHzRQxjl90Q
g68ypXVOphLrsm0lHehg/GsQsqQT3zLdutiiFuEOQNITlR1x2Eo6/Kid+sb2EhAS
yIOhZC07fPm3I6gULPBL3eNhywtbQyAQAGiU2KYO9w/DzlvO0KkXDBwuh2olwKBj
ZXCKvltUfHeO8Q6/aWXQ
=H2hR
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
