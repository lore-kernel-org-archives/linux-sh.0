Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB35625E6
	for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996286; cv=pass; b=J9MxgMSzBEyHJLm8XMyW1GkjYefKMQJwby/KdaESF1E/YbvJIexiFVzpCf2Lm5PrECZfnT745780CAmwyPeTNVF67A/4oKTqvqi8CSJ/6sfghIkuWsFkbCrW77N4UlEpYxag03uZkPUJyR1nlfOti0eqPlksRPcc90bYuHMVOX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996286; c=relaxed/simple;
	bh=aCsxctc/xcnHv1pMHQu5CMpv8HUZNsqkMA91yRiQJRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWR06swWaT2Nf9YeN/UIZ+tmroWT1foqy2wzA7RRmHfEB1YO5u2P206F35m4YSofCTP2zbDLud3XQ9XqPvWlNOqkD8XpJLcOI8Jg/Z3xDBiJuXQ6bBOLFPjcjku8Hhy62rse0gqjhxEao2QoMpiLUIqPr0QpETAtRLiPKqWDFEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MfSn5+O+; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MfSn5+O+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so37716455e9.2
        for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 09:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996282; cv=none;
        d=google.com; s=arc-20260327;
        b=UR2BucvEbGP1eEsBHFgE5UWRW6P5nPyo+pT0srVL7otUNNGOwXDmYCVoFMcpocLt7b
         FvucSivrAP5WOfRp3YAlnukdDCXdAvApp0rx8gMqbNle5ATW2VanFad/hOtLia8NNO0n
         hSh5j1QkmgpCw97CFVXVEjjv37CSO0P7O0O3BCMNSH/yPTm4iVIQYPSjr8ztSwT40aZT
         n6m9Kf8qmhqrR8pIyz/R7qjHv12w2Os3DstO+J5wiWqfcyxSuT3kon5fCBWIzBq6LZSJ
         LATRQP+ZPQBuwnnur7j6dnrSCxw5sl0zWMxxWg0Agh9IE17wM8XVY26+eRoS6c8r8w62
         +JZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        fh=DGq3V2DvscwbTmX12YzxRKBuE1ndWiQxRtSctXcPPHs=;
        b=F8+hWkq9ZecKIph28fDFFYnFnN5y6xvXBP6siUR/iKcC+jmU9pCK9u3JMdcLpzc7g5
         3YQDnOvw0ajM82kAS5fx0g2NpETbGtqdVW2TotT/Fxm4BohQCChJ1hOjQcQf/0JMqlBN
         Hv84GX42V7uKFxLZAyNY/M9Suz99jftt86szEZSxNMAKCqT+oPm7Hqjoesjg9h2FEg/6
         7AJlSuccriE7LRW29vDOL/E3spG6cLmhFW34LQfBuWr94FXIQunBmKqjqBe9PKqFrUnY
         +m2sWAEZseDAJZpc/fSdMyM47ojLF8/iJ2V41VdhdKRjBOQh/dWP+180WFFQUPpO7P6m
         X8FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996282; x=1792601082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=MfSn5+O+jWmDzU6Qat1Y+ZlT9jQoLCDnc9H3KO4dn05UZFbknls9QJdUQdVHYrbH/r
         BjOqlf3kmLrvBEN+Mtojy4fbT9cweHy1LxBSI+bW+ULfJ4/rlZFR25iTxRiVLmL1gGnX
         c8rZefI4LK2DJZIZjJVSTObVpjKw+wSEK5PJDepzjqgXoKlUd1jDQgsozfPwxsvd6/DH
         QdTpkMk+HGHIM3ND3MsUt45ZR7+33r6TOkpgl6cxhB1Gizo3hgEYuVd3UeABgWu0Jsfr
         6IcFCEE+7ZpZDqM6N6SHznacNDYLDeiilTwNXJL4XcQzUiy1RKhY4gBMUtMEVldNdt/7
         vPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996282; x=1792601082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hsPwLhsDZInozncTdS3m6Cc033xIb80Yu7bEmy4I9fE=;
        b=aOmTGcPvV+h2Jhd91xUn4L43mnREL8pedSJAxabkgpc9TCXy95nCSklmnQiEQQ0t55
         Msbq34N/O+g5+83T0PAlgjV5G9vnSNdtG2FjcF+IbevikkCRz1RO1NyO6EhnNYBg5W4v
         F/ISAS+7AbyjFRSHIrbuKH6AQBgqdTnJg7WkgB6bH31GQP9bFzMwa2utnbwfnQN/EhDz
         xh3P+OXkvE13AUDnpmOCXXrJzrmfhjwoFbdTyccqS6DsId9NoLJLrH4sqDirTLd7NtW1
         xqtJKxsV/mzn10jA4DOad1zetjM+Hndpda8nQhxgw01DYQbMxBLB5e9pJutsRCSys0Oy
         A+Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwFHeuazUn8avcRYaFlt1JPz7LvcVQDwedunruOLAr1yc84VpKwFC+ywlEPL75pgHjDJvoJbn1pqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIUdpuuXFYor2lF1FeddG90LELqHFz2sTyogfBGkcmqP7FibyDu
	9A6rCcpxYlcCtuA6NBOK1xWZehvM4ta2Yx3humyaNv/1YBYTqXlkIvUmIcNbUBAeEGm5+mHwTns
	2Txee2zHmpYz2sXw/xlIwJKjld2BI3wZrXRkE6SgS
