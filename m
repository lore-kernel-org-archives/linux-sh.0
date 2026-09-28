Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4F4E36F6;
	Mon, 28 Sep 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607725; cv=none; b=FAWL5bxm0hxv52JskyY4V/QwSXRT2mHPeLQ8/Qtc2qeMrE+XS4KV96wo4sXG0NZopjymC/k9Hx5fP2vC06sIDAWeJ64zF4UzWGRtk42XtqAah/Mmx+DQPv3zrQDQAPImvoYzsupqHm6yagyebm7keMc4WzCtk2U6BCl/XllOt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607725; c=relaxed/simple;
	bh=3Sp+De0eWOBBxrSjv1LaZhSd0QuqC+DGO3CY6tjd/LU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6r6x+xsI3k6QcrmKxAKDkfUAuyt9DaSKcZm6XyXavtyDIxx+ck4zjfSgOd9d48yc6QsqoxD9QEm5I1l434UeDfcfUboyT5uGJ7rTlELhg/JV1cT5RLBnWIaJ6keFPjjjv8F/CqoDe3iTRhDR+765nrJBXfa2jt8q7Q5cnfO1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=jen8dR3Y; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="jen8dR3Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=TTAsZ/FG+6xRXis/eVJHzTHZpMK2QDzcT3PxJfAUZ6o=; t=1790607720;
	x=1791212520; b=jen8dR3Y6USTyW3eTIKIu+E3e4WkVZmRp0eMA6jAfllNFCGqbNhyZ8uvR6p1Y
	FgOm3ek5242b3tOJVEskc7IiEir0+1wAUzK+EtrFKaUc7drH8u/8QMJ0zS1W+l5aP9QhniyOT/tYg
	iZlHSSjpwpjneTDM+cCdTSRcNtGIAamco9o+xXD+L242NeAP/zQ72XSgFml9RysKypCC7YLqKigOe
	YSRGwrV3nBJC0sZtOQuH3hWlkKPDyOYGaCceUb6bFdj2PF8ZZZjR/w9QAhludLi9agypNc5Fhqapf
	b69JYOnvb6acq/dFZc09SIHz4J+XxnCwCOqvmuif7BO3wY86/g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xBCrZ-00000000ccf-2YoS; Mon, 28 Sep 2026 17:01:53 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xBCrZ-00000002RLR-1axb; Mon, 28 Sep 2026 17:01:53 +0200
Message-ID: <d4f35d5001924ef9ff4b28ac412a9d4b6048d789.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 17:01:52 +0200
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

I tried this patch and the kernel still gets stuck for me after loading it
with u-boot, the problem that I have been seeing since 6.5.0 and haven't
been able to resolve.

=3D> usb reset; fatload usb 0:1 0x89000000 uImage-7.3.0.gz ; pmb ; bootm
(Re)start USB...
USB0:   scanning bus 0 for devices... 2 USB Device(s) found
       scanning usb for storage devices... 1 Storage Device(s) found
reading uImage-7.3.0.gz
3649306 bytes read in 2074 ms (1.7 MiB/s)
## Booting kernel from Legacy Image at 89000000 ...
   Image Name:   Linux-7.3.0-rc5-00001-g8cd915e93
   Image Type:   SuperH Linux Kernel Image (gzip compressed)
   Data Size:    3649242 Bytes =3D 3.5 MiB
   Load Address: 8c010000
   Entry Point:  8c011000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

I also never understood why the load address I used at the u-boot prompt
differed from the one that the uImage build process showed at the end of
the kernel build:

  GZIP    arch/sh/boot/vmlinux.bin.gz
  UIMAGE  arch/sh/boot/uImage.gz
Image Name:   Linux-7.3.0-rc5-00002-g02d53450e
Created:      Mon Sep 28 14:56:15 2026
Image Type:   SuperH Linux Kernel Image (gzip compressed)
Data Size:    3649249 Bytes =3D 3563.72 KiB =3D 3.48 MiB
Load Address: 8c010000
Entry Point:  8c011000
  Image arch/sh/boot/uImage is ready

Any idea?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
