From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Jul 2015 10:54:41 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <20150703105441.GF1521@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SkvwRMAIpAhPCcCJ"
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
In-Reply-To: <20150703024044.GB24695@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> I have observed what appears to be a regression while testing next-201507=
02
> which seems to be caused by 2951d5c031a3 ("tick: broadcast: Prevent
> livelock from event handler").

Does reverting help? I see a similar case with your branch
renesas-devel-20150629-v4.1 which does not include both commits.

For this branch, if I select CONFIG_NO_HZ_IDLE and *no* CONFIG_HIGH_RES_TIM=
ERS,
I see the case you described:

> input: gpio_keys as /devices/platform/gpio_keys/input/input0
> hctosys: unable to open rtc device (rtc0)
>=20
> The boot hangs here.
> The next line should be:
>=20
> smsc911x 20000000.ethernet eth0: SMSC911x/921x identified at 0xc8880000, =
IRQ: 33

There is no OOPS, it just stops here. With CONFIG_HIGH_RES_TIMERS, the
system boots to the prompt.

Enabling all lockdep features doesn't show anything for the non-working
case. However, I get warning for the working case:

[    2.560000] input: gpio_keys as /devices/platform/gpio_keys/input/input0
[    2.610000] smsc911x 20000000.ethernet eth0: SMSC911x/921x identified at=
 0xc8880000, IRQ: 33
[    5.510000] Sending DHCP requests ., OK
[    5.580000] IP-Config: Got DHCP answer from 192.168.64.1, my address is =
192.168.64.14
[    5.580000] IP-Config: Complete:
[    5.590000]      device=3Deth0, hwaddr=3D00:01:9b:04:03:ce, ipaddr=3D192=
=2E168.64.14, mask=3D255.255.255.0, gw=3D192.168.64.1
[    5.600000]      host=3D192.168.64.14, domain=3Dlocal, nis-domain=3D(non=
e)
[    5.600000]      bootserver=3D192.168.64.1, rootserver=3D192.168.64.1, r=
ootpath=3D
[    5.610000]      nameserver0=3D192.168.64.1
[    5.630000] Freeing unused kernel memory: 632K (c0306000 - c03a4000)
[    5.660000] random: init urandom read with 14 bits of entropy available
[    5.820000] ------------[ cut here ]------------
[    5.820000] WARNING: CPU: 0 PID: 282 at kernel/locking/lockdep.c:3557 ch=
eck_flags+0x84/0x1f4()
[    5.820000] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[    5.820000] CPU: 0 PID: 282 Comm: rcS Tainted: G        W       4.1.0-00=
002-g5b076054611833 #179
[    5.820000] Hardware name: Generic Emma Mobile EV2 (Flattened Device Tre=
e)
[    5.820000] Backtrace:=20
[    5.820000] [<c0012c94>] (dump_backtrace) from [<c0012e3c>] (show_stack+=
0x18/0x1c)
[    5.820000]  r6:c02dcc67 r5:00000009 r4:00000000 r3:00400000
[    5.820000] [<c0012e24>] (show_stack) from [<c02510c8>] (dump_stack+0x20=
/0x28)
[    5.820000] [<c02510a8>] (dump_stack) from [<c0022c44>] (warn_slowpath_c=
ommon+0x8c/0xb4)
[    5.820000] [<c0022bb8>] (warn_slowpath_common) from [<c0022cd8>] (warn_=
slowpath_fmt+0x38/0x40)
[    5.820000]  r8:c780f470 r7:00000000 r6:00000000 r5:c03b0570 r4:c0b7ec04
[    5.820000] [<c0022ca4>] (warn_slowpath_fmt) from [<c004cd38>] (check_fl=
ags+0x84/0x1f4)
[    5.820000]  r3:c02e13d8 r2:c02dceaa
[    5.820000] [<c004ccb4>] (check_flags) from [<c0050e50>] (lock_acquire+0=
x4c/0xbc)
[    5.820000]  r5:00000000 r4:60000193
[    5.820000] [<c0050e04>] (lock_acquire) from [<c0256000>] (_raw_spin_loc=
k+0x34/0x44)
[    5.820000]  r9:000a8d5c r8:00000001 r7:c7806000 r6:c780f460 r5:c03b06a0=
 r4:c780f460
[    5.820000] [<c0255fcc>] (_raw_spin_lock) from [<c005a8cc>] (handle_fast=
eoi_irq+0x20/0x11c)
[    5.820000]  r4:c780f400
[    5.820000] [<c005a8ac>] (handle_fasteoi_irq) from [<c0057a4c>] (generic=
_handle_irq+0x28/0x38)
[    5.820000]  r6:00000000 r5:c03b038c r4:00000012 r3:c005a8ac
[    5.820000] [<c0057a24>] (generic_handle_irq) from [<c0057ae4>] (__handl=
e_domain_irq+0x88/0xa8)
[    5.820000]  r4:00000000 r3:00000026
[    5.820000] [<c0057a5c>] (__handle_domain_irq) from [<c000a3cc>] (gic_ha=
ndle_irq+0x40/0x58)
[    5.820000]  r8:10c5347d r7:10c5347d r6:c35b1fb0 r5:c03a6304 r4:c8802000=
 r3:c35b1fb0
[    5.820000] [<c000a38c>] (gic_handle_irq) from [<c0013bc8>] (__irq_usr+0=
x48/0x60)
[    5.820000] Exception stack(0xc35b1fb0 to 0xc35b1ff8)
[    5.820000] 1fa0:                                     00000061 00000000 =
000ab736 00000066
[    5.820000] 1fc0: 00000061 000aa1f0 000a8d54 000a8d54 000a8d88 000a8d5c =
000a8cc8 000a8d68
[    5.820000] 1fe0: 72727272 bef8a528 000398c0 00031334 20000010 ffffffff
[    5.820000]  r6:ffffffff r5:20000010 r4:00031334 r3:00000061
[    5.820000] ---[ end trace cb88537fdc8fa202 ]---
[    5.820000] possible reason: unannotated irqs-off.
[    5.820000] irq event stamp: 769
[    5.820000] hardirqs last  enabled at (769): [<c000f82c>] ret_fast_sysca=
ll+0x2c/0x54
[    5.820000] hardirqs last disabled at (768): [<c000f80c>] ret_fast_sysca=
ll+0xc/0x54
[    5.820000] softirqs last  enabled at (0): [<c0020ec4>] copy_process.par=
t.65+0x2e8/0x11dc
[    5.820000] softirqs last disabled at (0): [<  (null)>]   (null)

I haven't further researched, but wanted to share this already.

All the best,

   Wolfram#


--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlmnxAAoJEBQN5MwUoCm2DNkP/2LPLu4bE6R54jXnJc4+MERe
ZJHCcVAyCPvuLXzAIeJIkQGbDTA/VHfPjbFjrE3NI6C3Qf2lXVNi8xCChMomEobt
DAd/+SnrAWk9gyJaunC3tCOC3J8Z/R8+7ooypdbu6RKLVK9CkES/nFRiW0sZviLk
wHSLn/4G9M7bwB/LubRHxiKDkvNpv/9FavuZgMRcCmWmDDg4VEKYq+8vD5hMZpdE
aZ/UvjvJA+Yi4X3GEPimhdndn5PU/UPwtN3D0PPIg2Vy+6I7xBtfvBg3xmppkB2Y
KoH4lXSsFLWES/EWJx0COgdt1Re80tR04fSJY8DSMLT8Ivz1V+ETiGE2Z+eLGMQ0
mmpwNHXK7Sn5n4slnARJ1hDL9MGdoP+hG9ahYh4ipvf8/GQH8tNxCFRCPOG8U0BL
fbjrfVqqHQHPlVQBWpoBFKjDqxEvNdrrfXxN4iTfiVmEga1hjuG6A0KOiOttrIcz
9MyS0X621dhE+G+1E5YcSQ0Zm+VGF168Mo3zUH4Dtqu9r8IDkstnf/hVTm6Yhv6E
/OZhjc2kYI1Si15LgCDksJ4M6JtITgTVUrvOT2hvGnUaIxkrUgsXxLu+r3J4OdAB
c4rwpyqTt6Pb1E/NdaHiM48u8w2yKfG5NAqDNjVDd5kecTmlRmEZ13oFVJ3pVSBr
vM0jO2plMftsR+sV/lYN
=wYW0
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
