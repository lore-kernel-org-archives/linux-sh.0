Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7813E0C66;
	Tue, 28 Apr 2026 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380938; cv=none; b=gfqkxeBveHIC+spFYBH9l6uTZnDyI5dSoNb6abnQRn/SKxts1E/Jenczv3nqIrM7MoAltyp8hcclvUcBVlAOKyHLXs5C95I7P0lTr64zsUqWs8P/Z1SfCuNDPjdRBipqICYsapYZCCdzg5sn59G5EBR0ikE8Na6CR0sV/X6z2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380938; c=relaxed/simple;
	bh=/9DQBGg+oIHEF7Z+Sj7T7b8Sm7+9IrrqIGJSYhKjNl4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MQdQjc6OUe9FB47938YjWjY98pNpYM6PF2gF9Thu4BlDI5jn6KXy5lTV/HQxbFnb0jXdb1PiMxB3mkKXZR9x7lj7Fz/gBfZYOWyZONHDifpBOwneVKfy/KZO89YRFrwjhOVJk+IHslzNwPodNRmq1nDYkSe5KFzPQwvBsvxZc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jIbqWkao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jIbqWkao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5AAC2BCAF;
	Tue, 28 Apr 2026 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777380936;
	bh=/9DQBGg+oIHEF7Z+Sj7T7b8Sm7+9IrrqIGJSYhKjNl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jIbqWkaokQIvuZsPRDPQLt4L2WTdGLiOpYdBVGmrl/QN1FOaEe2HdrK5yAY8VwfCd
	 fADHYshRi87nkp7mz3/Plobu3+MeVNGiIxUCl/a431r68koWYP3En8SeFlzGvAseaZ
	 QO6Nrto1N8fw5lJE6TxAqhxnq1sq1t39AC+f9j/U=
Date: Tue, 28 Apr 2026 05:55:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, Thomas
 Wei?schuh <thomas.weissschuh@linutronix.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
Message-Id: <20260428055535.0daa3699bb6ff62f03ff1edb@linux-foundation.org>
In-Reply-To: <92295dd525d946777e84269cff6e9a3f2f585286.camel@physik.fu-berlin.de>
References: <20260417103208.1217010-1-rppt@kernel.org>
	<30ff5e1e6c0c3d4e0fb3b6f36a5372ed6bf45d19.camel@physik.fu-berlin.de>
	<ef7d133aabff5ce58a91f0274f3ed05947c8aa48.camel@physik.fu-berlin.de>
	<aeNeKYwMJA3JXO8d@kernel.org>
	<92295dd525d946777e84269cff6e9a3f2f585286.camel@physik.fu-berlin.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 13:26:50 +0200 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> > > I just realized that this patch actually depends on 6215d9f4470f ("arch, mm:
> > > consolidate empty_zero_page"), so I cannot take it directly into my tree now.
> > > 
> > > Shall we wait for v7.0-rc1 then, so I can pick it up as a regression fix?
> >  
> > Or we can ask Andrew to pick it via mm tree.
> 
> Let me take it for v7.0-rc2, so I can take more time for testing the patch.

I put a copy of this into mm.git, so it goes into linux-next.
