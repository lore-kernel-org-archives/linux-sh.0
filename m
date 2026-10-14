Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA74F93C6
	for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977351; cv=pass; b=m2vxJIZ5xedkW/KBLUBiaYN066TTQWf5LnPTQenhI4Lxn0lWLoZi4XCvTMIPiVvji/427QM5/MngEgbw47fhDYzbwSj/3kYFwarcHkTfimYEvdS4jydeDVU51hJZB1bf0CFh9p/90SQOFqqk40aZIzqGcas9U4i1QxhyOkFxTXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977351; c=relaxed/simple;
	bh=Bm8IXeZCCjjHRHqufoiH0uSm7tIaA4fZ4x02DGLBDgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVqB/6xHHNjf60I7D//KsjbOpZQMAidfRy69frq+P1Vt2GnPVhecm7l2GEqJA/WKfpMCgb4lNg5a37CtJIS0VUVoIeMrQTZ5T1Q/QjJZ4HtztPdcRomuZIQjN8ziRJ5sobc/muY+ECoPnUyoODPG5I+dBKQslKOKL6R7rbGj5mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkAqllS7; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkAqllS7"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35159e0092aso446348eec.2
        for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791977348; cv=none;
        d=google.com; s=arc-20260327;
        b=LYGfChVNnL80TUROogZuz5fgKzDEkv/vEXfpy06WqJfizalcHZB1egCigS7iHlnehR
         M7k9Do6xSOKjFS6wxHuBAaYw1YZ0Vnx96gw+3z9CVOS7UbtW6cGG8rwMI0Zai5AWYPc2
         5hdhSpRms3StAeJMGxosZoGNkaDWpxAStONT3a3uECKOsXbu+jM9Vwbj1Z9OMI4sEFh2
         6UrsiR0a27d3rj8IHm52I1uhzBXcfNMwbafsqYv0O0vi3BdsTantGlx8TiGgy4nq3M4U
         aNMaJcxYtP23Raowu5nJ+s6oaLLHAun1kdUrbh1KX0HyPTLveDD9K2/l8+zKjIj/bTPr
         qbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        fh=8jbaFhF2M5/Ru+/jNihCCVDSd5/bNynl4Uxch2Jb4/I=;
        b=mYIInWAFFYr9na6in48G0g//HIfMBYbr8kpwCMZePxrr7m6lhaFATkA8z4v8UJbAyE
         wqjEw24OIJZXoCnY4c6kx43Hy0DRA/vX+9kNk5XS6mrfIsmfuxZGgAfv0BCzbJ37xUfW
         wlHVSechupf6KXluNM2krmLVnoRCbjOMqh/EDljNlrX3V46tOg7FmAe5ikY4Kh/IUYJs
         BOwUczGJ4EnHdKjIbSBP2cbo/NcaYAveZLbfK7jrpd5pk19r9bqMe50keuNgpDfYi3wQ
         rkaBkjR/W5vavG7slj0dHuZIQ+Mws2FCqpO6NiiyDgcG7QQEyFfJh1CSMeTZ5zefqODb
         CmTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791977348; x=1792582148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=EkAqllS7uOOZxDGJ4I1yKdIi3WQSBbyUhPsWLoVzgJERDBlfP0X9cEpWzjyHAR90JC
         Z1zW2YqVc7X46XPiuAerNf9mNnAJ0uUF6PLz0rzePzi7U1lf5J9vz/gZr1IuRwk27MI/
         4/D886vhZESIUjDPJZRvHbQYWiiMvCS3NjhX5siJV1JzVFlBVMBE4d5Q1ZOlRDw5uGo0
         qEQHzjWEYvo+agj8c1xw4Nkq2SVQg9Ys3jvU8s3NkIQ4fYLQcX3kMyght8wz2N51o7tV
         AXXBZTinlSID6wvgzNqIrr0dJv5ZGB14N23uEZXq5jf7doeVho73k08XFK/CJX/hTW5i
         pPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791977348; x=1792582148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xWJCwZOmpC49YtbA7QzlowrBvokYI4WD90uvALsrwIA=;
        b=KeMfGcYkfLfLM84aT/BxuRsFit+VXR5+8aOSNropFloKOkDPYwgEywG2n5lc5v4J4d
         pyfYxsJ2H8sJmORCAEAWhavJ6LBgUXm73ojgkLWwV0FVkvINu8ZBRWNZ9QPnnqCraFNy
         qzHIbCMqd+6H8BMa7Pm3GXYWStUW4y1PWDFNnS+t3LQ+CLb4EqJjBA8eLjbNkpMdK/Hs
         VU4rheIfSfVgqtlMfwgtEm7T59NKbkRdFRCiH2B4HXHdtParz/Rsq0PDMxgOPO4wUpIG
         2SEO7G8qz3hujJAimLLXHqUkVuxM/WFMjx8zrUISg1Gy38ObuUprFLqhz4JqAi+2BUCC
         by1A==
