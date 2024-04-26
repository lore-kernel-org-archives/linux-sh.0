Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCD147C82
	for <linux-sh@vger.kernel.org>; Fri, 26 Apr 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139106; cv=none; b=QOqie7RGnlS98wHvRCepiYfAoKKdjQC7XX6FhMBF1IJYp/o4Tyyo1Ti63aoEjuVpUBxdwdFqQfqSu4zFhcs0xPdshRlB55qwkdzDFY2nwZ4cnHIdqUUrylttWbxJDcykfD+lYWoqHPmUT4MZwoirjOZbWMx+fsj6g4CjS+gOls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139106; c=relaxed/simple;
	bh=/wyjt9d4AZ8Mo8vzASxA6mAa3oblPdVQKxM3OHzZLF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RgWxwzShc9vRACLfYJEiKGBKhoIMSTWDbeMDO+9e5c9TC1LnpjEOt6lSdUqV7N+nnB1TrwM9h9AiMheLViLiXa9OQrv95Y0uAZMBs38QGWeMhIhT1S5efUC/gOVx1KntafpESg8ut9+IBdcH7sdE4g6B2QnyNBxX/930xHyX79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnQJ1dJI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnQJ1dJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714139104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uF1kPlR2Ck3Z44kTNMrT7zanJ3tMGvooilBaXGx0yJc=;
	b=AnQJ1dJI3MtJ+7I0tkcWnraRJUBm9MW1uPpoAEPQpP6czxDrPrFfY2kGvbxe30YS501/Gb
	PSLgnbiOQZ/7zQJxoekoEhYqIxC3Za3r1Srf5f+U0V+3uinJqwqRjSzCEDqUXtxMa4WzCo
	R83vtPBuT6SQIbOeXPccWXoDQIHCLVo=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-c-RrtZIHPmu78caEMLPETw-1; Fri, 26 Apr 2024 09:45:02 -0400
X-MC-Unique: c-RrtZIHPmu78caEMLPETw-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6eb607b308bso679385a34.0
        for <linux-sh@vger.kernel.org>; Fri, 26 Apr 2024 06:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139102; x=1714743902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF1kPlR2Ck3Z44kTNMrT7zanJ3tMGvooilBaXGx0yJc=;
        b=j8iaTHkKSMT9+YlGu9orHlJlfXZalQProHZbY6i0N5uMGegobEM5R5GkMk5tKJXn4o
         ob/vjTCK+KYjN8KQyGA5b1gMnbLp06OFIrhgB4i5oKeBvoZHkKOwGmyKgYP3EzTn0Q/o
         e2+y8fjC0c/5fWdLsv2EKfdUinvunCT48+m83LfJN1AqwwxSqaPnkG2yUOk3vqquARVS
         WuUh0m7dj+79jhaZ+oZozZUaOPCv3pqzVAdbAH5Im+qvC76JkpSMeTondi6cSzRuvvrb
         oWC76qIDZS8I8+PPQss6YBTS83TM6wN7+mWDan7k3xibZ4hW06O5XTwcB3vocp1xI94T
         CMAg==
X-Forwarded-Encrypted: i=1; AJvYcCVO23elfyO/FOI5WuDCUaoAf7Zo+6yUXoxaRZMgqJawbJX9MDq6qy5Cl73r4CcEPodKy67Lq8BzRw/c5znd7Z+NxTpUkiu/S/I=
X-Gm-Message-State: AOJu0YxJuog9skxk9tE/354/9nIE14af6oT1/po031u5mU/wJLIQcSvH
	f85l7Hlg65qFE4zY7w9VAYeGHuxqpgKg6usxmOfH3rqF694u1L14vCOTp0z09LF+3RtkLMOEQCF
	KPXMbkQY5NeMrnQA4wWTdIsIKRyy3FDeVncZAGSY4YnGiwnPkeInLf9WW
X-Received: by 2002:a05:6808:d53:b0:3c5:f29a:5fda with SMTP id w19-20020a0568080d5300b003c5f29a5fdamr3101404oik.3.1714139101676;
        Fri, 26 Apr 2024 06:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzrxrCF28uWDRUo6q+zp4qFvioOS0q1e4hOagwn8iRvVD4UFCuaQuTxLkqj/Vp49yVezlG5g==
