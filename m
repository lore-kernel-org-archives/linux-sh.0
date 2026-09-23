Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C3244E652
	for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155723; cv=none; b=dTvAw7q99O2T0pZthYy+CgN4jLsTXw3YRe4R0k8DqvpHXi5qcH7s4ZpcKdV3vcz+wR7MtJ2wsZaDJ7AGr5qTIgJpxZTWp/1j6CY2ZxzQ0DKHUuHhLHhxGaO2F/ZQwEkWf5Hp5w9EGqETq89e1iY2cwnHkAOELu5fVi8gbK5lZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155723; c=relaxed/simple;
	bh=eKQNdHt+hhAAjn5VJiqGyCUamYddAWI7/Er5YHSBndM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoZGyRJA+dQab/nH+OcBSdEBPeGbWSZzcCg71vOBzZLXKuALnSHzLthcWv0h0uoWdekP8wt4fcw8tTb7qIoqYYB1W3oDcaSSLd+5yXqSVHW3iZ1kSBfw+jILaX5XZNlf4q0kIKnlOKeuuZw1aOKeV4iw0BPMnIz8GGpGOU7Bf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK32VceR; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK32VceR"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so562067f8f.2
        for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790155720; x=1790760520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Op+1G3Jxi9SdULjib67/1vBJNLUR2DhfwMdslr3CGLI=;
        b=VK32VceR6fWNd4+HvsPwSwCtgcnAY9SMwCt64LPwFGxbvQmM+d4Fh5ciQJfnDY+adl
         o0JaduaeSBfU0xFVGltxsIJ8l7kK4qCPjQQgWQQKUpfsPpPew6CVRR5DhBqbA207cz/8
         WYMZ3p/AyjVTb9I7ilFqG+FD6Ypvij1AOhrCK7kZUcMFy4knCXUuuLvRw79lSlM3+ZuN
         JfqtG68XoxblIvawKrDcAfHK1Q4q5xZr3uZXLXTTsJhrkZ/WPEI48VBU8e2ZhDSa3TSI
         qEXcs9MYLe3tGG2Hc+CrQcaAeyL9TbNIBQKPNPtNCWhsACfHcVMT2SJuy+4tT9HHrJfK
         YmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790155720; x=1790760520;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Op+1G3Jxi9SdULjib67/1vBJNLUR2DhfwMdslr3CGLI=;
        b=LR1nXIrufC6q0lgsLuM8+lgzPtam6zy0zKta5v7JWYdjsFs2xD/leGJ33EXamHm6v8
         1foqxqZOTRSl3By2x25Hwjpqb34vM6vn19xr2cFd914AAy5iXvrskE9vxIr7nZzyGIO9
         H0eqBAfLl1qBj6+uy5iwc/t/NlILS2BCnF+yIWJSyVvxMJi5jBep/xXQ5E2v0zH9VeQG
         2xWXyh/EtjHF9fp4O8iB6Kdxq+Wy3Xjw7DFN4VQ1dboWgU8KUbFlcDW60aQljM7eRNNQ
         rt/zF/k72Px783XYNg2bkNEr14BuynDQBoM3YLSt45KFntoWdz8UP7dJ0ReIDK0z55nd
         MVEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfolSctRY3FOmqERpuCDoEiDdkD5g96dPdH6lcNCgkEddNNCY90S0mx0pmyP0lun3KJqVyhDabIg==@vger.kernel.org
X-Gm-Message-State: AFuF++nV3VOQ9vQX6Quy4JWtJA2K/ISNQpCPgirjzYiP0tCQAvCUrraY
	EiTgs7xzrx7mh68C6fuKgCABn5uv8ul20KyUpZB0QkoalEzfT0SyAHuf
