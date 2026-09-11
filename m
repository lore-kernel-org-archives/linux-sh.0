Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475D38239A
	for <linux-sh@vger.kernel.org>; Fri, 11 Sep 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164622; cv=none; b=JW4TM4rM61ogAvsqMWJvIDkQ472SdYN/CpZot8JRS4bBsG4nda4isyY3pCfhQdSdr8XRZMucCHGkoJIhEcfshl8JSX5oVq3YUhDlX7DaBiN6XMs4S+4K/nYhIRn6lS6264skrHp0BrtnhUpV7vOaJhjBVN4PsskjCP5jzl+aFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164622; c=relaxed/simple;
	bh=wzOAT8P+HfggfOuW+tbV1rDr39BIeDu1f097JVhjors=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGZtXYVL96nc++Sl99C0vUDxZ5xhxUinetYDI55j0ZPCCYOt0VHH0CZVnskcotsv3D68WZl6R3nUGekG4qpI2LoiGQpzN3uOjGja6RhWMorh1rj7XrF1bkPnkdTdyvYpiTb0DPFYbCE7+aHSMRk/Q7t0vG+JJHdOm6QJBy2V+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8kPqdVL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8kPqdVL"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so15540485e9.1
        for <linux-sh@vger.kernel.org>; Fri, 11 Sep 2026 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164619; x=1789769419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1CitEInQG9IH8hFfkxw+Dy1+TcxOBHzYjUh6RK88Fgs=;
        b=V8kPqdVLxhbxYq/ndSOhh59EWr8wuK81XRGpgyG1cXj+UuOWKJMFJ2T2a2dgpFrdLa
         WkuVwWjHua6E0jDuliU9Xfih3FGXadW6+THWVrO6iOtCVXUCSCtYS+LVNXHxOpwM1s/Y
         /bOxgg+4FBx1y8MXDR1zhT3bH3ZKtN6CF8wJX8J7oMW/zGMtXic0VCWyi99/rWWjnfd/
         uuXLEKmMOpD1pjjTO6VRI6T6CUOYwvNYIghCxNP5Ys0xeNLSImT2vW7SH3c25q936lXU
         qUoUKrw/pjuOxzetQVpQHrvTyuVJAj49eK1mHFx/vB/wgw7+zJMHO9eiGbAO23VErWjb
         30HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164619; x=1789769419;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CitEInQG9IH8hFfkxw+Dy1+TcxOBHzYjUh6RK88Fgs=;
        b=pzaFeTKDT2endVxIDHRAo3VSPQ1YxNEYjHGUkGebezaubt4JWACmZTA+tJHJhwmyrq
         dpPOnOGWrkeCMN8UZmZWgxtFVsrdWt7vtsh204slimN9x8la3glbMfuJ5cNYrR2ZXKeF
         wruJv15fGY+HsOJbzdPSi3acS3XpmxfYN1rCnH/3kXq4FwhH6xWke6ebFxh9iofQtVZx
         0hVvJY6d5DIsY3d5XEhGjC3RROBQejFM5EdXFE8G8aqmgxcp/JgdNIeSG/i3dSlPsHN9
         XkPPnO+DT8sKYMut1oTHTeZKLFvl5fRDJn+PdQs045OaOqc1W3oTVXZoqNaAfHifHfPm
         yCyA==
X-Forwarded-Encrypted: i=1; AKwUvBxiA5RAnVoyrz1HDQQR31j5xtmgRmVfWHEpPo1FlQSQis6+xpH5Vh+X22oQszSwjrAvQM9AkDIWJQ==@vger.kernel.org
X-Gm-Message-State: AFuF++loDcGa7DbZLaNLZh2JthURnY7cdEVLObph0Khqc4wFotX6ue/A
	MsT9XuFVZKrQA7DYy8tQtuRuQFFWwzm8uSbKDzqBjgad1obu3JtfzqEe
X-Gm-Gg: AYBFou0p3jM749E5pPRNlGSX3nVjM4N/onl9yIw/jd9CW8wFMGn56TJ61KnBfjQf83A
	zm5BlxFtGBxM+tgd2Xqa84jQt48QpK81utbJwUPm7nkYmH3ZIln7Yc7w/J+xHa17r4vyTTfsxuA
	rLbZQ5EIQ97Q7A6kFntYZtIn9Ia0BH9XewhCQOgMeuROPT5VDc7GppaYa/PrK6jV3/2Yr9imx3C
	OUJV9NWvF7QnSi7uGY4cw3R+q1f2Ffr4j/fLR03uUc0z+l6sjOxwSGwdFw2j51Z0BJdKUzzfkSI
	rtDkr6USEpUB+yVvkTkyyeBGOBRsQ5PwuIBjp9acsYHtL93xNGpEPHZvIdySjKod60QmRPVNohk
	vJg5aBKDlC06JdkGSogVJu5kIZ0ER4gfwKUcrklXq1/80hihJrb+ThZ3tqjyoR7IlIvzAsw2sM2
	uUxfJyaSsuU0vI9HC5Ok8/HkD4A8Yt4uO0IIALfGEfHI1pqfMj6MC2hFmhWfjxbGb3UgWhbRuns
	odcZdhd5pLAsANEvqeljDqpy+cMiCS9azJT
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49e6198865dmr87033975e9.8.1789164618893;
        Fri, 11 Sep 2026 15:10:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm69553525e9.1.2026.09.11.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:10:18 -0700 (PDT)
Date: Fri, 11 Sep 2026 23:10:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun@kernel.org, joelagnelf@nvidia.com,
 rcu@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>, "Arnd
 Bergmann" <arnd@arndb.de>, linux-arch@vger.kernel.org, "Vineet Gupta"
 <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, "Russell King"
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, "Guo Ren"
 <guoren@kernel.org>, linux-csky@vger.kernel.org, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
Message-ID: <20260911231017.550f8cd1@pumpkin>
In-Reply-To: <20260911192540.20983-2-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
	<20260911192540.20983-2-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 19:25:34 +0000
Bradley Morgan <brads@mainlining.org> wrote:

> cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
> cmpxchg() for the architectures lacking native one-byte atomics.
> The same architectures also lack native two-byte cmpxchg(), where
> such an operation is not supported and either fails to compile via
> BUILD_BUG() or fails to link, because the bad pointer sentinels
> these architectures declare are never defined.
> 
> Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
> word with READ_ONCE(), splices the two target bytes through a union
> and loops on cmpxchg() of the full word until the compare succeeds.
> Like cmpxchg_emu_u8() it is fully ordered.
> 
> The Kconfig symbol gating this file is renamed from
> ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> selects both the one-byte and the two-byte emulation.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/Kconfig                |  2 +-
>  arch/arc/Kconfig            |  2 +-
>  arch/arm/Kconfig            |  2 +-
>  arch/csky/Kconfig           |  2 +-
>  arch/sh/Kconfig             |  2 +-
>  arch/xtensa/Kconfig         |  2 +-
>  include/linux/cmpxchg-emu.h |  1 +
>  lib/Makefile                |  2 +-
>  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
>  9 files changed, 40 insertions(+), 10 deletions(-)
> 
...
> diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> index 998deec67740..fee8171fa05e 100644
> --- a/include/linux/cmpxchg-emu.h
> +++ b/include/linux/cmpxchg-emu.h
> @@ -11,5 +11,6 @@
>  #define __LINUX_CMPXCHG_EMU_H
>  
>  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);

Why uintptr_t? Shouldn't it just be u16?
(Which probably means the code would better if it was just 'unsigned int')

David

