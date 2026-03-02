Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E93859F3
	for <linux-sh@vger.kernel.org>; Mon,  2 Mar 2026 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436949; cv=pass; b=fXly3BaJhpUjnzEJqJE9BojTcfkXr7iDJhuErVmoSp+fY1mveV7o8bW9wnsRT+M0C5L1Sei07WysqA2FBgGFy762MJ+USA+J5vlYzN2zvHZLYnPkgACQWcw6y970JmCjg02EKUSVRAJiJE8XDoiTCTS3j/LH9eXbAvAoGQBu7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436949; c=relaxed/simple;
	bh=ujd5yXOhTDzHrD3boEovwrv4TuSWaU3Puvvt4/TwwnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY9MQubUge6tdLqwH12g6/xnxFoyiOFokDwpbiTwn/mbWAGyCGntHmoiAXLkAYIbY4uBGN9p2p3xJIg0R/0rGJvsMcqQ+zR3reCCdJzLlWVkCOpRCoqsV0a4rNtvm2D+i35S51WAJab9Gv85ZW5bU6ootm5kzpJzfe28EhTEHjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8Ntw6FO; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8Ntw6FO"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662f5c5507cso3695173eaf.3
        for <linux-sh@vger.kernel.org>; Sun, 01 Mar 2026 23:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772436944; cv=none;
        d=google.com; s=arc-20240605;
        b=TjexvpkTzvVcGPjFvvucjKanq5x5Z8ZOr001GPPk9S7r/hzE5GZdh/28+v3P9GLh+I
         G1agLIwTRiRqxNURwtlDYN8yQOKlU8VUcI0RC4msHEWCev5UVw80B2cnrlveR23aQ0ut
         wEVAAhA/isB2Avmn03NLM4LKCcy1du0j0xiSxwYs9tEPp/D1u5A8MbntJ4PFDM+sE7LH
         lKvMnkyRpEjOlDZiai+WWn7eVGCzh60ZWzZfoyK7qAg6+HgzAI2mn0X0K1P0AAPq2op5
         HQvFT4Lrm5GFChKGPhRAo2mh+auj4wLaFpIBmGNHDANZ4A6JJ1kuVY89sSZ5crCjEPVg
         GYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2mC1y6DD7pcz5Nf2sOZ2nH/LBUN0Jx9nFjMcf/CfvDQ=;
        fh=0L8rfo8qzii7se/XH6X022WMkPhBGTfcCovST+83LoQ=;
        b=iKwAqoBfH3pxWbogtKfsu8PIQIzqWBPCclBtuARtgQP34lrxPOS6bKW+BgVGILdF+z
         UR7NAFPJewWHthxdZ4rTG8FWXBhr1hvbZFDbucznvEntu0KNS4ZivnBlWPROgMZIcJ7A
         tniTA5SKlGCLq+zxWjIfqc6XxfJgrAsxDuD2/mBScngo7DyYQAT9w/1KLQuC7YBTXEBk
         cHQGCSEfdr5bEu0AIH9T5V4C51ED962/Cg4PvORTRkLP1ptIrAk7cjdNT3lNjAzvwXMO
         u7Pq1dAz+Z/UaZOvJ8YrkQ+ls116uAMtiOMBsdSmtXMIjrYxX4fSUWaOd3r3xBoaTMyX
         yolg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772436944; x=1773041744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mC1y6DD7pcz5Nf2sOZ2nH/LBUN0Jx9nFjMcf/CfvDQ=;
        b=m8Ntw6FOSkzOoGz3z/IVAB246ZBJDlR/21/auBqxdeK+rG7Xc4eUvihwi3B/uUM9Jo
         ZmUi4I0WaiiYSfHkmAw8cFv5ZBfLWpJxQQkdZ0OJ6oBElwZL4O7kwkH/VkM0CdNhuvfO
         k24xEa2MBuL4XlUI+dMJ7lMbLyJzqGe36lJQBuhPzCfdjrUEf+ABPKR4mTPw/fDxqIqz
         u//5pySzidrpVWw4r2a51zsg8L+FXe6c/NMKc9i6eMlR37AUxoZkXh2BH9kHLJAEUCxk
         f+dcpq+it/gBx3HF38OCJGg9L4wN6KrgOEKiwlMUFJtRaI6vOTzyq9WcczzKiJgf9TQ+
         KEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772436944; x=1773041744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2mC1y6DD7pcz5Nf2sOZ2nH/LBUN0Jx9nFjMcf/CfvDQ=;
        b=hiFr47qpX+5hnFQvIRNbSoh6j2Eokc6NyJOK1GNc1WQ/JFXGDiUbYl6aQC0UcpQqws
         LC62ysWrX9iUXa/msSpyoD8RtDPf2y3z0UbTkHRlVaHZupHExhVk1AjjPLLHVp80DO2q
         AUKsBamtXlCMbVB/sF/zBhrU1zdzu6rMXBWivaW4bXYKBg8KnErTONZMcQSbQl8ViUjE
         9Q7jFabXtWWaA8yKftBFBe0qSITb3OddVTlG29gaR/+pj4Ffk0Y9bckk3gOP++rxBbkD
         JZQfeExIjK9AlgPENbg/KVnBLP9sDGTp0wVdU/n2qPaOGYmYO9nizggD4KkbZ6wwPvrH
         Px6A==
