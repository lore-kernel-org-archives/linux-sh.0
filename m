Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47660C77B7C
	for <linux-sh@archiver.kernel.org>; Thu, 11 May 2023 03:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjEKDkt (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 10 May 2023 23:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjEKDks (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 10 May 2023 23:40:48 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856EF30FE
        for <linux-sh@vger.kernel.org>; Wed, 10 May 2023 20:40:46 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-559f1819c5dso121717257b3.0
        for <linux-sh@vger.kernel.org>; Wed, 10 May 2023 20:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683776446; x=1686368446;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENej4jeIUZxBD8VRbCOiI8elHKtxPPI57IP2BPex2w8=;
        b=rviiAWub81WZaaPcAMwIMpPx+RM5d7a1hQGcoQ8Eqv2OqKv43ouIJ6GM0Wqm5MKw19
         LlfJ3mauLEKM4EJ7ZB4sOpgDUGoN5Ak/+OXf8SHKvg8BrrIQ8mj26P/t+9KKCmZeNAR3
         c3aByxh2kGch+WNujk2ErjRPhOnwQeT92JRc5DBl9JJAmmzq7/qiNEJWuS0m7V9Devz8
         0Vopapo7pIiPZPd8xIHbRWy7CL2RdDqu7m1Q6FJFKKBLqxrFd0oOXOuWSyJ5b+ZPMXeF
         OsW+3BbBiu8BwYCTIqJ9f3bU46zyRenionGejcnHG/apa36HhsSJADojKmBj7efm6f3a
         MOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683776446; x=1686368446;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENej4jeIUZxBD8VRbCOiI8elHKtxPPI57IP2BPex2w8=;
        b=BWd1L8Tgw5bCrYTRp5MfVtkKPiVCh+jnMvQlRqN8/Pe/8bZ/r99PUxi2CVo43Hiz3J
         ic9vH38YFyiPoVmxc6cFYbAAjWOt0Lod4qm/e8pXjN3n7ubZ3k/zCSrbLFtBEP6gkJaI
         6SD3nZvEpSqdiFIoBJsv+5jKHcAscY8oxgfNpoj1w2lCP/w6MG4SocU61BbeQGFHH5RQ
         g4EC6LBlKVL5/hv1twyEeBihiiDbfsdy8Qapw3MegMQ/2g2HJKjqPqRWfcorr+9/8v4e
         8rVNPdoVhXJ3RyLHJcUPesDL2/pTk6hfc70Bqf6utGrhMFKL8gJeWI95YkVd1b406KyY
         K04Q==
X-Gm-Message-State: AC+VfDzxuXjWYjQQ63ycDmwBbsjTpiKlPVovr4tmahdIhtMpxY2YcM91
        KTaNnwWa0lVs4HHqTPwfGvN5Mg==
X-Google-Smtp-Source: ACHHUZ7h//pElwTWDcmRkblmnEL8tpIvH3DpaXFnfKmYUIesZtUkvvAepMEKFrx4IKpikCPoidpc1g==
X-Received: by 2002:a81:8702:0:b0:560:bb81:6468 with SMTP id x2-20020a818702000000b00560bb816468mr6471997ywf.23.1683776445583;
        Wed, 10 May 2023 20:40:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g138-20020a815290000000b0054629ed8300sm4571040ywb.80.2023.05.10.20.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 20:40:45 -0700 (PDT)
Date:   Wed, 10 May 2023 20:40:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCH 01/23] arm: allow pte_offset_map[_lock]() to fail
In-Reply-To: <ZFup/fG50MPFF979@casper.infradead.org>
Message-ID: <b9dc75bf-b13c-37ba-6c16-9fc163703dd@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <5011977-d876-6a24-a3fc-c7e6a02877b8@google.com> <ZFup/fG50MPFF979@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, 10 May 2023, Matthew Wilcox wrote:
> On Tue, May 09, 2023 at 09:42:44PM -0700, Hugh Dickins wrote:
> > diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
> > index e4c2677cc1e9..2f6163f05e93 100644
> > --- a/arch/arm/lib/uaccess_with_memcpy.c
> > +++ b/arch/arm/lib/uaccess_with_memcpy.c
> > @@ -74,6 +74,9 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
> >  		return 0;
> >  
> >  	pte = pte_offset_map_lock(current->mm, pmd, addr, &ptl);
> > +	if (unlikely(!pte))
> > +		return 0;
> 
> Failing seems like the wrong thig to do if we transitioned from a PTE
> to PMD here?  Looks to me like we should goto a new label right after
> the 'pmd = pmd_offset(pud, addr);', no?

I'm pretty sure it's right as is; but probably more by luck than care -
I do not think I studied this code as closely as you have now made me do;
and it's clear that this is a piece of code where rare transient issues
could come up, and must be handled correctly.  Thank you for making me
look again.

The key is in the callers of pin_page_for_write(): __copy_to_user_memcpy()
and __clear_user_memset().  They're doing "while (!pin_page_for_write())"
loops - they hope for the fast path of getting pte_lock or pmd_lock on
the page, and doing a __memcpy() or __memset() to the user address; but
if anything goes "wrong", a __put_user() to fault in the page (or fail)
then pin_page_for_write() again.

"if (unlikely(!pte)) return 0" says that the expected fast path did not
succeed, so please __put_user() and have another go.

It is somewhere I could have done a "goto again", but that would be
superfluous when it's already designed that way at the outer level.

Hugh
