Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3D425CC2
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780573646; cv=none; b=A+ZcTMrb7gQuFR3yJ/p6zUECtFdfhss48N34EVqhiphK9BfuiyOTpbrTPTl900p5AZswQxn/yYF4mPyfHLTgH9qvgwK9ZclocdY5nnslmhOnYXbVBumQ8r2IfEC9eqs80i8xUeOZb5ka9273BFYzmNRB91GzHUtoBKVzayd5cXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780573646; c=relaxed/simple;
	bh=X3jcO211yCzUEX8cCiuXZU3dN80xuoEmhIPDq6IhjjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEFTcpGZ4SvQxgheqYFyHeiEOtyJa2Tie2WSt+bRJIuv9RfaH09w7RJGAwwLFzuYFrculwPLa53xUgqat+7HA7RR1jGrxA/WW4uprD7n4TlUWnub0gK4SZBs8ppwICIv08OH98kg4rGE1VAOWpd0NzQmBv9Ge3G8p4nF/WrL1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XZBohDha; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZBohDha"
Date: Thu, 4 Jun 2026 13:47:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780573643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VogQJB2OxKh5hs9EKw4HnbFx1jTB1RF1WgmZ+L+RCx4=;
	b=XZBohDhab3et4X/Ns36Gy7mVLwhFB6pPaJOFXdVjkETe33NjFJzGJUkAiYEzHPwCgLKkS3
	GKvKGv5+T8BPgK6vMfjvXxliAvIvNwMJw8EN8OXZ0SBDNE+gHs5mhSm85qJqCYPjm17+zr
	1FrZjiRxueMStAsAjk2zIHhDWF/IhFY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: dma: use str_plural helper in register_dmac
Message-ID: <aiFlx8arTja5SVbC@linux.dev>
References: <20260604113442.1303771-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604113442.1303771-3-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

Please note that this patch requires the following to apply cleanly:
https://lore.kernel.org/lkml/20260510161012.108731-4-thorsten.blum@linux.dev/

On Thu, Jun 04, 2026 at 01:34:42PM +0200, Thorsten Blum wrote:
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code. This also corrects the "0 channels" case.
> 
> Use pr_info() while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/sh/drivers/dma/dma-api.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
> index 31b614358270..7c8ee3a0bdf9 100644
> --- a/arch/sh/drivers/dma/dma-api.c
> +++ b/arch/sh/drivers/dma/dma-api.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/string_choices.h>
>  #include <asm/dma.h>
>  
>  DEFINE_SPINLOCK(dma_spin_lock);
> @@ -200,8 +201,8 @@ int register_dmac(struct dma_info *info)
>  
>  	INIT_LIST_HEAD(&info->list);
>  
> -	printk(KERN_INFO "DMA: Registering %s handler (%d channel%s).\n",
> -	       info->name, info->nr_channels, info->nr_channels > 1 ? "s" : "");
> +	pr_info("DMA: Registering %s handler (%d channel%s).\n",
> +		info->name, info->nr_channels, str_plural(info->nr_channels));
>  
>  	BUG_ON((info->flags & DMAC_CHANNELS_CONFIGURED) && !info->channels);
>  
