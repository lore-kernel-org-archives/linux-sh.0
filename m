Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21F7868C
	for <linux-sh@vger.kernel.org>; Fri, 16 Feb 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085880; cv=none; b=RvBSB9nAVzl4TGgSbincM77xaleE6XfsZTozN+KVWEha3oTx2KwTro6EWa3/UakljyLwNF0SJV0ZAc+XODkBeIL733YfFmR90lGQbYkZThgG06HK/S13Zq72V0DZfVUpzcLgEWDk9qqSDN10Rsp0rhnK6xd5mllEJstuQK6uYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085880; c=relaxed/simple;
	bh=NvuKKeKVdgYcUFn0+eZsd6GEWeUFAQkeL+9LQtnzlU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhe0Ac7El0lNoUFxJ3Q1jpabFb67yoQ8VIYA7ZCuDL4jusgq4ddu5BP2z7FRYr3NCffrno9Tqtd273b3myUAnnIWesK4Eq+jWyY9I8LZhklFT6JBefOnhiALZAXZP4PfJaGSN3hvR/XXHYII56MWqzH0vHV3QGELO9fvvd6FU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=bl25e+OD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="bl25e+OD"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2de202d9aso727671a34.0
        for <linux-sh@vger.kernel.org>; Fri, 16 Feb 2024 04:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1708085878; x=1708690678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXxLHIQnXIA5qnxPoCMUjtbPVmRBO3dP7QzVREvGIW4=;
        b=bl25e+ODgFaJf1SiwQNV0Dp+ULDjKUzRB6Hrv00w51urtcRhkZ6OQlKIX8ZViJhpZ9
         FKN8sMdmFF42A4BqN9hjcuTSJCo10x+3BCvxNSjDu1oI83YHIZDq4+E+IgkrkH7wate3
         UccKl8Y1v9mfUYhehyTVxl4kT8Io96Bnz46cqcskGxieoYS1xSrj8UOIk+GjBq1HfNyB
         qybHet15knjqYYv2ckaSZ9TJC5Ao2wp9FBIJJG9U4CjpXPdiHWhWRMkp2pIoD0jHC11y
         nZMDJV9bIUJPFWgNBWQdFTwkREMOtmWm1+0ukmFgoQDO8OyMxnbfZ9hTGsE9LXht6vd4
         beyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708085878; x=1708690678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXxLHIQnXIA5qnxPoCMUjtbPVmRBO3dP7QzVREvGIW4=;
        b=JOGZcMkcxJwXrRUB4Chhu20ZeTN4R9eGV9EChZ2tAuWGLkjc6mKcmg/n5ZDb1TrG6R
         CUImnKwrsCcikpSNEFWq9MTRrI9u6mehbjb4pKi+PoRz26BNrmu0FuV6zQYDGC+4M6TM
         wEgugbHMtftQ1FZwcE5p2tN82VKTzconxVCq8iozJjeXXbauyLOsPOA3FFXytBBcGF5y
         4+CrwfR+N75wkIPk+NjSev9I2yeibvE3RCpeoVuzEmiLd8OeYOjCCLePdhd1Qw79oGgM
         /aIK/SGfXUEb83DfqlJtzHlXJ7jPUGWTAu43w+q3M9KD/NJT5c01rJj7cEmD/4qZ/P+E
         Mxbw==
X-Gm-Message-State: AOJu0Ywl92cHjz9VWKKDP/LRYG7rWVwcIGMdhCWocIAVJyUVwKaeaMB4
	djpHOxLwuEPzMp+Vk1xfVabnM0OMjcMBmfRtyFNqsuZY2yT33jegkuPpo1HYdx9g/Jrw6i+X7//
	svO4=
X-Google-Smtp-Source: AGHT+IFLcjMFF+pBwek4PErIKA3wi7vGqpzD8lmZCW4tYcvATeB7kIrlvIwqzKz0Djbb0JCP75jbeQ==
X-Received: by 2002:a9d:774d:0:b0:6e2:e955:c718 with SMTP id t13-20020a9d774d000000b006e2e955c718mr4545563otl.1.1708085878000;
        Fri, 16 Feb 2024 04:17:58 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id w12-20020a056830144c00b006e2f7ddf4eesm531690otp.28.2024.02.16.04.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 04:17:57 -0800 (PST)
