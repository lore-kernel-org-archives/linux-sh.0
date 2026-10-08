Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC94A0919;
	Thu,  8 Oct 2026 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473882; cv=none; b=QuOqdW9GlK0Tx7s4FmcsNsoYidla2rmeeBPG4TVyzvNFGsXrI2CME1tUwfTL7RSs/idMnDUBMI7HrAylVn6tsA9mYY2A7T/+wLCDhhO8dyIU6ZngkS2zdp9vEUJyoey6AYEFM1CG+OyFvSGt8MfG0Bv5bdxa+h7wZ6YMWS9xJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473882; c=relaxed/simple;
	bh=wNsI6BIbsFDmQ20Vb2iU9k+rDnX8fhCuvI0qtQ+2r0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxJ1KGXtUz7iptp+3PqDxSoRH5nq5PC4jm33digtKfqU/M+uQA3UBAlu8cbnJC+ME5Xm/S9RdgYxtsjSsZtPKDU+XzwLhibIyFythb5gbvhIEbTY7ChJBjBvnsENNle6mVTUIEFJjozSTsOdWfN/PoX464jibseuk5Ex5JsNgiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2iU6EW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2iU6EW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F91F000FF;
	Thu,  8 Oct 2026 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791473880;
	bh=ie7wR03RucgsB/jgJe4FU0Vwspb7ELUKAMZ57zUu0sE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=G2iU6EW9EFIllbh3aVrRfKKXqDkxcF0TBv8st/BCo5pUJAfjqVKnOh+mEdtx0NjMM
	 HBQ2SnVVFaLMu9fJOL0SZDdrfY5C5l58muGuiGZJHy+UQJf3WXP5TlcGZAWe7qZ6fB
	 tujJGNSQUFY4tn1VoF0TTGgvOUckabbBFRTMGHPwOJKXVt+5+ouB8MxfOFwqdxBjC5
	 eP/YzTcBkWvWjGKYh2RJORIQS4fLIi68PbaalWWLpUBFQ9h72DYG7inT3EIqZc58PK
	 aWlDl9WvG5RL0sxFslbBc9eITx/iTfTIp6z9o8sWVw3ZhfXXJjuw4SEh0QXGKIbF/h
	 uQI2iYoJauGTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48E57CE399B; Thu,  8 Oct 2026 08:38:00 -0700 (PDT)
Date: Thu, 8 Oct 2026 08:38:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-sh@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/5] csky: Emulate two-byte cmpxchg
Message-ID: <f4e71ae2-e97e-4667-8d97-bcdab56caf86@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
 <20261007203636.1982188-4-paulmck@kernel.org>
 <CAJF2gTQbbPAdjS3p3oMoCGdkBWFM3Hx5+JnCu=9hdXuPQaM5Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQbbPAdjS3p3oMoCGdkBWFM3Hx5+JnCu=9hdXuPQaM5Zg@mail.gmail.com>

On Thu, Oct 08, 2026 at 01:54:57PM +0800, Guo Ren wrote:
> On Thu, Oct 8, 2026 at 4:36 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > From: Bradley Morgan <brads@mainlining.org>
> >
> > C-SKY has no two-byte atomic compare and swap, so the __cmpxchg()
> > macros let case 2 fall through to BUILD_BUG() via default, and a
> > two-byte cmpxchg() fails the build.
> >
> > Route case 2 through the new cmpxchg_emu_u16(), which narrows the
> > old and new values itself, so all three orderings, relaxed, acquire
> > and full, keep the (uintptr_t) casts the case 1 path already uses.
> >
> > Signed-off-by: Bradley Morgan <brads@mainlining.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  arch/csky/include/asm/cmpxchg.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
> > index db6dda47184e4..6f3ca79e54acf 100644
> > --- a/arch/csky/include/asm/cmpxchg.h
> > +++ b/arch/csky/include/asm/cmpxchg.h
> > @@ -64,6 +64,9 @@
> >         switch (size) {                                         \
> >         case 1:                                                 \
> >                 __ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> > +               break;                                                  \
> > +       case 2:                                                 \
> > +               __ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
> >                 break;                                          \
> >         case 4:                                                 \
> >                 asm volatile (                                  \
> > @@ -97,6 +100,9 @@
> >         switch (size) {                                         \
> >         case 1:                                                 \
> >                 __ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> > +               break;                                                  \
> > +       case 2:                                                 \
> > +               __ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
> >                 break;                                          \
> >         case 4:                                                 \
> >                 asm volatile (                                  \
> > @@ -131,6 +137,9 @@
> >         switch (size) {                                         \
> >         case 1:                                                 \
> >                 __ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> > +               break;                                                  \
> > +       case 2:                                                 \
> > +               __ret = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *)__ptr, (unsigned long)__old, (unsigned long)__new); \
> LGTM!
> 
> Acked-by: GUO Ren <guoren@kernel.org>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

> >                 break;                                          \
> >         case 4:                                                 \
> >                 asm volatile (                                  \
> > --
> > 2.40.1
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
