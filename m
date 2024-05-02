Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB418EB0
	for <linux-sh@vger.kernel.org>; Thu,  2 May 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692777; cv=none; b=AIniSlBQ9t6OuK7EAFBF1jsrM0OyJLAL3NLiU/R+KagykyLP8FWvJeicVHMh+KEe/fd8fz94q4D52BuPSo9OyQCs+GSufY7+Uj38zdhKhgeEQsFoFjuyy4eo1MZWQm3Z7J7l851ftf5qrjW08DJcu2Nkq5Kwx+mmJ/C3OpK48uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692777; c=relaxed/simple;
	bh=BZ52Tcx3eQkXrtn3fFvtEmKqc76WYA0oPdpNw2t/Pqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PqwJIS4qD2n6T3Fy8DpXB0/JkhAwbY1749Kn7fVSF0uReQbNdgEHb2e9LNYjgf3ItKzDEWWfR0F+4dEszjGFCdq4fBiJGMpjuwG5Xz5oG4jzoGpzzWHG2UpmJEoxZD+QiAq+3zeoh6d747gCXjf5M9g5S8ET+xTaP44skN2g4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JpJRGctS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JpJRGctS"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a597c192246so77858066b.0
        for <linux-sh@vger.kernel.org>; Thu, 02 May 2024 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714692773; x=1715297573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CFOJ/4TKYJEMM9t2wMqQPhhUvH4D3HXIbUI8k+tY+E=;
        b=JpJRGctSIVLk654NqObexqx568+cgQCSj6uzU8Yv6bFFYdZGvUOFTyzFD/hg+f/mpT
         VnQRhNRN/Vjw0Cts05mmE/+a2W15hbIdRh5BAIrA1d0CJ5KWFFvIoEv7ENBlVXj+Re2T
         +tebzuXFcsUaYJdI5G+SXrOlBylw9dGBeu63g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692773; x=1715297573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CFOJ/4TKYJEMM9t2wMqQPhhUvH4D3HXIbUI8k+tY+E=;
        b=mEByciCuUbRyl5HYORBS5hhQTZBOfYIwfs0waykLD2n4tg+IJkpVSdRJ0vmTAbi/wW
         u1veUgbrE0QVXiJ7JVlL5rR8fkjhrHyHhMeWwFtYLOsuUL8Je5ZtIVe7C+G4TOxtfgL/
         Dkz3UuZfow8HQx+0ui9HgA/LW0TKpKpzksYOHL9NwBokFhVF19BC8/Mvwvj3Unzs2h/Y
         gRMAOOX49ZujjFkFBdXrWwlofx5nTEH49KtkhWNjZuEzx5v3Y+kLN870XtKiG5GUE+KW
         XqEKdRXaupnywz/vooEu6zKPnCF3L2qIieoohLeaWk28tJuQp6wN3qR6yEZhpA0cXrYP
         hhAA==
X-Forwarded-Encrypted: i=1; AJvYcCUxdeVpyG+bgKfLtbd5Y8PPiND9SeqHefecl9fMMnA372tUbxNySpQFtfE8sZCfhN8vNDrW0gjODYocVekYFrwzL+CAw3IaycI=
X-Gm-Message-State: AOJu0YykcF65YMPOIptEeD88j0nWYxK6RVw9W/D0tOkuKU29UJFXxCN4
	q7vuLb9c8WNNphrXYZtqkewo9THg7Xllu68gVhxRwLamyOhJBtspL9WCPTcYOfE+77YwcYMcIzr
	Kfeb0aA==
X-Google-Smtp-Source: AGHT+IEQvW9W2trogSPvuLnync/s+sP8T6yeijDwd+5Q4jFGrqejr1T9hOw5JSz8quJs0sbHUSavaA==
X-Received: by 2002:a50:930a:0:b0:56e:3f0:a163 with SMTP id m10-20020a50930a000000b0056e03f0a163mr567273eda.14.1714692773469;
        Thu, 02 May 2024 16:32:53 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id en18-20020a056402529200b005721b7bfea2sm1006317edb.22.2024.05.02.16.32.52
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 16:32:53 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so67278275e9.1
        for <linux-sh@vger.kernel.org>; Thu, 02 May 2024 16:32:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ95EQYqRxygjbxy1WkH+bmhzzfaTueMp/tr3Z6pQmC8w96VPytJ5wVEmGDvyXyHpTyLNQfYzMAXimxQcZE4u0vDRyx+DOyn0=
X-Received: by 2002:a05:600c:1ca0:b0:418:4aac:a576 with SMTP id
 k32-20020a05600c1ca000b004184aaca576mr1051475wms.39.1714692772592; Thu, 02
 May 2024 16:32:52 -0700 (PDT)
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
 <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop> <20240502220757.GL2118490@ZenIV>
 <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
In-Reply-To: <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 May 2024 16:32:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>
Message-ID: <CAHk-=whaCSxengJHP82WUwrjKjYsVeD_zEN_We+gmyHpJJayoQ@mail.gmail.com>
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
To: paulmck@kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, elver@google.com, akpm@linux-foundation.org, 
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org, 
	pmladek@suse.com, arnd@arndb.de, kernel-team@meta.com, 
	Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 16:12, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> One of RCU's state machines uses smp_store_release() to start the
> state machine (only one task gets to do this) and cmpxchg() to update
> state beyond that point.  And the state is 8 bits so that it and other
> state fits into 32 bits to allow a single check for multiple conditions
> elsewhere.

Note that since alpha lacks the release-acquire model, it's always
going to be a full memory barrier before the store.

And then the store turns into a load-mask-store for older alphas.

So it's going to be a complete mess from a performance standpoint regardless.

Happily, I doubt anybody really cares.

I've occasionally wondered if we have situations where the
"smp_store_release()" only cares about previous *writes* being ordered
(ie a "smp_wmb()+WRITE_ONCE" would be sufficient).

It makes no difference on x86 (all stores are relases), power64 (wmb
and store_release are both LWSYNC) or arm64 (str is documentated to be
cheaper than DMB).

On alpha, smp_wmb()+WRITE_ONCE() is cheaper than smp_store_release(),
but nobody sane cares.

But *if* we have a situation where the "smp_store_release()" might be
just a "previous writes need to be visible" rather than ordering
previous reads too, we could maybe introduce that kind of op. I
_think_ the RCU writes tend to be of that kind?

                    Linus
