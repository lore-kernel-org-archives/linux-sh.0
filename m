Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C42E22BF
	for <linux-sh@vger.kernel.org>; Thu, 20 Nov 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628820; cv=none; b=NIwiB/cV/ZbSZLfCkP0m8hFR/vDoG0FXtRn+L+FDtlwHZGT2F7vzYJqg+Zgx6EyDaikuXrebqPfe6ynOpjIjpXfySuUpp931TtfVlj9oUUi9SBZcXwRURGoxQyYnp61fVFgOZyU8iCdfznt/FoMX9y9SnT+/PkhWx0CSfuk0ipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628820; c=relaxed/simple;
	bh=HcQka7iNW7U8N3uml7gUEawvdUD0OSAV9tCECew5mEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnGZEHu67YgbTpoIckurvVvadyIHIJvljoNnfxJ2Yi+72oDOzwVdxSj4KmxGEDlx3nk6aKO05+/nRd6P1ibvoBj4fnllMOv5nhHWfchfL9CvOTSk52H+VcL/ifSslH4yEQJQVz+e+uxGxPIkSLNPSDWxE1WtUdd0XIZkIg3YZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEhUNYPD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEhUNYPD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b739b3fc2a0so93544066b.3
        for <linux-sh@vger.kernel.org>; Thu, 20 Nov 2025 00:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763628817; x=1764233617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBzoWjm+zGLqmCIyzB0TyxHbnJM1rzuj4emFBqer5s=;
        b=BEhUNYPDFf5rBLr0EQ1Gi7W7DQyEul17jYgEoVU1Fqxp8OZgytxvseT1F9LJc8lQqy
         0Dh9JA5HKQCt34yUMISywiQxmWwoNdr/JvnAbSQk2X6fsUGT1EZTeg+ykRWBXIY9JDKq
         f4QG5F+La1hafxrllcPrWg+yLxe54EpuHsCHFCt39zu87rDub7rhVde5vnaNEwZ43Wtt
         erLUObrTPpIH3HHzAUGa3vb8LRG8K6uIe1AK/x9FEGlfZ+FeHiDqBMIjSPcS1jzZK8a5
         8zjyszgCmqz8Hmr329FftGdg0lzLyWTM+bOlO0cEJtc2orLJycTO8nTwdOYss3x5waW1
         xfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763628817; x=1764233617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdBzoWjm+zGLqmCIyzB0TyxHbnJM1rzuj4emFBqer5s=;
        b=pUc72tUmddiisilwVQg3iFpWB5lJbLhCp96ezaJl3ilM7Z0rU965pKVdIWhcRymvW2
         YMVYIKcRJvtSxR17EPzSmHZwitFP2vqVV8RlXHuY8GIUhlt7Eo874f++0qos28ReZ6kV
         0u/6a/+4mNQkQToL9IEqhB/H+JTTOe+bMi+aqyXR04rvN7jTI0NicFUqDfbuldue5rmE
         gmCcz+J/bTMlHGij59D2zSDQQhqXdYpx0BRDAPksAgVcATlASxDDC4TQkHM9BLnYB+/x
         Ac/+ELDKRS3/jX+84MOkmD15wCKHu+2D+F5FrQEHdcoiWK8BdMwcCc5UYPltcOZCzimf
         PbVg==
X-Forwarded-Encrypted: i=1; AJvYcCXZafQzPXdoBnuhGHEtvHIAPjlUeWZgZo8t2E+ecxoN/oZJSOTlb7LHvj/HERAd4mXJ8+ZJSXNBOg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MErq50bAb/eTCRVCcO6CslBC3vQ8RVBmND1d3NI2iUIKGO8z
	NXzVJ2OQexk5oDjnLnqdJA59TLp21EcMC0YndSB4BIX4kCh+pT2dHYE=
X-Gm-Gg: ASbGncu4Ot0ZdyIviF2MtSJruOiDvg9HSY1eVBd+JLbCEd6CvQkM53RBrDz4ztB4JTJ
	lxXWLUXZoveI0M+FyukfWZFx8DP7lWdXJrqFLQQ0GrInzWMKBh95jGq9dX+BcQ8BbysXDQvD8OT
	LQ+/qf/NnT0klUObK5v7+D7lye2sqjyYZ9dkNMEQJkYgo1gIvluo9glavGk4bobgJl3jlS3kibt
	z0iS9LAcLuC1xDbv7YIJ8a8dtin8yHLzWTfBRGyR9vy3FoGZfHF8+aaCOrbBxt4RPgl9zhUcu1H
	xF9sDfVTzkKlqtvBvC3KcV+CHcECVeMEAiCBRAJ7Nl239C88Ia4bOeoOH+3qm0CyTPaKS6bEsIP
	QBAN3aLKQrDtetRPBAG9iwBkzsRckDgX8N7VAs3Jz8atJVjz38cgudBrgMPn7QVSDkC76BctpYk
	pIc9lwYCibsHIAUhzbWWxWj4BAON2wZQv4qhou05V2kP6UHk8HoBKOMdbDLTyJjtLQOWcgjQ==
