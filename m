From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 22 Mar 2010 10:49:26 +0000
Subject: [uClinux-dev] I'll I have now working NOR flash r/w jffs2 FS (flash SST39VF6401B)
Message-Id: <201003221149.26630.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

In data luned=C3=AC 22 marzo 2010 11:31:30, Fabio Giovagnini ha scritto:
: > But for making it owrking I needed to comment
> linux-2.6.17-sh7203/drivers/mtd/chips
>=20
> static void put_chip(struct map_info *map, struct flchip *chip, unsigned
>  long adr)
> {
> 	struct cfi_private *cfi =3D map->fldrv_priv;
>=20
> 	switch(chip->oldstate) {
> 	case FL_ERASING:
> 		chip->state =3D chip->oldstate;
> 		map_write(map, CMD(0x30), chip->in_progress_block_addr);
> 		chip->oldstate =3D FL_READY;
> 		chip->state =3D FL_ERASING;
> 		break;
>=20
> 	case FL_XIP_WHILE_ERASING:
> 		chip->state =3D chip->oldstate;
> 		chip->oldstate =3D FL_READY;
> 		break;
>=20
> 	case FL_READY:
> 	case FL_STATUS:
> 		/* We should really make set_vpp() count, rather than doing this */
> 		DISABLE_VPP(map);
> 		break;
> 	default:
> 		printk(KERN_ERR "MTD: put_chip() called with oldstate %d!!\n", chip-
>=20
> >oldstate);
>=20
> 	}
> 	// FABIO
> 	//wake_up(&chip->wq);
> }
>=20
>=20
> The question is:
> Does the MTD driver and the substanding chip flash handler uses the IRQ? =
If
>  yes what is the interrupt handler?
> Why with wakeup I have call trace?
>=20
> Thanks a lot
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