X-Forwarded-Encrypted: i=1; AJvYcCVwb3XUetMXdhbAl0y1dH4mbAAxTlO+LlCilz9vN8RnsKcPljWrzvHIKyLPJF8xy7Pu+Svo1nbBww==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPwXmQbqCZRctLxP3J8IzQDjyGROkrqnTDFipbuI/wefaYD05
	9ZWxZmOUx60ttbOF1XXU+q+LdihKPS8/h27lnp4R0eCMy+hpe1sin7vQOnSfiMIhwBqf27UHYip
	qhtATazanBvgnV0vxs6XIJ17eDBPlCK0=
X-Gm-Gg: ATEYQzxuiCTVeiALHKXtsLGu53nhaj3C45XNloAqMfgPB+TQvOL/JsNTj9s6JSr1cyY
	oMxNughwCsO5K9rdyS0PwP3BGkRSZmSCs4oQSbZQ/mPmlROQB7hSvtWfSXhdLOtlcEQpsNfb5pP
	oLP+SXAB2mKQAG7cggzmejpBqb7CFSh5O+WYEXinB0sMNCI0K7SILcW0BUaqrnQYEwfJJQCCZf0
	WV5+Fb5szYWwHDaWzpUoucEKhJxmg+dN+zdr3Dp1GcZjzSryfQbR9TkkzJLsS5qa4nCyED28Btx
	XqL4clKgxpk1YrjFf8ZZOidvKiCSpkAHAph4jiLHvH8EasxiNookkiOQgvc2Yed+d8qo4GmSQc7
	eBGboxQHOYQ==
X-Received: by 2002:a05:6820:4988:b0:66e:1928:ca4f with SMTP id
 006d021491bc7-679faf11891mr5541109eaf.49.1772436943542; Sun, 01 Mar 2026
 23:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302002729.19438-1-dakr@kernel.org> <20260302002729.19438-2-dakr@kernel.org>
In-Reply-To: <20260302002729.19438-2-dakr@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Mon, 2 Mar 2026 15:35:32 +0800
X-Gm-Features: AaiRm50_s22j6LsCWMU-TfsOHqNdXrP3vXkDmNbbxBCzOFnGOAxq_l0pLMJKbQI
Message-ID: <CALbr=LbsXYYVGc6d6AC7APDW+u+UHzLj2-c3DNcMKN2ZSyYYJw@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: generalize driver_override in struct device
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, abelvesa@kernel.org, 
	srini@kernel.org, s.nawrocki@samsung.com, nuno.sa@analog.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-sh@vger.kernel.org, Wang Jiayue <akaieurus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 8:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Currently, there are 12 busses (including platform and PCI) that