Message-ID: <08431a7c-322e-596c-ff46-6b7e0578646d@landley.net>
Date: Fri, 16 Feb 2024 06:25:44 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [musl] FDPIC on sh4?
Content-Language: en-US
To: Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, musl <musl@lists.openwall.com>
References: <2d8878fa-c990-e187-9040-934cce908e7c@landley.net>
 <20240215134941.GE4163@brightrain.aerifal.cx>
 <CAMuHMdVczQMiyDkhgAd4G6Zrmw7-pBYMnDvVn18vxd-3CSsSaA@mail.gmail.com>
 <20240215164723.GG4163@brightrain.aerifal.cx>
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240215164723.GG4163@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/15/24 10:47, Rich Felker wrote:
> On Thu, Feb 15, 2024 at 03:53:53PM +0100, Geert Uytterhoeven wrote:
>> Hi Rich,
>> 
>> On Thu, Feb 15, 2024 at 2:49 PM Rich Felker <dalias@libc.org> wrote:
>> > On Thu, Feb 15, 2024 at 04:31:00AM -0600, Rob Landley wrote:
>> > > Is there any easy way to build FDPIC support for sh4 with-mmu? In theory ARM can
>> >
>> > On the userspace toolchain and musl side, yes, I see no reason you
>> > shouldn't be able to build musl for sh4 with fdpic ABI or build a
>> > toolchain for sh4 that defaults to fdpic and has fdpic target-libs. I
>> > just tested passing -mfdpic to sh4-linux-musl-gcc and it seems to
>> > produce correct fdpic code.
>> >
>> > On the kernel side, I'm not sure, but the normal ELF loader should be
>> > able to load fdpic binaries on a system with mmu. It will not float
>> > the data segment separately from text, but doesn't need to because it
>> > has an mmu. If this is no longer working it's a kernel regression;
>> > that's how I always tested sh2eb fdpic binaries on qemu-system-sh4eb.
>> >
>> > > do it, so I tried editing the kconfig BINFMT_ELF_FDPIC dependencies in
>> > > fs/Kconfig.binfmt to move "SUPERH" out of the !MMU list and put it next to ARM,
>> > > switched on the FDPIC loader, and the build broke with:
>> > >
>> > > fs/binfmt_elf_fdpic.o: in function `load_elf_fdpic_binary':
>> > > binfmt_elf_fdpic.c:(.text+0x1b44): undefined reference to
>> > > `elf_fdpic_arch_lay_out_mm'
>> >
>> > It looks like there's an arch-provided function that's conditional on
>> > !MMU in arch/sh but that, now that fdpic loader is intended to be
>> > supported on mmu-ful systems, should be changed to be conditional on
>> > fdpic support (or maybe even unconditional if fdpic can be loaded as a
>> > module). Just look for where it's defined in arch/sh. If it's in a
>> > nommu-specific file it might need to be moved somewhere more
>> > appropriate, or an mmu-ful variant may need to be written and placed
>> > somewhere more appropriate.
>> 
>> ARM is the sole architecture that provides elf_fdpic_arch_lay_out_mm().
> 
> Ah, I missed that this was a new mmu-ful only function. So I guess
> something like the ARM one is needed. I'm not clear why this is
> expected to be arch-specific, so it would probably be nice for the
> kernel to provide a generic version that archs can use unless they
> need specific behaviors here, or just make it conditional whether it's
> called at all (only if the arch declares its presence) and use
> defaults otherwise.

It's in arch/arm/kernel/elf.c, and pretty short. Doesn't LOOK
architecture-specific, although I'm not an expert. (Why SZ_16M instead of
RLIM_STACK? No idea...)

#if defined(CONFIG_MMU) && defined(CONFIG_BINFMT_ELF_FDPIC)

void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
                               struct elf_fdpic_params *interp_params,
                               unsigned long *start_stack,
                               unsigned long *start_brk)
{
        elf_set_personality(&exec_params->hdr);

        exec_params->load_addr = 0x8000;
        interp_params->load_addr = ELF_ET_DYN_BASE;
        *start_stack = TASK_SIZE - SZ_16M;

        if ((exec_params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) ==
ELF_FDPIC_FLAG_INDEPENDENT) {
                exec_params->flags &= ~ELF_FDPIC_FLAG_ARRANGEMENT;
                exec_params->flags |= ELF_FDPIC_FLAG_CONSTDISP;
        }
}

#endif

Oddly, it's NOT in arch/arm64. Does the 64 bit arch pull in bits of the 32 bit
one, or is this only supported for 32 bit arm?

Rob
