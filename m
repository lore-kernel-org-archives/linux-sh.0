Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21693101A9;
	Sat,  3 Oct 2026 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791012548; cv=none; b=W9HhOociyc4OokEU8QposdqcJYbuQAQ7C4D3kVMoi/K7H63FeH0aJC0DnBPF1emNq/i1Sgwifj/hi/6U49rhmt4+bswqMpQOTEg21mxi7LL4O0x223tsX8whc+LUwZXWPjbZLC3ICJ9dYqazAxVsHQBlwnI9lonqZmU0urXL5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791012548; c=relaxed/simple;
	bh=QAZxF42yFxmxRaWTu65PnAdmxN8G5AG9D1ZBmDsgVno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KeVe0Pf24Yg6OMe37jEbNrFQwHt5JKLd8eP0USewTkNks/FXEtnOPXm4QSNq+wdmj2RM2YFjh9f8SooQPn1Wf3MnvqJU7uCllgmcW097EKfKhT8uIyLeptoq1X7SQSJcLme3iTr7Z2/XUErwY1Lm0w49q9ZWVO2pKdEjmmXTxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=c1KKXtPj; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="c1KKXtPj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=SmIBZmUqEdRbscojyJFi/SOpB/iGb5DMUUhqbSfuGUs=; t=1791012545;
	x=1791617345; b=c1KKXtPjLIjkT6QXQcYB4j9VsuOJ7+XRUrac1ftimNrrVT0L/ScYCvohzCA2E
	0430+JAYVAs+MzI/5Z32VfbCRSFP4wYWIuF2mKHE84oaH6cQmNk8k7CgJ6YHH/NmiKD1pDUIs/tU2
	Rwvcf75h5wYzBTmjVMyLRtR6MLrZPDUQWAWldAFQcwq52OMb+Tpx/gsgAuYMQu6ZLByOjy8BdUIzh
	hq0NAeWvgWjWc68DX47FHVS2bYjemJfyJkPWg5LO5/fRmQRSnsVU20wKuCMX0byjqyzU3WVWQKJeV
	qmXha8PxP4T6NKYsi7TlZbrjS51alBZeuq/etSCTIY9zHDAEfQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCuB5-00000002odj-35O6; Sat, 03 Oct 2026 09:29:03 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCuB5-00000002Azq-27tA; Sat, 03 Oct 2026 09:29:03 +0200
Message-ID: <c8361e4bdc00b73025c989fa56913776ebeda829.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] usb: r8a66597-hcd: fix buffer overflow on odd-length
 FIFO reads
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 09:29:02 +0200
In-Reply-To: <20261002213225.27834-1-kmehltretter@gmail.com>
References: <20261002213225.27834-1-kmehltretter@gmail.com>
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

Hi,

On Fri, 2026-10-02 at 23:32 +0200, Karl Mehltretter wrote:
> For an external R8A66597 (pdata->on_chip is false), the driver accesses
> the FIFO 16 bits at a time. It rounds an odd byte count up to the next
> word and passes that word count to ioread16_rep(), which stores both byte=
s
> of every word in the caller's buffer. The final word therefore writes one
> byte beyond an odd-length read, past the end of the buffer when the read
> fills it.
>=20
> This is visible while enumerating a USB device on an SH7785LCR. The USB
> core allocates nine bytes for the configuration descriptor header, and
> the controller driver stores ten bytes in it. SLUB reports the first
> redzone byte changing from 0xcc to 0x09 in usb_get_configuration().
> Odd-sized HID report descriptors trigger the same overwrite.
>=20
> Section 2.8.5 of the R8A66597 datasheet requires software to discard the
> excess byte after a 16-bit FIFO read when DTLN is odd. Read the trailing
> byte through a temporary word and copy only that byte.
>=20
> Fixes: 5d3043586db4 ("USB: r8a66597-hcd: host controller driver for R8A66=
597")
> Cc: stable@vger.kernel.org
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Link: https://lore.kernel.org/all/3bd32eaf159db61ed1d423e1d52a869b3689c68=
2.camel@physik.fu-berlin.de/
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>=20
> Reproduced with 32-bit and 29-bit SH7785LCR kernels against a local
> R8A66597 QEMU model. Before this patch, slub_debug=3DFZPU reports overflo=
ws
> for the 9-byte configuration header and the 63-byte HID report descriptor=
.
> An A/B test of this patch with the 32-bit kernel enumerates the keyboard
> and removes both reports.
> Testing the fix on real hardware is welcome.
>=20
>  drivers/usb/host/r8a66597.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
> --- a/drivers/usb/host/r8a66597.h
> +++ b/drivers/usb/host/r8a66597.h
> @@ -178,8 +178,15 @@ static inline void r8a66597_read_fifo(struct r8a6659=
7 *r8a66597,
>  			       len & 0x03);
>  		}
>  	} else {
> -		len =3D (len + 1) / 2;
> -		ioread16_rep(fifoaddr, buf, len);
> +		count =3D len / 2;
> +		ioread16_rep(fifoaddr, buf, count);
> +
> +		if (len & 0x00000001) {
> +			u16 tmp;
> +
> +			ioread16_rep(fifoaddr, &tmp, 1);
> +			memcpy((unsigned char *)buf + count * 2, &tmp, 1);
> +		}
>  	}
>  }
> =20

