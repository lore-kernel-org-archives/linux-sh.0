Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB640B0EC
	for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155833; cv=none; b=Eah7/T7sfufVaBKwVqi3sEn2j7CGFlnQxSa4PfSLWlWvkS7eSg0VCmdVwqNmFXV+TJMZWzdXpVovh3HWeFOqVrO13xKMKPV2knV/0yvbMIam1fsi2hUVZDS0bf2GSeSoVbkZYFyRDVAFkjUQjFdA9CxzeoJDLmBimUGE2TphPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155833; c=relaxed/simple;
	bh=vBPUuNMXa0dgJzwuDSTU7kuQyYIoV4Ak7Pjwd9e1PnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bo90dL8znJTmLoX5H+H3AcauBWsZu1Yjxl5l/L0lZYsgVLGugtOAlq7D7YKC1TxLX58q4cKWzGgjGTXpZ9EnsF2M/1AFL9EllWvUS7aeQy0vnLObNE9l/Q/s2kZ1H5DQ3VDP0gOvlPSaxAwBX7MNUp8chOojHikBx2NCoSJtFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZo1aBS9; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZo1aBS9"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso634202f8f.0
        for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790155830; x=1790760630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XpdOD7b7tZjf2YLODbEeqXbESzHRLhCJCCPyiQAoQpI=;
        b=mZo1aBS9p45hjZPXMYgAS/IwXUHKZYyeBLuhZnxYXk+iTyUzi6lGbXjY/Ue+x7UU1R
         rO4YpGbpylZLDW4711fn9YqCw7Z0K2KdiUHd5TJvGAtRXjWGapkkkKgidoZfG9f1qUOa
         TKI5Ug6rcT1ryqpD7HEv/ea7F02wMs6YYo5TuOvml2V4AHktJm2smSKi54jsVWpV6q+5
         dva+Ajd9TpId7R6x1Zf2ndPth5uWaU4+waRFwSHxKfmpGNDGIj8TOv0KQIrNfp5i6BxZ
         t25ff0Tms2fy7nPSv8K7fW1cu6nqx9QHSE3BXWUuRPXhxN3hbY8rK042iIb/QGvSvoF+
         t4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790155830; x=1790760630;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XpdOD7b7tZjf2YLODbEeqXbESzHRLhCJCCPyiQAoQpI=;
        b=etja/GNoovr2a/2zVsYPBoDY/RxWEmLRsbV7bNneqdML78OJUHTSqirwTSj9+OFLnD
         RGZ4Kw+K6gbV3BV9JwXYzp+BnCdTga4XnwJD+rSWRbDeYwkag1LHO/12DZ9hD227LAsr
         77RiXjquvOUoBzbS1ZuOAiQ1eT8bVAWswrH1uOJEgVDx0ryQHCfQkjVHjoRBolUXT7Sm
         /iNGGNFdgP3Na++g59kkROq34+vc0A5WnOR/WNG3gLprZbr5ukyHKdvDhWIcuZlOz2EX
         gWN1gegHT3nZzMVV3Qpd6zLNMiWJo0TWPGruRC6t2EJ5CHc9b7JWJISbAmYT0VlkxIim
         b4bA==
X-Forwarded-Encrypted: i=1; AKwUvByEB97KaGL1M48umkM2Pp8WbUItfskk9+964WezHI6vVS2QfQqBl8sPtEG3IwL7wqn9n+nGdBGCVg==@vger.kernel.org
X-Gm-Message-State: AFuF++kmOpiB3auQrCHK75rCYz+n+N846KJ6PTbzEnhIn2Sajr55RRfP
	e2D66Bb2KAATOusOO2NMqbT2cgef+Ha13Ok0TL8ue6kPLu/mPKukQABh
X-Gm-Gg: AYBFou3vNL2KvTD2cYQtfG1NZMk06js42kNSHZcg+l9ZEJXXXI6m1v3zv3AdRCSFWuf
	82j3LTQYEJaf1pzMRMzGH7+x44ipxq8XCkS4UEU8AJPNJrNl0EJCELp46oT01x0B9E6d5MK8bvC
	EjVvJw0aFxRnme246mPmem20uYwbV3mAWWMCJr1GoOcFxTqy8bk5EkSYaAuP+5w3VVcX2QZVGqQ
	9ppmQlkTXuUgC1ciyAUoYBVWpgYBwF0f0Pv3H3UN2aM0vyq6TSpw7EBjDv2I8gLqoSyW/+Gcq1F
	fkPjuME6MyIVQIXrWvrUwO/SCdrkJc25cVY77XqpyFUsZwKoUK2J/ooGysxPCuN8r8CYfcv0FR/
	tETzVBLe085gWXYa8gG19ObhvN7tvza6j/aXodgyxTvmQwXAZF3CTmXtDmkAAzAAa1zK8AA2fdn
	uJC2Ph+BiOK+gK0TQsJXeL7FSSY4On5Op/TgS4F3PBOqjUpVEumAT8Jqk9lbE6rpXoh3745J+pq
	vcDNaEwoXhUHCmyeLENdLtcJAVBgnp7+Td2+AJ1oh3wS5MhChLP+6e1
