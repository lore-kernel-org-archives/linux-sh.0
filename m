Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635738E5C5
	for <linux-sh@vger.kernel.org>; Tue,  9 Jun 2026 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998931; cv=none; b=FTWBO2S+NSKplWZzL/JAcTIolgbb75Y29jWI/BP9YnQUeg64hHmawqamPHfqBJDMR+smAVDr52u1oBA15zywko2uwEANdQJLXB0KlcusqGp8N7DLoNn/O2vdd/V95+c89i/zDVnVdJmZae9/WfU3rxkbQjlzQeLWoJ8IeGl8YZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998931; c=relaxed/simple;
	bh=LMAkeVaZptDMfPIXMRgnhcXwRYr1AtJoIiiI7hhG/Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQMOdYtjQtyhpYHvRgX1id6EVTO+9cg8B3WG8vLvHYDTE5fTPdSEJ6LH6QVExv/QlH0FOIMMOuDDOkyTcFUWXWrYmQpe0QFsJPhQvgAwu2+pqy79uknXZ29C9vKqQr/4Wks5FUOETPRjRdQ8ab47h4NFSRKfIlCCSmRkVWag66A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-96358d0a024so3661160241.3
        for <linux-sh@vger.kernel.org>; Tue, 09 Jun 2026 02:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998929; x=1781603729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/QDHCd1pzNPKIKT6XsNCXh/My/ujozGgvsOiDCA3LA=;
        b=lfhlmd7M8qWUOojnmIr8vVpUckcRirr3MTIUHE1eJj0WymT5QZQ03dQRsA3wSohnCK
         LUYLKj3Ucv2jtNRXtqRkYD+qeByJZJPon9wFcZxfuOAhLG0ZAtFu1EXgzX1s73AngTuf
         kZ7LzRdb/GQU644rQnEYccM9ax0ZA8YjWoF4sZ99S75xGvOJL1DfBn9T6uQvfU36/zFP
         EzRNcNSeLVu66ks1cSDFg+x2zkkv9RtKyx83wDZV5VkY0EB+UlKJCJoZ0xr+dA+i/5Ku
         tVbQULs7LBxh54a9JeSWcluViAueDetmnS3d4f/yM1GrPFtWN2One1uwzYNoBWMXrQ+S
         mELw==
X-Forwarded-Encrypted: i=1; AFNElJ//WQ+Gk17KGnrMHCyjGW3QaTSctQyH2mPsrOD1Q4OzRuwavdEeMiUreLmNxxy50jSvLBCTp7bDOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BBOxD0NdVW6P7UhI9tZBfEWLpugyUUVpUSAoKm9W0G/LpWS7
	6CxgQjHG1jsWWGtI5MCWxnpHozVqIQveZLw1Z1yHYmAuEi8MhW/lrjLT/Ite1Mc6
X-Gm-Gg: Acq92OFyJAgsf3aeFV2xA3DCQBk048HqNb2VgLif8DsZPIVaDW0wGkQkgSgDhP3ZZTu
	dsQ0xpA/xJn6yw1iV60VFa5oOV8uAaCi+VEcbgu6j4jPm+/sC0Ei2TqXepb/xiBwHisN69lRuXQ
	ICnVzIecy+2vxf+ZX7d9Xop7mZAPqIpzbFkesVp+4q54nmR35D9lBOB+uN78P6lCHTM7rfsSsg0
	H+XrvUr89g3GAZDkahQVsWZB3Juiv1owxaBzAX3sL5L32j4p1Lc3FXXfR5pMuLc8wFiNxbVaKyn
	LioU97X6PW7a0Xtlx5YegvvaexIe218DF874YWCiwCSOxOGA95teupOHeX8dwCBaGFDMGUW5f10
	DeQoa1pT+mrWwy+++YeNNz+H+t1+y0VWIOJog/O1ryB37inFbjTkiAd6Go3skxQuJqGazwbyFSv
	ve09ux34qDTEdrP2d67kGs+JI1T+/TqQFkfGfvEV8AlYjsV2BQUHWiPGU1jRsDV9V1/ZJNooE=
X-Received: by 2002:a05:6102:548c:b0:639:1e8b:ecd9 with SMTP id ada2fe7eead31-6fefa23308cmr9731075137.20.1780998929023;
        Tue, 09 Jun 2026 02:55:29 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96414115a93sm15416462241.9.2026.06.09.02.55.25
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:55:26 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6c534af2470so3506031137.3
        for <linux-sh@vger.kernel.org>; Tue, 09 Jun 2026 02:55:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+eNALIc0EwBIbeYSc6GvB404zXXPOMrkotXzOXS34jVcXDYOw+IHBMN20mp5dbRGwDrjpLB5cYog==@vger.kernel.org
X-Received: by 2002:a05:6102:149a:b0:636:984a:1e5d with SMTP id
 ada2fe7eead31-6fef05f052fmr11135049137.11.1780998924802; Tue, 09 Jun 2026
 02:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com> <CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>
 <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com> <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
In-Reply-To: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 11:55:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-rH7s6GD4FtiKP9++3c2ojwZKm=YGLM_S_+nkj+EBtw@mail.gmail.com>
X-Gm-Features: AVVi8CfDur0wzec2mY_1awm30cbHrLvunVYojJnvz6Cb53IUltKkdZGFSORVN6A
Message-ID: <CAMuHMdV-rH7s6GD4FtiKP9++3c2ojwZKm=YGLM_S_+nkj+EBtw@mail.gmail.com>
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 08:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> On 09.06.2026 08:22, Marek Szyprowski wrote:
> > On 29.05.2026 17:02, Ard Biesheuvel wrote:
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> The linear aliases of the kernel text and rodata are also mapped
> >> read-only in the linear map. Given that the contents of these regions
> >> are mostly identical to the version in the loadable image, mapping them
> >> read-only and leaving their contents visible is a reasonable hardening
> >> measure.
> >>
> >> Data and bss, however, are now also mapped read-only but the contents of
> >> these regions are more likely to contain data that we'd rather not leak.
> >> So let's unmap these entirely in the linear map when the kernel is
> >> running normally.
> >>
> >> When going into hibernation or waking up from it, these regions need to
> >> be mapped, so map the region initially, and toggle the valid bit so
> >> map/unmap the region as needed.
> >>
> >> Doing so is required because pages covering the kernel image are marked
> >> as PageReserved, and therefore disregarded for snapshotting by the
> >> hibernate logic unless they are mapped.
> >>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > This commit landed in yesterday's linux-next as commit 63e0b6a5b693
> > ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
> > In my tests I found that it breaks booting of RaspberryPi3 and
> > RaspberryPi4 boards with the following kernel panic:

Seeing the same panic on R-Car H3 ES2.0 (Cortex A57/A53), but not
on R-Car V4M (Cortex A76).

> One more comment - reverting 63e0b6a5b693 and 53205d56212c (dependent
> change) on top of next-20260608 fixes this issue.

Confirmed, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