X-Gm-Gg: AYBFou21kHVAr+pjdKJzK1mjlLzMGFMzAxwsH4JqUgLp4vPfVH3XgmZulMfqYYEeKb8
	+XQY0p9CDzZhbiTlcDhoynhmrwX0Y4k39+JKoMJKNrUVQLOHTluDfJMyXu2SKFxsZ5Tw6l6FPuY
	3guG6jOjRLg3nJjRLuErBNepgYMQGUdN2CKavXwei3Oxuf0Qk9o4mPRBv/fLTzbuI83SOrhUaVD
	LZV3dGBsK+4ilYTkYxA4kgWsvMKXXTw4BNi2+K8/k2bZOQyvFQsNn8xLkfoIwj1Kn+aXxn3ScND
	ZoOhMDAj5Jyd/4AkgqVz2rTPLL9sr8ZJtE19ab632XUaS9Mn9R12Jk66Xd3NpvbEa3nT5hhvY81
	QF6S6CPGjmebMx3mYV7KDYkI+KPxaK7ZEzOGVOfv5oyGfWTlVch/w8KOa2WTnwf6qxqH+q9N1e9
	PcB8UV3fj1N+F8NeUROlzrCX7Oxc4l519m4ji7plJI4OvHlG3rODTl
X-Received: by 2002:a05:600c:354a:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4a18e3ef23cmr329192565e9.0.1791996281614; Wed, 14 Oct 2026
 09:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
 <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com> <202610140937.B68C8C9AAC@keescook>
In-Reply-To: <202610140937.B68C8C9AAC@keescook>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 14 Oct 2026 09:44:29 -0700
X-Gm-Features: AclHuK9LUe2FvddsKjj0vYiArabpm2vrSaqioSsrjl7koqqOn_VyYRh6l-6milM
Message-ID: <CAKwvOdm6nO6skW4-AZtmzpGoNyO126L_AN3Mz2fu23+3QXcshg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Kees Cook <kees@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 01:28:55PM +0200, Miguel Ojeda wrote:
> > On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > +/*
> > > + * Optional: not supported by gcc
> > > + *
> > > + * clang: https://clang.llvm.org/docs/AttributeReference.html#requir=
e-explicit-initialization
> > > + */
> > > +#if __has_attribute(__require_explicit_initialization__)
> > > +# define __require_explicit_initialization __attribute__((__require_=
explicit_initialization__))
> > > +#else
> > > +# define __require_explicit_initialization
> > > +#endif
> >
> > The LPC slides mention Clang 14+, but from a quick test in Compiler
> > Explorer and a `git log --grep` on the LLVM repository to confirm, it
> > seems the attribute was introduced in Clang 20+, no?
> >
> > If that is correct, then it is not available in all LLVM versions we
> > support (LLVM 17+), so we should add:
> >
> >      * Optional: only supported since clang >=3D 20.0
> >
> > With that:
> >
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Yup, I can confirm, I only see it with 20+ too.

Fix up the comment and have a coin, witcher.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> --
> Kees Cook



--=20
Thanks,
~Nick Desaulniers