> duplicate the driver_override logic for their individual devices.
>
> All of them seem to be prone to the bug described in [1].
>
> While this could be solved for every bus individually using a separate
> lock, solving this in the driver-core generically results in less (and
> cleaner) changes overall.
>
> Thus, move driver_override to struct device, provide corresponding
> accessors for busses and handle locking with a separate lock internally.
>
> In particular, add device_set_driver_override(),
> device_has_driver_override(), device_match_driver_override() and a
> helper, DEVICE_ATTR_DRIVER_OVERRIDE(), to declare the corresponding
> sysfs store() and show() callbacks.
>
> Until all busses have migrated, keep driver_set_override() in place.
>
> Note that we can't use the device lock for the reasons described in [2].
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220789 [1]
> Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kern=
el.org/ [2]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Hi Danilo,

I wanted to test if this fixes the issue using PoCs, but I'm hitting a
KASAN splat right during boot. The issue disappears if I revert this
patch.

KASAN report:
[    7.266874] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    7.267707] BUG: KASAN: slab-use-after-free in device_release+0x1f4/0x24=
0
[    7.267707] Read of size 8 at addr ffff888003f4a370 by task kworker/1:0/=
24
[    7.267707]
[    7.267707] CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted
7.0.0-rc2-00001-gc1a10dc76109 #4 PREEMP
[    7.267707] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-de4
[    7.267707] Workqueue: events_long serio_handle_event
[    7.267707] Call Trace:
[    7.267707]  <TASK>
[    7.267707]  dump_stack_lvl+0x66/0xa0
[    7.267707]  print_report+0xce/0x660
[    7.267707]  ? device_release+0x1f4/0x240
[    7.267707]  ? __virt_addr_valid+0x208/0x410
[    7.267707]  ? device_release+0x1f4/0x240
[    7.267707]  kasan_report+0xe0/0x110
[    7.267707]  ? device_release+0x1f4/0x240
[    7.267707]  device_release+0x1f4/0x240
[    7.267707]  kobject_put+0x1c8/0x450
[    7.267707]  atkbd_connect+0x615/0x9e0
[    7.267707]  ? __pfx_atkbd_connect+0x10/0x10
[    7.267707]  ? kernfs_create_link+0x169/0x230
[    7.267707]  ? do_raw_spin_unlock+0x53/0x220
[    7.267707]  serio_driver_probe+0x72/0xb0
[    7.267707]  really_probe+0x254/0x910
[    7.267707]  __driver_probe_device+0x20b/0x3d0
[    7.267707]  driver_probe_device+0x45/0x130
[    7.267707]  __driver_attach+0x1f6/0x550
[    7.267707]  ? __pfx___driver_attach+0x10/0x10
[    7.267707]  bus_for_each_dev+0x103/0x180
[    7.267707]  ? __pfx_bus_for_each_dev+0x10/0x10
[    7.267707]  ? _raw_spin_unlock_irqrestore+0x3f/0x50
[    7.267707]  ? lockdep_hardirqs_on_prepare+0xea/0x1a0
[    7.267707]  serio_handle_event+0x1ce/0x840
[    7.267707]  process_one_work+0x7fc/0x1760
[    7.267707]  ? __pfx_process_one_work+0x10/0x10
[    7.267707]  ? lock_is_held_type+0x8f/0x100
[    7.267707]  ? __pfx_serio_handle_event+0x10/0x10
[    7.267707]  worker_thread+0x593/0xfb0
[    7.267707]  ? __pfx_worker_thread+0x10/0x10
[    7.267707]  kthread+0x319/0x400
[    7.267707]  ? __pfx_kthread+0x10/0x10
[    7.267707]  ret_from_fork+0x590/0x830
[    7.267707]  ? __pfx_ret_from_fork+0x10/0x10
[    7.267707]  ? __switch_to+0x860/0xe50
[    7.267707]  ? __switch_to_asm+0x39/0x70
[    7.267707]  ? __switch_to_asm+0x33/0x70
[    7.267707]  ? __pfx_kthread+0x10/0x10
[    7.267707]  ret_from_fork_asm+0x1a/0x30
[    7.267707]  </TASK>
[    7.267707]
[    7.267707] Allocated by task 24:
[    7.267707]  kasan_save_stack+0x33/0x60
[    7.267707]  kasan_save_track+0x14/0x30
[    7.267707]  __kasan_kmalloc+0x8f/0xa0
[    7.267707]  input_allocate_device+0x3f/0x330
[    7.267707]  atkbd_connect+0x97/0x9e0
[    7.267707]  serio_driver_probe+0x72/0xb0
[    7.267707]  really_probe+0x254/0x910
[    7.267707]  __driver_probe_device+0x20b/0x3d0
[    7.267707]  driver_probe_device+0x45/0x130
[    7.267707]  __driver_attach+0x1f6/0x550
[    7.267707]  bus_for_each_dev+0x103/0x180
[    7.267707]  serio_handle_event+0x1ce/0x840
[    7.267707]  process_one_work+0x7fc/0x1760
[    7.267707]  worker_thread+0x593/0xfb0
[    7.267707]  kthread+0x319/0x400
[    7.267707]  ret_from_fork+0x590/0x830
[    7.267707]  ret_from_fork_asm+0x1a/0x30
[    7.267707]
[    7.267707] Freed by task 24:
[    7.267707]  kasan_save_stack+0x33/0x60
[    7.267707]  kasan_save_track+0x14/0x30
[    7.267707]  kasan_save_free_info+0x3b/0x60
[    7.267707]  __kasan_slab_free+0x43/0x70
[    7.267707]  kfree+0x193/0x4f0
[    7.267707]  input_dev_release+0xa6/0xd0
[    7.267707]  device_release+0x9a/0x240
[    7.267707]  kobject_put+0x1c8/0x450
[    7.267707]  atkbd_connect+0x615/0x9e0
[    7.267707]  serio_driver_probe+0x72/0xb0
[    7.267707]  really_probe+0x254/0x910
[    7.267707]  __driver_probe_device+0x20b/0x3d0
[    7.267707]  driver_probe_device+0x45/0x130
[    7.267707]  __driver_attach+0x1f6/0x550
[    7.267707]  bus_for_each_dev+0x103/0x180
[    7.267707]  serio_handle_event+0x1ce/0x840
[    7.267707]  process_one_work+0x7fc/0x1760
[    7.267707]  worker_thread+0x593/0xfb0
[    7.267707]  kthread+0x319/0x400
[    7.267707]  ret_from_fork+0x590/0x830
[    7.267707]  ret_from_fork_asm+0x1a/0x30
[    7.267707]
[    7.267707] The buggy address belongs to the object at ffff888003f4a000
[    7.267707]  which belongs to the cache kmalloc-2k of size 2048
[    7.267707] The buggy address is located 880 bytes inside of
[    7.267707]  freed 2048-byte region [ffff888003f4a000, ffff888003f4a800)
[    7.267707]
[    7.267707] The buggy address belongs to the physical page:
[    7.267707] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0xffff888003f4b800 pfn:0x3f48
[    7.267707] head: order:3 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[    7.267707] flags: 0x100000000000240(workingset|head|node=3D0|zone=3D1)
[    7.267707] page_type: f5(slab)
[    7.267707] raw: 0100000000000240 ffff888001043240 ffff888001041088
ffff888001041088
[    7.267707] raw: ffff888003f4b800 0000000000050002 00000000f5000000
0000000000000000
[    7.267707] head: 0100000000000240 ffff888001043240
ffff888001041088 ffff888001041088
[    7.267707] head: ffff888003f4b800 0000000000050002
00000000f5000000 0000000000000000
[    7.267707] head: 0100000000000003 ffffea00000fd201
00000000ffffffff 00000000ffffffff
[    7.267707] head: 0000000000000000 0000000000000000
00000000ffffffff 0000000000000000
[    7.267707] page dumped because: kasan: bad access detected
[    7.267707]
[    7.267707] Memory state around the buggy address:
[    7.267707]  ffff888003f4a200: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    7.267707]  ffff888003f4a280: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    7.267707] >ffff888003f4a300: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    7.267707]                                                             =
 ^
