Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795FB35C6B7;
	Fri,  2 Oct 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790917053; cv=none; b=qbS6lX35MBpgleVZtoKGGj0od8pl4G5tC1gowco/kQ7s9C3DUKDWb++iTkUG8zCkbdN1b3WXaukA9N+vMuNXywDVdOcG/FE349mAxicRDz2oGV2cVwkhesI81cb3dbeQRXxkw5Tlyv4b5zYOCMNCYYAYk5JZZ2CJdmKFmuvjmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790917053; c=relaxed/simple;
	bh=iki+AruOBthrY3zSuoxyNIkBMZUe+AlBpK2uinFmpow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WLRCyJv3A0uMro1ZuKcb2Lhee99+31SricwNS8tJYFqzOLc9YndBuMDxJE/PslQGb2gKNu9Lo2WOTmhebgbdlYVj3qnPx7XUhcO1i6ABw3b9hdAbWI9/fdi6hfIeD0QVNf7cHWVZBQllhCTWGEbQ/noggkHNRZ3S8RjbnB2yTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=KxDQ1+Yh; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="KxDQ1+Yh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=1t8wOqxR1yufeFjgSKnbbJNcChdiHJJgbIuggzY3PTE=; t=1790917046;
	x=1791521846; b=KxDQ1+YhBHbCzsIWuBOdpnhCh9LMlT/f7HkypcIEtDZ8VqZec0JhT2HqZxBdR
	q469ih6qHC/YA6sWzO4BFx6SYM8MFigonKV3ckgE7u4zCVAxv6aDewr1ayxFHkrvmA91M1t23C0t5
	mv/5iGQ/jBa2GuTtLcT7dkrhEfpzChPG+tjo/u6NUKAz78wTvkrB1w4L7Hzmr4QTVh/s5LdHVWgqC
	F4pZXKjVV0MPFx0rDj+EpIpu5qqQFPA4fbkRsEkLTz8yc3B9wlZeQstp0rmFTb8EB6+hsw9Ns8pZB
	Mfv0YJv3LKpNA5fU3TDl4oCXMlwRRB/k4heMfiFuGFYO1nwaNw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCVKi-00000002TPf-3eES; Fri, 02 Oct 2026 06:57:20 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCVKi-000000040H3-26PW; Fri, 02 Oct 2026 06:57:20 +0200
Message-ID: <3bd32eaf159db61ed1d423e1d52a869b3689c682.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 06:57:19 +0200
In-Reply-To: <20260927191359.6144-1-kmehltretter@gmail.com>
References: <20260927191359.6144-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Karl,

On Sun, 2026-09-27 at 21:13 +0200, Karl Mehltretter wrote:
> register_intc_controller() sorts d->prio and d->sense right after
> allocating them, with hw->nr_prio_regs and hw->nr_sense_regs as the
> element count. The lists hold hw->nr_vectors entries and are only
> filled later, by intc_register_irq().
>=20
> On SH7785, sh7785-irq0123 and sh7785-irq4567 have four vectors but the
> SoC's eleven priority registers, so sort() swaps 88 bytes in a 32 byte
> kmalloc object at boot. slub_debug=3DFZPU reports "Right Redzone
> overwritten" in kmalloc-32, and v6.5 and v6.6 panic in
> __kmem_cache_alloc_node() while registering sh7785-irq0123.
>=20
> Found with a custom QEMU model of the SH7785LCR. On it, v6.4
> sh7785lcr_defconfig boots with SLAB, the defconfig default before v6.5,
> and hangs before the console is up when built with SLUB.
>=20
> Sort the lists once all vectors are registered, with the number of
> entries that were added.
>=20
> Fixes: b59f9f9775e6 ("sh: intc: optimize intc IRQ lookup")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> Notes:
>     Testing, all in QEMU on a custom SH7785LCR model, not on hardware:
>     - v6.5 and v6.6 sh7785lcr_defconfig hang before the console is up
>       (gcc 8 and gcc 14). With slub_debug=3DFZPU they boot and validating
>       kmalloc-32 reports "Right Redzone overwritten" after the object
>       holding the entries of sh7785-irq4567. With this patch they boot
>       and the report is gone.
>     - v6.4 sh7785lcr_defconfig (SLAB) boots. The same v6.4 built with SLU=
B
>       hangs, reports the overflow with slub_debug=3DFZPU, and boots with
>       this patch.
>     - Current mainline boots with or without the patch, but reports the
>       overflow with slub_debug=3DFZPU unless patched.
>     Testing on real hardware is welcome.
>=20
>  drivers/sh/intc/core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index aa68fe190865d..ffbe60234eefc 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -275,9 +275,6 @@ int __init register_intc_controller(struct intc_desc =
*desc)
>  			k +=3D save_reg(d, k, hw->prio_regs[i].set_reg, smp);
>  			k +=3D save_reg(d, k, hw->prio_regs[i].clr_reg, smp);
>  		}
> -
> -		sort(d->prio, hw->nr_prio_regs, sizeof(*d->prio),
> -		     intc_handle_int_cmp, NULL);
>  	}
> =20
>  	if (hw->sense_regs) {
> @@ -287,9 +284,6 @@ int __init register_intc_controller(struct intc_desc =
*desc)
> =20
>  		for (i =3D 0; i < hw->nr_sense_regs; i++)
>  			k +=3D save_reg(d, k, hw->sense_regs[i].reg, 0);
> -
> -		sort(d->sense, hw->nr_sense_regs, sizeof(*d->sense),
> -		     intc_handle_int_cmp, NULL);
>  	}
> =20
>  	if (hw->subgroups)
> @@ -357,6 +351,11 @@ int __init register_intc_controller(struct intc_desc=
 *desc)
