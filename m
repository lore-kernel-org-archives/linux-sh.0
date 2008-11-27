From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 27 Nov 2008 19:02:10 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <20081127210257.3a563e06.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Thu__27_Nov_2008_21_02_57_+0100_GDmP_pdckKQNp.MD"
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Thu__27_Nov_2008_21_02_57_+0100_GDmP_pdckKQNp.MD
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Nov 2008 16:49:52 +0000
Matt Fleming <mjf@gentoo.org> wrote:

> On Fri, Nov 21, 2008 at 04:34:45PM +0900, Paul Mundt wrote:
> >=20
> > So, pending a rewrite of hd64461, we should probably just leave the
> > __do_IRQ() dispatch as an option there, until someone gets around to
> > rewriting that mess. I will conditionalize it on !HD64461 for now.
>=20
> Kristoffer can you try the attached patch, please? It compiles OK but I
> haven't had chance to test it on actual hardware.
>=20
>=20

Seems to have solved the kernel panics errors, however
get some ATA errors now, weird but alot better than before.

Considering the state before this patch, I'm inclined to
ack it.

/Kristoffer

Linux version 2.6.28-rc6-00007-ged31348-dirty (kristoffer@BoTux) (gcc versi=
on 3.4.5) #4 Thu No8
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - ffffffff
... ORIG_ROOT_DEV     - ffffffff
... LOADER_TYPE       - 00000001
... INITRD_START      - ffffffff
... INITRD_SIZE       - ffffffff
Booting machvec: hp6xx
Node 0: start_pfn =3D 0xd000, low =3D 0xe000
Zone PFN ranges:
  Normal   0x0000d000 -> 0x0000e000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000d000 -> 0x0000e000
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: mem=3D16M console=3DttySC1,115200
PID hash table entries: 64 (order: 6, 256 bytes)
Using tmu for system timer
Using 5.528 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13896k/16384k available (1286k kernel code, 380k data, 76k init)
Calibrating delay loop (skipped)... 132.66 BogoMIPS PRESET (lpj=3D265320)
Mount-cache hash table entries: 512
CPU: SH7729
SCSI subsystem initialized
DMA: Registering DMA API.
DMA: Registering sh_dmac handler (4 channels).
HD64461 configured at 0xb0000000 on irq 36(mapped into 64 to 79)
HD64461: enabling PCMCIA devices
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Console: switching to colour frame buffer device 80x30
fb0: Hitachi HD64461 frame buffer device
SuperH SCI(F) driver initialized
sh-sci: ttySC0 at MMIO 0xfffffe80 (irq =3D 25) is a sci
sh-sci: ttySC1 at MMIO 0xa4000150 (irq =3D 59) is a scif
console [ttySC1] enabled
sh-sci: ttySC2 at MMIO 0xa4000140 (irq =3D 55) is a irda
Driver 'sd' needs updating - please use bus_type methods
scsi0 : pata_platform
ata1: PATA max PIO0 mmio cmd 0x150001f0 ctl 0x150001fe irq 77
ata1.00: CFA: SanDisk SDCFH-256, HDX 2.15, max PIO4
ata1.00: 501760 sectors, multi 0: LBA
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFH-25 HDX  PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 501760 512-byte hardware sectors: (256 MB/245 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
sd 0:0:0:0: [sda] 501760 512-byte hardware sectors: (256 MB/245 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA


................
................
................

ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: configured for PIO
ata1: EH complete
ata1.00: limiting speed to UDMA7:PIO5
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
......................
......................
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
ata1: EH complete
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI removable disk

--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Thu__27_Nov_2008_21_02_57_+0100_GDmP_pdckKQNp.MD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkku/PEACgkQPQls10ERAGftbQCg5XsBOTnRSOSquYhaQvt/fbyV
7jsAoJm2XPtliOkklRTZKqAdhU+LguFK
=Rz+O
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Nov_2008_21_02_57_+0100_GDmP_pdckKQNp.MD--
