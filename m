Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC62222CC;
	Thu, 23 Apr 2026 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956287; cv=none; b=cJfVqtI/KvJ68D6RwjQik1hQx1xhXWzRZ2ARQiSJzdWBwU05aeqJQgdVjvXiNI17Icuni1ERN3gXhLuAWX4OTZFY0K3G68brkf/yEqVBHN1XSubKGq1P0Eb1nTjSIHoeVkOGrnmrtGWidCn389/kvtMWSfFC8dyRjbBn5LBMF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956287; c=relaxed/simple;
	bh=IHN068CgpuQMMzCWxJhv3EPO4opZ9mkJtDUoyjSbtR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejO+oYkeKbi0hoUD85G07ErXCS8ucnd5x798Os0q8diJBjAqah055k+trvl2upagJ6INCsLeL5YF1daP4Xf38R/RCi1bKjUFdCyiBYGsCRfmbkolBdJKKQnjnLXS6am8E4zIjLU4s3eHs/SiDSBAxrKWlNDZX1bKXNNmTx1iCUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=grJ4XTFk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="grJ4XTFk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V2+fKH8cfcnGaIWyfr1LOPlVfwYoDzH/Ub08ksZxm2Q=; b=grJ4XTFknIX2ExW4F9BdSIB3XW
	Dku5Rn+0mC3JTd2W7uBxu6X5lblhC12/EOtpAvgU6XerJ91UIC1E0eNaWWfujjaZzb4lVlLRE6GgQ
	5NTagWAYlBUcnKtlyOAQJTcb/pwppTKy8+y0YvWN5nsrcQpmRIALKodsDoKpoz/92IIi+rfSUEzzy
	Lg822GbzrjHkwuygnWO24+cZEHQwZuUfHY3hhg1UWfUf36B3Ywa4D+QgptCdx/7MSdr/GpVJr4Yrk
	QUOKwXfE30KQA0zfH4XsQ4SYM0EM49cYCwmhotwubMuC5CMh/S9iXrD3UeKMCnO4ev535khgLXnGn
	bKni/MGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFvV9-0000000Dd2X-2dWA;
	Thu, 23 Apr 2026 14:57:59 +0000
Date: Thu, 23 Apr 2026 15:57:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sh: cache: remove unused but set variables in
 sh4_flush_cache_range
Message-ID: <aeozdx1V_A1vkWzY@casper.infradead.org>
References: <20260423145301.245374-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423145301.245374-4-thorsten.blum@linux.dev>

On Thu, Apr 23, 2026 at 04:53:01PM +0200, Thorsten Blum wrote:
> Remove 'start' and 'end' to avoid two "variable set but not used"
> warnings triggered by -Wunused-but-set-variable.

Looks like the actual uses of them were removed in 654d364e26c7.  2009!
