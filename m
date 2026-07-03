Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC468331ECD;
	Fri,  3 Jul 2026 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059406; cv=none; b=u4UaFTuntFp31N2y+l6XQgG7Vn0ssWkHMuqYxALK8eI/FSLrAcSoJzHH1Mjd5KFyddvJ5GEGptRWbOF2A0V/I7EBlF5E1qeDUl3xOZQca9dmdR0n0Ty5oPuFBzyCgDpQ0zaPwb5WvSSTY2mgDH4jl/64SZC+aYuHzVCTF8CD/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059406; c=relaxed/simple;
	bh=K3XKmzfG7U56TWp/AwPZk1YQfFMpM4tVk0iMGMS9MJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxee3i713s7z4QzxYgsor2axk65WgeTaprDSxctDIwXqtKxails+jnecQbJTNQUo/l5RP1+3wykD7Tc/h3ZUaRENZp2TqUQWMwkZw4FQNzH6HZH89mG+VGGbFjUPmjQGehlc086tE6aoMgMxegc1n/KAWUDAxDEas8dWx64Y+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eikfK/WR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eikfK/WR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49BE1F000E9;
	Fri,  3 Jul 2026 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059405;
	bh=i1VdzkvxjcNef3On+ZEjzz2EDquI+okMGLXMK9XiBFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eikfK/WRMW1shSu7Vfe5dev3QsRjEOBjj0z1KEjlVI2LphWAt7BZWWJ/AcUy0/Htz
	 vb+BU8hD2fihc/CDag80L3VoXn2ci/MB+k9ec96BWtTsOy2EOM6zbpCP7x1wlAO2WQ
	 CmPDUXNI+vO8nnRYBX7Lp3jVO2elXZ1isI4uIc0yXSaRT/QojByRyO06itkZawo0mm
	 pdGEj5T3d55tZQAbssqygdzyzCg3uDhIKP3BAJXlMhXCe3m3rl/dbGkl1L0kkAeFwO
	 qSzQ+G0TzzKLoA1MWaljllceMdQ9uKMz4JGn4U3Cz4WERn4qhRcCDdd9lL2mWLB4FX
	 2dbGLzK/YIivA==
Date: Fri, 3 Jul 2026 09:16:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/10] sh: remove NUMA and SPARSEMEM support
Message-ID: <akdTxsulVwWP0jgF@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
 <fe0e2ca854db64b1bb169ce47aaa2ce1e796b023.camel@physik.fu-berlin.de>
 <akY7VSgIhorP54vh@kernel.org>
 <eab1aaff6f37089d46401059ad7ff056aa5195c1.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab1aaff6f37089d46401059ad7ff056aa5195c1.camel@physik.fu-berlin.de>

Hi Adrian,

On Thu, Jul 02, 2026 at 12:25:47PM +0200, John Paul Adrian Glaubitz wrote:
> Hello Mike,
> 
> On Thu, 2026-07-02 at 13:20 +0300, Mike Rapoport wrote:
> > > I feel like this is an attempt to force me to give up as a maintainer.
> > 
> > This isn't an attempt to force you to give up, this is an attempt to merge
> > patches that have been out there for long time.
> 
> You posted these patches the first time in April. This isn't a long time.

It is by mm standards.
 
> > This isn't about sh, this is about reducing NUMA and SPARSEMEM_STATIC
> > footprint to ease the maintenance.
> 
> Yes, and I will eventually pick up those patches to rectify this.

Why do you insist that these patches must go via sh-linux tree?

If you don't have time right now because of other commitments, Andrew is
here to help in exactly these cases: let patches move upstream when a
subsystem maintainer is too overloaded.
 
> Adrian

-- 
Sincerely yours,
Mike.
