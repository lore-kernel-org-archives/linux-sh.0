Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521329E10B
	for <linux-sh@vger.kernel.org>; Wed, 19 Nov 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588657; cv=none; b=Mq+F7wYsdRMbfLMZWh+EZckf4Q+U71wSTXP/ws84XYBom/wT7ylRQh0aAuoo8Tfa1k0Ng9X0FPVlX/pWdbK+6By2iapBKvTZTSVeWVP080WcNWhmmQtHKaWfBg2QADqp0KbUAbIzdJjg9JFSLlpMErFNUW0TZRdKnx5WUkpwwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588657; c=relaxed/simple;
	bh=LJ+MY7x8IVx/34IGhfvFoSblnGi4JSwCuafTMOKKaFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itww8XorWMsaSxdcyYkgkV0OOVx870L1oHE3H9fbY/x6qdhnN4vO1U/1LiBtt48vOv1AFkq8Z3TsWGutmwuKvyzzOb5mn34CMzCl7fMJwCVJAl032I2dQJHjbcCE1Cm34LRZtREEJ60XqeXYOmSNXA9ddMV4gJgzDL3ZVOgQ0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkUzjOlB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkUzjOlB"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73669bdcd2so39837166b.2
        for <linux-sh@vger.kernel.org>; Wed, 19 Nov 2025 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588654; x=1764193454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U95iNDsSv/ghWmzAcmjpejAYSRfTfC67TH6196g4c74=;
        b=MkUzjOlBc3S/mmVYQSTvL+iS9Cn4y8JuSBiQDjnHK1WDI3Old3FRYBDbMLVqNk5qX+
         sR+VR1cA7ITx2zzMY/OMKfJIuiJbi/H8JiuafLINX7YyJsgZI0ZeS7mm4lqT0g+PiizE
         OwtNPSEeQhR6qjo73fTLVEXDH6ZxDEB2FhR2DCmxHC3N+4TBjgMZnYjtOZsKLGdm5zic
         Bkf93X0sjuwCxWpwwdzenmRFQqmqVmbA0JczGaptBDWXFD8Qq8E1p0bxiZktN1QZUYAb
         Hjkz3PGHFWzOZeIbQhqvNLzp1BOQWkuUGqKULLyNnaJaVr/ansIkgzOz6Zvdggk/0XxF
         NCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588654; x=1764193454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U95iNDsSv/ghWmzAcmjpejAYSRfTfC67TH6196g4c74=;
        b=MewV/8ElqO3OEBsoZRb+6nF/18IfJUKBkgu1lXVKkgsnw9dyHL8Tqu0yfxEN5hTa9X
         xzhaO8hxGnjySa20n8DjYs88w4gvQXf4PX+CL5W/AKL0+RsHtWyeyWCDwLcDA/3kOPJc
         f9tlnqcGt48t7azYbh2sE/Zqy+UDMEfjXaA6cNsOl/xsMx0KuK1gqwgwhITxQtSqYJsF
         coBXF6JlmYaGGmuXhdeJIc7mfgwEyY8up9hxniTtnzF94lxHP/T+B/xhEnb/V981Ep6R
         Yqqx+JHhCUj3ozduEg/vDENPTlNeS/rzX6dNV97OT7MNSsQa/d0Zdu8V9oiIB8YrWOtF
         o1UA==
X-Forwarded-Encrypted: i=1; AJvYcCUQlKT2T8Vw1IuAjuPv+PQ1c4ghCjp5sGBSAO2ZZCSzWauHOmhNKj/aAjArrpKkfkEwa/JTWrMrxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtB5f6oMIkkMJdTaLkkMXeGLN2clghErTTPZtwibmpfM45VHV
	38kj4Gqbn2QggLL/saTRmHwqECxtrX3jQk67za93NwNkEMKCfG/wR8k=
