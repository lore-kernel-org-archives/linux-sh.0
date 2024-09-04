Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E9145344
	for <linux-sh@vger.kernel.org>; Wed,  4 Sep 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476839; cv=none; b=EUYFqGUwoJ6S12CdUpAEaskPeY/DFoEhbqbijH1iuHr75h9+tuIJF9lG93aHvY6AyX+yn3r0ubnxxSfvLHbMFMRjwLnFbE2KzpLcL/Tk0M2YtdZOwuT5lgdzVhOaotqH6n5zDrMKfRl1kZgbBeRv6H5o7MeVRjh278+HxA5y4KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476839; c=relaxed/simple;
	bh=hLtrV9fo2ENFsppI3EM5//2a1v6xLdR6UciGmLp3E0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAjn+6z914rrce6MLO3Xq+T91w5t54fccLBHV/Y5CAD/A9KBTQAe2vnZoYb695i1PSfFF4Rdvh3MoBUsqRU5skF+Hz9ueb2FIk9GQVFn+HgDqB4lxAd+t+5Urj/245FUqNurrc0HxWPRTth71EBoonpIlVsQ1h0WNgZnTidXlu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O83/Gbf8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O83/Gbf8"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so1524a12.0
        for <linux-sh@vger.kernel.org>; Wed, 04 Sep 2024 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725476837; x=1726081637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2U7wgEbLS4i4a8ingcWCBDQrhNmwXrz+ffgx64j+qE=;
        b=O83/Gbf8QHytDjtKBC2VP1NHGE69K97QzsnnPLhood4y27NcYWvbRpAYJZHt9lWN5L
         piIbJArzYN5Qf7SPBI49vUE2VjW4GYvYSSeWevifsRIo2JwxWESaOWjUw9KNQUlcAOjW
         M57C0o6ln8DywnEEETUAFokbAoSyohPtRCDiZcplIwBMyuz2tior5wk9DBWcDqSCynVu
         jAvaHC4YqJY0ofPBytPoIllLrn/HiP7br0fsxdsL6Iq9qfvJZ6jQmTfrZAaTKNkj8iqz
         t2z+vruq/jHHUU7ujoGLdO82BtEDxwSzFDLuOmaaNt8DQwT2aKkt8z2EJBcsRPlrEHcB
         kXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725476837; x=1726081637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2U7wgEbLS4i4a8ingcWCBDQrhNmwXrz+ffgx64j+qE=;
        b=rraVTKJyo6Uner+TV4w9Vk11ZlALGVmxz2bYE1cP3ZnzNDpPpkGpscH0TGTLyx1uJq
         ehTEqAzWxwOSxjcjYn8NuRzfD8Ojg//1P/AzC620ZdgLJz0ahhpUjCP7hJ3TxjWFlFjM
         ropX22Du+TtPgUCsb+n/DcVBP679h8m0uTnKsTapeaUw3HEu3NIE3d8WK2mBKodCa2s9
         yeazjnMuQACKjIZQio1Plcd1T13UpDp+xJXQlKfK458uTaU4EEBF29xpIp0qgvBrhsaI
         IT/mXHuXSJQqsVh6ioJKKalDkgOk8+gAmssGPmmK3TUDo16l53ysDphnUQ62z1Mbtj87
         1ipA==
X-Forwarded-Encrypted: i=1; AJvYcCUzvxZu22PaE+RFE04mPWcRiBrFBrpe7K/o958fmab7NU1LkOQnJMeI0kJ5/AxwD2weL5bu5CYw8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6C4YZblRBRiDXz8oZrfSpGwu1bPrLztoffD7AECVeElyo0eD
	4LY7/cm6/GlM/GzWvhZ1sZuxmGGE3B0NRdKQx2BHHjaHxyMURTMv/WQB0OxBrTs=
X-Google-Smtp-Source: AGHT+IGRXMFw8eODDeHuSZGixob1QmbWy894YR3dac/q8kTYt2afjYPzXJiDq5qdDnRm4AHLgT4d4Q==
X-Received: by 2002:a17:90b:300e:b0:2d8:27c3:87d7 with SMTP id 98e67ed59e1d1-2d893284ebdmr13545892a91.8.1725476836620;
        Wed, 04 Sep 2024 12:07:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da53740084sm4858056a91.32.2024.09.04.12.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:07:16 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:07:12 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-mm@kvack.org, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 3/3] mm: Care about shadow stack guard gap when getting
 an unmapped area
Message-ID: <Ztiv4NtsIkKnyiLO@debug.ba.rivosinc.com>
References: <20240902-mm-generic-shadow-stack-guard-v1-0-9acda38b3dd3@kernel.org>
 <20240902-mm-generic-shadow-stack-guard-v1-3-9acda38b3dd3@kernel.org>
 <is6ewj3bhtqy3zadj6lbdv6maupx4kmduvhny66ntifkji6hoj@xmhcf5jt4o66>
 <dbaf5653-df46-4e17-bce1-aec7fb168197@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dbaf5653-df46-4e17-bce1-aec7fb168197@sirena.org.uk>

On Tue, Sep 03, 2024 at 08:57:20PM +0100, Mark Brown wrote:
>On Tue, Sep 03, 2024 at 03:41:49PM -0400, Liam R. Howlett wrote:
>> * Mark Brown <broonie@kernel.org> [240902 15:09]:
>
>> > +static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
>> > +{
>> > +	if (vm_flags & VM_SHADOW_STACK)
>> > +		return PAGE_SIZE;
>
>> Is PAGE_SIZE is enough?
>
>It's what x86 currently uses so it'll be no worse off if it gets moved
>to the generic code (there's a comment in the arch code explaing what's
>needed there) and it's enough for arm64, we only do single record
>pushes/pops or (optionally) writes to unconstrained addresses.

It's enough for RISC-V too.

