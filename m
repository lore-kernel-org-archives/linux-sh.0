Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF634BF939
	for <linux-sh@vger.kernel.org>; Fri, 18 Sep 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721984; cv=none; b=BkGX0WWB5ZBYoOTP7aU/qwPAPyXbwyYe7dzPyIZPvLkXL6jtuBDNN+M+yjFLXijNvmYkjDUeYpNTcJcwx8ib6+upPIhONmGXJIsPPhs8OFNJdzo4hldf/NV1NEkDzuKfQuiDRQQhDpZEUp+j2hU6FlvWnUMAdZX0AudQfP9LfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721984; c=relaxed/simple;
	bh=ag8wHUMdvAkX5UXW/sgiiILfewkFHxwIL+3xC1CLLP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/zMWoxCz0ztQovTc7n9OgIQcqJzTYMgGUqSd41Zx1uB5P2ZIBLjmzjU7Dkl3dQRCbRHgOobUXUivMYH6xTaICLcEvfGtInYgMuC0rYvJ2776Z5cyOZ4ODg4Zib8hX5+1nJNEh6MkRF4lRR7DQgfuUwWFZd0EroXPg2qbdquWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw7XcUZm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw7XcUZm"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48442ea8f59so673917f8f.1
        for <linux-sh@vger.kernel.org>; Fri, 18 Sep 2026 01:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789721980; x=1790326780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ebKeWW1b/FCTysKRCA2qCKC9jXPhUpw/tMxPeazltLI=;
        b=Tw7XcUZm0rC0dkuh5w5E/veMnAhHyo0i7FcBH07sfDYi3aAAUsIle064UkwLQIZSMe
         useq7JQAeSSaz08P4uG5jY5l10RZd7riLVIKipTE9RnSidBNPtYxPGEWSjBSnPqpNux2
         qVzVyMbACCUE/cE4CgY/Kec/zkb0hCVMAz/BXbqxKszI3bTE5A3+TFTczN13inT5sLFt
         Zm0WVYEHp4fl6PyZYQOO+yiI1UcBFS2DETFGYgkUW9tLY3uwCTRMSYNgt+A87U8/iJl8
         fF4FViJlCDt6G3SGpB1D06SoBeUUvIyOIhYkF8ejii0kdeyP+cV23dJ4736Kqzd0u1H8
         qbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789721980; x=1790326780;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebKeWW1b/FCTysKRCA2qCKC9jXPhUpw/tMxPeazltLI=;
        b=BFrESRnMSgM55K3QoSfc/XWGfRPf89/HBriFNb10DvT6rNkUWXu+WiV06NhRo3TxMf
         OiOR/yd9mImkMrDRZB2bBCYcBXcQyeapg6hxNcG/6n/A4PMbnDIBlgn5l0Pa1dqVu0rw
         p/+fuyb8LAqNO5ZcwT7Rv3wYfJRLWKjeedkBmee8h7YTEkXrp59ky6oQOd7Nz33dzgaE
         6VcvdmRyL9ELyznj1eY2BL9ihna8oBpkKwdvKUYtWlCkKosKYH0g+DRJYa9caUlxszNf
         sr/IF5aX3DcSZDPTs55u0grsHaAaZc4wUYMK/SwIdD1tEAQJUQ6Lj7VTx/Ob9kHVRozN
         ffDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBycVJTKCrYUAlXSWbnkt58zsG22aOZNx/Ra8B4CMe14XkkvTb34UKqgbHScWFVATAoNce/AgaBw==@vger.kernel.org
X-Gm-Message-State: AFuF++l1pp271hGfq/1rK21n70WhbWWj/WqhNiijDczCw+JyZVWUYlK5
	CypZkS7cFm5i6DyWLrik4jEnC2Y7C8RVuj+fCGATyLv5ms7tORs29/Mm