Without the patch, the following memory leaks are reported:

[    9.676000] [kmalloc Redzone overwritten] 0x820c4229-0x820c4229 @offset=
=3D553. First byte 0x9 instead of 0xcc
[    9.676000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[    9.676000] BUG kmalloc-32 (Not tainted): Object corrupt
[    9.676000] ------------------------------------------------------------=
-----------------
[    9.676000]=20
[    9.676000] Allocated in usb_get_configuration+0x12c/0x11d8 age=3D51 cpu=
=3D0 pid=3D10
[    9.676000]  _raw_spin_lock_irqsave+0x20/0x38
[    9.676000]  ___slab_alloc+0x21e/0x44c
[    9.676000]  _raw_spin_unlock_irqrestore+0xe/0x44
[    9.676000]  __alloc_object+0xaa/0x19c
[    9.676000]  memset+0x0/0x8c
[    9.676000]  __kmalloc_noprof+0xb0/0x1c0
[    9.676000]  memset+0x0/0x8c
[    9.676000]  _kzalloc_noprof.constprop.0+0xc/0x1c
[    9.676000]  usb_get_configuration+0x12c/0x11d8
[    9.676000]  usb_get_configuration+0x12c/0x11d8
[    9.676000]  _kzalloc_noprof.constprop.0+0x0/0x1c
[    9.676000]  set_next_task_fair+0x190/0x350
[    9.676000]  __schedule+0x5aa/0x6bc
[    9.676000]  _raw_spin_lock_irqsave+0x20/0x38
[    9.676000]  _raw_spin_unlock_irqrestore+0xe/0x44
[    9.676000]  __try_to_del_timer_sync+0x4a/0x88
[    9.676000] Slab 0x9ff41880 objects=3D32 used=3D6 fp=3D0x820c4320 flags=
=3D0x40000200(workingset|section=3D16|zone=3D0)
[    9.676000] Object 0x820c4220 @offset=3D544 fp=3D0x820c42a0
[    9.676000]=20
[    9.676000] Redzone  820c4200: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.676000] Redzone  820c4210: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.676000] Object   820c4220: 09 02 20 00 01 01 00 80 fa 09 cc cc cc cc=
 cc cc  .. .............
[    9.676000] Object   820c4230: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[    9.676000] Redzone  820c4240: cc cc cc cc                              =
        ....
[    9.676000] Padding  820c4274: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a      =
        ZZZZZZZZZZZZ
[    9.676000] Disabling lock debugging due to kernel taint
[    9.676000] ------------[ cut here ]------------
[    9.676000] WARNING: mm/slub.c:1257 at object_err+0x46/0x158, CPU#0: kwo=
rker/0:1/10
[    9.676000] Modules linked in:
[    9.676000]=20
[    9.676000] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G    B     =
          7.3.0-rc5-00340-ge767a4ea70a3 #6 PREEMPT=20
