Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801AC7EE2E
	for <linux-sh@archiver.kernel.org>; Thu,  8 Jun 2023 19:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjFHTZU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbjFHTZQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 8 Jun 2023 15:25:16 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0691430F2
        for <linux-sh@vger.kernel.org>; Thu,  8 Jun 2023 12:24:41 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39aa8a055e0so50671b6e.0
        for <linux-sh@vger.kernel.org>; Thu, 08 Jun 2023 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252276; x=1688844276;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7vs80eeAHoowuGiB3IXr1R0pQ52ZVhylKFRPge1iSc=;
        b=Fizq3Xl20k0s99bdV61+X0NES9CrzdKWOse7eCbwtn1uu9/h4mE0n0kQt9PwBBK2XD
         BLlYV7LOU26RY2UNjTt4eTKg2MiSFQ+mNE44PGkBbtphVk3O0XARXhUyyawmE+XPjZkM
         EIuZgR8dgqHGa9xPUigE/FawhK1QiFlabNgVMomZeu9AjaWaPJZt0b1g6ImgUkyGd5Ls
         fLctCunPng5YblGLwKbDucX0igX9BBdDWTKtQ02LRRmnejkHdR4rcW59H7SIyTy+bUtn
         UJH+uR4By3Rz8RGak7Nu20/xco5IlkAXPoTxOravmVmGg5IIQRwIeYxmwmVdJLgwdVhQ
         Kkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252276; x=1688844276;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7vs80eeAHoowuGiB3IXr1R0pQ52ZVhylKFRPge1iSc=;
        b=B6dvivsb4sJ3IwGfeaxnZJ0WE72WBQs9PKlzO8cV9AkgEHPA3HUcWZdJnjv9B1gQKj
         hdwON/u21Q9W4sa4WmHB58TOxfOhdo2m1iuY7l8wqF6ka6DihR05oP4TQ3MGr5c1H+cF
         WD3SBrGL7oKt8urhjjGBqcx5RL+LC5d3jEo71o/Yh4haZjWuTm/AX4tx1I/01R+SqDm1
         oDXXbhGxUt43nbEhRi8L+kWLjbdzrC8+S7lg52hUFQ6RuKaA6hTATkasi+UMmyI3CmGA
         E3l7RKmATkqSNl6tSyOb8oNK925NMJv7F8aAYFlmjbZNpw7jOXi+eWrCwCqbrk9O3/9B
         y1ng==
X-Gm-Message-State: AC+VfDwXpYEVaMDxRwY3Vp7R31EYyszd87rZpv9N6e1hVzx++mz4E14i
        z1eSHGwbX1ylZYb6MY+GXIjjsQ==
X-Google-Smtp-Source: ACHHUZ7q/V1z+M3JmfzPQUSgwqST3P0/aMtaG97EoZD5q0BXyKYRTA5dvNNFRGy2eGKWgHikkJ/mpQ==
X-Received: by 2002:aca:231a:0:b0:398:2e8d:3ca8 with SMTP id e26-20020aca231a000000b003982e8d3ca8mr9311006oie.52.1686252276532;
        Thu, 08 Jun 2023 12:24:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p127-20020a0dcd85000000b0055db91a6ddfsm111980ywd.73.2023.06.08.12.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:24:35 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:24:32 -0700 (PDT)
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
Subject: [PATCH v2 13/23] powerpc/hugetlb: pte_alloc_huge()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <36b4e5d-954b-8569-4fe2-bd1797362441@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

pte_alloc_map() expects to be followed by pte_unmap(), but hugetlb omits
that: to keep balance in future, use the recently added pte_alloc_huge()
instead.  huge_pte_offset() is using __find_linux_pte(), which is using
pte_offset_kernel() - don't rename that to _huge, it's more complicated.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/powerpc/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index b900933507da..f7c683b672c1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -183,7 +183,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		return NULL;
 
 	if (IS_ENABLED(CONFIG_PPC_8xx) && pshift < PMD_SHIFT)
-		return pte_alloc_map(mm, (pmd_t *)hpdp, addr);
+		return pte_alloc_huge(mm, (pmd_t *)hpdp, addr);
 
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
 
-- 
2.35.3

