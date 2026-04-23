Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509EE385519
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962298; cv=none; b=KvCpTyXLTXMfD7EbUx3ARU4rWxv8DFI9qFmtHd19tTCCmT/zZI3cMcx6zAdtxNGGluOzOcOaDTftWdnd0t9fZEjFmB/RxvXs787iwBakvTsMmMbKJQqnZIIjQnyMcA/cs74Xq2AO4rBPJ5g7b8+qwt+DaI6fdwvfojgd0+neaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962298; c=relaxed/simple;
	bh=S3+bbvUwO5X0LFCZ6I4QA6ZpNBn1otbj8LK87eYnONM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vi6EfBdtJ0WjlxJ3r6g8nlt5NrR8KIJG7tNagQcGC8ygpnR2jpjkD7ryj/YlXSskDfQG4ivvnqNiT3F/OA/5soXZNXi/PAlM9lmI3KwIDI07aAvrF5Vf42q2JZ2YvkiHXkd53iO1VzMwtNXsHaJi3rV8KOdW+f4xWPqntet6wAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mYrLeb8Z; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mYrLeb8Z"
Date: Thu, 23 Apr 2026 18:38:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776962294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHU1n+4Sn9L4AVE/rJ36qb9UNz/H0J1xnaM371OdCSA=;
	b=mYrLeb8ZSWnaXe2MVW41laphGJcmr/embJtfv31iGzyiYRABo0uvvGQZP0PnRINYyhi/+9
	1P+zsN/w4Q8kael35gmUgTYhoJckVCKbArsvy/wvKTiQBAMvoZJ8wp3aLJZp+GeggwreMc
	PnxP8KdLlgW/DBqvIbONOw5oF6Wlw2c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: cache: remove unused but set variables in
 sh4_flush_cache_range
Message-ID: <aepK8ucK5LJc1NbE@linux.dev>
References: <20260423145301.245374-4-thorsten.blum@linux.dev>
 <B1350795-6210-4C52-9100-1FF66687E3DC@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B1350795-6210-4C52-9100-1FF66687E3DC@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 23, 2026 at 11:46:38AM -0400, Zi Yan wrote:
> On 23 Apr 2026, at 10:53, Thorsten Blum wrote:
> 
> > Remove 'start' and 'end' to avoid two "variable set but not used"
> > warnings triggered by -Wunused-but-set-variable.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  arch/sh/mm/cache-sh4.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
> > index 83fb34b39ca7..9776027382cc 100644
> > --- a/arch/sh/mm/cache-sh4.c
> > +++ b/arch/sh/mm/cache-sh4.c
> > @@ -284,11 +284,8 @@ static void sh4_flush_cache_range(void *args)
> >  {
> >  	struct flusher_data *data = args;
> >  	struct vm_area_struct *vma;
> > -	unsigned long start, end;
> >
> >  	vma = data->vma;
> > -	start = data->addr1;
> > -	end = data->addr2;
> >
> >  	if (cpu_context(smp_processor_id(), vma->vm_mm) == NO_CONTEXT)
> >  		return;
> 
> Is the comment above the function considered stale too?

Yes, that should be removed too. I will send a v2.

> “START, END: Virtual Address (U0 address)” and the NOTE.

I think the NOTE is still relevant as it explains why flush_dcache_all()
is used.

> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks,
Thorsten
