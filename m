Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353538;
	b=kKiVfh7KWFspXLAvh564qZHbDyzNvaIGHxj+c5gXmvk7i/v9pPu0pgE6rRUsiiUD7QaP
	 thrRzwjZIGTZUJs/OaK/WX94JJKUc9aLhcQzYCYEqBXHNc0APVGNFtdRDCKgOVi/KXfJc
	 FOMZHwUq9n8vWPTAUGN4SD5pebM5ycL0nqjcWGBse9id6Wir0q6kMlQcZEYps5jD1521o
	 NhESGmBiF8QmVfLHqJJf/Qx6xB4WeA9UB/YfWZGXbk8F0gus1ujPSNc21SUSmdZsruOE1
	 qOGOV8PbStcMcjoQuIV0VS8AkTiwIephJfDEG8216w7tVAuAie/9QNHzFCM9Gz0LZ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353538;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
	b=jp8it0zO6NEN2ix9DFMHD3aMhx47Qszo734QoaKaoI/Lonxbv9UzupLswtHljV8vVXJJ
	 lmIQPKSaGjmS0pukBOECb7D8jQI4/QCfNmYrnst1W/XRYFN5l+NPXO6jZKKd+x3Oy9iYI
	 NxRNJrDu0fJHi0i75waFvo+YUaQDxGVe7/MdlpczChPisc/H309CZUyxFG3l/R/UHhPec
	 hPUNwhwXaoNFD2fpiIxLnv5r6b10mSvF8M1P/IHit9alGfb1Y67i7AvJDPq3h+wwWHbsu
	 +nJZkShojU397xMVsbTqTMu0T+78K30v980zC3iH08+4Nn0dIwCXSQ/eFBJt0po17NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D7606A323
	for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 09:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901D7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2493c28bso45908585a.0
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 02:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353538; x=1793958338;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
        b=a21W/zpifa1Wu6E7fADBihRnvnNBkxX33Wo4RQIouYl+wjZjk9JOYUDb/CvBGV+0kk
         irtoTgcsmghxhEZaM3MHtpERmgwKNpUJ++9VQQiTYvSZVJqnFHTcqVo2l+jatL5NFG8U
         xYIfiIi2wM5z5aaJzYD7HSTN4wXnp3CRHpgeHqcbEz3R95U3NCLIXKkPAmUGpmSa2klY
         uFbnJZkDp/X51Ey0OqNHcPbng9iJ9Rzs0Cvn/NFGD9w2f2vsSYZz8cp4mbQA0IxyQXHa
         qiX/fXpuyZupjmi34JpHWy8NPxvhgO+xswuEQTeC/l4nuIRs8amE9EhPshsIKbyAdkHc
         4rlA==
X-Forwarded-Encrypted: i=1; AKwUvBxC8QXVs2yaLk7kkxPPmkycFOa/wCK4DHhfKXc0ERN8lY3c39Bjmy5ELIyTkyXNhDWgChCDuI7Bow==@vger.kernel.org
X-Gm-Message-State: AFq9FYJbj1knN0GrwGnizXHekyj26iM9NCZH4ZtbcSQJt6f3O6NrTwdc
	WCtC69Aldr2hfPsGcwHyNFP5aOW9e02PXhn8AN2TuF+kn2mJYkDodZpreaMIWpCd
X-Gm-Gg: AYBFou0pYHoxOp7FiTf5+6qj05by54V/zHoZ/o1z8MfWdIbNsbIWY6l0txiXsxRXlSF
	q899rkGm88E37yS3qEcE+eUY2NXC7StFRmsMw7hg4avKYJfYreXw1foaGpBjFuXYhM5lNrIWwkJ
	72ooMTnWd4TBiTjIEuDitkm23x467QbhY6j8kiuv2F6qlhkIhirwi8JgEC0iZ0Q+arFoygc1vba
	x9Zrm5Zy+iVoiYZ28cAIP503cdMW6hHoP0KEVmFngUL3N/CDiDTDxfk3Z7xt8dUCIjEWT/zQJZg
	zBoxbgYv8uqZdTUNwbtOrkVV9owHB4P4Y8eHquudouVAvT7JUyEhDAafkzbdhLroh8KOz0oStxi
	sus3CgQ5uYEfX7DL78bZ2g/CypMujyWNKAaUiHH6jB/EvqWBomDAbevuWonqn2C6dAt+kn0c1/J
	4aQId2YZPLldRRaSgpPBpPFiOyuKaMA5TX7rq/PVQc8O0kzs2J1EXqWZDzcWWdy+9lHBvjNiZD4
	nsBbzCrfWHs3AvmmZSkLE98emJjs/Xs3BXp8dH04D3D6GI2fo+/0OieXP26IsWU1DPVE5q11C/L
	aKc16hgv1mNKW7hclIvvTOL1A5GeTLD/cWGgMosUpF9DyWhXC6frflv78vHvfiMqv+i6eBs=
X-Received: by 2002:a05:620a:29c1:b0:93c:6028:6d2b with SMTP id af79cd13be357-9442175b5b4mr290235585a.43.1793353537717;
        Fri, 30 Oct 2026 02:45:37 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425852274sm99611485a.19.2026.10.30.02.45.37
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:45:37 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53669f7b518so5111291cf.2
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 02:45:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByxOCnznSvhUBCQ7e1ISjbiJ5hj/+CeHYaLBmEoxElAqainMAl1ytOyrXDIxwIcu9VruMJbArPJwQ==@vger.kernel.org
X-Received: by 2002:a05:6102:14a3:b0:7c3:1395:a090 with SMTP id
 ada2fe7eead31-7d0726152famr950274137.6.1793353170421; Fri, 30 Oct 2026
 02:39:30 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-3-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-3-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
X-Gm-Features: AclHuK8vFqi3dqWRxr6f8_rNGo4Y5wLrZ0prryPEwyIfD0-s59WP5msq_iDtOig
Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for constructed page
> tables. Calling the destructor immediately before freeing the page table
> therefore duplicates the lifecycle handling at each caller.
>
> Remove the redundant calls and let pagetable_free() handle the
> destructor. No functional change is intended.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h    | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
