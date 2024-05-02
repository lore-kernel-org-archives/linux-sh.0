Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC957CA1
	for <linux-sh@vger.kernel.org>; Thu,  2 May 2024 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688716; cv=none; b=rVvBbkw0LW2vdagmaq2+DeHLCq2cdnS2Gqx8PVIglCodwKyC8L3H/BVIElzxUq/cZEVtvOiuxR5UD5Eis0W6SRCVpswrJLRkS14AqyYgGHrGPMbGAa4xT1YoCBzDkz8YN3RAeQQm5/wVpIpAr80WwTSCWJ5zPC7fCu6tQ0frzMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688716; c=relaxed/simple;
	bh=qnKN9L3Z0Au55/oPWH4SsCKSSflxsoIcUt2AGUKIs6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJRq0+xcuGhPS1boMWL20vn1xZTR+Zm1IxtnJ6xf7uJqrYmpVRXrXir0rxulayG/z+OOi7rALLWw0emIy/hpJPPjwSL8UgDi9/IvPvYMXG1/QZ80lfeU2sbRFpFMCQQkSIO9IO9knCJNKnCrGaLR5lSTy5rvqJET7KWh31b8p40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QP5+yV5Y; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QP5+yV5Y"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a55911bff66so1115241266b.0
        for <linux-sh@vger.kernel.org>; Thu, 02 May 2024 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714688713; x=1715293513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8L1plbBpC5b8hbxFDn23VRySV0QK2bnDqJWgg6u+KQ=;
        b=QP5+yV5YykizLib3LmpeMaqWToyKZDLApr5cTXdCGJvwvnczWHF6tUH0J7iLFTF+Qs
         pk2WRN+nhAND0dmqITSRYBG8oK0BcV4BqZvI1cjlR1nsX0JqSniGGEvLMA92dVQk+SkB
         urxXEbkpTKCr0ATBLePhF0jDSeqDCZOtwrvjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714688713; x=1715293513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8L1plbBpC5b8hbxFDn23VRySV0QK2bnDqJWgg6u+KQ=;
        b=pfIoIYw8a2Zli14l1oLHny6zjRI2t8TT1bB0CZB3pdHlQYGU8H8jiTw2NQhZTiu2QE
         RdVCvzuGHLuLhWSYYOxhXRdwleAh7BQ3eb4x96EIfN/RaExfbK1JvLflBt3AbSOL/J6e
         rzVP7+ii963pD19onyE/e6wFoJFpi3Y4kKBpZtkRjsc27Ky2xPNuPfgTmgrMbG8tMf7j
         59sfKqKSxVV+pEUuvHEW4bWqR2mS4cWmcpjByHF2Zskf6NPM8TUZ2tdnj1EjJxKxX+id
         /ZwWLR+0toS1lGaOh6drNLX0FvTmdsl3JtUX2PDzgbna3K8sdUDKR4WbMK0skme61hIZ
         SuGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4b6IXhti5bV9hB/VpDoXuYn2sJOwjwYsa89MyC05CwcyRShRo38Xl545fGL/NJ7YNTzTFwEzQDZM7rUKEpOSI4kOWcNSZMY=
X-Gm-Message-State: AOJu0Yxfk72UjpLQwi0z8nil2tRUosnTTcJmn5tnvEjgfwFh4jT8jXwp
	ATwrdRm1QTUT1L3hlL9c2NpzLZMACytkmftFkfH4cY8xCSQq45QBLCAPIdsODwOHiy20ZVONTvs
	59gYMWA==
X-Google-Smtp-Source: AGHT+IHY80C7S+ykY9L85w5IXBg/2YlQIpnouxX6hCpNzjIrrOFVmjkXrPmDk38nzRqdj7xYYabPXg==
X-Received: by 2002:a17:906:cf83:b0:a55:75f6:ce0f with SMTP id um3-20020a170906cf8300b00a5575f6ce0fmr483170ejb.13.1714688712978;
        Thu, 02 May 2024 15:25:12 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090652cb00b00a4da28f42f1sm999302ejn.177.2024.05.02.15.25.12
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:25:12 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34db22374f3so1834236f8f.2
        for <linux-sh@vger.kernel.org>; Thu, 02 May 2024 15:25:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgJFn5lKCYIW/bQSbajLr6Mt/T3OE5/+KPscamIpa9YlbIU6PGredykb7zXpM5PjloS86LayciQdDWf/UASK0a9ZLi3Ju4gQI=
X-Received: by 2002:a17:906:2b94:b0:a59:4101:433e with SMTP id
 m20-20020a1709062b9400b00a594101433emr448463ejg.35.1714688229488; Thu, 02 May
 2024 15:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org> <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop> <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop> <20240502205345.GK2118490@ZenIV>
 <20240502210122.GA2322432@ZenIV>
In-Reply-To: <20240502210122.GA2322432@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 15:16:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-Jt7MgFC4-yr6DdvCVDoy1nu0W9W2zmaGZm6u=b2qTg@mail.gmail.com>
Message-ID: <CAHk-=wj-Jt7MgFC4-yr6DdvCVDoy1nu0W9W2zmaGZm6u=b2qTg@mail.gmail.com>
Subject: Re: alpha cmpxchg.h (was Re: [PATCH v2 cmpxchg 12/13] sh: Emulate
 one-byte cmpxchg)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, arnd@arndb.de, kernel-team@meta.com, 
	Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 14:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +static inline unsigned long
> +____xchg_u8(volatile char *m, unsigned long val)
> +{
> +       unsigned long ret, tmp, addr64;
> +
> +       __asm__ __volatile__(
> +       "       andnot  %4,7,%3\n"
> +       "       insbl   %1,%4,%1\n"
> +       "1:     ldq_l   %2,0(%3)\n"
> +       "       extbl   %2,%4,%0\n"
> +       "       mskbl   %2,%4,%2\n"
> +       "       or      %1,%2,%2\n"
> +       "       stq_c   %2,0(%3)\n"
> +       "       beq     %2,2f\n"
> +       ".subsection 2\n"
> +       "2:     br      1b\n"
> +       ".previous"
> +       : "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
> +       : "r" ((long)m), "1" (val) : "memory");
> +
> +       return ret;
> +}

Side note: if you move this around, I think you should just uninline
it too and turn it into a function call.

This inline asm doesn't actually take any advantage of the inlining.
The main reason to inline something like this is that you could then
deal with different compile-time alignments better than using the
generic software sequence. But that's not what the inline asm actually
does, and it uses the worst-case code sequence for inserting the byte.

Put that together with "byte and word xchg are rare", and it really
smells to me like we shouldn't be inlining this.

Now, the 32-bit and 64-bit cases are different - more common, but also
much simpler code sequences. They seem worth inlining.

That said, maybe for alpha, the "just move code around" is better than
"fix up old bad decisions" just because the effort is lower.

              Linus
