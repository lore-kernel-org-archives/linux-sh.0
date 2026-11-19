Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073754;
	b=MFlkdqFPqe+hTR2YK2cmBIrOiFGil4OO2LJJFvMpAX22ugvRLXXObUHddUAgGOrmNIA5
	 WooNjSSToGrgAPfGtSPkI7oj66FsEcYgmn4HNG/mzRt1H27ISQqYHDflDZfPGuGw4sX1u
	 6u6s/Ib04hKxtsEdzoMEpGjm+/7qWchRrs3+XwT6XkVVAr0WE1j8Wd1ySKBwNuY4cvlLa
	 tXvtlrkYfgzPzrZbZ0QtAKLMzm0M53GIGJ7IgR8IhkGZzcRJQQMKfBZbDZDKFcKoDvRUC
	 xbBxHikAW3Nt11puNtJ09vmQRPRO4qWA1eAE7yedhVMt3R/PDuqfxCirf33cpQa22xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073754;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=;
	b=RLwiYq0/LNwIdX+1tnpEEViW1Z2Mjg8o3TxiJc3YPhmD+JIC0dDhjFgXhUsLlVK1N8cW
	 kfMe7zcMpLr825bJVMxkKroRO5broHtXo2v6srDvTHRs+AcCamU1+4E9bsTVi2rTneyzV
	 ADzErNk1pbKxa47POmY+BHXsyPhhsKaMovKncVTMKOfNF9exmkkaXPaT9VahKRNLae8O7
	 1q1Eakzm8UPe9N2ifraPwJeu35W+s7HSC+UqO5n9kZd7nPiyAEuGMUN4b74D85+X6FWeb
	 T3j8935bi9UW87YnnTCXKrgsdm//JP8XND81BIeA3CtOUHjH+S5bLJXg6TF0jIRW8bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B383606A326
	for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2026 07:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B383606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-85c1135c286so1424848a34.1
        for <linux-sh@vger.kernel.org>; Wed, 18 Nov 2026 23:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795073753; x=1795678553;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Klcqtq67J8++CxJ47wWJ4KmRtmeIU5oN8tRyALYYbAY=;
        b=HCIfejrbWcJKUUO3NEBhraimzK1ALCSWwRqx0ImHLGVp9YLhOayetuSB/bd7GjN1tU
         m+AQwoK1PNtBl//+aJPaQ6UyFckwCH9Q1iLsGtvJqXt55a3U9kMV7bOPQ9bBD/LdPzus
         J8B7UuNjWukiHjN4GkduLtDXtp6NnRaynEE2EO0wdRc+wb3vDgCda5ALNY6+dQHnWLAe
         SsEnICx3ARYy4s/j5Dt97MSst8vrC8OrQvMqwfHMaCrEaRuZh6xIZWSlLTSN+9yhNTGF
         dIZ3vQkeOC7wzrUm0DpTpyGgnj8xSczxg/upS8KKw0Kbq3aP/qTnkyAPEhqEmZG6MIeL
         F2iA==
X-Forwarded-Encrypted: i=1; AL+hErF+W5V3ACcXOizUt4ypWh4iB6RnFlz76JBAMO7R0cm9uQHiNF4OLyyqfFn5DE7PRsHPE2ZDQqDT+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9w+/+/XgXhnYHEAJtayY134aG6x5yUFXabcPLlVS8PuFFQkRgd
	7Cejp9KctkYPZY3HbqdcVZR8C0KQvPCm589iOW8lRYaLfloQZI/4gwbCsdSqto4X
X-Gm-Gg: AYBFou2de14CdvfF+dr4NtJh8HgXS0W86JYjwBUBaejK1r8tO6kDdItMs8fT/vkPOQz
	8yzDPcJ/UOTVFnOY60ZpUU8ERAWYvhk3OvyFXuKDKH6QhuBo1QvPUSuCMJ+He8mwapO3p8LdlcO
	F+Fl47ura5DL3Xegigy0qJEbVWszsaIv8BvY/3jq3bY/6831Dow2WoRJv4UpLCN11GSuakK/akg
	/arXitpsHiwjZfBMEJFfYNuA3PtGZmz6NGJbmxZ40JxVJOygPf+Xh5imZ59rsvjkl4vpUczxbXs
	Uyt8sJoD9L8M6DdPO9tqjK6vJFOKu/nKmCCDGERF+V6v7JBIbexnmZcEfVRwCu0AkaoOOvv8iSi
	r+6TFV7qnmMJ9z5C8D3zZGMqheZQnEXtGixZXwTi2oo3T6d6SFHFBIxxpE/mavg6uCfDfGSagCU
	v2/yGh952qWVNKVXE1JPqKqLSsV+vwZCXCtaXXPvpoU0Q9IUrVXhYNTQ/ApOqFf+dmX0x5h/fN7
	C/QK40+pXjqj0wZktnJoMtki3S6RQ2cC8z8oZ+so14Is37+BJWXhudodkJz4GWFo80y3gueF684
	USi/QqOodyEMOuIalukfdVs4OmIhLeDlY6FIHQvKi6elN6EK9JFU7myfU/KaspTqwLE=
X-Received: by 2002:a05:6830:2b28:b0:862:a48e:24dd with SMTP id 46e09a7af769-862f08f33c6mr5114342a34.8.1795073753266;
        Wed, 18 Nov 2026 23:35:53 -0800 (PST)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f02123fdsm4159559a34.14.2026.11.18.23.35.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 23:35:53 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49429181ce9so1255259fac.0
        for <linux-sh@vger.kernel.org>; Wed, 18 Nov 2026 23:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF2QYp9AiWoqilT5uACArJtZ77C/ucxtGAPbpVlIDhP0G68NjJrEVzW47kfu9ACB+Mk/R3tO6XcQw==@vger.kernel.org
X-Received: by 2002:a05:6102:e0c:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d6ba35b7d8mr1806982137.13.1795073401089; Wed, 18 Nov 2026
 23:30:01 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2026 08:29:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
X-Gm-Features: Aa3M54rf5ygj8ORK3fy8Y6Bg5UcrfzvYekQ-eoJmIgxSYs0ZeBrecHV4-2jERSw
Message-ID: <CAMuHMdU2u9wDiqp+H-aDWSRcT8_VtDg1NS0gVmqYYm9rt2ZSrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, 
	Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Nov 2026 at 07:17, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # sh

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
