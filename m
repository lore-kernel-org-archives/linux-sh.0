Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57228C433EF
	for <linux-sh@archiver.kernel.org>; Fri, 17 Jun 2022 14:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382648AbiFQOPm (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 17 Jun 2022 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiFQOPl (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 17 Jun 2022 10:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FA1B427F5
        for <linux-sh@vger.kernel.org>; Fri, 17 Jun 2022 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655475339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=45WsYeBZBgVP+tO+Yp5wRnejBKTYaIp3okpekaDuC30=;
        b=exSbu3g2/R4OGiKaC+iCLPWAArp3zQ1sb3m25obkVyrTKXoF/RCGdte30TOtE6K7xBcEOM
        /1nC6q982RJ5wp2vrfKIVKiuvQutUJ7n57m85BWXJD0v8BZjzasVyb/YDmDIiqdCMdeHJr
        QrxYOAlWvgVEB5AD0K22SHYk3lEyzkI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-NzD3pyZFNdOxZ-LXpAr8IA-1; Fri, 17 Jun 2022 10:15:38 -0400
X-MC-Unique: NzD3pyZFNdOxZ-LXpAr8IA-1
Received: by mail-io1-f70.google.com with SMTP id f16-20020a056602071000b00669bb12a6baso2581588iox.8
        for <linux-sh@vger.kernel.org>; Fri, 17 Jun 2022 07:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45WsYeBZBgVP+tO+Yp5wRnejBKTYaIp3okpekaDuC30=;
        b=ZGU36aEhJ1UOhLjQ5OKhK7zd7FYno/CBt9hr3uNmHVbQb8gZp6ES0PSa1SDxHuDk1u
         IVCu2TRobICbeMPmTCqjdmEGl0R5hPwLoNTtt6WBYmjhIPVTyyc4VdjoxHmdVgV9JMSf
         SvOsIriFef/CjvCH4rT1mIsbGpkZsd+8so2J2VRmx/hcxCbHxTLJBhqFMiYfB5Dv86sX
         dlERBsDUU2v9RDVKnDV6TOmWDuyG0wODBPBA2IbwY3kxoeZ7ngt/Rc3O7WS00SLHs65h
         SYwLe6+gNdakrxKh/5J6Et2fHpQie+S7EG9CerM+eMMmsSNHpOuVwgzXcBmUCkzbSAMd
         YZRA==
X-Gm-Message-State: AJIora+URqrLIap1YNeMWzyqXkOIkyR/RqtXhMDxMldQiaF8tv+oMZix
        qjs37YevATU3PxxZgGJFwL4Lf/8dWDDQ2B+pJxC3KjLjyh7i1DMPXDlZye1bZI019n53TfWyqLC
        Z/tqnViDfxoidxSXq2KM=
X-Received: by 2002:a92:da4c:0:b0:2d5:4942:151c with SMTP id p12-20020a92da4c000000b002d54942151cmr5595294ilq.54.1655475337979;
        Fri, 17 Jun 2022 07:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5+pBPw8qcp/W9vVk3R5y0UpR770R+5zi051+5lmo73AcdTcYx/JcpFCItROcYKy2t53b2mA==
X-Received: by 2002:a92:da4c:0:b0:2d5:4942:151c with SMTP id p12-20020a92da4c000000b002d54942151cmr5595259ilq.54.1655475337682;
        Fri, 17 Jun 2022 07:15:37 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id h22-20020a02c736000000b0033792143bf5sm649986jao.67.2022.06.17.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:15:36 -0700 (PDT)
Date:   Fri, 17 Jun 2022 10:15:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Muchun Song <songmuchun@bytedance.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] hugetlb: skip to end of PT page mapping when pte not
 present
Message-ID: <YqyMhmAjrQ4C+EyA@xz-m1.local>
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
 <20220616210518.125287-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220616210518.125287-2-mike.kravetz@oracle.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi, Mike,

On Thu, Jun 16, 2022 at 02:05:15PM -0700, Mike Kravetz wrote:
> @@ -6877,6 +6896,39 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return (pte_t *)pmd;
>  }
>  
> +/*
> + * Return a mask that can be used to update an address to the last huge
> + * page in a page table page mapping size.  Used to skip non-present
> + * page table entries when linearly scanning address ranges.  Architectures
> + * with unique huge page to page table relationships can define their own
> + * version of this routine.
> + */
> +unsigned long hugetlb_mask_last_page(struct hstate *h)
> +{
> +	unsigned long hp_size = huge_page_size(h);
> +
> +	switch (hp_size) {
> +	case P4D_SIZE:
> +		return PGDIR_SIZE - P4D_SIZE;
> +	case PUD_SIZE:
> +		return P4D_SIZE - PUD_SIZE;
> +	case PMD_SIZE:
> +		return PUD_SIZE - PMD_SIZE;
> +	default:

Should we add a WARN_ON_ONCE() if it should never trigger?

> +		break; /* Should never happen */
> +	}
> +
> +	return ~(0UL);
> +}
> +
> +#else
> +
> +/* See description above.  Architectures can provide their own version. */
> +__weak unsigned long hugetlb_mask_last_page(struct hstate *h)
> +{
> +	return ~(0UL);

I'm wondering whether it's better to return 0 rather than ~0 by default.
Could an arch with !CONFIG_ARCH_WANT_GENERAL_HUGETLB wrongly skip some
valid address ranges with ~0, or perhaps I misread?

Thanks,

-- 
Peter Xu

