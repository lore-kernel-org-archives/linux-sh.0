Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03B3955E5;
	Sun, 14 Jun 2026 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781433236; cv=none; b=t9pcoPgoIGU7UicjX8xuJiDqrcmdrCaF4i0htV7WBYbG1hEdcx1qdZsHLLJA0yLJP07O32Jfs41REKBl5e0ViqauyKzZ+RXoY/b823NTJ3xTQ2HC+CqeEg73OTy8YUP2RM2ByPXnbu3K5EvOzFyZOTH95gbUNwM0s8Wr8UClZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781433236; c=relaxed/simple;
	bh=7yCTHQvaHgTR9R09RzhiFDRkvW0mVPNNaN8Ar5I4NqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZRD4648F82bJfljOVYY5j78BRfp/fE409i7gtTzhtrrcfRGqTNgxlkuB9qzVm/9ARhhtxVGgD2YcgA2/gR/xXAAMBX7/PICLd6qtcTGowwO1jku0bGG+woDvWvJ6rdaI69PC8By6W0OegPmAFOKDH9D3xGcfBuUtsguBDO/ngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4O033mF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4O033mF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD01F000E9;
	Sun, 14 Jun 2026 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781433233;
	bh=fNZGt5jAdvGJ9FE8m2dMOVkQl0H6oyUWqUmCHO4bEDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D4O033mFlKeba1PLOGOiRmaKT0HE5hCywAb2SmHaWTLg7Si9bZXSFsGSHQ2W5zmqQ
	 ys03YqOtdxF4fiW61Q7KcV8HbOnyBKxBgn95LV/qvejr8YcPGFLfykFMYKao9DmxIh
	 QSmkssstKxU22KEdn6XIPYm8omxvYWxxIVeh31P5IMP6p93MOWrlHgBD/00hQSuS+4
	 8u/nCwXfb4s7Lr/quIEefgn3MuMlBtPNP57E34hRse3Dzti0yLPt/ngnQOhg+UDG+w
	 zT5HCGNe7QMMaCdgWcJRrG6ut0rmGxAbJds9ctsWLOSmxhHdR+0u0H4buLOVBx3nkg
	 mMyv6PUIGqE2g==
Date: Sun, 14 Jun 2026 13:33:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 00/10] sh: remove NUMA and SPARSEMEM support
Message-ID: <ai6Diz0UgSGccbhY@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
 <agr7XvoWn_-axX1-@kernel.org>
 <adb1db8d1fbb9d219fa041776ae863aa2fc09270.camel@physik.fu-berlin.de>
 <aiBI_QEmeVSBb2HY@kernel.org>
 <865aaa7aa64ab69ca9020d64d86baa8d9b700bcb.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865aaa7aa64ab69ca9020d64d86baa8d9b700bcb.camel@physik.fu-berlin.de>

Hi Adrian,

On Tue, Jun 09, 2026 at 09:21:37AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Mike,
> 
> On Wed, 2026-06-03 at 18:32 +0300, Mike Rapoport wrote:
> > On Mon, May 18, 2026 at 02:05:39PM +0200, John Paul Adrian Glaubitz wrote:
> > > Hi Mike,
> > > 
> > > On Mon, 2026-05-18 at 14:43 +0300, Mike Rapoport wrote:
> > > > Gentle ping?
> > > 
> > > It's on my TODO list for this week!
> > 
> > It's sad to see this being dragged since mid April (if we count v1 and
> > there were really minor changes in v2).
> 
> I apologize. I am doing the maintenance as a hobby in my free time, it's
> not my primary job and it can sometimes take me a bit longer to take up
> changes.
>
> > If you don't have time to take care of that, just say so and we'll take
> > this via one of the mm trees in the next cycle.
> 
> It should be better this week. I've been recently busy with CVE fixes during
> my dayjob and the workload was extremely high.
> 
> I am not going to let this slip, don't worry. It's just been a bit too much
> stress the past weeks due to the AI CVE reporting.

I understand that this is a hobby for you and there are a day job and other
obligations and you don't have time for timely responses for arch/sh
patches.
 
I just don't understand why do you insist on taking this via sh tree given
you don't have the resources to timely deal with the patches.

This set can perfectly go via mm tree as it cleanups a memory management
feature that should not have been added to sh at the first place.
 
> Adrian

-- 
Sincerely yours,
Mike.