X-Gm-Gg: ASbGncsB+5bOS0GSkLV9CkaObZP20Y0Hq5HuaAmD3SPpWtBArvmFjwgaJnFkGVQPOBt
	VaIP2BxIUceJYmz5yFyVP9boWiDgFiwQ+oGBqMAe+4YndX3Bg7rdr/vAlNphhtfrc1Zl1oRtd2B
	6XF9/owPOK5fznr5CZOz4YmTrkfb62cTQhGkAU+YgplH5Y5ndWl0BQeHtlPyxXQGZr9drl+OG0S
	VEyQg/McHe0CoXVZB9wnTYPMnuDuVhqNTwoHsyKSOW6XPiM3YAee/rC0nsuD2CdADk44PmVrYpt
	rl3BIR/qoPQtv26tDhY7l+OkRSLYNbCv7uOTyLIG+a9iYIDwRxLnAaqtXQr/5B9TTIKk5AOKF5g
	cjGkIHcviEPrJW6FYARuKnY8bZn3KvFOlug57VzvXzr/5hTymikvCeAs5m34LD39G2cVTDZ/MzT
	hJRU6uI6+Bt8W3SL0/Vs5Qd+tR0LvRJUouO6Tu71mF3u96sHktHqp0YTMZuZaD3KVibkNPvYLrm
	Ts=
X-Google-Smtp-Source: AGHT+IE2xXkv86N4UkOLtXCMQLWikSMyXY2JViiO06NZWnCSJi1e1dTJwXeebwOqChhJXWU2lYCUvQ==
X-Received: by 2002:a17:907:3e88:b0:b72:5e2c:9e97 with SMTP id a640c23a62f3a-b7654eb7855mr69113966b.36.1763588653565;
        Wed, 19 Nov 2025 13:44:13 -0800 (PST)
Received: from lithos ([2a02:810d:4a94:b300:9776:7754:ce4b:5663])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7655050927sm36445966b.71.2025.11.19.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:44:13 -0800 (PST)
Date: Wed, 19 Nov 2025 22:44:11 +0100
From: Florian Fuchs <fuchsfl@gmail.com>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
	Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/3] mtd: maps: vmu-flash: Fix build and runtime errors
Message-ID: <aR46Kw5n4hIAZCcn@lithos>
References: <20251117224408.498449-1-fuchsfl@gmail.com>
 <6e2e9edcd9247c216bfe1ba637629a9a838f9fed.camel@physik.fu-berlin.de>
 <5a4f8f1d543ef90aae3299b0f8803fb3@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a4f8f1d543ef90aae3299b0f8803fb3@artur-rojek.eu>

