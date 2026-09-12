Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537441E6DB
	for <linux-sh@vger.kernel.org>; Sat, 12 Sep 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789205457; cv=none; b=mf/DCaYBj9SkxwLvAKz1xLHp6DPccZNE/V27HSvTiNfKvVQS5PXzSgbGygDeYPZsknMe6Wpl2KkhNjTTYYAQUR2oH8q+lyMx6uhnm1Z36mBDsd7H4lUkzC6nRhSmNprprJgQFtys28NnmPR/aRYtwbwMOSWvWD8YFNwKu1t/GdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789205457; c=relaxed/simple;
	bh=JFkNJfIWl4JBPhtIiMKJsDFXpmdvhj7ZI5ApqqlkfAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yrxf6BVElSvaW+hBlfcC7esrcPoTtmtBmhwZBhkUd+j4+Mt3mdPdyNmW4vLbT2Z363YpbYAdmxb2Og9gcPX2LXNF4yZc2cknmXoh17J8xIZqxoQdFW9hnDE3QYSv40yA4urbg8kJB2EjmagCUQulCxO+/NxI/Uqfmyggs77fqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2fsXHiu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2fsXHiu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso7742285e9.2
        for <linux-sh@vger.kernel.org>; Sat, 12 Sep 2026 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789205449; x=1789810249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wIDaovYKooHqH78d/6XZ6tf1fVeqSDWOw5EQD+FAKCk=;
        b=Q2fsXHiukvnErotvdp8NVy6d8RV4/YZJCAqJyxu5qGJKDuzNNe5rPzUCLU8QT7RZs2
         bF+3ujmUnzXiDykLXUCDstyPmSpP+oBVos8pcXz7O9GbCq768nQE8CWTaiDLFUEvMOPq
         k5q2Bk0flpD8RBEd1ahQan5JvbOS3/mMRquT8BujuAOltom+uAMLwKh9/hWxdgpSr2nC
         biptUkQmVq90XJGr7q4rVjCME9FAAOnmx3dWcq9rywP51Cx8qKjUKp2j4p1WhTgGMXED
         Oz9gLam4h1S2cPxHZZXko/2MMEJ/azzGRey9y46+U1TB3pjCeT9w/wHx0zK8mJfr/Yih
         s/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789205449; x=1789810249;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIDaovYKooHqH78d/6XZ6tf1fVeqSDWOw5EQD+FAKCk=;
        b=njiTgCGbIeF6HgzosUqO8HmdoD2o7L2BlK3PeUMwe9ESQUgbas5pGdYW/smAbawAKD
         fe6vn6NkMUwQiG2CDXAvVnFTd0RjCceWApAZnHZJjb4MniNaqJzjHnv/OCj8LP8KFbP1
         PMOLnXWsBmJJOaeHd2L+PQN1WzT5b+i6K7jLAd+s3qHyMFXFKXHtOfYREjeiW5KqerJ+
         pjsk1sVm0uWUKJAL5aV+NyiLugBpNBC4vBP/aHwvNHd7jIpKH7j9dnub1zaGcoCUxO0E
         GQkid++aGJxmojOoFj4i7Uc91yoQAcKV+ozhf37zzGQTF8ZBy+dTGWHEeTIe0NhYqChA
         9KEA==
X-Forwarded-Encrypted: i=1; AKwUvBwF8jeZo+fWd+h98fC6bG59RHpQ6McUYBPtCBwErwLsOpi6gVVagZjSv/JrDuWWjg0QXI4YM5GCeQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kQgYRaRWLoLedYNDUIz3AS1phidPXS6K9+iBpodSNNjbzXVSJB
	yn5GIq8nkdpV7MZYgWfkaOLT8Ky5cSUsx2uImHwhgrtLCEEUczwf2gaV
X-Gm-Gg: AYBFou3Y/kXhlcEbOYTHarXr0UBNGzdEryGn7UsUUeY9PfX0lShvyHgNCPgu5S3/e98
	JAeO3NsvYSlDUBgyk6dh6JlrLPvLEOHmaIMdv6vapAmyN011jTh3bh6UMLfDNuS7FXAgNK52tCp
	PZC97yBT5g0k+eV4llgf/1yr+ic+hd6H2TeupPepWNmSvThE6V6peFTHYe2coW99rFv8MeHHYSE
	eC++y6SxRuir/ZhaK8/D+OvWnLEJPGePpls0fCzj0pHQZYOzyeSsQHtPw7lRKNvJqVW5MTOuqUM
	c++FHDpT6AgiUoTUvW78zbysEZtd446Ep9Nbxhm7HctHK25B41/YgeJbjUleB7xCcF69ORUMqe4
	xgIjq4gstAeIMU80AkY1sYMO4m9pVGoptBGvk7T9zax0dx9O6ufv56hfUTmdsi/dZHBVNDSJtrY
	qPg3dUpAxfgBk1XGQ1sYxDUi7dSC6+cfn6GqUo6wb3faZG9neR+Uy94LHMPYOKIOsLp8VZX5OBF
	z2kvMOEw+kjwYcrLwrSwXrIyYatH6AN5ekG