>  		}
>  	}
> =20
> +	sort(d->prio, d->nr_prio, sizeof(*d->prio),
> +	     intc_handle_int_cmp, NULL);
> +	sort(d->sense, d->nr_sense, sizeof(*d->sense),
> +	     intc_handle_int_cmp, NULL);
> +
>  	intc_subgroup_init(desc, d);
> =20
>  	/* enable bits matching force_enable after registering irqs */

I just booted the kernel with slub_debug=3DFZPU on my SH-7785LCR EVB and
I'm getting the following "kmalloc Redzone overwritten" warning in both
cases.

Without your patch:

[    9.580000] [kmalloc Redzone overwritten] 0x820d32a9-0x820d32a9 @offset=
=3D681. First byte 0x9 instead of 0xcc
[    9.580000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[    9.580000] BUG kmalloc-32 (Not tainted): Object corrupt
[    9.580000] ------------------------------------------------------------=
-----------------
[    9.580000]=20
[    9.580000] Allocated in usb_get_configuration+0x12c/0x11d8 age=3D51 cpu=
=3D0 pid=3D10
[    9.580000]  _raw_spin_lock_irqsave+0x20/0x38
[    9.580000]  ___slab_alloc+0x21e/0x44c
[    9.580000]  _raw_spin_unlock_irqrestore+0xe/0x44
[    9.580000]  __alloc_object+0xaa/0x19c
[    9.580000]  memset+0x0/0x8c
[    9.580000]  __kmalloc_noprof+0xb0/0x1c0
[    9.580000]  memset+0x0/0x8c
[    9.580000]  _kzalloc_noprof.constprop.0+0xc/0x1c
[    9.580000]  usb_get_configuration+0x12c/0x11d8
[    9.580000]  usb_get_configuration+0x12c/0x11d8
[    9.580000]  _kzalloc_noprof.constprop.0+0x0/0x1c
[    9.580000]  set_next_task_fair+0x190/0x350
[    9.580000]  __schedule+0x5aa/0x6bc
[    9.580000]  _raw_spin_lock_irqsave+0x20/0x38
[    9.580000]  _raw_spin_unlock_irqrestore+0xe/0x44
[    9.580000]  __try_to_del_timer_sync+0x4a/0x88
[    9.580000] Slab 0x9ff41a60 objects=3D32 used=3D7 fp=3D0x820d33a0 flags=
=3D0x40000200(workingset|section=3D16|zone=3D0)
[    9.580000] Object 0x820d32a0 @offset=3D672 fp=3D0x820d3320
[    9.580000]=20
[    9.580000] Redzone  820d3280: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.580000] Redzone  820d3290: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.580000] Object   820d32a0: 09 02 20 00 01 01 00 80 fa 09 cc cc cc cc=
 cc cc  .. .............
