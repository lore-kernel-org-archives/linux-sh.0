Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB013F58D6;
	Wed,  7 Oct 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406684; cv=none; b=AvIjKrXrxe09jtcfDLF7TMHp6d4nChy6+mJKrgxR1kU0wj+ceSlFnaEuzgdhRES2EwfH1oX2/EnLVANekJ+D5YmvXDfYjUN/hIdjUS5uDyDZRcbLzXAstZiRugh/JMPXMCLl5EggCXaxLuXd4vMnnj1wtmlPn174D1speC9Hw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406684; c=relaxed/simple;
	bh=JeEYZGdbDljhK8XnvOrGfNfb4vHoy86+Rfnu6ygkMbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7RtERiLKTfjFHHIiSBZTOYeiwxcuLBQVdGBRep+/eOzObRk7olvMteSKMCBL3i826gpwWnL+YseVjaaLRWsGpEb3ihWa43pPdnczkPlwL+CxxzxH+vG4M76U9M3ThtCdU+YJcbw9q4KBwXSXqN5zUmTvOO3Dpzt2ZUrU/00xxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HByuxuIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HByuxuIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DDA1F000FF;
	Wed,  7 Oct 2026 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406682;
	bh=6WxyqvyYSdNPTbBnLGG14anOKtdEuM+bt5bLe2BRv/U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=HByuxuIYdD0nrKhEN3T8KubjGIVh+9+9FPiSbMap0x9GIioYdwZzlOSOlKodojh1b
	 ZjMQzfKu0aVfglRPfdyAYYlX8Cggi73TTJKthD4i2A2jBgKGpGfO8NAGbieAZc6/XC
	 g80+Hi6+kzIBF50YjuMA4URcS/qormUTw+Mz3gJxVsdWLaSne3yO0AiQ4VKx0ABJhl
	 KjvRhIU3M1JNIh9hXGOVb8sw1qXKDlwuaDzRl8cD3dK837P4z8nVsTyUO10uc5sEQ3
	 EPyx1+5Nwnm73vwASMCobzSx6cmC6EvDVo1wbCQG2kJDt5Z+XpIh206TmeLOVOeHyU
	 jQZCoJ/mWhL9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36375CE0D79; Wed,  7 Oct 2026 13:58:02 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:58:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	Guo Ren <guoren@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/5] ARC: Emulate two-byte cmpxchg
Message-ID: <708d744f-08a5-46b7-8c37-c227a0f3be73@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
 <20261007203636.1982188-3-paulmck@kernel.org>
 <40f3c095-4202-4d2b-93e3-376a231d4fe8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f3c095-4202-4d2b-93e3-376a231d4fe8@kernel.org>

On Wed, Oct 07, 2026 at 10:48:39PM +0200, Vineet Gupta wrote:
> On 10/7/26 22:36, Paul E. McKenney wrote:
> > From: Bradley Morgan <brads@mainlining.org>
> > 
> > ARC has no two-byte atomic compare and swap, so the
> > arch_cmpxchg_relaxed() macro switch lets case 2 fall through to
> > BUILD_BUG() via default, and a two-byte cmpxchg() fails the build.
> > 
> > Route case 2 through the new cmpxchg_emu_u16(), which narrows the
> > old and new values itself, so the dispatch keeps the (uintptr_t)
> > casts the case 1 path already uses.
> > 
> > The sizeof(*(_p_)) fix that v4 folded in here landed separately
> > through Vineet's f050c3e61d2a, so this patch is now only the
> > case 2 wiring.
> > 
> > Signed-off-by: Bradley Morgan <brads@mainlining.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Vineet Gupta <vgupta@kernel.org>

Thank you!  I will apply this on my next rebase.  Unless something breaks,
I will include this in my pull request for the upcoming merge window.

							Thanx, Paul

> Thx,
> -Vineet
> 
> > ---
> >   arch/arc/include/asm/cmpxchg.h | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> > index 76f43db0890fc..7157718f147c1 100644
> > --- a/arch/arc/include/asm/cmpxchg.h
> > +++ b/arch/arc/include/asm/cmpxchg.h
> > @@ -50,6 +50,9 @@
> >   	case 1:								\
> >   		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> >   		break;							\
> > +	case 2:								\
> > +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, (unsigned long)_o_, (unsigned long)_n_);	\
> > +		break;							\
> >   	case 4:								\
> >   		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
> >   		break;							\
> 