X-Received: by 2002:a05:600c:8411:b0:49d:1e09:694a with SMTP id 5b1f17b1804b1-49e619f5049mr195258665e9.11.1789205448684;
        Sat, 12 Sep 2026 02:30:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e706d0c1fsm26523335e9.1.2026.09.12.02.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:30:48 -0700 (PDT)
Date: Sat, 12 Sep 2026 10:30:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun@kernel.org, joelagnelf@nvidia.com,
 rcu@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd
 Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Vineet Gupta
 <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Guo Ren
 <guoren@kernel.org>, linux-csky@vger.kernel.org, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
Message-ID: <20260912103047.1b95bb03@pumpkin>
In-Reply-To: <d0ef7beb-6952-49cc-9b33-e7542e831ba6@paulmck-laptop>
References: <20260911192540.20983-1-brads@mainlining.org>
	<20260911192540.20983-2-brads@mainlining.org>
	<20260911231017.550f8cd1@pumpkin>
	<d0ef7beb-6952-49cc-9b33-e7542e831ba6@paulmck-laptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 16:09:16 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, Sep 11, 2026 at 11:10:17PM +0100, David Laight wrote:
> > On Fri, 11 Sep 2026 19:25:34 +0000
> > Bradley Morgan <brads@mainlining.org> wrote:
> >   
> > > cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
> > > cmpxchg() for the architectures lacking native one-byte atomics.
> > > The same architectures also lack native two-byte cmpxchg(), where
> > > such an operation is not supported and either fails to compile via
> > > BUILD_BUG() or fails to link, because the bad pointer sentinels
> > > these architectures declare are never defined.
> > > 
> > > Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
> > > word with READ_ONCE(), splices the two target bytes through a union
> > > and loops on cmpxchg() of the full word until the compare succeeds.
> > > Like cmpxchg_emu_u8() it is fully ordered.
> > > 
> > > The Kconfig symbol gating this file is renamed from
> > > ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> > > selects both the one-byte and the two-byte emulation.
> > > 
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Bradley Morgan <brads@mainlining.org>
> > > ---
> > >  arch/Kconfig                |  2 +-
> > >  arch/arc/Kconfig            |  2 +-
> > >  arch/arm/Kconfig            |  2 +-
> > >  arch/csky/Kconfig           |  2 +-
> > >  arch/sh/Kconfig             |  2 +-
> > >  arch/xtensa/Kconfig         |  2 +-
> > >  include/linux/cmpxchg-emu.h |  1 +
> > >  lib/Makefile                |  2 +-
> > >  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
> > >  9 files changed, 40 insertions(+), 10 deletions(-)
> > >   
> > ...  
> > > diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> > > index 998deec67740..fee8171fa05e 100644
> > > --- a/include/linux/cmpxchg-emu.h
> > > +++ b/include/linux/cmpxchg-emu.h
> > > @@ -11,5 +11,6 @@
> > >  #define __LINUX_CMPXCHG_EMU_H
> > >  
> > >  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > > +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);  
> > 
> > Why uintptr_t? Shouldn't it just be u16?
> > (Which probably means the code would better if it was just 'unsigned int')  
> 
> I suspect that Bradley is just following my cmpxchg_emu_u8() example,
> which also returns uintptr_t.
> 
> I remember that *something* broke when I made this be u8, but I cannot
> recall what the problem was.
> 
> Bradley, could you please try making it be u16 as David suggests just to
> see what happens?  Who knows?  Maybe it was a compiler issue that has
> since been fixed.  Or maybe the macros and asms using cmpxchg_emu_u8()
> need that uintptr_t for some reason.

I think the uintptr (unsigned long) cast is needed to stop a compile
error when exchanging pointers.
But that is an issue with the #define not the called functions.

Possibly changing the #define to have:
	unsigned long ul_old = (unsigned long)(old);
Or even, with the type check from:
	unsigned long ul_old = (unsigned long)(0 ? *(ptr) : (old));
(with the same for 'new')
and the removing all the casts where the value are used might be better.

David

> 
> 							Thanx, Paul