X-Google-Smtp-Source: AGHT+IFdpoKkkCSoqkR4/Q0CyFwn/CTYQnETlnTGU7Rvx6EXWH50VzH6hwAt2lrUZ4W/98HyhMhiGg==
X-Received: by 2002:a17:907:7f1f:b0:b73:819f:f13f with SMTP id a640c23a62f3a-b7654d8accfmr193646166b.8.1763628816664;
        Thu, 20 Nov 2025 00:53:36 -0800 (PST)
Received: from lithos ([95.91.233.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4f14sm154117766b.35.2025.11.20.00.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:53:36 -0800 (PST)
Date: Thu, 20 Nov 2025 09:52:15 +0100
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
Message-ID: <aR7Wvxzy0aiosDYK@lithos>
References: <20251117224408.498449-1-fuchsfl@gmail.com>
 <6e2e9edcd9247c216bfe1ba637629a9a838f9fed.camel@physik.fu-berlin.de>
 <5a4f8f1d543ef90aae3299b0f8803fb3@artur-rojek.eu>
 <aR46Kw5n4hIAZCcn@lithos>
 <b5aa220dee9d7dcecea398ec0e33b4cf@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5aa220dee9d7dcecea398ec0e33b4cf@artur-rojek.eu>

On 19 Nov 22:54, Artur Rojek wrote:
> On 2025-11-19 22:44, Florian Fuchs wrote:
> > On 19 Nov 22:36, Artur Rojek wrote:
> > > On 2025-11-18 08:31, John Paul Adrian Glaubitz wrote:
> > > > Hi Florian,
> > > >
> > > > On Mon, 2025-11-17 at 23:44 +0100, Florian Fuchs wrote:
> > > > > This small series fixes build and runtime errors in the vmu-flash
> > > > > driver
> > > > > (enabled by CONFIG_MTD_VMU) and the included maple.h. These changes
> > > > > were
> > > > > verified on real Dreamcast hardware with a physical VMU. The VMU can
> > > > > now
> > > > > be successfully probed, read and written with MTD tools like
> > > > > mtd_info and
> > > > > mtd_debug. Previously, the driver failed to build or crashed during
> > > > > probing.
> > > > >
> > > > > 	bash-5.3# mtdinfo /dev/mtd0
> > > > > 	mtd0
> > > > > 	Name:                           vmu2.1.0
> > > > > 	Type:                           mlc-nand
> > > > > 	Eraseblock size:                512 bytes
> > > > > 	Amount of eraseblocks:          256 (131072 bytes, 128.0 KiB)
> > > > > 	Minimum input/output unit size: 512 bytes
> > > > > 	Sub-page size:                  512 bytes
> > > > > 	Character device major/minor:   90:0
> > > > > 	Bad blocks are allowed:         true
> > > > > 	Device is writable:             true
> > > >
> > > > Thanks again for this series. Before this can be picked up, I would like
> > > > again
> > > > Artur Rojek to test it on his Dreamcast, so let's loop him in.
> > > >
> > > > If he confirms the functionality, I'll pick it up. I'll try to get it
> > > > reviewed
> > > > later this week.
> > > >
> > > > Adrian
> > > 
> > > Hi Florian,
> > > thanks for this series!
> > > 
> > > Without the maple port fix, this works as intended only when all
> > > four maple ports are populated. I am able to read from multiple VMUs
> > > in
> > > various slots.
> > > 
> > > However, with even one port not populated, it causes a panic:
> > > > Maple (null): detected Dreamcast Controller: function 0x1: at (0, 0)
> > > > Maple (null): no driver found
> > > > Maple (null): detected Dreamcast Controller: function 0x1: at (1, 0)
> > > > Maple (null): no driver found
> > > > Maple (null): detected Visual Memory: function 0xE: at (0, 1)
> > > > Maple (null): no driver found
> > > > BUG: unable to handle kernel paging request at 00400000
> > > > PC: [<8c2aecee>] maple_send.part.0+0x102/0x1c8
> > > > Pgd = (ptrval)
> > > > [00400000] *pgd=00000000
> > > > Oops: 0000 [#1]
> > > > Modules linked in:
> > > >
> > > > CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted
> > > > 6.18.0-rc5-next-20251114-00003-gb6bcd2e803f3 #25 PREEMPT
> > > > Workqueue: even maple_dma_handler (events)
> > > > PC is at maple_send.part.0+0x102/0x1c8
> > > > PR is at maple_send.part.0+0x5c/0x1c8
> > > > PC  : 8c2aecee SP  : 8c85bef8 SR  : 40008000 TEA : 00400000
> > > > R0  : 0000002c R1  : 003fffc4 R2  : 00400004 R3  : 8c4e3d18
> > > > R4  : 8c92c024 R5  : 8c4e3d18 R6  : 0000002b R7  : 8c92c030
> > > > R8  : 00000000 R9  : 8c4e3d18 R10 : 00000016 R11 : 8c6aacdc
> > > > R12 : 00000007 R13 : 8c914c20 R14 : 8c92c030
> > > > MACH: 00000001 MACL: 000006cc GBR : 8c000000 PR  : 8c2aec48
> > > >
> > > > Call trace:
> > > >  [<8c030c50>] process_one_work+0x114/0x290
> > > >  [<8c00b6a0>] arch_local_irq_restore+0x0/0x24
> > > >  [<8c3dac3a>] schedule+0x22/0x108
> > > >  [<8c03144a>] worker_thread+0x27e/0x3bc
> > > >  [<8c030b3c>] process_one_work+0x0/0x290
> > > >  [<8c0379c2>] kthread+0xde/0x1c0
> > > >  [<8c0311cc>] worker_thread+0x0/0x3bc
> > > >  [<8c0374fc>] to_kthread+0x0/0x1c
> > > >  [<8c00b6a0>] arch_local_irq_restore+0x0/0x24
> > > >  [<8c00f200>] ret_from_kernel_thread+0xc/0x14
> > > >  [<8c00b698>] arch_local_save_flags+0x0/0x8
> > > >  [<8c0418b0>] schedule_tail+0x0/0x78
> > > >  [<8c0378e4>] kthread+0x0/0x1c0
> > > >
> > > > Process: kworker/0:1 (pid: 11, stack limit = (ptrval))
> > > > Stack: (0x8c85bef8 to 0x8c85c000)
> > > > Bee0:                                                       8c030c50
> > > > 8c00b6a0
> > > > Bf00: 8c80817c 8c808105 8c8462c0 8c808100 8c4e3d38 8c846280 00000000
> > > > 48f0d9a1
> > > > Bf20: 8c3dac3a 8c85bf40 8c846280 00000000 8c03144a 8c8462c0 8c846280
> > > > 8c4ca36c
> > > > Bf40: 8c8462a8 8c4da400 8c4ca388 8c030b3c 8c857ebc 8c80797c 8c0379c2
> > > > 8c846280
> > > > Bf60: 8c0311cc 8c0374fc 8c857ebc 8c00b6a0 8c807960 8c805b40 00000000
> > > > 8c85bf98
> > > > Bf80: 48f0d9a1 8c00f200 8c839f08 8c4dbbd8 8c493688 8c82c77c 8c00b698
> > > > 00000000
> > > > Bfa0: 8c0418b0 00000000 00000000 00000000 00000000 8c805b40 8c0378e4
> > > > 00000000
> > > > Bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > > 00000000
> > > > Bfe0: 00000000 00000000 00000000 40008000 00000000 00000000 00000000
> > > > 00000000
> > > > ---[ end trace 0000000000000000 ]---
> > > 
> > > This means we can't apply this series without the maple fix, and as
> > > such
> > > I'll recommend that this waits until hotplug is fixed.
> > > 
> > > PS. I don't know if it's down to the same issue, but once I remove and
> > > re-attach a VMU, it cannot be read from anymore:
> > > > Dreamcast_visual_memory 0:01.E: VMU at (0, 1) is busy
> > > 
> > > PS. Adding Paul in the CC, he might be interested to test in the
> > > future.
> > 
> > Hi Artur, thanks for testing!
> > 
> > I am not sure if the errors you see are related to the changes. The
> > fixes only make the VMU code compile at all. Without that, the build
> > fails and it crashes instantly.
> > 
> > So I would say, it is an improvement to the status quo.
> 
> I wouldn't say that trading a compilation issue for a runtime crash is
> an improvement. It only shows that further works needs to be done before
> we can accept both the VMU and maple port fixes, and that both of them
> are connected.
> 
> That said, great work getting it this far. I am here if you need further
> debug. If you'd like, check out #linux-sh IRC channel on libera.chat,
> then we can brainstorm this further.
> 
> Cheers,
> Artur
> 
> > 
> > Regards,
> > Florian

I mean, I guess it's ok, as the code is like this for a long time, so it
should be alright, when it keeps like this for a few weeks now, until an
extensive fix. I just sent it now for a gradual improvement, in my
opinion, as I need to invest a bit more debugging for the maple
misbehaviour than for the obvious build breakage.

Thank you for your kind words, I don't take them for granted!
And I will certainly hang around in #linux-sh as I have a few other
things there to debug were I really need some additional input.

see you there,
Florian
