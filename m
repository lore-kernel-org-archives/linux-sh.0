Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5825771;
	Sat, 18 Apr 2026 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776508464; cv=none; b=ONbTDWUBF7tpRsdsaliAMOpjmRJytAIgQyY8MYJx8kk/AfNgiHNZoqhZfJVXsIFULPHE1aZdRJWKcGMUrOvypkYqylRDbywNt4WtAVoKxgQNTlSTj302F0Np4Jj14D/skaRPOHqsNq9JgWfcHI/sKGEMK4GweGt+s6hDHcweNkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776508464; c=relaxed/simple;
	bh=+XNzGHp2P97lxakQsIs+TheunR6hG0xNXtVq2RNDATU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIuJ7TPOk6gFH5lrSPwB36mzeWGrx/Jau+M/1AXjO/wk8X02kF8PeUEprYDp1kbtpBI3elupVCIDZZht+g/mQZ1iGfjHJEMahzua20gJSSSGO6mBgDQ9BNPS9CwMZtZcq8/1XumZtURW3mRSJuk+NQt9aSqIt1Pu+7PlN2ceV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyBC/6MG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyBC/6MG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829FEC19424;
	Sat, 18 Apr 2026 10:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776508464;
	bh=+XNzGHp2P97lxakQsIs+TheunR6hG0xNXtVq2RNDATU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyBC/6MGS7D6Ca4pdK2lXn+if77iAvUjJtDoE6zKJt7SA0KHahRamAS6ei+Q21Iv8
	 jrDBVLFUESwqGptdcsb3eYIK4v8JOQh7/lIw2pI9QpRz5jpFYw2fEFHfbgf7z1tA2t
	 6jcewZd4zPhJsf1PggJEve1Rz0QnhiSiqRzBSGyihLO4dgA/xE8+SwPR38GbUPt5cD
	 XrV3zA2MEi6vwxn7oFo5mTQ4zUr9ohpHhK6j1rSUjqoXsJL+7eMRV3pPnnDiuhDx/I
	 7/6/oq0X5d65O9N3gwpe2Pqw87rCnplCu6x4B9e65MtJFaP2HeOI2QMN9Zg04Cd6Iz
	 FCRyOQU9C9RdQ==
Date: Sat, 18 Apr 2026 13:34:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rich Felker <dalias@libc.org>,
	Thomas Wei?schuh <thomas.weissschuh@linutronix.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
Message-ID: <aeNeKYwMJA3JXO8d@kernel.org>
References: <20260417103208.1217010-1-rppt@kernel.org>
 <30ff5e1e6c0c3d4e0fb3b6f36a5372ed6bf45d19.camel@physik.fu-berlin.de>
 <ef7d133aabff5ce58a91f0274f3ed05947c8aa48.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7d133aabff5ce58a91f0274f3ed05947c8aa48.camel@physik.fu-berlin.de>

Hi Adrian,

On Sat, Apr 18, 2026 at 10:33:56AM +0200, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-04-17 at 12:56 +0200, John Paul Adrian Glaubitz wrote:
> > > 
> > > base-commit: 43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9
> > 
> > Thanks, I'll try to test this patch this weekend and will pick it up for v7.1.
> > I have already collected a number of patches for v7.1 with my Reviewed-by.
> 
> I just realized that this patch actually depends on 6215d9f4470f ("arch, mm:
> consolidate empty_zero_page"), so I cannot take it directly into my tree now.
> 
> Shall we wait for v7.0-rc1 then, so I can pick it up as a regression fix?
 
Or we can ask Andrew to pick it via mm tree.

> Thanks,
> Adrian

-- 
Sincerely yours,
Mike.
