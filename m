Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B5342514
	for <linux-sh@vger.kernel.org>; Fri, 18 Sep 2026 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722610; cv=none; b=U1zKq0R8LoLMEUs7sQ3nf5SswofF7BJpVq9lwRbtuA7w4W5lwrTvY261zJ094kgfYCZZzp+F1UDdYechQ1hCsd4HoH+6lkp5BB2d+Kil6VPIVhDTCf+XR9kg4W1y9cZF8IvkqUkPve6WNuP3gsAzwelNBH+PJ3hlplkQqA6Bvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722610; c=relaxed/simple;
	bh=5KphqyRcDRyQsFPoykPOf4gJm5upFtblvDJSgHIJlNU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXWFt2q9YGQWGsxkDLwqQ7eOM7lbzUmIqxQlFaLJNBq9SaeSRiZIm/qaI1ge9C8MZEsk8YnqqlaVnjZ4ATTa5MoW7j/Z/2zCAIaDmwveX/TnFO7NiLVrz+Ig7jDOdqFERLn1LKq9bR1GzQxeKnUv5BPHk9rm7cXatSuh+6bAvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqSXrERL; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqSXrERL"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f88so280575f8f.2
        for <linux-sh@vger.kernel.org>; Fri, 18 Sep 2026 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722607; x=1790327407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEA9aek5vNuu7I8nEFfi0rFdQ9PD9h+hnZ3KY6uKWvs=;
        b=LqSXrERLgtZpC7gvAspaFFbEPse4UBtzL+dpqIbDhwaW5ccJHLv6IwvjSQBc+vhYeN
         T2kkaAq6RSV6tMicKasFuvue+lk68K2oM3wsmnyP4T/Mjq762KCmQ/cpr/uiFje279Dl
         2sZok8mIMEYEZ0aAkLbdDfcv42EYB7mwu7h3B6vFuEtpfX2hl2q3KOKwfFvnktFCVTWh
         qngquhBRvE0+JjV/uY1xhW26Nv9aL/eWMa86t8mTlgUtNDpQejBTgdzTK62Dq35iEisi
         MdkbsXM6nBauk2t/vABF9sB0zbvZCw2/uKJHoYOwAB4NgOgN0VX/dVdlHng2a51vUX3R
         qsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722607; x=1790327407;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEA9aek5vNuu7I8nEFfi0rFdQ9PD9h+hnZ3KY6uKWvs=;
        b=gJS462f9Lf5dcQ7wjgGzAYDTuS41NP0DlUMsomhQ7BuIvYxIL+FkOpVfWvtUfvqOvm
         SsPOIJARNxUP15txlbTpAu5yEiLToQLbKjgRgRlFjEL9tiAB6udKi+Th5W0SwFlL/vlg
         4UGfJyQKBF+iu0+BrC5xqqNYPKpAr7/N+V2kQFJhOw1gnkvuR2GuyLsUNBtF2Pe0fjYy
         yEjZLs6nL5O8WdgL9eghV6m834AqJeisZM4F4vpun05yEYEv/cwgavxV2UFgoqK40akM
         1pKtRXdErMbTUL0jUyW1CR7Cdg5vEPIrSotTggTBXemkeUdV+6U0kleshqvLAgVEgjiy
         RSEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+eNbklvPmOmqv5DaaUXCvipmrs+I4lD0Xr9MQB1gASBYNrypvzzEpCRSEPZCdGTpSvc3SE2c6bg==@vger.kernel.org
X-Gm-Message-State: AFuF++meRJ0XKQ0D7iap0x1htLQeUzyl3gGyccanoFggvuWR31ToP6rm
	pSmYWgTbB7TBXlRFTI7/vila03OVLBzX8SKJ8MfWKipozOZHRldbFsAX