[    9.580000] Object   820d32b0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.580000] Redzone  820d32c0: cc cc cc cc                              =
        ....
[    9.580000] Padding  820d32f4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a      =
        ZZZZZZZZZZZZ
[    9.580000] Disabling lock debugging due to kernel taint
[    9.580000] ------------[ cut here ]------------
[    9.580000] WARNING: mm/slub.c:1257 at object_err+0x46/0x158, CPU#0: kwo=
rker/0:1/10
[    9.580000] Modules linked in:
[    9.580000]=20
[    9.580000] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G    B     =
          7.3.0-rc5-00001-g8cd915e933c5 #4 PREEMPT=20
[    9.580000] Tainted: [B]=3DBAD_PAGE
[    9.580000] Workqueue: usb_hub_wq hub_event
[    9.580000] PC is at object_err+0x46/0x158
[    9.580000] PR is at object_err+0x46/0x158
[    9.580000] PC  : 80004e3a SP  : 810cdc20 SR  : 400081f1 TEA : c00d0008
[    9.580000] R0  : 00000020 R1  : 8074959c R2  : 00000000 R3  : 00000020
[    9.580000] R4  : 00000001 R5  : ff623224 R6  : 00000000 R7  : 00000000
[    9.580000] R8  : 810023e0 R9  : 820d32a0 R10 : 00000054 R11 : 80004d48
[    9.580000] R12 : 0000808f R13 : 80004bd4 R14 : 810cdc20
[    9.580000] MACH: 0000003a MACL: 0002bfa8 GBR : 2958a4c0 PR  : 80004e3a
[    9.580000]=20
[    9.580000] Call trace:
[    9.580000]  [<800ff6d2>] check_bytes_and_report+0xa2/0xfc
[    9.580000]  [<800ff7d2>] check_object+0xa6/0x204
[    9.580000]  [<800ff630>] check_bytes_and_report+0x0/0xfc
[    9.580000]  [<80100222>] free_to_partial_list+0x9a/0x2b8
[    9.580000]  [<800788da>] __timer_delete_sync+0x2a/0x50
[    9.580000]  [<80078810>] __try_to_del_timer_sync+0x0/0x88
[    9.580000]  [<8007890c>] timer_delete_sync+0xc/0x18
[    9.580000]  [<8010048a>] __slab_free+0x4a/0x19c
[    9.580000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.580000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.580000]  [<80112d28>] delete_object_full+0x40/0x68
[    9.580000]  [<80101bf6>] kfree+0x112/0x1a4
[    9.580000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.580000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.580000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.580000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.580000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.580000]  [<80044ec0>] set_next_task_fair+0x190/0x350
[    9.580000]  [<800788da>] __timer_delete_sync+0x2a/0x50
[    9.580000]  [<80078810>] __try_to_del_timer_sync+0x0/0x88
[    9.580000]  [<8007890c>] timer_delete_sync+0xc/0x18
[    9.580000]  [<80492f70>] schedule_timeout+0x98/0xe4
[    9.580000]  [<80323842>] usb_new_device+0x46/0x2ac
[    9.580000]  [<80493014>] schedule_timeout_uninterruptible+0x14/0x20
[    9.580000]  [<803248c0>] hub_event+0xbf0/0xdf4
[    9.580000]  [<8025657c>] _find_next_zero_bit+0x0/0x6c
[    9.580000]  [<80493756>] _raw_spin_unlock_bh+0x16/0x2c
[    9.580000]  [<80323360>] hub_init_func3+0x10/0x20
[    9.580000]  [<8002f084>] process_scheduled_works+0x148/0x25c
[    9.580000]  [<80030638>] wq_worker_sleeping+0x14/0x88
[    9.580000]  [<8002ccca>] assign_work+0x6c/0x82
[    9.580000]  [<8002f358>] worker_thread+0xe4/0x1a8
[    9.580000]  [<80493b98>] _raw_spin_lock_irq+0x0/0x34
[    9.580000]  [<8002cc5e>] assign_work+0x0/0x82
[    9.580000]  [<80036168>] kthread+0xdc/0x114
[    9.580000]  [<8002f274>] worker_thread+0x0/0x1a8
[    9.580000]  [<8001d45c>] do_exit+0x0/0x798
[    9.580000]  [<80010200>] ret_from_kernel_thread+0xc/0x14
[    9.580000]  [<8003f0c4>] schedule_tail+0x0/0x78
[    9.580000]  [<8003608c>] kthread+0x0/0x114
[    9.580000]=20
[    9.580000] ---[ end trace 0000000000000000 ]---
[    9.580000] FIX kmalloc-32: Restoring kmalloc Redzone 0x820d32a9-0x820d3=
2a9=3D0xcc
[    9.580000] FIX kmalloc-32: Object at 0x820d32a0 not freed
[   10.536000] kmemleak: Kernel memory leak detector initialized (mem pool =
available: 15907)
[   10.544000] kmemleak: Automatic memory scanning thread started