X-Forwarded-Encrypted: i=1; AKwUvBxcwL9tU98Yhm8yeRw9ipU8pXrqh8DmZ5Y2DOL2+YWyZCz3tS4pUlM0P54uotWGcmkxQvjZWYC3pg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIF635lLJ82PkJDByPamiDCKomj+jqEvaZBwoooT51X434Rwikh
	NJLk6XsseXbxxiCrJiZGICFbdPS0NQe5ancmfxCi3mRYXjTYPzQ3JbZLFypFAIUTJdy3+sjmQzv
	YzuahDimk691OQ8vb1hO+l81fVZQnZdo=
X-Gm-Gg: AYBFou2oOeWsvK0ygkShOJZarHjyVMqpgZ/NpSfwZ/hw+3ZXAhUhWSQ3FMASGIRx7XK
	EuCF+k5j/V0ROM53pK0WDZyvCUGp1xplx2Mx33XDyssniR9lIIZr15lhgpmpcgVOmoawMIG3r5E
	ikyTQrM9FFikTfuJldCPph74jx6BiPIaR/gUMNWW5rpJKqY9qJt7c9cS7DShgfdp4TVawqc98UF
	TMQ1yM5d5EB6VNFCHg3joehE+dCJffjX9PWztZo92Bt8nHYQl5yFDdeHak6eZyhn6uzBOOPwQZJ
	pZf1P4co6ruiMRb5E/oaZdzOCcMBVxzKRRF7bm9KiJU5OiVKqeZ8Vky7z7o05oHykGxNEp07ejr
	HTGBs1AnrmjX5PBnUWMhodyWEZFGxBea1buJaN/BBxOaM7fsRFTW3LGV5uc217O2/WJMSLVDL72
	cEcsVz1Wrzmr4gKUc6JhWpxwdarsuVmFi+BRowGOPalEaGjxlDWDo=
X-Received: by 2002:a05:693c:6215:b0:35b:cb8a:8ce7 with SMTP id
 5a478bee46e88-35bcb8a919dmr14326600eec.1.1791977347656; Wed, 14 Oct 2026
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <20261013223946.1836757-2-irogers@google.com>
In-Reply-To: <20261013223946.1836757-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Oct 2026 13:28:55 +0200
X-Gm-Features: AclHuK8qVHO7HVQy6LgzcUgjYcQf3EimC6SJcN58PVqcWVdOf6T45eXZNeTLsEY
Message-ID: <CANiq72mLUh1JB=9e=tqStuL_H3=Ormx5v-uFkCDp-0zZm7tBrQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] Compiler Attributes: Add __require_explicit_initialization
 macro
To: Ian Rogers <irogers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
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

On Wed, Oct 14, 2026 at 12:40=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> +/*
> + * Optional: not supported by gcc
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#require-ex=
plicit-initialization
> + */
> +#if __has_attribute(__require_explicit_initialization__)
> +# define __require_explicit_initialization __attribute__((__require_expl=
icit_initialization__))
> +#else
> +# define __require_explicit_initialization
> +#endif

The LPC slides mention Clang 14+, but from a quick test in Compiler
Explorer and a `git log --grep` on the LLVM repository to confirm, it
seems the attribute was introduced in Clang 20+, no?

If that is correct, then it is not available in all LLVM versions we
support (LLVM 17+), so we should add:

     * Optional: only supported since clang >=3D 20.0

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
