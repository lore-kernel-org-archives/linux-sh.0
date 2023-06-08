Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A83CC7EE29
	for <linux-sh@archiver.kernel.org>; Thu,  8 Jun 2023 19:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjFHTa1 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFHTaV (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 8 Jun 2023 15:30:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB27A2
        for <linux-sh@vger.kernel.org>; Thu,  8 Jun 2023 12:30:19 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33b0bfb76cfso4353425ab.2
        for <linux-sh@vger.kernel.org>; Thu, 08 Jun 2023 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252619; x=1688844619;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCwP+3tlZqvvMSbN25I242CI8N2o4w3/6RVIlVlj13g=;
        b=Z+1ROWx9LnxdX5nt3Yo9Gw9A1LjKJHFc2WtgcRAYaFIpj6m1+MueknjL2tetH/Yt/E
         Jkma5NMQVv2CGzmJBnvKYmHLILgxFTZBZe29Vg5F330+u2fSbBPVEtX3NRx2YFJBGUmp
         kCJjjc7KvjHhyEDucY5j+/eHT1OpuVlzl/VgAMVyKWRQ9P9ksfEE7oKQrQHB2ZVzogis
         AlGkparAM9e3I8OX/wc+UGRKJ9WTDNWGaUDF7YaTiCVpSxpo1NNn2hyrTeXSAmMOPutQ
         TUN3B1UmJFKBBqlJCwM8cMmQBeV6xJ4ogL/1WbFBc8kxJTJPQLfJ0hWbM0sLcNxIcm/D
         dTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252619; x=1688844619;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCwP+3tlZqvvMSbN25I242CI8N2o4w3/6RVIlVlj13g=;
        b=UwDJxodXg24cEmaQ0M6wntwk2M6H6gbHDrxoMSd4q8ZjCk7VTnHA+T6jYfiWE+O8QK
         1yS206qEPJTogfwUNzH8PMyK72J2sZRw3mNTRVs1WhoDq5FZubGqvEfmRcgTiRE0vjwD
         YnStToT0Lh4wt2GIsEyxlTBN5iE5GL7VsIBp9k7FIVp+3CqdtQPb+J/VMhTnlMEASZgd
         trCjSiE1n5KUt4zAR5J69oZ4lzweJbgtkf8cDCLSc+FwRTwpSURd7/aGw0UalDmRCE+Z
         MrPELaIt5GtmxKkOYtTmd4MaMzreWyTIF+D3rZyhsKHeFTiONzDysZq5jox/+ATsI+hy
         PHYw==
X-Gm-Message-State: AC+VfDwf+gEvZdt8r/dKo2IvD5ZbMaR1+RR/YwmTekhkyK4jGx7HFa9y
        njNsuQQqHQ/qYAqJ4Yy/bNIjQA==
X-Google-Smtp-Source: ACHHUZ5FLPawoStHwp2n90KOP3LMuG/l1wNARr8CXyW4COytL00Jtvx4PAa220fnQj49mz7p+WoCNQ==
X-Received: by 2002:a92:d34a:0:b0:33b:820:41ad with SMTP id a10-20020a92d34a000000b0033b082041admr8096921ilh.9.1686252619199;
        Thu, 08 Jun 2023 12:30:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h184-20020a256cc1000000b00bad07875d9bsm450282ybc.11.2023.06.08.12.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:30:18 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:30:14 -0700 (PDT)
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
        Peter Zijlstra <peterz@infradead.org>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: [PATCH v2 17/23] sh/hugetlb: pte_alloc_huge() pte_offset_huge()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <ee885978-7355-624b-cfe2-c3d75672b842@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
that: to keep balance in future, use the recently added pte_alloc_huge()
instead; with pte_offset_huge() a better name for pte_offset_kernel().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/sh/mm/hugetlbpage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/mm/hugetlbpage.c b/arch/sh/mm/hugetlbpage.c
index 999ab5916e69..6cb0ad73dbb9 100644
--- a/arch/sh/mm/hugetlbpage.c
+++ b/arch/sh/mm/hugetlbpage.c
@@ -38,7 +38,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			if (pud) {
 				pmd = pmd_alloc(mm, pud, addr);
 				if (pmd)
-					pte = pte_alloc_map(mm, pmd, addr);
+					pte = pte_alloc_huge(mm, pmd, addr);
 			}
 		}
 	}
@@ -63,7 +63,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 			if (pud) {
 				pmd = pmd_offset(pud, addr);
 				if (pmd)
-					pte = pte_offset_map(pmd, addr);
+					pte = pte_offset_huge(pmd, addr);
 			}
 		}
 	}
-- 
2.35.3

