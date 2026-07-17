Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74A2EDD7D;
	Fri, 17 Jul 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297854; cv=none; b=WdIeV1LwG0AAdr5oSSpBKewMoPJrh7OKjCeeXJbOl5K79yapycnkThfS1o5h9JP0sFSrroll2tcQ51fJl9xM+3Mem3cA7sYCHS1xkyf/PFiIJ8E+q43lf1jgdxbARKw6nCTkBxF+3lm31D2ziXJgIqI0zeVauT2sD/ZmGXtKnUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297854; c=relaxed/simple;
	bh=yQ7W60DLiP5tlafe2EPgPcBL8mrMUjKcoAI3a8PL4AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwa62cWA7lQAFtwbMGADijpVPQAyMjY6/gqZuEiZD5TvVXkSo9TRWEb34EaAuUpDIK1ofmDA1PIV7WRtmMk1N8DOFjSxq7p3mdlhksdwdFocvneqlJCEgw7m7TL/Z32bLtCrgGN7EJsuUzYZ1Uo2fMO7KFoWQgN5k5LjmujWmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHbIHiJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHbIHiJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8101F000E9;
	Fri, 17 Jul 2026 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784297853;
	bh=VIxX9V7ZlAsMS/XeKD1wi/ZYn+sJql2jlFMsVI+9BPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NHbIHiJ3lTzssQNHdOIzQJTQdEB38TrEtiK2yrcYfcOzlgTceZ+leLuT7FqXV6rOI
	 gsH3Xw/DRODI7bqEDiBYRi4TxjDwIFOLZOudv2GndE6GJhhMpNZPExHY4lDM2HO88V
	 DyGIUym4TcrjZ9UC4opoyWzF6nYSySk9V3eoQhDg=
Date: Fri, 17 Jul 2026 16:17:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH] char: mem: keep arch range checks overflow-safe
Message-ID: <2026071710-flanked-espresso-5b06@gregkh>
References: <20260625085800.4505-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625085800.4505-1-alhouseenyousef@gmail.com>

On Thu, Jun 25, 2026 at 10:58:00AM +0200, Yousef Alhouseen wrote:
> The generic /dev/mem physical range check now avoids validating
> addr + size directly, but ARM and SH provide their own
> valid_phys_addr_range() implementations with the same wrapped-addition
> pattern.
> 
> Use subtraction-based upper-bound checks in those overrides as well. Also
> make the ARM mmap pfn check avoid overflowing the pfn plus page-count
> expression.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  arch/arm/mm/mmap.c | 9 +++++++--
>  arch/sh/mm/mmap.c  | 4 +++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

This should be part of the char/mem patch, right?

thanks,

greg k-h
