Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9018C7EE26
	for <linux-sh@archiver.kernel.org>; Wed, 10 May 2023 05:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbjEJFIt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 10 May 2023 01:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbjEJFIp (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 10 May 2023 01:08:45 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A44EE3
        for <linux-sh@vger.kernel.org>; Tue,  9 May 2023 22:08:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9d8730fe5aso8894674276.1
        for <linux-sh@vger.kernel.org>; Tue, 09 May 2023 22:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683695321; x=1686287321;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTtpK1Un44XLqqGJYzxkLaX59Gadt3u8x45iMKydYoY=;
        b=xhQbPYpkUzDX8XU9iKlY3Y4428jn5y6GTm9xV45/y6OmNC04/3wNqkNgSXK3AJIxCv
         nf/3Kcyf7jXHraRNp8V/ThTGssm80Jrj1vFIVRl/eHnHIKGHX0llNwJFmswFPBKeszPS
         4ERvsVZvFaG63Gj8ZvkLnyoFsbatfd0tOGpnHcmb7QKy8F/PI1niiK9/bIJQ3clEICAC
         OKKiuKdx+Nga+KesCEIBcMETZuPReDAYyeYXYun87fEO018ylr/CbkSFeoHJtNA1RKEB
         SehH79xiSdMYH54KoBHTNvBbumLZBWgNKrjc9IJ4jvy2Xlbglq/VfxJ2yKtHyPoLu9Db
         naUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683695321; x=1686287321;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTtpK1Un44XLqqGJYzxkLaX59Gadt3u8x45iMKydYoY=;
        b=F3+mxi8FDKr8nopBX7UJLgUBsa0A9glFBR8LhZqzpEhcpT9AyNcNpsK7bkx7psDtFY
         ++h/sIqk6m00Wucya9C8ez16WOV5srs8D565K1GRl+S7gEfXp3zwDLUP8GWhPHL7kRwK
         xE+ldvW9Gbk8ZQFf2dkKghqpl7fhE5hvR4MHnAfUXet3yH50YQM/7Cf1dHxtSZeQc89u
         D6EcPaQygFccZWz/UwILHL8yaR9J+kzSNxiBplLiZY1eoJsA1PH/ggE02QfWpqMbqrBm
         //I1+SZMXy0g8rRYOqPJTP7kT3awPtW22yWE3H2uwAX52agtR5Rb6HBuTLtIFyxAaAo7
         Rolg==
X-Gm-Message-State: AC+VfDw2p1gpEv9x3OOF3ctwviFS5rmphTUqfwnIydw8QeBlZtJJ3aEY
        JKiy/dmxqRNmlV06Au5U1TsdLw==
X-Google-Smtp-Source: ACHHUZ4Nr7JCTjKD9JrQLs38TYvzUeemCSYHOU0HaXL9Z0TKs+cs2kkX5Dm1CGmBCetCdz6AhjKuwg==
X-Received: by 2002:a25:b228:0:b0:b92:2e22:aba5 with SMTP id i40-20020a25b228000000b00b922e22aba5mr17628224ybj.11.1683695321141;
        Tue, 09 May 2023 22:08:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 7-20020a250a07000000b00b9dcd17cc2dsm3512897ybk.46.2023.05.09.22.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:08:40 -0700 (PDT)
Date:   Tue, 9 May 2023 22:08:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 21/23] x86: Allow get_locked_pte() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <eba2b72f-2180-498b-c8bd-ce8f717fc78a@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/kernel/ldt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 525876e7b9f4..eb844549cd83 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -367,8 +367,10 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 
 		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
 		ptep = get_locked_pte(mm, va, &ptl);
-		pte_clear(mm, va, ptep);
-		pte_unmap_unlock(ptep, ptl);
+		if (ptep) {
+			pte_clear(mm, va, ptep);
+			pte_unmap_unlock(ptep, ptl);
+		}
 	}
 
 	va = (unsigned long)ldt_slot_va(ldt->slot);
-- 
2.35.3