X-Gm-Gg: AYBFou1HJ7HMu86yDguekI0PdyFDEKXUtaTaRsFuAr28+sKao/fjyO6ij3wELUfW6hk
	+qo0yuD+MbcdAYz0rEoX+LhifGmvD7plR/AehJUrQIB9D30+bLTeBUVMnORGCff2U3dztQaLzpx
	uOe8cEh7wlkqW1nVkH7zJOs2YeL7medomAWphJqf9v1YDbmyUIxbW/x/Sd0kp2HPPTkiPqnGe3X
	gZ0dzi3JR4MlHaGuSUkxk7T5JF5P2N/6CUH2f/948JbG1nd4Os5kftjENSxP6R3CU1tRo3A/BdY
	mDlqHCaCUfPl0ZVGa0dSAFhSXY1cSMZwW6OROfTg6PUt0jF+zO4C8ZEttwbOmeXiaujUG3FcbaF
	KogOYopNQJfmdIwb9jcJf6nA/f7h32u8BB7YOw6lwYC8S6WE2fcBieN6qZdAtpF7InHQh0H8Kai
	1/R2tJZhbi+rTb2tm0nUTjsJ8INnMHIe50YNtjDyNHD8g60/foDlUsmNpJ+JL3rZiAWop33YSvL
	1edgdMR62hv/xhELRv2RuzOnmawaLa6I+Nz
X-Received: by 2002:a5d:6f06:0:b0:485:8d9c:47d2 with SMTP id ffacd0b85a97d-48713c7ef38mr9129868f8f.30.1789721980248;
        Fri, 18 Sep 2026 01:59:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872008f34dsm2547841f8f.36.2026.09.18.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 01:59:39 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:59:38 +0100
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
Subject: Re: [PATCH v3 1/5] lib: Add two-byte cmpxchg emulation function
Message-ID: <20260918095938.6082a31a@pumpkin>
In-Reply-To: <20260917163830.3748-2-brads@mainlining.org>
References: <20260917163830.3748-1-brads@mainlining.org>
	<20260917163830.3748-2-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 16:38:26 +0000
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
> Unlike cmpxchg_emu_u8() it casts the old and new values to u16
> internally and returns unsigned long, taking the old and new values
> as unsigned long, per the suggestion from David Laight. The switch
> statements in the architecture macros instantiate every size case,
> so a cmpxchg() on a pointer type checks the two-byte case as well,
> and a u16 parameter or return would make the macro casts and return
> conversions warn there. With unsigned long parameters and return the
> call sites need no narrowing casts, pointer exchanges compile warning
> free, and the function still compares and returns exactly the 16 bits
> the caller asked for, which matches the hardware cmpxchg r16
> behaviour where a 16-bit compare only looks at the low 16 bits of
> the register.
> 
> The Kconfig symbol gating this file is renamed from
> ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> selects both the one-byte and the two-byte emulation.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
...
> diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> index 27f6f97cb60d..ac1c84383887 100644
> --- a/lib/cmpxchg-emu.c
> +++ b/lib/cmpxchg-emu.c
> @@ -1,10 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Emulated 1-byte cmpxchg operation for architectures lacking direct
> - * support for this size.  This is implemented in terms of 4-byte cmpxchg
> - * operations.
> + * Emulated 1-byte and 2-byte cmpxchg operations for architectures lacking
> + * direct support for these sizes.  These are implemented in terms of
> + * 4-byte cmpxchg operations.
>   *
> - * Copyright (C) 2024 Paul E. McKenney.
> + * Copyright (C) 2024 Paul E. McKenney <paulmck@kernel.org>
> + * Copyright (C) 2026 Bradley Morgan <brads@mainlining.org>
>   */
>  
>  #include <linux/types.h>
> @@ -40,6 +41,35 @@ uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
>  		instrument_atomic_read_write(p, 1);
>  		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
>  	} while (ret != old32.w);
> -	return old;
> +	return (u16)old;
>  }
>  EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);

Where did the (u16) cast come from?
If you want to mask 'old' to 8 bits it would be more reasonable to change
the function prototype.
(Although I can never remember whether the caller or called code is
responsible for masking the value.)

David

