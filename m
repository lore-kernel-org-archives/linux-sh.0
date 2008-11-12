From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 12 Nov 2008 15:52:37 +0000
Subject: Re: Qemu SH4 status #2
Message-Id: <20081112175249.ca9d87b6.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__12_Nov_2008_17_52_49_+0100_M+lApe0Y6FkfuXRz"
List-Id: <linux-sh.vger.kernel.org>
References: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
	<20081111141335.3c869c26.yoshii.takashi@gmail.com>
	<20081111122700.79906a33.kristoffer.ericson@gmail.com>
	<20081112133313.967c82e2.yoshii.takashi@gmail.com>
In-Reply-To: <20081112133313.967c82e2.yoshii.takashi@gmail.com>
To: yoshii.takashi@gmail.com
Cc: qemu-devel@nongnu.org, takasi-y@ops.dti.ne.jp, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

--Signature=_Wed__12_Nov_2008_17_52_49_+0100_M+lApe0Y6FkfuXRz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Still not working properly for me, but might be due
to my .img file since it complains about the partitioning.

Anyhow this is what I get:
[kristoffer@BoTux qemu-land]$ qemu-system-sh4 -M r2d --serial vc --serial /=
dev/tty -kernel zImage_3 --append "console=3DttySC0,115200 root=3D/dev/sda"=
 -usb --usbdevice keyboard --usbdevice mouse qemu-sh3-img.img=20
long read to SH7750_WCR1_A7 (0x1f800008) ignored
long read to SH7750_WCR2_A7 (0x1f80000c) ignored
long read to SH7750_WCR3_A7 (0x1f800010) ignored
long read to SH7750_MCR_A7 (0x1f800014) ignored
long read to SH7750_MCR_A7 (0x1f800014) ignored
Linux version 2.6.27-hpc-00015-g56be9ec-dirty (kristoffer@BoTux) (gcc versi=
on 3.4.5) #9 Wed Nov 12 17:39:55 CET 2008
Boot params:
... MOUNT_ROOT_RDONLY - 00000000
... RAMDISK_FLAGS     - 00000000
... ORIG_ROOT_DEV     - 00000000
... LOADER_TYPE       - 00000000
... INITRD_START      - 00000000
... INITRD_SIZE       - 00000000
Booting machvec: RTS7751R2D
Renesas Technology Sales RTS7751R2D support.
FPGA version:1 (revision:0)
Node 0: start_pfn =3D 0xc000, low =3D 0x10000
Zone PFN ranges:
  Normal   0x0000c000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x0000c000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=3DttySC0,115200 root=3D/dev/sda
Using R2D-PLUS interrupt controller.
PID hash table entries: 256 (order: 8, 1024 bytes)
Using tmu for system timer
Using 15.000 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61896k/65536k available (2129k kernel code, 605k data, 112k init)
Calibrating delay loop... 86.27 BogoMIPS (lpj=3D172544)
Mount-cache hash table entries: 512
CPU: SH7751R
net_namespace: 288 bytes
NET: Registered protocol family 16
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Autoconfig PCI channel 0x8c2b723c
Scanning bus 00, I/O 0x00004000:0x00040000, Mem 0xfd000000:0xfe000000
00:00.0 Class 0000: 1054:350e
00:01.0 Class 0c03: 106b:003f
        Mem at 0xfd000000 [size=3D0x100]
00:02.0 Class 0200: 10ec:8139 (rev 20)
        I/O at 0x00004000 [size=3D0x100]
        Mem at 0xfd000100 [size=3D0x100]