With your patch:

[    9.612000] [kmalloc Redzone overwritten] 0x820cc229-0x820cc229 @offset=
=3D553. First byte 0x9 instead of 0xcc
[    9.612000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[    9.612000] BUG kmalloc-32 (Not tainted): Object corrupt
[    9.612000] ------------------------------------------------------------=
-----------------
[    9.612000]=20
[    9.612000] Allocated in usb_get_configuration+0x12c/0x11d8 age=3D51 cpu=
=3D0 pid=3D10
[    9.612000]  _raw_spin_lock_irqsave+0x20/0x38
[    9.612000]  ___slab_alloc+0x21e/0x44c
[    9.612000]  _raw_spin_unlock_irqrestore+0xe/0x44
[    9.612000]  __alloc_object+0xaa/0x19c
[    9.612000]  memset+0x0/0x8c
[    9.612000]  __kmalloc_noprof+0xb0/0x1c0
[    9.612000]  memset+0x0/0x8c
[    9.612000]  _kzalloc_noprof.constprop.0+0xc/0x1c
[    9.612000]  usb_get_configuration+0x12c/0x11d8
[    9.612000]  usb_get_configuration+0x12c/0x11d8
[    9.612000]  _kzalloc_noprof.constprop.0+0x0/0x1c
[    9.612000]  set_next_task_fair+0x190/0x350
[    9.612000]  __schedule+0x5aa/0x6bc
[    9.612000]  _raw_spin_lock_irqsave+0x20/0x38
[    9.612000]  _raw_spin_unlock_irqrestore+0xe/0x44
[    9.612000]  __try_to_del_timer_sync+0x4a/0x88
[    9.612000] Slab 0x9ff41980 objects=3D32 used=3D6 fp=3D0x820cc320 flags=
=3D0x40000200(workingset|section=3D16|zone=3D0)
[    9.612000] Object 0x820cc220 @offset=3D544 fp=3D0x820cc2a0
[    9.612000]=20
[    9.612000] Redzone  820cc200: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.612000] Redzone  820cc210: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.612000] Object   820cc220: 09 02 20 00 01 01 00 80 fa 09 cc cc cc cc=
 cc cc  .. .............
[    9.612000] Object   820cc230: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.612000] Redzone  820cc240: cc cc cc cc                              =
        ....
[    9.612000] Padding  820cc274: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a      =
        ZZZZZZZZZZZZ
[    9.612000] Disabling lock debugging due to kernel taint
[    9.612000] ------------[ cut here ]------------
[    9.612000] WARNING: mm/slub.c:1257 at object_err+0x46/0x158, CPU#0: kwo=
rker/0:1/10
[    9.612000] Modules linked in:
[    9.612000]=20
[    9.612000] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G    B     =
          7.3.0-rc5-00002-g02d53450ebff #3 PREEMPT=20