X-Received: by 2002:a05:6808:d53:b0:3c5:f29a:5fda with SMTP id w19-20020a0568080d5300b003c5f29a5fdamr3101360oik.3.1714139100964;
        Fri, 26 Apr 2024 06:45:00 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id w9-20020a0ca809000000b00696b1050be8sm6864026qva.133.2024.04.26.06.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 06:45:00 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:44:58 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 1/3] mm/gup: consistently name GUP-fast functions
Message-ID: <Ziuv2jLY1wgBITiP@x1n>
References: <20240402125516.223131-1-david@redhat.com>
 <20240402125516.223131-2-david@redhat.com>
 <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e685c532-8330-4a57-bc08-c67845e0c352@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Apr 26, 2024 at 09:17:47AM +0200, David Hildenbrand wrote:
> On 02.04.24 14:55, David Hildenbrand wrote:
> > Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
> > all relevant internal functions to start with "gup_fast", to make it
> > clearer that this is not ordinary GUP. The current mixture of
> > "lockless", "gup" and "gup_fast" is confusing.
> > 
> > Further, avoid the term "huge" when talking about a "leaf" -- for
> > example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
> > "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
> > stays.
> > 
> > What remains is the "external" interface:
> > * get_user_pages_fast_only()
> > * get_user_pages_fast()
> > * pin_user_pages_fast()
> > 
> > The high-level internal functions for GUP-fast (+slow fallback) are now:
> > * internal_get_user_pages_fast() -> gup_fast_fallback()
> > * lockless_pages_from_mm() -> gup_fast()
> > 
> > The basic GUP-fast walker functions:
> > * gup_pgd_range() -> gup_fast_pgd_range()
> > * gup_p4d_range() -> gup_fast_p4d_range()
> > * gup_pud_range() -> gup_fast_pud_range()
> > * gup_pmd_range() -> gup_fast_pmd_range()
> > * gup_pte_range() -> gup_fast_pte_range()
> > * gup_huge_pgd()  -> gup_fast_pgd_leaf()
> > * gup_huge_pud()  -> gup_fast_pud_leaf()
> > * gup_huge_pmd()  -> gup_fast_pmd_leaf()
> > 
> > The weird hugepd stuff:
> > * gup_huge_pd() -> gup_fast_hugepd()
> > * gup_hugepte() -> gup_fast_hugepte()
> 
> I just realized that we end up calling these from follow_hugepd() as well.
> And something seems to be off, because gup_fast_hugepd() won't have the VMA
> even in the slow-GUP case to pass it to gup_must_unshare().
> 
> So these are GUP-fast functions and the terminology seem correct. But the
> usage from follow_hugepd() is questionable,
> 
> commit a12083d721d703f985f4403d6b333cc449f838f6
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Mar 27 11:23:31 2024 -0400
> 
>     mm/gup: handle hugepd for follow_page()
> 
> 
> states "With previous refactors on fast-gup gup_huge_pd(), most of the code
> can be leveraged", which doesn't look quite true just staring the the
> gup_must_unshare() call where we don't pass the VMA. Also,
> "unlikely(pte_val(pte) != pte_val(ptep_get(ptep)" doesn't make any sense for
> slow GUP ...

Yes it's not needed, just doesn't look worthwhile to put another helper on
top just for this.  I mentioned this in the commit message here:

  There's something not needed for follow page, for example, gup_hugepte()
  tries to detect pgtable entry change which will never happen with slow
  gup (which has the pgtable lock held), but that's not a problem to check.

> 
> @Peter, any insights?

However I think we should pass vma in for sure, I guess I overlooked that,
and it didn't expose in my tests too as I probably missed ./cow.

I'll prepare a separate patch on top of this series and the gup-fast rename
patches (I saw this one just reached mm-stable), and I'll see whether I can
test it too if I can find a Power system fast enough.  I'll probably drop
the "fast" in the hugepd function names too.

Thanks,

-- 
Peter Xu

