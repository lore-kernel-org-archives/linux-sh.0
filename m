From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 17 Mar 2010 06:15:05 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <201003170715.05296.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Magnus
I'm tring to build the new 2.6-git kernel
I'm using gcc-3.4.6 based toolchain;

I get this error
  CC      arch/sh/kernel/dumpstack.o
In file included from /home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/bitops.h:10,
                 from include/linux/bitops.h:17,
                 from include/linux/kernel.h:15,
                 from include/linux/kallsyms.h:9,
                 from arch/sh/kernel/dumpstack.c:6:
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:166: warning: parameter has=
=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:167: warning: parameter has=
=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:168: warning: parameter has=
=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:169: warning: parameter has=
=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:170: warning: parameter has=
=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:171: warning: parameter has=
=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:172: warning: parameter has=
=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:173: warning: parameter has=
=20
incomplete type
In file included from /home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system.h:183,
                 from /home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/bitops.h:10,
                 from include/linux/bitops.h:17,
                 from include/linux/kernel.h:15,
                 from include/linux/kallsyms.h:9,
                 from arch/sh/kernel/dumpstack.c:6:
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system_32.h:233: warning: parameter =
has=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system_32.h:236: warning: parameter =
has=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system_32.h:239: warning: parameter =
has=20
incomplete type
/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6/arch/sh/include/asm/system_32.h:242: warning: parameter =
has=20
incomplete type
make[2]: *** [arch/sh/kernel/dumpstack.o] Errore 1
make[1]: *** [arch/sh/kernel] Errore 2
make[1]: uscita dalla directory =AB/home/fgiovagnini/sh7203/sh7203-
uClinux-1.4/sh-2.6=BB
make: *** [build] Errore 2


Which toolchian I have to use?
My host pc is ubuntu 9.10

Cheers


In data mercoled=EC 17 marzo 2010 06:47:14, Fabio Giovagnini ha scritto:
: > Hi Magnus,
> yesterday I used the following command
>  git clone  git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.g=
it
>=20
> Am I ok?
>=20
> My configuration is :
>=20
> SH2a 7203			smc9118
> Addresses:
> A1...A7				A1...A7
> Data:
> D0...D31				D0...D31
>=20
> when I execute
> static int __init smc911x_probe(struct net_device *dev, unsigned long
>  ioaddr) {
> 	struct smc911x_local *lp =3D netdev_priv(dev);
> 	int i, retval;
> 	unsigned int val, chip_id, revision;
> 	const char *version_string;
> 	unsigned long endian;
>=20
> 	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
>=20
> 	activedev =3D dev;
>=20
> 	/* First, see if the endian word is recognized */
> 	val =3D SMC_GET_BYTE_TEST();
> 	DBG(SMC_DEBUG_MISC, "%s: endian probe returned 0x%04x\n", CARDNAME, val);
> 	if (val !=3D 0x87654321) {
> 		DBG(SMC_DEBUG_MISC, "%s: swapping endianness of card \n", CARDNAME);
>=20
> 		endian =3D SMC_GET_ENDIAN();
>=20
> 		SMC_SET_ENDIAN(~endian);
> 		SMC_SET_ENDIAN(~endian);
>=20
> 		val =3D SMC_GET_BYTE_TEST();
> 		DBG(SMC_DEBUG_MISC, "%s: endian probe returned 0x%04x\n", CARDNAME, val=
);
> 		if (val !=3D 0x87654321) {
> 			printk(KERN_ERR "Invalid chip endian 0x%x\n",val);
> 			retval =3D -ENODEV;
> 			goto err_out;
> 		}
> 	}
>=20
> if I use
> /* 4567_0123 --> 0123_4567 */
>=20
> #define SWAPDW(x)	( (_uint32)(  (((_uint32)x & 0x0000FFFF) << 16) | \
>                                   (((_uint32)x & 0xFFFF0000) >> 16) ) )
>=20
> //#define SWAPDW(x) (x)
>=20
> /* 2301_6745 --> 0123_4567 */
>=20
> #define SWAPDB(x)	( (_uint32)(	(((_uint32)x & 0x000000FF) << 8) | \
> 					(((_uint32)x & 0x0000FF00) >> 8) | \
> 					(((_uint32)x & 0x00FF0000) << 8) | \
> 					(((_uint32)x & 0xFF000000) >> 8)) )
>=20
> //#define SWAPDB(x) (x)
>=20
> The check fails;
> If I use
> /* 4567_0123 --> 0123_4567 */
> /*
> #define SWAPDW(x)	( (_uint32)(  (((_uint32)x & 0x0000FFFF) << 16) | \
>                                   (((_uint32)x & 0xFFFF0000) >> 16) ) )
> */
> #define SWAPDW(x) (x)
>=20
> /* 2301_6745 --> 0123_4567 */
> /*
> #define SWAPDB(x)	( (_uint32)(	(((_uint32)x & 0x000000FF) << 8) | \
> 					(((_uint32)x & 0x0000FF00) >> 8) | \
> 					(((_uint32)x & 0x00FF0000) << 8) | \
> 					(((_uint32)x & 0xFF000000) >> 8)) )
> */
> #define SWAPDB(x) (x)
>=20
> That means no swap it seems to work but really fails.
>=20
> My hw configration is good for actual version of the kernel driver or I
>  need to be carefull to other stuff?
>=20
> Thanks a lot again
>=20
> In data mercoled=EC 17 marzo 2010 04:29:27, Magnus Damm ha scritto:
> : > On Tue, Mar 16, 2010 at 9:32 PM, Magnus Damm <magnus.damm@gmail.com>
>=20
> wrote:
> > > On Tue, Mar 16, 2010 at 8:59 PM, Fabio Giovagnini
> > >
> > > <fabio.giovagnini@aurion-tech.com> wrote:
> > >> 2) I have a 32 bus connected sh2a D0 do smc9118 D0 and sh2a D31 do
> > >> smc9118 D31; do I need a software swap? ( I followed the schematics =
of
> > >> rsk+ 7203 eva board before to learn that for big endioan processors
> > >> the designer needs to physically swap the bytes).
> > >
> > > I've added code to enable swap on upstream for the rsk7203. It was
> > > needed by big endian platforms.
> >
> > Look here:
> >
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit
> >;h r4cfb944007b7f8d346523a7810b53a35921bc5
> >
> > and here:
> >
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit
> >;h =833cc67c7722e35863c6aaee9df56b442ef957ae
> >
> > > Please use a newer kernel if possible.
> >
> > If you use the latest kernel then the fixes above are already included.
> >
> > I recommend you to use the sh-2.6 git tree for development.
> >
> > Thanks,
> >
> > / magnus
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
