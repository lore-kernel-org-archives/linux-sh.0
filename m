From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Jul 2015 07:21:55 +0000
Subject: Re: [PATCH v2] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <87twso21ij.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent
Cc Magnus

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> The Mitsubishi AA121TD01 panel is commonly used with the Marzen, Lager
> and Koelsch boards. Create a .dtsi file that describe the panel and its
> connection to the board.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

I tested this panel on Koelsch board (with I2C fixup local patch),
and it works well for me.
But, on Lager (with I2C fixup local patch), it doesn't work.
But, it seems not panel issue, LVDS issue (?).

On Lager board, modetest listed VGA/HDMI/LDVS
(I attached it on this mail)
VGA works well for me, but, it can't get HDMI size information,
and it dead if I tried LDVS.
(I attached log on this mail)

I'm using renesas-drivers-2015-07-14-v4.2-rc2

--- modetest list ----------------

> modetest -M rcar-du -c
Connectors:
id      encoder status          name            size (mm)       modes   encoders
42      41      connected       VGA-1           0x0             5       41
  modes:
        name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot)
  1024x768 60 1024 1048 1184 1344 768 771 777 806 flags: nhsync, nvsync; type: driver
  800x600 60 800 840 968 1056 600 601 605 628 flags: phsync, pvsync; type: driver
  800x600 56 800 824 896 1024 600 601 603 625 flags: phsync, pvsync; type: driver
  848x480 60 848 864 976 1088 480 486 494 517 flags: phsync, pvsync; type: driver
  640x480 60 640 656 752 800 480 490 492 525 flags: nhsync, nvsync; type: driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 3
44      0       disconnected    HDMI-A-1        0x0             0       43
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 3
46      45      connected       LVDS-1          261x163         1       45
  modes:
        name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot)
  1280x800 60 1280 1300 1370 1440 800 803 808 823 flags: ; type: preferred, driver
  props:
        1 EDID:
                flags: immutable blob
                blobs:

                value:
        2 DPMS:
                flags: enum
                enums: On=0 Standby=1 Suspend=2 Off=3
                value: 3


--- LVDS dead ------------------


> modetest -M rcar-du -s 46:1280x800@AR24
setting mode 1280x800-60Hz@AR24 on connectors 46, crtc 39
------------[ cut here ]------------
WARNING: CPU: 2 PID: 977 at /opt/home/morimoto/WORK/linux/drivers/gpu/drm/drm_irq.c:1171 drm_wait_one_vblank+0x118/0x138()
vblank wait timed out on crtc 1
CPU: 2 PID: 977 Comm: modetest Tainted: G        W       4.2.0-rc1-00223-gf187fe9-dirty #317
Hardware name: Generic R8A7790 (Flattened Device Tree)
Backtrace: 
[<c0012f84>] (dump_backtrace) from [<c001312c>] (show_stack+0x18/0x1c)
 r7:c05e27fc r6:ee053500 r5:00000009 r4:00000000
[<c0013114>] (show_stack) from [<c04b765c>] (dump_stack+0x78/0x94)
[<c04b75e4>] (dump_stack) from [<c0026260>] (warn_slowpath_common+0x88/0xb4)
 r5:00000009 r4:ee13bb40
[<c00261d8>] (warn_slowpath_common) from [<c00262f8>] (warn_slowpath_fmt+0x38/0x40)
 r9:00000000 r8:00000058 r7:ee13bb6c r6:ee008c00 r5:00000000 r4:00000001
[<c00262c4>] (warn_slowpath_fmt) from [<c024f670>] (drm_wait_one_vblank+0x118/0x138)
 r3:00000001 r2:c05f2f53
[<c024f558>] (drm_wait_one_vblank) from [<c024f6b0>] (drm_crtc_wait_one_vblank+0x20/0x24)
 r9:c06cb768 r8:ee008c00 r7:c0527014 r6:00000001 r5:ee338388 r4:ee008c00
[<c024f690>] (drm_crtc_wait_one_vblank) from [<c0267c38>] (rcar_du_crtc_stop+0x48/0x16c)
 r5:ee338388 r4:ee338388
[<c0267bf0>] (rcar_du_crtc_stop) from [<c0267d7c>] (rcar_du_crtc_disable+0x20/0x38)
 r10:c06cb768 r9:c06cb768 r8:ee008c00 r7:c0527014 r6:00000001 r5:ee338388
 r4:ee338388
