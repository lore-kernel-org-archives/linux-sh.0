From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 17 Mar 2010 05:47:14 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <201003170647.15084.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Magnus,
yesterday I used the following command
 git clone  git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Am I ok?

My configuration is :

SH2a 7203			smc9118
Addresses:
A1...A7				A1...A7
Data:
D0...D31				D0...D31

when I execute
static int __init smc911x_probe(struct net_device *dev, unsigned long ioadd=
r)
{
	struct smc911x_local *lp =3D netdev_priv(dev);
	int i, retval;
	unsigned int val, chip_id, revision;
	const char *version_string;
	unsigned long endian;

	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);

	activedev =3D dev;

	/* First, see if the endian word is recognized */
	val =3D SMC_GET_BYTE_TEST();
	DBG(SMC_DEBUG_MISC, "%s: endian probe returned 0x%04x\n", CARDNAME, val);
	if (val !=3D 0x87654321) {
		DBG(SMC_DEBUG_MISC, "%s: swapping endianness of card \n", CARDNAME);
	=09
		endian =3D SMC_GET_ENDIAN();=09
=09
		SMC_SET_ENDIAN(~endian);
		SMC_SET_ENDIAN(~endian);

		val =3D SMC_GET_BYTE_TEST();
		DBG(SMC_DEBUG_MISC, "%s: endian probe returned 0x%04x\n", CARDNAME, val);
		if (val !=3D 0x87654321) {
			printk(KERN_ERR "Invalid chip endian 0x%x\n",val);
			retval =3D -ENODEV;
			goto err_out;
		}
	}

if I use=20
/* 4567_0123 --> 0123_4567 */

#define SWAPDW(x)	( (_uint32)(  (((_uint32)x & 0x0000FFFF) << 16) | \
                                  (((_uint32)x & 0xFFFF0000) >> 16) ) )

//#define SWAPDW(x) (x)

/* 2301_6745 --> 0123_4567 */

#define SWAPDB(x)	( (_uint32)(	(((_uint32)x & 0x000000FF) << 8) | \
					(((_uint32)x & 0x0000FF00) >> 8) | \
					(((_uint32)x & 0x00FF0000) << 8) | \
					(((_uint32)x & 0xFF000000) >> 8)) )

//#define SWAPDB(x) (x)

The check fails;
If I use
/* 4567_0123 --> 0123_4567 */
/*
#define SWAPDW(x)	( (_uint32)(  (((_uint32)x & 0x0000FFFF) << 16) | \
                                  (((_uint32)x & 0xFFFF0000) >> 16) ) )
*/
#define SWAPDW(x) (x)

/* 2301_6745 --> 0123_4567 */
/*
#define SWAPDB(x)	( (_uint32)(	(((_uint32)x & 0x000000FF) << 8) | \
					(((_uint32)x & 0x0000FF00) >> 8) | \
					(((_uint32)x & 0x00FF0000) << 8) | \
					(((_uint32)x & 0xFF000000) >> 8)) )
*/
#define SWAPDB(x) (x)

That means no swap it seems to work but really fails.

My hw configration is good for actual version of the kernel driver or I nee=
d to=20
be carefull to other stuff?

Thanks a lot again




In data mercoled=EC 17 marzo 2010 04:29:27, Magnus Damm ha scritto:
: > On Tue, Mar 16, 2010 at 9:32 PM, Magnus Damm <magnus.damm@gmail.com>=20
wrote:
> > On Tue, Mar 16, 2010 at 8:59 PM, Fabio Giovagnini
> >
> > <fabio.giovagnini@aurion-tech.com> wrote:
> >> 2) I have a 32 bus connected sh2a D0 do smc9118 D0 and sh2a D31 do
> >> smc9118 D31; do I need a software swap? ( I followed the schematics of
> >> rsk+ 7203 eva board before to learn that for big endioan processors the
> >> designer needs to physically swap the bytes).
> >
> > I've added code to enable swap on upstream for the rsk7203. It was
> > needed by big endian platforms.
>=20
> Look here:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h
> r4cfb944007b7f8d346523a7810b53a35921bc5
>=20
> and here:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h
> =833cc67c7722e35863c6aaee9df56b442ef957ae
>=20
> > Please use a newer kernel if possible.
>=20
> If you use the latest kernel then the fixes above are already included.
>=20
> I recommend you to use the sh-2.6 git tree for development.
>=20
> Thanks,
>=20
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