X-Gm-Gg: AYBFou0cB9/MJWaVjsaHdNSQ4sKmgLls5YksmCE7CyMOset7+GJfNSzsOAGt/FFOwbs
	OycnPnnTRpvHDgmcFX/HxXONt9XlutUMIMlT/Z9/fhq0iCdMonSeSvKdQ7/bg17PoXFbLgzemnf
	84kQr4TIGjrMtgzYoW6hu8z1zJFRSgZO+JGB7ArzJKeUqkE+YRxn2Umm2OQK+rT+iSr0js4FZyj
	EyOEKbIjiYo6o9s9CsRzBoGczNrdajH9qgG1WSxhq34/J2Cnu0URq2VY0o4k/Jdje1x2xacGIq4
	fYc5KU1MXwr+eT+Y4hk2ZetMz1MSYT+mWzVQ3MeEdEEXTBjH8XeT/6kvGcxw/2k3iUpIqccIST8
	ek+MRehWkI/uaxiPQjWydTWj5WPe+Qa2vYFD+s1j1yeBJW12zaQTprJQovyk2efZqgPWl46bQ+G
	MQZ/KBi0+v+NpATwxcDWSesRwDGweZSN36Mf1FiahVV+D0byyqssyCFjWZ4WXWh2q7k3bY+bwv7
	74S5AvUjsGjVPehF5j4nPQkqmT1opvqWAqt
X-Received: by 2002:a05:600c:3f0b:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49fc5750c61mr18187915e9.21.1789722607156;
        Fri, 18 Sep 2026 02:10:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc56aab7csm31503375e9.1.2026.09.18.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:10:06 -0700 (PDT)
Date: Fri, 18 Sep 2026 10:10:04 +0100
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
Subject: Re: [PATCH v3 0/5] Add two-byte cmpxchg emulation and wire it into
 the architectures
Message-ID: <20260918101004.731bf2e5@pumpkin>
In-Reply-To: <20260917163830.3748-1-brads@mainlining.org>
References: <20260917163830.3748-1-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 16:38:25 +0000
Bradley Morgan <brads@mainlining.org> wrote:

> This is v3 of the two byte cmpxchg emulation series, wiring
> cmpxchg_emu_u16() into arc, csky, sh and xtensa.
> 
> v2 tried u16 as the parameter type. David Laight pointed out that
> this does not compile warning free when exchanging a pointer type,
> because the switch statements in the architecture macros instantiate
> every size case, so a pointer cmpxchg() type checks the two byte
> case, and the (u16) casts there warn. v3 takes the old and new
> values as unsigned long and casts to u16 inside the function, so the
> call sites need no narrowing casts and pointer exchanges compile
> clean. The function still compares and returns exactly the 16 bits
> of the emulated halfword, which matches hardware cmpxchg r16
> behaviour, and a host test of 972 cases across both halfword offsets
> against a byte level reference model still passes.
> 
> David also noted the missing pointer to integer type check in some
> of the macros, so cmpxchg(&p, 4, 5) compiled silently. The csky
> macros typed __old and __new through __typeof__(old), which skips
> the check, and sh had none either. Both now type check through
> (unsigned long)(0 ? *(ptr) : (old)), the idiom David suggested,
> which keeps the pointer to integer conversion explicit while making
> the compiler reject mismatched types. Both of his test cases now
> fail to compile on every macro shape.

You fixed csky but not the others.
I guess that could be a separate patch (maybe series).

David

> 
> The ARMv6 wiring stays dropped from v1, per Arnd Bergmann's offer to
> take the INTEGRATOR_CM1136JFS cleanup in his platform removal series.
> 
> Thank you, Paul McKenney for suggesting this, and David Laight and
> Arnd Bergmann for the review that shaped all three revisions.
> 
> Bradley Morgan (5):
>   lib: Add two-byte cmpxchg emulation function
>   ARC: Emulate two-byte cmpxchg
>   csky: Emulate two-byte cmpxchg
>   sh: Emulate two-byte cmpxchg
>   xtensa: Emulate two-byte cmpxchg

