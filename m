Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5639447C
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326447; cv=none; b=uel8Ii2f+JSXSf4yGSbM3z1aEZk69exOOoMZkVIJQpxEzfuynLlh8GJWl1YhE3Y0qLKliYIyefWr7fH4fdWaAwPSx2dMXQUftWWue8sji0pfLecAIwAUep4Gc/kKpOxplI0uoo/ZL2AZQlD5Ei/3/SxiUSW0mn5ayKi4o7b5+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326447; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5puet0AlQUkx29lQZ966MY6XwC4BDuwCXOecgaibc+dftU+mMZdFZ+mZFmk6v6GtXTzBYxC2YRRmb1r46qX8v+qdzdiVv0fTiUyrS9JrDMwgn1x/4NPzBCmad7HnTwOxTAweetJ92deAfy4OI1o+bkuZGTlh3R+6SiatN/ate8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QzG4xnmw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QzG4xnmw"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so6521386a12.0
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326445; x=1777931245; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=QzG4xnmwcN3HoxHNlgHvUqs5CoC7tNJmN45XymPrkmoT8Ic/Mjeg7/auZVke69+1i8
         a5FnS33WFTG6H1yD0eg+y1I/wCbfNQyX+AlePnbDvN9DJHVxwu8WxN5FMr/1d4iq69GU
         6bKkCQ4oasKV/42HP9/iB6N9Uwo0sh/OtBFtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326445; x=1777931245;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=BBtqibOdYJUWNTMLG0xLWXYQ/IJfEBmLAzFJC9NdrRGOHoBH/FDf/ueCiBdCVkgJDG
         wGN2FRUlmgIwLfiyHFUiO8AzXTXWsJ2LWpNH/tynE3lucHvnAGxSR/WxV8d3ZWdyKz4E
         qw3ohKEYHBYj9S2nDig7esvQL0UqkXnQHazg7uboty7DLLVm+NFDHhlvN+5bboHAbvXx
         ZoGz/R2hCHRZA7DAEdNLSVxqDGqnF3KJIyC7gTpsK3qQdrYYAarccICRFHBiBa9Pcy8A
         uqXquUPLKPxx31Cln+Q0u0EMS5QRVfWpFY9+mFTeSxd0/vOE+G9MeLDZH/DxSSE+5r4O
         Yt4g==
X-Forwarded-Encrypted: i=1; AFNElJ98/KqKUV/B2KALVh1XBWB8jrnQUQyeBQWBfgGJN4MKvys+B6NZv63T/3oJqdc1RK9NgW46VDHgsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymv50ja7kzL3M9NXOIVOlWeOUXeJ14FJFGhHupRNHHN8NIv6kr
	+TLtXjQG39OY8wnIAEm+jcl0s8qWz+n1BsA1t9Hwy1epBbSfgqPol5iA1zzEoohQpZM8u9wApmF
	IZJTTVogX1A==
X-Gm-Gg: AeBDieuhv6I5HLaUluDSJZO5m2mgsa+9Rapo4Xs8K5baztsmdR68NcFk0g6G2RkN6ht
	hrdGhfb/2YT20rNCyampRa7UbydfcaOFz98gc8YE8wN5GWzNadxA5qbm66kAVfoaLy/8cF/HAkY
	vzCcC3PLrdvlCMK6QhujrkJ4GCCxDZZNJa6WlOpAtlZUq5N/UCyoF2Cc1OrVN/Y+ndNIWZ1tTo0
	tZwM//6RCP5X+201+pVqYVmqjf7h7fUT4SWJwSqNfwtImQjtVHYybJSTGr4AV6qeYq4UR3LxDQw
	Aot0E7XA5hu7ymu9uurtvVpWiSQVHvgOhAJgLEJqe8/Ldl3TmDo2GoTmB4z9CHfHXkWXSRaJyr9
	QCpZHf+BwxXKMQK8k5K2x70FnRdDB1n/holor30tPYkXVhq1EtyKp9sfVEyIP4Vffk2kMyRvAnu
	8p3HZmdGeFWTD2KeYZ8zPAhTzss46HwIuVpVQdO9BWy8CpyTn1V38KAAZbBLD7zwljZA8PFbxxX
	BqoI7wgKCI=
X-Received: by 2002:a05:6402:3593:b0:670:8bc2:7fc with SMTP id 4fb4d7f45d1cf-679bb04c0c0mr172723a12.2.1777326444841;
        Mon, 27 Apr 2026 14:47:24 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67d5c1csm158277a12.8.2026.04.27.14.47.24
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:47:24 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c01854477so696832266b.0
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 14:47:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8ewNHdTIqvJQ42dx4zXlX5eGqe3vsbVEaAIdD6cp7wkKd8fBPPML3HmA8zZnZEiCC6xjYGhGP/wA==@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