[    9.676000] Tainted: [B]=3DBAD_PAGE
[    9.676000] Workqueue: usb_hub_wq hub_event
[    9.676000] PC is at object_err+0x46/0x158
[    9.676000] PR is at object_err+0x46/0x158
[    9.676000] PC  : 80004e3a SP  : 810cdc20 SR  : 400081f1 TEA : c00d0008
[    9.676000] R0  : 00000020 R1  : 8074959c R2  : 00000000 R3  : 00000020
[    9.676000] R4  : 00000001 R5  : ff623224 R6  : 00000000 R7  : 00000000
[    9.676000] R8  : 810023e0 R9  : 820c4220 R10 : 00000054 R11 : 80004d48
[    9.676000] R12 : 0000808f R13 : 80004bd4 R14 : 810cdc20
[    9.676000] MACH: 00000043 MACL: 0002bfa8 GBR : 2958a4c0 PR  : 80004e3a
[    9.676000]=20
[    9.676000] Call trace:
[    9.676000]  [<800ff726>] check_bytes_and_report+0xa2/0xfc
[    9.676000]  [<800ff826>] check_object+0xa6/0x204
[    9.676000]  [<800ff684>] check_bytes_and_report+0x0/0xfc
[    9.676000]  [<80100276>] free_to_partial_list+0x9a/0x2b8
[    9.676000]  [<800788ce>] __timer_delete_sync+0x2a/0x50
[    9.676000]  [<80078804>] __try_to_del_timer_sync+0x0/0x88
[    9.676000]  [<80078900>] timer_delete_sync+0xc/0x18
[    9.676000]  [<801004de>] __slab_free+0x4a/0x19c
[    9.676000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.676000]  [<8032b626>] usb_get_configuration+0x1a2/0x11d8
[    9.676000]  [<80112d6c>] delete_object_full+0x40/0x68
[    9.676000]  [<80101c4a>] kfree+0x112/0x1a4
[    9.676000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.676000]  [<8032b626>] usb_get_configuration+0x1a2/0x11d8
[    9.676000]  [<8032b626>] usb_get_configuration+0x1a2/0x11d8
[    9.676000]  [<8032b626>] usb_get_configuration+0x1a2/0x11d8
[    9.676000]  [<80009264>] _dev_notice+0x0/0x5c
[    9.676000]  [<80044eb4>] set_next_task_fair+0x190/0x350
[    9.676000]  [<800788ce>] __timer_delete_sync+0x2a/0x50
[    9.676000]  [<80078804>] __try_to_del_timer_sync+0x0/0x88
[    9.676000]  [<80078900>] timer_delete_sync+0xc/0x18
[    9.676000]  [<804931f0>] schedule_timeout+0x98/0xe4
[    9.676000]  [<80323952>] usb_new_device+0x46/0x2ac
[    9.676000]  [<80493294>] schedule_timeout_uninterruptible+0x14/0x20
[    9.676000]  [<803249d0>] hub_event+0xbf0/0xdf4
[    9.676000]  [<8025667c>] _find_next_zero_bit+0x0/0x6c
[    9.676000]  [<80323470>] hub_init_func3+0x10/0x20
[    9.676000]  [<8002f078>] process_scheduled_works+0x148/0x25c
[    9.676000]  [<8003062c>] wq_worker_sleeping+0x14/0x88
[    9.676000]  [<8002ccbe>] assign_work+0x6c/0x82
[    9.676000]  [<8002f34c>] worker_thread+0xe4/0x1a8
[    9.676000]  [<80493e18>] _raw_spin_lock_irq+0x0/0x34
[    9.676000]  [<8002cc52>] assign_work+0x0/0x82
[    9.676000]  [<8003615c>] kthread+0xdc/0x114
[    9.676000]  [<8002f268>] worker_thread+0x0/0x1a8
[    9.676000]  [<8001d45c>] do_exit+0x0/0x798
[    9.676000]  [<80010200>] ret_from_kernel_thread+0xc/0x14
[    9.676000]  [<8003f0b8>] schedule_tail+0x0/0x78
[    9.676000]  [<80036080>] kthread+0x0/0x114
[    9.676000]=20
[    9.676000] ---[ end trace 0000000000000000 ]---
[    9.676000] FIX kmalloc-32: Restoring kmalloc Redzone 0x820c4229-0x820c4=
229=3D0xcc
[    9.676000] FIX kmalloc-32: Object at 0x820c4220 not freed
[   10.596000] kmemleak: Kernel memory leak detector initialized (mem pool =
available: 15907)
[   10.608000] kmemleak: Automatic memory scanning thread started

With the patch applied, there are no memory leaks reported during boot:

[   10.236000] kmemleak: Kernel memory leak detector initialized (mem pool =
available: 15907)
[   10.244000] kmemleak: Automatic memory scanning thread started

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
