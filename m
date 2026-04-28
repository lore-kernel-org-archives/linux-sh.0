Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EC3B7778;
	Tue, 28 Apr 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388512; cv=none; b=nuspvf7J5J4KOhJQnGE7cT7RlIEaEaOOnmOVcj8mfMkumMERaBGx6L5UkArvN/xtfgCZBL0mf5+g+WGyDkRmavg9CATDP8hk5zH8di24XGaBEZl/cDL8matFExrdWAfJqbc2rF7Tn+jaZBvwga6KCdsg6wU8u+qtNWE+H3Wx++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388512; c=relaxed/simple;
	bh=9V1bLTn1vWOQVsqBgRHz2cCJNHH/Y3+OWVbtf5Gd5s4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bgj0mv3OxabWo3m7SGG8VVMI4FGhpjTmxABKnnifq/OnHlbcK2PnEmxg7W7fKetWUW5vHeE0805ko7Frnv6ZvnYSb+acS7V4NNbxcuQtt9RV9kpUT4zzLIUt87WCI8f1YF5mzLKcFK47VqlirsvSieMNX+K9rD6O5Bk6zGzc0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y0OPnVAw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="y0OPnVAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55643C2BCAF;
	Tue, 28 Apr 2026 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777388511;
	bh=9V1bLTn1vWOQVsqBgRHz2cCJNHH/Y3+OWVbtf5Gd5s4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=y0OPnVAwlg4IcQzrn23U81NbTCK5jLokkm7KQkdWWkFvT+szYqryMFm9gI2WVEjOj
	 0nXsA2Cl60vUigAjkzuJMh5rKc+/VnLM4I/90jw2XPEVyqo2cjg1AIteklB507M+En
	 zd3OWP26e0Rzv4SznuG6hs8m2E9uSpt2X4t7kp1w=
Date: Tue, 28 Apr 2026 08:01:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, Thomas
 Wei?schuh <thomas.weissschuh@linutronix.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
Message-Id: <20260428080150.d9c0a60947aa3db4a2b87071@linux-foundation.org>
In-Reply-To: <99cdbec216d678e714ae14024e62d9ffcbab6d90.camel@physik.fu-berlin.de>
References: <20260417103208.1217010-1-rppt@kernel.org>
	<30ff5e1e6c0c3d4e0fb3b6f36a5372ed6bf45d19.camel@physik.fu-berlin.de>
	<ef7d133aabff5ce58a91f0274f3ed05947c8aa48.camel@physik.fu-berlin.de>
	<aeNeKYwMJA3JXO8d@kernel.org>
	<92295dd525d946777e84269cff6e9a3f2f585286.camel@physik.fu-berlin.de>
	<20260428055535.0daa3699bb6ff62f03ff1edb@linux-foundation.org>
	<99cdbec216d678e714ae14024e62d9ffcbab6d90.camel@physik.fu-berlin.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 15:20:21 +0200 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> On Tue, 2026-04-28 at 05:55 -0700, Andrew Morton wrote:
> > On Sat, 18 Apr 2026 13:26:50 +0200 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
> > 
> > > > > I just realized that this patch actually depends on 6215d9f4470f ("arch, mm:
> > > > > consolidate empty_zero_page"), so I cannot take it directly into my tree now.
> > > > > 
> > > > > Shall we wait for v7.0-rc1 then, so I can pick it up as a regression fix?
> > > >  
> > > > Or we can ask Andrew to pick it via mm tree.
> > > 
> > > Let me take it for v7.0-rc2, so I can take more time for testing the patch.
> > 
> > I put a copy of this into mm.git, so it goes into linux-next.
> 
> Erhm, I wanted to merge it myself being the SH maintainer.
> 

Yep, I saw that.  I wanted to unbreak linux-next.

If/when this turns up in -next I'll drop the mm.git copy.