PCI: Using configuration type 1
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
trapped io 0xc0000000 overrides mmio 0xb4001000
trapped io 0xc0001000 overrides mmio 0xb400080c
msgmni has been set to 121
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
SuperH SCI(F) driver initialized
sh-sci: ttySC0 at MMIO 0xffe80000 (irq =3D 43) is a scif
console [ttySC0] enabled
brd: module loaded
sm501 sm501: SM501 At b3e00000: Version 050100a0, 8 Mb, IRQ 100
sm501-usb[0] flags 00000200: 13e40000..13e5ffff
sm501-usb[1] flags 00000200: 107c0000..107fffff
sm501-usb[2] flags 00000400: 00000064..00000064
sm501-fb[0] flags 00000200: 13e80000..13e8ffff
sm501-fb[1] flags 00000200: 13f00000..13f4ffff
sm501-fb[2] flags 00000200: 10000000..107bffff
sm501-fb[3] flags 00000400: 00000064..00000064
sm501-fb sm501-fb: fb sm501fb-crt disabled at start
sm501 sm501: gate 00021807, clock 2a090a09, mode 00000000
sm501 sm501: gate 00021807, clock 2a090a09, mode 00000001
Console: switching to colour frame buffer device 80x25
sm501-fb sm501-fb: fb0: sm501fb-crt frame buffer
sm501-fb sm501-fb: fb sm501fb-panel disabled at start
sm501-fb sm501-fb: using supplied mode
sm501 sm501: gate 00021807, clock 291a0a09, mode 00000000
sm501-fb sm501-fb: fb1: sm501fb-panel frame buffer
8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
eth0: RTL-8139C+ at 0xfd000100, 52:54:00:12:34:56, IRQ 112
Driver 'sd' needs updating - please use bus_type methods
scsi0 : pata_platform
ata1: PATA max PIO0 mmio cmd 0xb4001000 ctl 0xb400080c irq 107
ata1.00: ATA-7: QEMU HARDDISK, 0.9.1, max UDMA/100
ata1.00: 40000 sectors, multi 16: LBA48=20
ata1.00: configured for PIO
scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    0.9. PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 40000 512-byte hardware sectors (20 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
sd 0:0:0:0: [sda] 40000 512-byte hardware sectors (20 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
 sda: unknown partition table
sd 0:0:0:0: [sda] Attached SCSI disk
ohci_hcd 0000:00:01.0: OHCI Host Controller
ohci_hcd 0000:00:01.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:01.0: irq 111, io mem 0xfd000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
irq 111: nobody cared (try booting with the "irqpoll" option)
Stack: (0x8f819948 to 0x8f81a000)
9940:                   8c04c5c0 0000006f 8c2a9350 8c04c84a 0000001a 000000=
6f=20
9960: 00000000 0000000a 0000006f 8c04d20a 00000000 8c2deba0 0000000a 8c2e12=
70=20
9980: 0000001a 0000006f 8c2a9350 8c012752 8f819a3c 8c2e2a4c 8c0170e0 000000=
01=20
99a0: 8c012720 ffffffff 00000001 8c02ef40 40008000 8f818000 8c2debd8 00000c=
2d=20
99c0: 00002000 000000f0 00000000 8c2debdc 00000001 8c2e1270 0000000a 8c2deb=
a0=20
99e0: 00000000 8f819a08 8c02ef40 8c02a79a 40008001 00000000 00010a8b 000018=
48=20
9a00: ffffffff ffffffff 8c02a8a6 00000000 00000000 00000000 0000001a 000000=
00=20
9a20: 000000f0 8c012758 8c2e2a4c 8c0170e0 8f9354b8 8c012720 ffffffff 000100=
00=20
9a40: 8c0124c0 00000010 00000004 00010000 fd00005c 0000001e 00000003 8f9354=
00=20
9a60: 8f819ac8 8f9354b8 00000000 00000000 00000000 00000000 8f819a9c 8c1875=
f8=20
9a80: 8c1875f8 40000000 00000000 00010a8b 00000000 ffffffff ffffffff 8c17bc=
26=20
9aa0: 8c17bba4 00000000 00000000 8f935400 00000000 8f947de0 00000010 000000=
00=20
9ac0: 8f819ac8 00000000 00000000 8c17bc26 00000000 9e75a1a9 8f817b6c 000000=
00=20
9ae0: 8c01f860 8f819af8 8c2a3560 8c2d9e88 8c2d9eb8 8f817b6c 8c02109c 8f819b=
0c=20
9b00: 8f817b40 8c2da244 8c2d9e9c 8c02ef5a 8f929460 8c2a6e10 0000000a 8f940e=
40=20
9b20: 8f819aa0 00000000 00000000 8f947e20 8c17d9b0 8c17d9c4 80000180 8c0f63=
e4=20
9b40: 8f947de0 00000000 8f819ac8 00000000 00000000 8f947e20 8c17d9b0 800001=
00=20
9b60: 8f935000 8f819ba8 000003e8 8f947de0 8f947e20 00000000 00000000 8f819b=
7c=20
9b80: 8f819b7c 8c17d0ee 8c17db0c 8f819ba2 00000001 00000000 fffffff4 8f940e=
00=20
9ba0: 00030010 00000000 00000003 8c176a28 8f935240 8f935000 8f819be6 ffffff=
0f=20
9bc0: 8f83fc80 00000003 00000000 00000010 00000003 00000000 00000000 000003=
e8=20
9be0: 8c17798e 00010101 00000000 00000001 8f83fcbc 8c178404 8f929466 8f9350=
00=20
9c00: 8f83fc80 8c27bde4 8f942600 00000002 40408180 00000000 8c0bdbfa 8c08d7=
8c=20
9c20: 8f809a00 00000000 8c0be9ac 00000000 8f942698 00000001 00000000 8f9426=
1c=20
9c40: 8f83fcc0 8f948a04 8c180006 00000000 ffffffed 8c2b4504 8c2b44d4 8c2b45=
3c=20
9c60: 8f935000 8f942600 8c142ae4 8f942698 8c2e75a4 8f942698 00000000 8c2b45=
04=20
9c80: 8f94261c 8c141bae 8f94265c 8f94261c 8c142be0 8c219e60 00000000 8f862e=
68=20
9ca0: 8f862e68 8f830934 8c142c6e ffffffec 8f9426d8 8f94261c 8c2b45f0 8c141f=
06=20
9cc0: 8f94261c 8f94261c 8c2b45f0 8c13fef2 00000000 00000000 8c27cb73 ffffff=
ff=20
9ce0: 8c13fc96 8f942850 8f93505c 8c2b45d4 8f942684 8c17f592 8f93505c 000000=
8c=20
9d00: 00000000 8f942854 8f9294aa 8f942600 8f94261c 8f935000 00000001 8f940f=
40=20
9d20: 00000001 00000000 8f9350fc 8f93505c 8f935004 8f9428d4 00000004 8c186b=
54=20
9d40: 00000000 8f9350d8 8c2e75a4 8f9350d8 00000001 8f935000 8f93505c 8c17f9=
f4=20
9d60: 8f9350d8 00000000 8c2b4bc0 8f93505c 8c142ae4 8c141bae 8f93509c 8f9350=
5c=20
9d80: 8c142be0 8c219e60 00000000 8f862e68 8f862e68 8f8308d4 8c142c6e ffffff=
ec=20
9da0: 8f935118 8f93505c 8c2b45f0 8c141f06 8f93505c 8f93505c 8c2b45f0 8c13fe=
f2=20
9dc0: 00000000 00000000 3a393831 8c170030 8c17e9fa 8f935000 8f80f058 8c2b44=
94=20
9de0: 8f9350c4 8c178800 8f935000 8f935440 8f93505c 8f935000 8f935400 000000=
00=20
9e00: 8f819e10 8c17cd86 8f93547c 00000012 8f935400 8f935000 8f819e10 000000=
6f=20
9e20: 00000080 8f80f058 8c186e74 8f935400 8c242b98 8f80f058 8f80f000 ffffff=
f2=20
9e40: 8f93547c e0000000 00000100 8c105b78 00000000 000000ac 8c2e75a4 8f80f0=
d4=20
9e60: ffffffed 8f80f000 8c2b4c4c 8c142ae4 00000000 8c2b4c80 8f80f058 8c142d=
26=20
9e80: 8c2b4c80 8f80f098 8c03f180 8f80f104 8f80f058 8c141808 8f880260 8c2d80=
80=20
9ea0: 8c2b4c80 8c142ca0 8c141780 00000000 8f82f798 8f82f798 8f80f0a0 8c1422=
26=20
9ec0: 8c2ade98 8c2b4c80 8c2b4c80 00000000 8c1432d8 00000000 8c2cc240 8c2d80=
80=20
9ee0: 8c2d69a4 8c2b4c80 8c2b4c80 8c2b4c4c 8c1058d6 8c2cc240 8c2d8080 8c2d69=
a4=20
9f00: 8c2b4c80 8c011060 8c2b4c4c 8c2d6b70 8c2cc264 8c2d6bdc 8c011060 8c2d6b=
70=20
9f20: 8c011088 8c2d6b70 00000000 8c2d69a4 8f830f60 8f82f8e0 8c0f4b60 000000=
8f=20
9f40: 8c0b701e 8c2e126c 00000071 8f82f8e0 8f830f60 8c04dc4a 8c2a93c0 003331=
31=20
9f60: 00000000 8c010000 8c2bcc16 00000000 00000000 00000000 8c2d69a4 8c2d6b=
dc=20
9f80: 8c011060 8c2d6b70 00000001 8c0127a4 00000000 00000000 00000000 000000=
00=20
9fa0: 00000000 00000000 00000000 00000000 00000000 8c2bcba0 00000000 000000=
00=20
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 8f819f=
a0=20
9fe0: 8c0127a0 00000000 40000000 00000000 00000000 00000000 00000000 000000=
00=20

Call trace:=20
[<8c026220>] printk+0x0/0x20
[<8c04c84a>] note_interrupt+0x20a/0x240
[<8c04d20a>] handle_level_irq+0xaa/0x100
[<8c012752>] do_IRQ+0x32/0x60
[<8c0170e0>] ret_from_exception+0x0/0xc
[<8c012720>] do_IRQ+0x0/0x60
[<8c02ef40>] run_timer_softirq+0x0/0x180
[<8c02ef40>] run_timer_softirq+0x0/0x180
[<8c02a79a>] __do_softirq+0x5a/0xe0
[<8c02a8a6>] do_softirq+0x86/0xa0
[<8c012758>] do_IRQ+0x38/0x60
[<8c0170e0>] ret_from_exception+0x0/0xc
[<8c012720>] do_IRQ+0x0/0x60
[<8c0124c0>] generic_writel+0x0/0x20
[<8c1875f8>] ohci_hub_control+0xf8/0x620
[<8c1875f8>] ohci_hub_control+0xf8/0x620
[<8c17bc26>] usb_hcd_submit_urb+0x466/0x9c0
[<8c17bba4>] usb_hcd_submit_urb+0x3e4/0x9c0
[<8c17bc26>] usb_hcd_submit_urb+0x466/0x9c0
[<8c01f860>] task_tick_fair+0x20/0x80
[<8c02109c>] scheduler_tick+0x5c/0x80
[<8c02ef5a>] run_timer_softirq+0x1a/0x180
[<8c17d9b0>] usb_start_wait_urb+0x30/0xe0
[<8c17d9c4>] usb_start_wait_urb+0x44/0xe0
[<8c0f63e4>] kref_put+0x44/0xa0
[<8c17d9b0>] usb_start_wait_urb+0x30/0xe0
[<8c17d0ee>] usb_alloc_urb+0xe/0x60
[<8c17db0c>] usb_control_msg+0xac/0x100
[<8c176a28>] clear_port_feature+0x28/0x40
[<8c17798e>] hub_activate+0x18e/0x2c0
[<8c178404>] hub_probe+0x544/0x7a0
[<8c0bdbfa>] sysfs_addrm_finish+0x1a/0x2e0
[<8c08d78c>] ilookup5_nowait+0x2c/0x60
[<8c0be9ac>] sysfs_do_create_link+0x6c/0x200
[<8c180006>] usb_probe_interface+0x86/0x160
[<8c142ae4>] driver_probe_device+0xe4/0x1e0
[<8c141bae>] bus_for_each_drv+0x4e/0x80
[<8c142be0>] __device_attach+0x0/0x20
[<8c219e60>] klist_next+0x0/0xc0
[<8c142c6e>] device_attach+0x6e/0xa0
[<8c141f06>] bus_attach_device+0x66/0xa0
[<8c13fef2>] device_add+0x192/0x600
[<8c13fc96>] dev_set_name+0x16/0x40
[<8c17f592>] usb_set_configuration+0x292/0x520
[<8c186b54>] generic_probe+0x74/0xe0
[<8c17f9f4>] usb_probe_device+0x34/0x60
[<8c142ae4>] driver_probe_device+0xe4/0x1e0
[<8c141bae>] bus_for_each_drv+0x4e/0x80
[<8c142be0>] __device_attach+0x0/0x20
[<8c219e60>] klist_next+0x0/0xc0
[<8c142c6e>] device_attach+0x6e/0xa0
[<8c141f06>] bus_attach_device+0x66/0xa0
[<8c13fef2>] device_add+0x192/0x600
[<8c170030>] ata_sff_irq_on+0x50/0xa0
[<8c17e9fa>] usb_cache_string+0x5a/0xa0
[<8c178800>] usb_new_device+0x40/0x160
[<8c17cd86>] usb_add_hcd+0x5a6/0x740
[<8c186e74>] usb_hcd_pci_probe+0x194/0x2e0
[<8c105b78>] pci_device_probe+0x58/0xa0
[<8c142ae4>] driver_probe_device+0xe4/0x1e0
[<8c142d26>] __driver_attach+0x86/0xc0
[<8c03f180>] down+0x0/0x80
[<8c141808>] bus_for_each_dev+0x48/0xa0
[<8c142ca0>] __driver_attach+0x0/0xc0
[<8c141780>] next_device+0x0/0x40
[<8c142226>] bus_add_driver+0x166/0x220
[<8c1432d8>] driver_register+0x38/0x160
[<8c2cc240>] ohci_hcd_mod_init+0x0/0x80
[<8c1058d6>] __pci_register_driver+0x36/0xc0
[<8c2cc240>] ohci_hcd_mod_init+0x0/0x80
[<8c011060>] do_one_initcall+0x0/0x1a0
[<8c2cc264>] ohci_hcd_mod_init+0x24/0x80
[<8c011060>] do_one_initcall+0x0/0x1a0
[<8c011088>] do_one_initcall+0x28/0x1a0
[<8c0f4b60>] ida_pre_get+0x0/0x80
[<8c0b701e>] create_proc_entry+0x3e/0xe0
[<8c04dc4a>] register_irq_proc+0x6a/0xc0
[<8c2bcc16>] kernel_init+0x76/0x140
[<8c011060>] do_one_initcall+0x0/0x1a0
[<8c0127a4>] kernel_thread_helper+0x4/0x20
[<8c2bcba0>] kernel_init+0x0/0x140
[<8c0127a0>] kernel_thread_helper+0x0/0x20

handlers:
[<8c17c580>] (usb_hcd_irq+0x0/0x120)
Disabling IRQ #111
usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0001
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.27-hpc-00015-g56be9ec-dirty ohci_hcd
usb usb1: SerialNumber: 0000:00:01.0
sm501-usb sm501-usb: SM501 OHCI
sm501-usb sm501-usb: new USB bus registered, assigned bus number 2
sm501-usb sm501-usb: irq 100, io mem 0x13e40000
sm501-usb sm501-usb: init err (00000000 0000)
sm501-usb sm501-usb: can't start sm501-usb<3>sm501-usb sm501-usb: startup e=
rror -75
sm501-usb sm501-usb: USB bus 2 deregistered
sm501-usb: probe of sm501-usb failed with error -75
Initializing USB Mass Storage driver...
usb 1-3: new full speed USB device using ohci_hcd and address 2
...................stands endlessly here.........................

On Wed, 12 Nov 2008 13:33:13 +0900
yoshii.takashi@gmail.com wrote:

> Hi,
>=20
> > I'm still getting segmentation fault at exact same
> > location. Have you made additional patches?
> Please find attached file "qemu081111.diff".
> Basically, this is an aggregate of patches found on qemu-devel ML,
>  with some conflicts against current svn source being resolved,
>  and some small fix are added, which are scheduled to be posted after
>  I finished with my pending patches.
>=20
> I post this to share information between qemu and linux/sh people,
>  and hopefully accelerate debugging with linux people's help.
>=20
> Another file "linuxconfig_r2d_qemu.diff" is diff for linux kernel
>  configuretion. It changes following parameters from r2d+'s defconfig.
> - Cache -> off (qemu has no cache)
> - commandline change (for debugging)
> - 8139too -> 8139cp (qemu's default is c+, still thinking how to switch)
> - SH SPI -> off (sci emulation is not mature enough to handle it)
>=20
> Build procedure is as follows,
> Configure kernel:
>  make ARCH=3Dsh rts7751r2dplus_defconfig
>  patch .config < linuxconfig_r2d_qemu.diff
>  (and build)
>=20
> Configure Qemu:
>  ./configure --disable-system --target-list=3Dsh4-softmmu \
>   --disable-linux-user --disable-kqemu
>=20
> Execute:
>  sh4-softmmu/qemu-system-sh4 -M r2d --serial vc --serial /dev/tty \
>   --kernel zImage --append "console=3Dtty0 root=3D/dev/sda" \
>   -usb --usbdevice keyboard --usbdevice mouse disk.img
>=20
> I've tested it on qemu svn head this morning.
> You will see penguin logo, and fbcon input/output working.
> For debugging purpose, console=3DttySC0,115200 might help.
> /yoshii
>=20


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Wed__12_Nov_2008_17_52_49_+0100_M+lApe0Y6FkfuXRz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkbCeEACgkQPQls10ERAGfcQACgw43mnKZyB6sQFhn4pIrigiSl
ty8AoLCi6/rbu/rcpgPP8MAnea1PWHkk
=nlvp
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Nov_2008_17_52_49_+0100_M+lApe0Y6FkfuXRz--
