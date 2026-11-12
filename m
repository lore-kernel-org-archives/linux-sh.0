Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511021;
	b=rJoJwwLXwxU3fvCz38Na/gnZrBSzuBc287ICujcXyg0KBZ4HD1FB7uTWshxobsfijyIb
	 h6eWMbxz4KCis6LZnW1O5kV/ku9dldzm6GxP50crirFQ25qou/BGbKg8T2zR4ZeElNaMn
	 PNR4n3XKlpGRm6yFUSrhLjeyRcHUcbsF8lJhwXqwrQ/EGYt1GNUS/b0E/q+5kv4eEXHql
	 Spqks/W6w1iE2CbafpS4DkPYb1O7ONF/WFETW4TIcSg2tlk6+jkstDAVlWVBVFXcwHP77
	 6hYA8ImYOGk7o4YYpZY+tkQhVKbjSRARcDTQTnaSogRnof4GXqkEfuEF16pvvdT/Dpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511021;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
	b=zLSCNkP/augtThJ42eecq+wuxur0W69hfIrfzcl1xqK+H9IYMe/kPHodwP6ZyCN6d5sK
	 RjfsNki7iDk25xxuV1i42I4o4EdoPOPdngvdueUG5SVq4v+PvEfCI3eNNQmcmD7FH3I5e
	 xYQDsTwcWpBaHtNYT7EgXWsw7kBg/qiXnbvWNST58htWs4Mdd3d9HrSbdAzam6ZTicI6x
	 BAv/neTf7ACGSnJuQN4eXWpEyMFs2ozyee6sCZKCJZWFwB2s4EmvImttwt4b7RMbfVKw2
	 Yhzt/PV1c8guivgQeYXXDJwGUlQ4l2o5nDvkrBJUSnVoza8St5hwGM70CQDKVefwEXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D336606A888
	for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 19:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D336606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso141938a12.1
        for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 11:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511020; x=1795115820;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
        b=l1vXOf4rMP6SrrFosN/NzQHtTJsVfTbWkytXGX8opnI3fkEvNRAK0KFMgHvlK1BwDe
         UxUKw8U+4Buh2YrFwj+4JSxtO3lm6F/DhFqBnmfqJiCRLIsTjVXE0r7ZYwUV5GjICFdC
         bTunl+rIRfAoB72TMG8+nWZmXi8iiRG2tjA+UxWvomDuAEtt7wRNqmVubmo8RDgSPMSM
         X23lIA50JULlve3en6Y9NvSH54tGHNLjNhbY562thJL0YGuy+ooAKjEpFYw/WLp36RQC
         frzb6W0bJiYdG9swIKYKdsj5sDYMYSfQp/SQJCqbDSbUiLwJjVqLIDuDwpkBvqTP3JEq
         SSOA==
X-Forwarded-Encrypted: i=1; AL+hErFQfgGipkXTZcwfqaoDOp+ADA1NfKIsVZo7oNcVgC4jsSzhTz0K19bbB2I7aP7pSniT4K+Xr4UMmA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Yptb4RoKfboJS1a7v/xpE644XMEm7I674+Quf1M/FbLbKZgel
	+7FMuG7XfmlO2DV1VnHwX8sUz1pBXvBfzV3zDGJnSZQ89JzX32bCN8DP4iFRBJnQt0Q=
X-Gm-Gg: AYBFou2HGFqzxDKtKv7m7N5Cs2SjKiXyv3V0bmNr6sAGV37UoS/mArkTq+fGcAgXNue
	51C9s4nj5NFkylVX/vix9yqW/ITY/Y3/6wKBVS2ideimVW2IhD2v+8nofaJsxgcd+S4hw9Ltdqt
	gEjJ5DODh0I5BgLimNFbPdpV4aBlIziKpkaW1UFMgmtox/8/LhHkYc7rw4RCG2xWAFDqK0lD7F4
	N1pYNzgKqm6OpNAN/omz1cEPx6zVfWAe+NeyeLeclKfFFW3PHENu/hCzqkrZ49pLhrT2GOJNglm
	cODH+uqAlG8ErjzR0ree3LlAhx6bo+Ax/GyMO4x61b66glzuemxMhm4K2N6HX0LhnupiOXcuHsn
	DrmgC/9N+0x2yXCg3D80aneqjNd0j8zlHe6Q9jMzKEN9jsQyw/uiJx6DECO4cONXDqjG7me7ca5
	TseNtYjD+TXt8d92ThDW0qH1Cs7jl0o/TRJc5pc3ikSa2OEotllYeQYvldUqWzTB6UVFPeBbbxI
	25vUFcsVOAR64ZvTTo4wXqMl9+nMe3q3cW7J+kqW+jj5jte1qL0k1d3Iu09u92ipRef6Qerhkx8
	uZEuKCpW9wr9YrpgLeoNL4vQRG1l5rFGyLQh1NGeygeZBI+FRtB4HC1qU2vHqBr8pZe4vQ==
X-Received: by 2002:a05:6a21:498e:b0:3dd:85aa:452e with SMTP id adf61e73a8af0-3f7a7ccd22fmr128756637.32.1794511020211;
        Thu, 12 Nov 2026 11:17:00 -0800 (PST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com. [74.125.82.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2053d26sm62796b3a.36.2026.11.12.11.16.59
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:16:59 -0800 (PST)
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3282db206d3so72486eec.0
        for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 11:16:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHwYNXIiSfwP7mf6ovPNs+bu0qH6nvVpLdA7deiw3sJ9pl2ozHUoXSdYeX/aigtLbLdGYI/qYNG3g==@vger.kernel.org
X-Received: by 2002:a05:6102:5ccb:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d64db29605mr42432137.36.1794510618289; Thu, 12 Nov 2026
 11:10:18 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:10:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
X-Gm-Features: AclHuK-k7G9fpVKu6BhCbcWfXavvnldoQZhCl9e2eioRf49lg5T7xpzAfc2z5gM
Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 17:39, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without checking
> whether the mapping worked. If it didn't, the copy reads from an offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