[    7.267707]  ffff888003f4a380: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    7.267707]  ffff888003f4a400: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    7.267707] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    7.293685] Disabling lock debugging due to kernel taint

This is on a basic QEMU x86_64 VM. Note that I did not apply the "WIP:
treewide: make callsites use generic driver_override" patch.

I'm currently looking into the root cause.

Thanks.

> ---
>  drivers/base/core.c    |  2 ++
>  drivers/base/dd.c      | 60 +++++++++++++++++++++++++++++++
>  include/linux/device.h | 81 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 791f9e444df8..a8cb90577d10 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2566,6 +2566,7 @@ static void device_release(struct kobject *kobj)
>         else
>                 WARN(1, KERN_ERR "Device '%s' does not have a release() f=
unction, it is broken and must be fixed. See Documentation/core-api/kobject=
.rst.\n",
>                         dev_name(dev));
> +       kfree(dev->driver_override.name);
>         kfree(p);
>  }
>
> @@ -3159,6 +3160,7 @@ void device_initialize(struct device *dev)
>         kobject_init(&dev->kobj, &device_ktype);
>         INIT_LIST_HEAD(&dev->dma_pools);
>         mutex_init(&dev->mutex);
> +       spin_lock_init(&dev->driver_override.lock);
>         lockdep_set_novalidate_class(&dev->mutex);
>         spin_lock_init(&dev->devres_lock);
>         INIT_LIST_HEAD(&dev->devres_head);
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 0354f209529c..697e36e63cab 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -381,6 +381,66 @@ static void __exit deferred_probe_exit(void)
>  }
>  __exitcall(deferred_probe_exit);
>
> +int __device_set_driver_override(struct device *dev, const char *s, size=
_t len)
> +{
> +       const char *new, *old;
> +       char *cp;
> +
> +       if (!s)
> +               return -EINVAL;
> +
> +       /*
> +        * The stored value will be used in sysfs show callback (sysfs_em=
it()),
> +        * which has a length limit of PAGE_SIZE and adds a trailing newl=
ine.
> +        * Thus we can store one character less to avoid truncation durin=
g sysfs
> +        * show.
> +        */
> +       if (len >=3D (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       /*
> +        * Compute the real length of the string in case userspace sends =
us a
> +        * bunch of \0 characters like python likes to do.
> +        */
> +       len =3D strlen(s);
> +
> +       if (!len) {
> +               /* Empty string passed - clear override */
> +               spin_lock(&dev->driver_override.lock);
> +               old =3D dev->driver_override.name;
> +               dev->driver_override.name =3D NULL;
> +               spin_unlock(&dev->driver_override.lock);
> +               kfree(old);
> +
> +               return 0;
> +       }
> +
> +       cp =3D strnchr(s, len, '\n');
> +       if (cp)
> +               len =3D cp - s;
> +
> +       new =3D kstrndup(s, len, GFP_KERNEL);
> +       if (!new)
> +               return -ENOMEM;
> +
> +       spin_lock(&dev->driver_override.lock);
> +       old =3D dev->driver_override.name;
> +       if (cp !=3D s) {
> +               dev->driver_override.name =3D new;
> +               spin_unlock(&dev->driver_override.lock);
> +       } else {
> +               /* "\n" passed - clear override */
> +               dev->driver_override.name =3D NULL;
> +               spin_unlock(&dev->driver_override.lock);
> +
> +               kfree(new);
> +       }
> +       kfree(old);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(__device_set_driver_override);
> +
>  /**
>   * device_is_bound() - Check if device is bound to a driver
>   * @dev: device to check
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 0be95294b6e6..4599156d5cbd 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -266,6 +266,33 @@ ssize_t device_show_string(struct device *dev, struc=
t device_attribute *attr,
>         struct dev_ext_attribute dev_attr_##_name =3D \
>                 { __ATTR(_name, (_mode) & ~0222, device_show_string, NULL=
), (_var) }
>
> +/**
> + * DEVICE_ATTR_DRIVER_OVERRIDE - Define sysfs driver_override attribute =
callbacks
> + *
> + * Generates the standard driver_override_show() and driver_override_sto=
re()
> + * sysfs callbacks and the static DEVICE_ATTR_RW(driver_override) declar=
ation.
> + */
> +#define DEVICE_ATTR_DRIVER_OVERRIDE()                                   =
       \
> +static ssize_t driver_override_store(struct device *dev,                =
       \
> +                                    struct device_attribute *attr,      =
       \
> +                                    const char *buf, size_t count)      =
       \
> +{                                                                       =
       \
> +       int ret;                                                         =
       \
> +                                                                        =
       \
> +       ret =3D __device_set_driver_override(dev, buf, count);           =
         \
> +       if (ret)                                                         =
       \
> +               return ret;                                              =
       \
> +                                                                        =
       \
> +       return count;                                                    =
       \
> +}                                                                       =
       \
> +static ssize_t driver_override_show(struct device *dev,                 =
               \
> +                                   struct device_attribute *attr, char *=
buf)   \
> +{                                                                       =
       \
> +       guard(spinlock)(&dev->driver_override.lock);                     =
       \
> +       return sysfs_emit(buf, "%s\n", dev->driver_override.name);       =
       \
> +}                                                                       =
       \
> +static DEVICE_ATTR_RW(driver_override)
> +
>  #define DEVICE_ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) \
>         struct device_attribute dev_attr_##_name =3D              \
>                 __ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
> @@ -483,6 +510,8 @@ struct device_physical_location {
>   *             on.  This shrinks the "Board Support Packages" (BSPs) and
>   *             minimizes board-specific #ifdefs in drivers.
>   * @driver_data: Private pointer for driver specific info.
> + * @driver_override: Driver name to force a match.  Do not touch directl=
y; use
> + *                  device_set_driver_override() instead.
>   * @links:     Links to suppliers and consumers of this device.
>   * @power:     For device power management.
>   *             See Documentation/driver-api/pm/devices.rst for details.
> @@ -576,6 +605,10 @@ struct device {
>                                            core doesn't touch it */
>         void            *driver_data;   /* Driver data, set and get with
>                                            dev_set_drvdata/dev_get_drvdat=
a */
> +       struct {
> +               const char      *name;
> +               spinlock_t      lock;
> +       } driver_override;
>         struct mutex            mutex;  /* mutex to synchronize calls to
>                                          * its driver.
>                                          */
> @@ -701,6 +734,54 @@ struct device_link {
>
>  #define kobj_to_dev(__kobj)    container_of_const(__kobj, struct device,=
 kobj)
>
> +int __device_set_driver_override(struct device *dev, const char *s, size=
_t len);
> +
> +/**
> + * device_set_driver_override() - Helper to set or clear driver override=
.
> + * @dev: Device to change
> + * @s: NUL-terminated string, new driver name to force a match, pass emp=
ty
> + *     string to clear it ("" or "\n", where the latter is only for sysf=
s
> + *     interface).
> + *
> + * Helper to set or clear driver override of a device.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +static inline int device_set_driver_override(struct device *dev, const c=
har *s)
> +{
> +       return __device_set_driver_override(dev, s, strlen(s));
> +}
> +
> +/**
> + * device_has_driver_override() - Check if a driver override has been se=
t.
> + * @dev: device to check
> + *
> + * Returns true if a driver override has been set for this device.
> + */
> +static inline bool device_has_driver_override(struct device *dev)
> +{
> +       guard(spinlock)(&dev->driver_override.lock);
> +       return !!dev->driver_override.name;
> +}
> +
> +/**
> + * device_match_driver_override() - Match a driver against the device's =
driver_override.
> + * @dev: device to check
> + * @drv: driver to match against
> + *
> + * Returns > 0 if a driver override is set and matches the given driver,=
 0 if a
> + * driver override is set but does not match, or < 0 if a driver overrid=
e is not
> + * set at all.
> + */
> +static inline int device_match_driver_override(struct device *dev,
> +                                              const struct device_driver=
 *drv)
> +{
> +       guard(spinlock)(&dev->driver_override.lock);
> +       if (dev->driver_override.name)
> +               return !strcmp(dev->driver_override.name, drv->name);
> +       return -1;
> +}
> +
>  /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
>   *                      by an IOMMU
> --
> 2.53.0
>
