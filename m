Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4982BEFEE;
	Sat,  3 Oct 2026 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013907; cv=none; b=kWW+KU9qZXcGh8Esde+Z1vF8MZfdpoGxmy6h9FW8p+V/Rs8HXECsLPCq5msuOC08ZJ5XDk/ItDoYYkLCZ8IpWNqtRUitkJJwmn/AVHGdrbb6KNs+fgglUySIZ0/TnkdCoX14v3c6Rjp2JkNRSSNvYFqxejd2yQVdz3AhYEjTn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013907; c=relaxed/simple;
	bh=915f/KTB/0IDOtu+i34K6Kv6BCtwZWLhJ4JjXuVfq/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7SQsWVjUSDd0TdKQXCqNlyrJ1ePMnc/mJI4s2Lb+MeUdzD6NX/rSuUu4z0V9PGjqnA/8XywG8Ml6/VuJcYl17IHFQX1j/TM6aE0Z/mi2ENuPxTwPgj1znSN1KtWU3XGQtYZa2Q77DgYMwma/ZWqNJaGb6vI4GJnpVXcJw8cTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=nlxGkYNW; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="nlxGkYNW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=pkSkd0gz3K0uXbc8+oZdyjkkYDQv0/easJRst8PwuKA=; t=1791013904;
	x=1791618704; b=nlxGkYNWLdc+YX7gYaEmJBnHjSuR1Dw6wMDgCn3RDmUyMcCZqp6CiJaZq7FVL
	mXhX9WNETnugZqnWZNycXdx0AiDk13VcxFmDk0KmSlJ8K+0H8i5QJugBDmCHxk4U0TJiICOIHOWZO
	prcD8651uDHQ6ygowo6kBprNkWAbyb+XuZNzaggZHa9YhZp59LRdpXc+3qz1SNCtNonPM0kE6oceW
	16tLi4kmaihhz4JOVfBNrcg2YhWMaHl5scv2kf7Oh1kQ6KbcCSnnaGqRWhRzhZCAV9BZpJPwU4KYe
	f3/fcF0QhhcoE7giX3fPj45mg77wMakwk1w7DCv+6qwo0QbEOw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xCuX0-00000002u1t-0SHF; Sat, 03 Oct 2026 09:51:42 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xCuWz-00000002Hyv-3XoG; Sat, 03 Oct 2026 09:51:42 +0200
Message-ID: <0e3121169e89eef9c84dfcabaa864a24a44e2760.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: intc: sort the prio and sense lists after filling
 them
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 09:51:41 +0200
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

Without the patch, a memory leak is reported when booting with slub_debug=
=3DFZPU
triggering a validation manually after boot:

root@tirpitz:~> echo 1 > /sys/kernel/slab/kmalloc-32/validate
[  181.568000] [Right Redzone overwritten] 0x810245c0-0x810245c3 @offset=3D=
1472. First byte 0x0 instead of 0xcc
[  181.568000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[  181.568000] BUG kmalloc-32 (Not tainted): Object corrupt
[  181.568000] ------------------------------------------------------------=
-----------------
[  181.568000]=20
[  181.568000] Slab 0x9ff20480 objects=3D32 used=3D32 fp=3D0x00000000 flags=
=3D0x40000000(section=3D16|zone=3D0)
[  181.568000] Object 0x810245a0 @offset=3D1440 fp=3D0x00000000
[  181.568000]=20
[  181.568000] Redzone  81024580: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[  181.568000] Redzone  81024590: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[  181.568000] Object   810245a0: 1a 00 00 00 8c 78 06 06 1c 00 00 00 88 78=
 06 06  .....x.......x..
[  181.568000] Object   810245b0: 1e 00 00 00 84 78 06 06 10 00 00 00 80 78=
 06 06  .....x.......x..
[  181.568000] Redzone  810245c0: 00 00 00 00                              =
        ....
[  181.568000] Padding  810245f4: 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a      =
        ....ZZZZZZZZ
[  181.568000] Disabling lock debugging due to kernel taint
[  181.568000] ------------[ cut here ]------------
[  181.568000] WARNING: mm/slub.c:1257 at object_err+0x46/0x158, CPU#0: bas=
h/970
[  181.568000] Modules linked in:
[  181.568000]=20
[  181.568000] CPU: 0 UID: 0 PID: 970 Comm: bash Tainted: G    B           =
    7.3.0-rc5-00341-gf6dfa8891d61 #7 PREEMPT=20
[  181.568000] Tainted: [B]=3DBAD_PAGE
[  181.568000] PC is at object_err+0x46/0x158
[  181.568000] PR is at object_err+0x46/0x158
[  181.568000] PC  : 80004e3a SP  : 86051dcc SR  : 400081f1 TEA : c0000010
[  181.568000] R0  : 00000020 R1  : 8074959c R2  : 00000000 R3  : 00000020
[  181.568000] R4  : 806becb0 R5  : fa69f078 R6  : 00000000 R7  : 00000000
[  181.568000] R8  : 810023e0 R9  : 810245a0 R10 : 00000054 R11 : 80004d48
[  181.568000] R12 : 0000808f R13 : 80004bd4 R14 : 86051dcc
[  181.568000] MACH: 00000038 MACL: 0002bfa8 GBR : 2957b860 PR  : 80004e3a
[  181.568000]=20
[  181.568000] Call trace:
[  181.568000]  [<800ff726>] check_bytes_and_report+0xa2/0xfc
[  181.568000]  [<800ff7e8>] check_object+0x68/0x204
[  181.568000]  [<800ff684>] check_bytes_and_report+0x0/0xfc
[  181.568000]  [<800ffafe>] validate_slab+0xbe/0xf4
[  181.568000]  [<800ffc12>] validate_slab_cache+0xde/0x114
[  181.568000]  [<800ffa40>] validate_slab+0x0/0xf4
[  181.568000]  [<800ffc7e>] validate_store+0x36/0x48
[  181.568000]  [<800fcd82>] slab_attr_store+0x1a/0x22
[  181.568000]  [<80185fcc>] sysfs_kf_write+0x3c/0x58
[  181.568000]  [<80185670>] kernfs_fop_write_iter+0xe6/0x136
[  181.568000]  [<801188b8>] vfs_write+0xd0/0x138
[  181.568000]  [<80118a56>] ksys_write+0x62/0xbc
[  181.568000]  [<80118aba>] sys_write+0xa/0x18
[  181.568000]  [<80118ab0>] sys_write+0x0/0x18
[  181.568000]  [<8001025a>] syscall_call+0x18/0x1e
[  181.568000]=20
[  181.568000] ---[ end trace 0000000000000000 ]---
[  181.568000] FIX kmalloc-32: Restoring Right Redzone 0x810245c0-0x810245c=
3=3D0xcc
[  181.568000] [Object padding overwritten] 0x810245f4-0x810245f7 @offset=
=3D1524. First byte 0x0 instead of 0x5a
[  181.568000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
[  181.568000] BUG kmalloc-32 (Tainted: G    B   W          ): Object corru=
pt
[  181.568000] ------------------------------------------------------------=
-----------------
[  181.568000]=20
[  181.568000] Slab 0x9ff20480 objects=3D32 used=3D32 fp=3D0x00000000 flags=
=3D0x40000000(section=3D16|zone=3D0)
[  181.568000] Object 0x810245a0 @offset=3D1440 fp=3D0x00000000
[  181.568000]=20
[  181.568000] Redzone  81024580: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[  181.568000] Redzone  81024590: cc cc cc cc cc cc cc cc cc cc cc cc cc cc=
 cc cc  ................
[  181.568000] Object   810245a0: 1a 00 00 00 8c 78 06 06 1c 00 00 00 88 78=
 06 06  .....x.......x..
[  181.568000] Object   810245b0: 1e 00 00 00 84 78 06 06 10 00 00 00 80 78=
 06 06  .....x.......x..
[  181.568000] Redzone  810245c0: cc cc cc cc                              =
        ....
[  181.568000] Padding  810245f4: 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a      =
        ....ZZZZZZZZ
[  181.568000] ------------[ cut here ]------------
[  181.568000] WARNING: mm/slub.c:1257 at object_err+0x46/0x158, CPU#0: bas=
h/970
[  181.568000] Modules linked in:
[  181.568000]=20
[  181.568000] CPU: 0 UID: 0 PID: 970 Comm: bash Tainted: G    B   W       =
    7.3.0-rc5-00341-gf6dfa8891d61 #7 PREEMPT=20
[  181.568000] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
[  181.568000] PC is at object_err+0x46/0x158
[  181.568000] PR is at object_err+0x46/0x158
[  181.568000] PC  : 80004e3a SP  : 86051dcc SR  : 400081f1 TEA : c0000010
[  181.568000] R0  : 00000220 R1  : 8074959c R2  : 00000000 R3  : 00000220
[  181.568000] R4  : 00000005 R5  : 00000001 R6  : 00000000 R7  : 00000000
[  181.568000] R8  : 810023e0 R9  : 810245a0 R10 : 00000054 R11 : 80004d48
[  181.568000] R12 : 0000808f R13 : 80004bd4 R14 : 86051dcc
[  181.568000] MACH: 00000038 MACL: 0002bfa8 GBR : 2957b860 PR  : 80004e3a
[  181.568000]=20
[  181.568000] Call trace:
[  181.568000]  [<800ff726>] check_bytes_and_report+0xa2/0xfc
[  181.568000]  [<800ff8ce>] check_object+0x14e/0x204
[  181.568000]  [<800ff684>] check_bytes_and_report+0x0/0xfc
[  181.568000]  [<800ffafe>] validate_slab+0xbe/0xf4
[  181.568000]  [<800ffc12>] validate_slab_cache+0xde/0x114
[  181.568000]  [<800ffa40>] validate_slab+0x0/0xf4
[  181.568000]  [<800ffc7e>] validate_store+0x36/0x48
[  181.568000]  [<800fcd82>] slab_attr_store+0x1a/0x22
[  181.568000]  [<80185fcc>] sysfs_kf_write+0x3c/0x58
[  181.568000]  [<80185670>] kernfs_fop_write_iter+0xe6/0x136
[  181.568000]  [<801188b8>] vfs_write+0xd0/0x138
[  181.568000]  [<80118a56>] ksys_write+0x62/0xbc
[  181.568000]  [<80118aba>] sys_write+0xa/0x18
[  181.568000]  [<80118ab0>] sys_write+0x0/0x18
[  181.568000]  [<8001025a>] syscall_call+0x18/0x1e
[  181.568000]=20
[  181.568000] ---[ end trace 0000000000000000 ]---
[  181.568000] FIX kmalloc-32: Restoring Object padding 0x810245f4-0x810245=
f7=3D0x5a
root@tirpitz:~>

With the patch applied, no leak is reported after validation:

root@tirpitz:~> echo 1 > /sys/kernel/slab/kmalloc-32/validate
root@tirpitz:~>=20

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