On 19 Nov 22:36, Artur Rojek wrote:
> On 2025-11-18 08:31, John Paul Adrian Glaubitz wrote:
> > Hi Florian,
> > 
> > On Mon, 2025-11-17 at 23:44 +0100, Florian Fuchs wrote:
> > > This small series fixes build and runtime errors in the vmu-flash
> > > driver
> > > (enabled by CONFIG_MTD_VMU) and the included maple.h. These changes
> > > were
> > > verified on real Dreamcast hardware with a physical VMU. The VMU can
> > > now
> > > be successfully probed, read and written with MTD tools like
> > > mtd_info and
> > > mtd_debug. Previously, the driver failed to build or crashed during
> > > probing.
> > > 
> > > 	bash-5.3# mtdinfo /dev/mtd0
> > > 	mtd0
> > > 	Name:                           vmu2.1.0
> > > 	Type:                           mlc-nand
> > > 	Eraseblock size:                512 bytes
> > > 	Amount of eraseblocks:          256 (131072 bytes, 128.0 KiB)
> > > 	Minimum input/output unit size: 512 bytes
> > > 	Sub-page size:                  512 bytes
> > > 	Character device major/minor:   90:0
> > > 	Bad blocks are allowed:         true
> > > 	Device is writable:             true
> > 
> > Thanks again for this series. Before this can be picked up, I would like
> > again
> > Artur Rojek to test it on his Dreamcast, so let's loop him in.
> > 
> > If he confirms the functionality, I'll pick it up. I'll try to get it
> > reviewed
> > later this week.
> > 
> > Adrian
> 
> Hi Florian,
> thanks for this series!
> 
> Without the maple port fix, this works as intended only when all
> four maple ports are populated. I am able to read from multiple VMUs in
> various slots.
> 
> However, with even one port not populated, it causes a panic:
> > Maple (null): detected Dreamcast Controller: function 0x1: at (0, 0)
> > Maple (null): no driver found
> > Maple (null): detected Dreamcast Controller: function 0x1: at (1, 0)
> > Maple (null): no driver found
> > Maple (null): detected Visual Memory: function 0xE: at (0, 1)
> > Maple (null): no driver found
> > BUG: unable to handle kernel paging request at 00400000
> > PC: [<8c2aecee>] maple_send.part.0+0x102/0x1c8
> > Pgd = (ptrval)
> > [00400000] *pgd=00000000
> > Oops: 0000 [#1]
> > Modules linked in:
> > 
> > CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
> > 6.18.0-rc5-next-20251114-00003-gb6bcd2e803f3 #25 PREEMPT
> > Workqueue: even maple_dma_handler (events)
> > PC is at maple_send.part.0+0x102/0x1c8
> > PR is at maple_send.part.0+0x5c/0x1c8
> > PC  : 8c2aecee SP  : 8c85bef8 SR  : 40008000 TEA : 00400000
> > R0  : 0000002c R1  : 003fffc4 R2  : 00400004 R3  : 8c4e3d18
> > R4  : 8c92c024 R5  : 8c4e3d18 R6  : 0000002b R7  : 8c92c030
> > R8  : 00000000 R9  : 8c4e3d18 R10 : 00000016 R11 : 8c6aacdc
> > R12 : 00000007 R13 : 8c914c20 R14 : 8c92c030
> > MACH: 00000001 MACL: 000006cc GBR : 8c000000 PR  : 8c2aec48
> > 
> > Call trace:
> >  [<8c030c50>] process_one_work+0x114/0x290
> >  [<8c00b6a0>] arch_local_irq_restore+0x0/0x24
> >  [<8c3dac3a>] schedule+0x22/0x108
> >  [<8c03144a>] worker_thread+0x27e/0x3bc
> >  [<8c030b3c>] process_one_work+0x0/0x290
> >  [<8c0379c2>] kthread+0xde/0x1c0
> >  [<8c0311cc>] worker_thread+0x0/0x3bc
> >  [<8c0374fc>] to_kthread+0x0/0x1c
> >  [<8c00b6a0>] arch_local_irq_restore+0x0/0x24
> >  [<8c00f200>] ret_from_kernel_thread+0xc/0x14
> >  [<8c00b698>] arch_local_save_flags+0x0/0x8
> >  [<8c0418b0>] schedule_tail+0x0/0x78
> >  [<8c0378e4>] kthread+0x0/0x1c0
> > 
> > Process: kworker/0:1 (pid: 11, stack limit = (ptrval))
> > Stack: (0x8c85bef8 to 0x8c85c000)
> > Bee0:                                                       8c030c50
> > 8c00b6a0
> > Bf00: 8c80817c 8c808105 8c8462c0 8c808100 8c4e3d38 8c846280 00000000
> > 48f0d9a1
> > Bf20: 8c3dac3a 8c85bf40 8c846280 00000000 8c03144a 8c8462c0 8c846280
> > 8c4ca36c
> > Bf40: 8c8462a8 8c4da400 8c4ca388 8c030b3c 8c857ebc 8c80797c 8c0379c2
> > 8c846280
> > Bf60: 8c0311cc 8c0374fc 8c857ebc 8c00b6a0 8c807960 8c805b40 00000000
> > 8c85bf98
> > Bf80: 48f0d9a1 8c00f200 8c839f08 8c4dbbd8 8c493688 8c82c77c 8c00b698
> > 00000000
> > Bfa0: 8c0418b0 00000000 00000000 00000000 00000000 8c805b40 8c0378e4
> > 00000000
> > Bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 00000000
> > Bfe0: 00000000 00000000 00000000 40008000 00000000 00000000 00000000
> > 00000000
> > ---[ end trace 0000000000000000 ]---
> 
> This means we can't apply this series without the maple fix, and as such
> I'll recommend that this waits until hotplug is fixed.
> 
> PS. I don't know if it's down to the same issue, but once I remove and
> re-attach a VMU, it cannot be read from anymore:
> > Dreamcast_visual_memory 0:01.E: VMU at (0, 1) is busy
> 
> PS. Adding Paul in the CC, he might be interested to test in the future.

Hi Artur, thanks for testing!

I am not sure if the errors you see are related to the changes. The
fixes only make the VMU code compile at all. Without that, the build
fails and it crashes instantly.

So I would say, it is an improvement to the status quo.

Regards,
Florian