[    9.612000] Tainted: [B]=3DBAD_PAGE
[    9.612000] Workqueue: usb_hub_wq hub_event
[    9.612000] PC is at object_err+0x46/0x158
[    9.612000] PR is at object_err+0x46/0x158
[    9.612000] PC  : 80004e3a SP  : 810cdc20 SR  : 400081f1 TEA : c00d0008
[    9.612000] R0  : 00000020 R1  : 8074959c R2  : 00000000 R3  : 00000020
[    9.612000] R4  : 00000001 R5  : ff623224 R6  : 00000000 R7  : 00000000
[    9.612000] R8  : 810023e0 R9  : 820cc220 R10 : 00000054 R11 : 80004d48
[    9.612000] R12 : 0000808f R13 : 80004bd4 R14 : 810cdc20
[    9.612000] MACH: 0000003d MACL: 0002bfa8 GBR : 2958a4c0 PR  : 80004e3a
[    9.612000]=20
[    9.612000] Call trace:
[    9.612000]  [<800ff6d2>] check_bytes_and_report+0xa2/0xfc
[    9.612000]  [<800ff7d2>] check_object+0xa6/0x204
[    9.612000]  [<800ff630>] check_bytes_and_report+0x0/0xfc
[    9.612000]  [<80100222>] free_to_partial_list+0x9a/0x2b8
[    9.612000]  [<800788da>] __timer_delete_sync+0x2a/0x50
[    9.612000]  [<80078810>] __try_to_del_timer_sync+0x0/0x88
[    9.612000]  [<8007890c>] timer_delete_sync+0xc/0x18
[    9.612000]  [<8010048a>] __slab_free+0x4a/0x19c
[    9.612000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.612000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.612000]  [<80112d28>] delete_object_full+0x40/0x68
[    9.612000]  [<80101bf6>] kfree+0x112/0x1a4
[    9.612000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.612000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.612000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.612000]  [<8032b516>] usb_get_configuration+0x1a2/0x11d8
[    9.612000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.612000]  [<80044ec0>] set_next_task_fair+0x190/0x350
[    9.612000]  [<800788da>] __timer_delete_sync+0x2a/0x50
[    9.612000]  [<80078810>] __try_to_del_timer_sync+0x0/0x88
[    9.612000]  [<8007890c>] timer_delete_sync+0xc/0x18
[    9.612000]  [<80492f70>] schedule_timeout+0x98/0xe4
[    9.612000]  [<80323842>] usb_new_device+0x46/0x2ac
[    9.612000]  [<80493014>] schedule_timeout_uninterruptible+0x14/0x20
[    9.612000]  [<803248c0>] hub_event+0xbf0/0xdf4
[    9.612000]  [<8025657c>] _find_next_zero_bit+0x0/0x6c
[    9.612000]  [<80493756>] _raw_spin_unlock_bh+0x16/0x2c
[    9.612000]  [<80323360>] hub_init_func3+0x10/0x20
[    9.612000]  [<8002f084>] process_scheduled_works+0x148/0x25c
[    9.612000]  [<80030638>] wq_worker_sleeping+0x14/0x88
[    9.612000]  [<8002ccca>] assign_work+0x6c/0x82
[    9.612000]  [<8002f358>] worker_thread+0xe4/0x1a8
[    9.612000]  [<80493b98>] _raw_spin_lock_irq+0x0/0x34
[    9.612000]  [<8002cc5e>] assign_work+0x0/0x82
[    9.612000]  [<80036168>] kthread+0xdc/0x114
[    9.612000]  [<8002f274>] worker_thread+0x0/0x1a8
[    9.612000]  [<8001d45c>] do_exit+0x0/0x798
[    9.612000]  [<80010200>] ret_from_kernel_thread+0xc/0x14
[    9.612000]  [<8003f0c4>] schedule_tail+0x0/0x78
[    9.612000]  [<8003608c>] kthread+0x0/0x114
[    9.612000]=20
[    9.612000] ---[ end trace 0000000000000000 ]---
[    9.612000] FIX kmalloc-32: Restoring kmalloc Redzone 0x820cc229-0x820cc=
229=3D0xcc
[    9.612000] FIX kmalloc-32: Object at 0x820cc220 not freed
[   10.528000] kmemleak: Kernel memory leak detector initialized (mem pool =
available: 15907)
[   10.536000] kmemleak: Automatic memory scanning thread started

Are you sure your patch actually fixes this problem?

Or do I maybe need a cold reboot?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
