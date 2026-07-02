Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0C431E49;
	Thu,  2 Jul 2026 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987613; cv=none; b=jjcoBg/65DnBNY0QU4fLidS1PjmYcNkhSHzVmlIsgTzFtsIbEOl5eeSu4z0e1hKWFhLKBXsqFy6BP2xLNJrRPhjgwW08yksjGmKZF3b9cusy/IamebUg5fkuI2eBWdlfSD7poEi/n95EEdscrShvqwuFqnICWGFWFoV1v7CVWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987613; c=relaxed/simple;
	bh=l1ov2uWXFVUE/dLkZ4L3k2S2CNWqLTmvpem6e2KASRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cosZ9QlBNMMrBtF0qS88JnVm3NbTDSwx4v4qBzJncmle/Ri9IxKWvOmxfRSh9B/piWT5yAAdU1/m+F1HXS6RnXe/EKKiml4pbAdauzP4CahMzpMeOpTBk+RIBMQsd/mVuHYqtzuw3210zQlXQx63ES9tYCeOqSboY6LD8TeHmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqGFU+4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqGFU+4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43EC1F000E9;
	Thu,  2 Jul 2026 10:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987611;
	bh=1/Z5IR9o47zjVjCxsK5ODNW9RNRvUPJ+a8vvLMhHT7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SqGFU+4M5D7r8LizA9EwVSOvmB/b+FrnvSxRNptKl4cPnJ4bEpRXifDka+zJiiaby
	 b8HuX66jnOJmIQUY8JxBR7dFu0gC1WPK3iySWOufUq5bCtUKmHcZY30diSlFBeqZn6
	 2iED0za1rllzf2G1675xS4cC8lpfzmhvrVhmq9jyi6dAV0+Et0E7QOfGBCnWihLOUl
	 EfZotzFHTlAg3G41YLeGNRlX4kQ+ksllasK6ytmJ4WgXQzMSCu8LGc9sGdk/2xTZkc
	 RaJeRVRiSc8C3RYmroCfv7vfyd3RSok7G2q1Rf+Rce53jYvuOHOIL5SeKY6Ez5N/yH
	 Tr6zK5RLjRJLw==
Date: Thu, 2 Jul 2026 13:20:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/10] sh: remove NUMA and SPARSEMEM support
Message-ID: <akY7VSgIhorP54vh@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
 <fe0e2ca854db64b1bb169ce47aaa2ce1e796b023.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0e2ca854db64b1bb169ce47aaa2ce1e796b023.camel@physik.fu-berlin.de>

Hi Adrian,

On Thu, Jul 02, 2026 at 11:54:59AM +0200, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Thu, 2026-07-02 at 12:37 +0300, Mike Rapoport (Microsoft) wrote:
> > Hi,
> > 
> > NUMA support for SuperH was introduced a long time ago by commit
> > b241cb0c885e ("sh: Support for multiple nodes.")
> > 
> >         "... for boards with many different memory blocks that are
> >          otherwise unused (SH7722/SH7785 URAM and so forth)"
> > 
> > In reality, this added 128K of memory on sh7722 and sh7785 and 256K on
> > shx3 at the expense of all the NUMA related code in the kernel.
> > 
> > For build of v7.0-rc7 with defconfig and the same configuration with
> > CONFIG_NUMA disabled, bloat-o-meter reports difference of ~76k. Disabling
> > CONFIG_SPARSMEM on top increases the difference to ~94k. And that's only
> > overhead in code and static data that does not take into the account data
> > structures allocated at run time.
> > 
> > And all this overhead has been there for nothing for almost 8 years
> > because since commit ac21fc2dcb40 ("sh: switch to NO_BOOTMEM")
> > those additional "nodes" could not be used by the core MM because the
> > maximal pfn for ZONE_NORMAL was cut out at the end of the normal memory.
> > 
> > ---
> > It's been another few weeks without updates from Adrian and I don't see
> > why it should wait more.
> > 
> > @Andrew, please take it to the mm tree.
> 
> I feel like this is an attempt to force me to give up as a maintainer.

This isn't an attempt to force you to give up, this is an attempt to merge
patches that have been out there for long time.

They are related to mm because we are talking about mm features. And it is
long standing practice that Andrew takes patches that fall between the
cracks.

v1 went out in the middle of April, there were no comments at all from you
almost for a month and I sent v2 on May 10th.

We are in July now, so this is definitely falling between the cracks.
 
> Otherwise, I can't really understand why you are building up so much
> pressure for a niche and hobbyist architecture

By pressure you mean an email in a few weeks?!

This isn't about sh, this is about reducing NUMA and SPARSEMEM_STATIC
footprint to ease the maintenance.

A niche and hobbyist architecture does not need NUMA and SPARSEMEM.
And for sh particularly they should have not be enabled at the first place.
 
> Adrian

-- 
Sincerely yours,
Mike.
