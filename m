Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162B340283;
	Wed,  3 Jun 2026 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500740; cv=none; b=nu9PICZsmHnD/ODDnhB37SY6tumdoQ5ASQtpanlsAXk8cAY4OQSK/Ur5gVyqbnWkh5jrZH1HGWUuv8kuBpkl9vCH5HImtvORZyBf4UJkRvlDcD1OfBNAQgqtXklyC4eEdHUW8ZFoFU4tzJgvq2MiYq7P/R9YtYihC+6gpF4h6nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500740; c=relaxed/simple;
	bh=tyAIvgSCI5di8rxEwaU1ov8z/y8T9sHSjLBenwVTA54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up/uLL4zik+qlxTOdPR26nFfFJKpfn90KgyFj65CyNTrFukEtynXj9ykcRzHFyK9MO/187NAOB8sYHXX9NKxFd/aIaxWJ7ajSz9RskvA6XEE1lPV0wVPVUfJX/iLGcMKiRZxddQbwANegdTy6NJpvwv57qnsfykC+0wYkrd7zHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBjAKwNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBjAKwNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D931F00893;
	Wed,  3 Jun 2026 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780500739;
	bh=phx5JcnRqGG29OmuItoF1MyG6kbDGtyE55/LgSKTFQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NBjAKwNWWkdXPnLE43ZMJidLUxB8XdsOO9xqQnl/3aN33mYlvXyBD3L40D4TN8vtn
	 uPM7V5kP1pgyDn6pqyCu6K1Zbb3c7r/VoZNKKqc1/WQpvjiMSG0K51pcZ31ROU4/dx
	 dO3AgiJK+1ObA9c/0zQEDY7f/1YZet57+UbbHYGe1KwCSMV5UAJ5iutGFModUrXm8a
	 pGAozlH4yewc0IpBUO2V4JFgBEjRMrJxIsr00TrJ/tB+cCuNC+DVasC+GdC4Q1xZm7
	 dMpCDpG9dqVLnCzUSC6/n+bfeSP8W6sBWZdD+XIXyO6dqqAIpw+7PiOTGYg9mq8AzP
	 D1rxX8HCPL/BA==
Date: Wed, 3 Jun 2026 18:32:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/10] sh: remove NUMA and SPARSEMEM support
Message-ID: <aiBI_QEmeVSBb2HY@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
 <agr7XvoWn_-axX1-@kernel.org>
 <adb1db8d1fbb9d219fa041776ae863aa2fc09270.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb1db8d1fbb9d219fa041776ae863aa2fc09270.camel@physik.fu-berlin.de>

Hi Adrian,

On Mon, May 18, 2026 at 02:05:39PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Mike,
> 
> On Mon, 2026-05-18 at 14:43 +0300, Mike Rapoport wrote:
> > Gentle ping?
> 
> It's on my TODO list for this week!

It's sad to see this being dragged since mid April (if we count v1 and
there were really minor changes in v2).

If you don't have time to take care of that, just say so and we'll take
this via one of the mm trees in the next cycle.
 
> Adrian

-- 
Sincerely yours,
Mike.