X-Received: by 2002:a05:6000:22c4:b0:487:35c:6e6b with SMTP id ffacd0b85a97d-4886704aa19mr3430312f8f.12.1790155829433;
        Wed, 23 Sep 2026 02:30:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863d9sm5350009f8f.12.2026.09.23.02.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:30:28 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:30:27 +0100
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
Subject: Re: [PATCH 2/5] ARC: Emulate two-byte cmpxchg
Message-ID: <20260923103027.22bd9ef4@pumpkin>
In-Reply-To: <20260922173354.14404-3-brads@mainlining.org>
References: <20260922173354.14404-1-brads@mainlining.org>
	<20260922173354.14404-3-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 17:33:51 +0000
Bradley Morgan <brads@mainlining.org> wrote:

> ARC has no two-byte atomic compare and swap, so the arch_cmpxchg_relaxed()
> macro switch lets case 2 fall through to BUILD_BUG() via default. Route case
> 2 through the new cmpxchg_emu_u16(), which takes the old and new
> values as unsigned long and narrows them itself, so the (uintptr_t)
> casts on _o_ and _n_ are no longer needed and the case 2 call passes
> them straight.
> 
> The switch also now tests sizeof(*(_p_)) instead of sizeof((_p_)),
> which switched on the pointer and made the size 1 and size 2 cases
> dead code, routing every sub-word cmpxchg() through the 32-bit
> llock/scond pair and comparing whole words against sub-word values,
> so the compare almost never succeeded.

Hmmm... that looks like it warrants a 'Fixes' tag.
Clearly no one uses 'arc'.

David

> The old and new values are
> now declared as unsigned long through (unsigned long)(0 ? *(_p_) :
> (old)), the idiom David Laight suggested, which type checks the
> arguments against the pointee, so cmpxchg(&p, 4, 5) no longer
> compiles silently.
> 
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/arc/include/asm/cmpxchg.h | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index 76f43db0890f..4596edfefa95 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -42,16 +42,19 @@
>  #define arch_cmpxchg_relaxed(ptr, old, new)				\
>  ({									\
>  	__typeof__(ptr) _p_ = (ptr);					\
> -	__typeof__(*(ptr)) _o_ = (old);					\
> -	__typeof__(*(ptr)) _n_ = (new);					\
> +	unsigned long _old_ = (unsigned long)(0 ? *(_p_) : (old));		\
> +	unsigned long _new_ = (unsigned long)(0 ? *(_p_) : (new));		\
>  	__typeof__(*(ptr)) _prev_;					\
>  									\
> -	switch(sizeof((_p_))) {						\
> +	switch (sizeof(*(_p_))) {						\
>  	case 1:								\
> -		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
> +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, _old_, _new_);	\
> +		break;							\
> +	case 2:								\
> +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, _old_, _new_);	\
>  		break;							\
>  	case 4:								\
> -		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
> +		_prev_ = (__typeof__(*(ptr)))__cmpxchg(_p_, _old_, _new_);			\
>  		break;							\
>  	default:							\
>  		BUILD_BUG();						\
> @@ -64,8 +67,8 @@
>  #define arch_cmpxchg(ptr, old, new)				        \
>  ({									\
>  	volatile __typeof__(ptr) _p_ = (ptr);				\
> -	__typeof__(*(ptr)) _o_ = (old);					\
> -	__typeof__(*(ptr)) _n_ = (new);					\
> +	unsigned long _old_ = (unsigned long)(0 ? *(_p_) : (old));		\
> +	unsigned long _new_ = (unsigned long)(0 ? *(_p_) : (new));		\
>  	__typeof__(*(ptr)) _prev_;					\
>  	unsigned long __flags;						\
>  									\
> @@ -102,7 +105,7 @@
>  	__typeof__(ptr) _p_ = (ptr);					\
>  	__typeof__(*(ptr)) _val_ = (val);				\
>  									\
> -	switch(sizeof(*(_p_))) {					\
> +	switch (sizeof(*(_p_))) {					\
>  	case 4:								\
>  		_val_ = __arch_xchg(_p_, _val_);			\
>  		break;							\