X-Gm-Gg: AYBFou2OerxYMtjdqGKKjGFLQ3zAB0wueShTWTuXH5kd8E9cTo2ibgA6US0tKA5onNd
	EF8r+Yc2aE7odCi5Zrujpn14zuZXTZIffBuXjB8nAmJUOFHPZVopNZoJdE9xu/msDr6afh72Yrr
	qu6lakGXKfd7n9AtX+NqSODccWRu/m38JaHWtNkpkCKscU8t4thtbg1h8A2eBWjQkZV29eCdQt7
	8ig3BDfuoXZzpldMeJ4aDtWjl23SU22eo6c2RlYuAvBR+FNa2Hj1ecCaeq/XcjylmGVWpXz5gNx
	0ILVIGAPQhzHgVfPp9qWJ5KFV/KkORA+H726P8tl/Bfb2wH6ue6nZAkqUx5G5F1L5bWztkR+EQu
	1dkv3SbmLO97udWjailyLWyNxKMbabrXCDlEfO/pCvc1T9ll5x2V3taVOrKwHnXSvKIWl1RjHoy
	z9BrcHcImknZJOXdktzm9eLfvgWlVoH5TnZvfY+7mH5HXdUGoTmxmG9vmPeztHSQ2NTJ4TGQNwx
	L4Yj7iySDwwZLVq8yZfEwFQsn9C2sKjvjy8SDk8+sLq0g==
X-Received: by 2002:a05:6000:3ce:b0:485:8c16:5ef6 with SMTP id ffacd0b85a97d-488670b342cmr3399764f8f.48.1790155719650;
        Wed, 23 Sep 2026 02:28:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886876c500sm5584975f8f.19.2026.09.23.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:28:39 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:28:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta
 <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Chris Zankel
 <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>, "Paul E . McKenney" <paulmck@kernel.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] sh: Emulate two-byte cmpxchg
Message-ID: <20260923102837.2b46d772@pumpkin>
In-Reply-To: <20260922173354.14404-4-brads@mainlining.org>
References: <20260922173354.14404-1-brads@mainlining.org>
	<20260922173354.14404-4-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:33:52 +0000
Bradley Morgan <brads@mainlining.org> wrote:

You missed v4 from the subject line of all the patches.

> SH has no byte or halfword atomic memory operations, so the __cmpxchg()
> switch routes case 1 through cmpxchg_emu_u8() and lets case 2 fall
> through to __cmpxchg_called_with_bad_pointer(), which is declared but
> never defined, so a two-byte cmpxchg() fails at link time. Route case
> 2 through the new cmpxchg_emu_u16(), which takes the old and new
> values as unsigned long, so the (unsigned long) casts move off the
> call and into _old_ and _new_ declarations that type check the old
> and new arguments against *ptr through (unsigned long)(0 ? *ptr : _o_),
> the idiom David Laight suggested, so cmpxchg(&p, 4, 5) no longer
> compiles silently.
> 
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/sh/include/asm/cmpxchg.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> index 1e5dc5ccf7bf..b87f59107b4e 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>  	switch (size) {
>  	case 1:
>  		return cmpxchg_emu_u8(ptr, old, new);
> +	case 2:
> +		return cmpxchg_emu_u16(ptr, old, new);
>  	case 4:
>  		return __cmpxchg_u32(ptr, old, new);
>  	}
> @@ -70,8 +72,10 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>    ({									 \
>       __typeof__(*(ptr)) _o_ = (o);					 \
>       __typeof__(*(ptr)) _n_ = (n);					 \
> -     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
> -				    (unsigned long)_n_, sizeof(*(ptr))); \
> +     unsigned long _old_ = (unsigned long)(0 ? *ptr : _o_);	 \
> +     unsigned long _new_ = (unsigned long)(0 ? *ptr : _n_);	 \
> +     (__typeof__(*(ptr))) __cmpxchg((ptr), _old_,				 \
> +				    _new_, sizeof(*(ptr)));	 \

Minor niggle if you have to do these again...
That line doesn't look long enough to need splitting.
More generally if you add 'unsigned long _rval_' and put a final cast
at the bottom the the #define the code will probably look neater.

David

>    })
>  
>  #include <asm-generic/cmpxchg-local.h>

