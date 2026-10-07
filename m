Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C53EDE7C;
	Wed,  7 Oct 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406126; cv=none; b=QBxJPL87UK5YeOg6ltRFPcBqODqJk6vEHP5Wsmct2vNkILFY6eQoIpftzc13ouRwHedlj+bpDTnkv+awz8Ft1aqn9h3WKI6WbNLov+OsKaVcwZ/rXubZ/XeJSpv5YCaUkIge8lCWV12wbokw6nfx0YhMo0KiL/LLo/a+7g3lpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406126; c=relaxed/simple;
	bh=0/WhIE5xUByjGl43DhBMNRFzi1uqctn4Lq5DdYZ/MNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZktODw6n32h0v0AjisLuKO4QgrE6mTDqvXjaPFBFIhEf+Lvgi6T6rW7zfRE631s4lQ71o+GLezswYsgE4YdeBa0VVDKQp8JiSTTa7XuVBYNSJyvklH//NJqkstHLQvoa3TrWq6uuF18pynUdvBZ1lQ+ROX5NjRVDLVbcdm2nHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0spcabY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0spcabY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6562E1F000FF;
	Wed,  7 Oct 2026 20:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406124;
	bh=nPV72BRwuyAm3hJ2pQez24KWWbawWtDF4Xp0O9HmZIw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=T0spcabYBSnTFnftQPKCF43YJ2HgnJrVFQtkhrskjqqyfytiOkIswyApmhyNE1Lgb
	 xktpu3B4Mwse1eyz8rUdx/aK7jKsFt9uM7cQTbX4SEUFTrKnT55rb/gB6F/ZF2O2Jj
	 3Xa83NGCwg9WZHB866isMjmIh+Ilc0vpqIbPpJAKSRc8rhC+8FM5bG9hzrSmbj0xbL
	 vO2lImb8q7CITNTSB1YOzmX+cD71ff16ah9MwbMyzVr93AuGvJQ/NKWxbm6i9yoKEF
	 1+cgFAeouP/SHXsfNf9gGlTYNCv5QBIzywbfN0OUC8KSws49+dmjNI4snVQ12dRR9P
	 IHnmBtx8IClKg==
Message-ID: <40f3c095-4202-4d2b-93e3-376a231d4fe8@kernel.org>
Date: Wed, 7 Oct 2026 22:48:39 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ARC: Emulate two-byte cmpxchg
To: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>, Vineet Gupta <vgupta@kernel.org>,
 Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-sh@vger.kernel.org, kernel-team@meta.com
References: <7f398d4a-7fae-4382-9cc4-8627e8aa912b@paulmck-laptop>
 <20261007203636.1982188-3-paulmck@kernel.org>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20261007203636.1982188-3-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/26 22:36, Paul E. McKenney wrote:
> From: Bradley Morgan <brads@mainlining.org>
>
> ARC has no two-byte atomic compare and swap, so the
> arch_cmpxchg_relaxed() macro switch lets case 2 fall through to
> BUILD_BUG() via default, and a two-byte cmpxchg() fails the build.
>
> Route case 2 through the new cmpxchg_emu_u16(), which narrows the
> old and new values itself, so the dispatch keeps the (uintptr_t)
> casts the case 1 path already uses.
>
> The sizeof(*(_p_)) fix that v4 folded in here landed separately
> through Vineet's f050c3e61d2a, so this patch is now only the
> case 2 wiring.
>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx,
-Vineet

> ---
>   arch/arc/include/asm/cmpxchg.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
> index 76f43db0890fc..7157718f147c1 100644
> --- a/arch/arc/include/asm/cmpxchg.h
> +++ b/arch/arc/include/asm/cmpxchg.h
> @@ -50,6 +50,9 @@
>   	case 1:								\
>   		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *__force)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
>   		break;							\
> +	case 2:								\
> +		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u16((volatile u16 *__force)_p_, (unsigned long)_o_, (unsigned long)_n_);	\
> +		break;							\
>   	case 4:								\
>   		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
>   		break;							\

