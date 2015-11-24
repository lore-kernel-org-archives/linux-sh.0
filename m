From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Nov 2015 13:39:50 +0000
Subject: Re: renesas-drivers-2015-11-24-v4.4-rc2
Message-Id: <CAMuHMdXE6gQwh-GYeBheewBv9_9q0P8B=TQtLXFDbyPmihnsow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448372293-28024-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448372293-28024-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Nov 24, 2015 at 2:38 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> I've pushed renesas-drivers-2015-11-24-v4.4-rc2 to
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> This tree is meant to ease development of platform support and drivers for
> Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next
> branches of various subsystem trees and (b) branches with driver code
> submitted or planned for submission to maintainers into the development
> branch of Simon Horman's renesas.git tree.
>
> Today's version is based on renesas-devel-20151124-v4.4-rc2.
>
> Included branches with driver code:
>   - sh-pfc-for-v4.5
>   - topic/rcar-dmac-residue-v1
>   - topic/rcar-dmac-hamza-v3
>   - topic/scif-iommu
>   - topic/sci-clk-cleanup-v2
>   - topic/pfc-scif-clk
>   - topic/scif-brg
>   - topic/cpg-mssr-v6
>   - topic/r8a7795-drivers-sh-v1
>   - topic/cs2000-v6
>   - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#topic=
/r8a7795-sound-v6
>   - git://linuxtv.org/pinchartl/media.git#vsp1-kms-20151112~4

When running "modetest -D rcar-du" on koelsch (shmobile_defconfig), it cras=
hes
with:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
pgd =3D ee2f8000
[00000004] *pgd=BFca8831
Internal error: Oops: 17 [#1] SMP ARM
CPU: 1 PID: 2408 Comm: lt-modetest Not tainted
4.4.0-rc2-01622-g1f9e8ee5963d826a #379
Hardware name: Generic R8A7791 (Flattened Device Tree)
task: ee078dc0 ti: eeb50000 task.ti: eeb50000
PC is at drm_platform_set_busid+0x1c/0x58
LR is at drm_setversion+0x90/0x16c
pc : [<c0265aac>]    lr : [<c0260644>]    psr: a0070013
sp : eeb51e10  ip : eeb51e28  fp : eeb51e24
r10: ee1d6000  r9 : 00000051  r8 : c0106407
r7 : edf93f40  r6 : eeac6600  r5 : eeb51e68  r4 : eeac6600
r3 : c06aca24  r2 : 00000000  r1 : c061181a  r0 : 024000c0
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5307d  Table: 6e2f806a  DAC: 00000051
Process lt-modetest (pid: 2408, stack limit =3D 0xeeb50210)
Stack: (0xeeb51e10 to 0xeeb52000)
1e00:                                     c06aca24 ee1d6000 eeb51e44 eeb51e=
28
1e20: c0260644 c0265a9c eeb51e68 00000010 c0538920 edf93f40 eeb51f14 eeb51e=
48
1e40: c0260b38 c02605c0 00000041 ee4213b8 edffce98 00000000 c02605b4 000000=
00
1e60: bebf09f8 00000007 00000001 00000004 ffffffff ffffffff ee1b77d0 ee4211=
98
1e80: c0694658 00000003 eeb51f5c 00000001 eea9f000 c000ffa4 ee245dc0 eeb51f=
5c
1ea0: eeb51f4c eeb51eb0 c00dec3c c00daba4 ee1b77d0 ee421198 88056cab 000000=
05
1ec0: eea9f019 00000000 00000000 ee4237f8 edffce98 00000101 00000000 000000=
6c
1ee0: 00000000 00000000 00000000 bebf09f8 edffce98 ee245dc0 c0106407 000000=
03
1f00: eeb50000 00000000 eeb51f7c eeb51f18 c00e2710 c02608b4 ee245dc8 eea9f0=
00
1f20: 00000020 edffce98 eeb51f4c eeb51f38 c00db434 c00cd76c edfc8c00 000000=
03
1f40: eeb51f94 eeb51f50 c00d20e4 c00db3e0 00000000 bebf09f8 ee245dc0 ee245d=
c0
1f60: c0106407 00000003 eeb50000 00000000 eeb51fa4 eeb51f80 c00e2870 c00e21=
a4
1f80: ffffffff bebf0a70 bebf09f8 c0106407 00000036 c000ffa4 00000000 eeb51f=
a8
1fa0: c000fde0 c00e2840 bebf0a70 bebf09f8 00000003 c0106407 bebf09f8 ffffff=
ff
1fc0: bebf0a70 bebf09f8 c0106407 00000036 b6f4c988 ffffffff 00000001 000000=
0f
1fe0: b6f5d180 bebf09dc b6f484bb b6ec1ed6 80070030 00000003 00000000 000000=
00
Backtrace:
[<c0265a90>] (drm_platform_set_busid) from [<c0260644>]
(drm_setversion+0x90/0x16c)
 r4:ee1d6000 r3:c06aca24
[<c02605b4>] (drm_setversion) from [<c0260b38>] (drm_ioctl+0x290/0x408)
 r7:edf93f40 r6:c0538920 r5:00000010 r4:eeb51e68
[<c02608a8>] (drm_ioctl) from [<c00e2710>] (do_vfs_ioctl+0x578/0x69c)
 r10:00000000 r9:eeb50000 r8:00000003 r7:c0106407 r6:ee245dc0 r5:edffce98
 r4:bebf09f8
[<c00e2198>] (do_vfs_ioctl) from [<c00e2870>] (SyS_ioctl+0x3c/0x64)
 r10:00000000 r9:eeb50000 r8:00000003 r7:c0106407 r6:ee245dc0 r5:ee245dc0
 r4:bebf09f8
[<c00e2834>] (SyS_ioctl) from [<c000fde0>] (ret_fast_syscall+0x0/0x3c)
 r8:c000ffa4 r7:00000036 r6:c0106407 r5:bebf09f8 r4:bebf0a70 r3:ffffffff
Code: e590210c e1a04001 e59f0034 e59f1034 (e5923004)
---[ end trace bf083d5d69d2439d ]---

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