[<c0267d5c>] (rcar_du_crtc_disable) from [<c0244da0>] (drm_atomic_helper_commit_modeset_disables+0x1a0/0x33c)
 r5:ee338388 r4:ee9b0040
[<c0244c00>] (drm_atomic_helper_commit_modeset_disables) from [<c0268b0c>] (rcar_du_atomic_complete+0x28/0xbc)
 r10:ee33a010 r9:ee90c300 r8:00000000 r7:ee90c300 r6:ee008c00 r5:ee9b0040
 r4:ee338010 r3:00000011
[<c0268ae4>] (rcar_du_atomic_complete) from [<c0268df8>] (rcar_du_atomic_commit+0x258/0x298)
 r7:ee9b0040 r6:ee008c00 r5:ee33a818 r4:00000000
[<c0268ba0>] (rcar_du_atomic_commit) from [<c0265ef0>] (drm_atomic_commit+0x58/0x68)
 r10:edcf6810 r9:00000000 r8:ee338388 r7:00000003 r6:ee9b0040 r5:ee008c00
 r4:ee9b0040
[<c0265e98>] (drm_atomic_commit) from [<c0245e9c>] (drm_atomic_helper_set_config+0x33c/0x388)
 r5:ee13bd34 r4:00000000
[<c0245b60>] (drm_atomic_helper_set_config) from [<c0256da8>] (drm_mode_set_config_internal+0x54/0xcc)
 r10:ee008c00 r9:ee008dc4 r8:ee008c00 r7:00000000 r6:ee008c00 r5:ee338388
 r4:00000000 r3:c0245b60
[<c0256d54>] (drm_mode_set_config_internal) from [<c0256eb0>] (drm_framebuffer_remove+0x90/0x100)
 r7:ee008e14 r6:ee008c00 r5:ee941100 r4:ee338388
[<c0256e20>] (drm_framebuffer_remove) from [<c02578dc>] (drm_fb_release+0x78/0x88)
 r7:ee941178 r6:ee28d6d4 r5:ee28d74c r4:ee28d6d4
[<c0257864>] (drm_fb_release) from [<c024c33c>] (drm_release+0x2a8/0x484)
 r9:ee008d00 r8:eeaaa300 r7:ee008c34 r6:ee28d780 r5:ee008c00 r4:ee28d700
[<c024c094>] (drm_release) from [<c00cba38>] (__fput+0xe0/0x1a0)
 r10:ee93f7c8 r9:00000008 r8:ee93cad0 r7:ee442b28 r6:00000000 r5:eeb29d28
 r4:ee93f7c0
[<c00cb958>] (__fput) from [<c00cbb58>] (____fput+0x10/0x14)
 r10:ee103280 r9:ee18f3f8 r8:00000001 r7:ee13be58 r6:c06a61ec r5:00000000
 r4:ee053500
[<c00cbb48>] (____fput) from [<c003d688>] (task_work_run+0xbc/0xd0)
[<c003d5cc>] (task_work_run) from [<c0028700>] (do_exit+0x3c0/0x870)
 r7:ee13be58 r6:ee0538ec r5:ee18f3c0 r4:ee053500
[<c0028340>] (do_exit) from [<c0028c40>] (do_group_exit+0x54/0xd8)
 r7:ee13a000
[<c0028bec>] (do_group_exit) from [<c00324c0>] (get_signal+0x4e4/0x554)
 r7:ee13a000 r6:ee917544 r5:ee13bed0 r4:00000009
[<c0031fdc>] (get_signal) from [<c0012774>] (do_signal+0x94/0x360)
 r10:00000000 r9:ee13a000 r8:000215dc r7:fffffe00 r6:ee13bfb0 r5:000215d8
 r4:00000001
[<c00126e0>] (do_signal) from [<c0012bb4>] (do_work_pending+0x58/0xb0)
 r9:ee13a000 r8:c000fd84 r7:00000003 r6:ee13bfb0 r5:ee13a010 r4:c000fd84
[<c0012b5c>] (do_work_pending) from [<c000fc2c>] (work_pending+0xc/0x20)
 r7:00000003 r6:00000001 r5:00001000 r4:000342e4
---[ end trace a644a4a45e5f5e9d ]---


Best regards
---
Kuninori Morimoto
