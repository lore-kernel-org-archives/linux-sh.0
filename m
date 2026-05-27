Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EF299948
	for <linux-sh@vger.kernel.org>; Wed, 27 May 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874291; cv=none; b=bIbr9WmEwlwxnNgR3ckVflIZewnOiXSnBWHXckmJUcNhxeXm5xo4LYByB04NzkE2sVlJx39RJau3JSu5mrf1M+ccwpNZ2GokWF8CE0PY/gtbuFY055Zpx11VOlRxkPp664hXqtQGxG+tn+fhPPUl0DGhNU6fvOfAYbJechazRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874291; c=relaxed/simple;
	bh=MIwNRIQhmMvHp1RJPcezhJTrNh/CER1g8LrsudZZBhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xkq5FavzaQlE60OW7XL+Q3CcdWYqkNzHIKss4JE0LIWb5fIsepuCEoDH1S2whlHsa62QAkjOM5QZQ0TwEQVYrJchLDD5XBJjhFHNdL/FK2I+qp0OekzjPCvCQWbXtNTiracKUDZYR9XoQaHUr0rk1ygqXwGBZdfkImlCb5FXxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5751770a178so3752843e0c.3
        for <linux-sh@vger.kernel.org>; Wed, 27 May 2026 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874288; x=1780479088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jh4B5AC2q6XDT+EhwYr9A0M1dYuh/w8VgN+zze6pNI=;
        b=tGAdJ2ZQIpTn5rSstR+D6p55bf9lqUIuLnMFloUwkaGXt/cdMe95m4EMsxVRNcS59R
         kNi3HBnTbg+TUYsRMYsQsJAwlZuHKNqE23TG2UlA4XiRI4mkXBntnAuB+Hcdzkao0mdm
         zuUL2g3ia+vEsPXm7iFgm4Zu/J9bEa6dYbEZOnpvu5hMrdWci0j99bElw4MgJw2qGID/
         N9XS7vUD1lPiaojnukw3XV9srPvxfnwzUWIv0Rij4WVuACtiCp/ZByyqBTSkiYc1m+Sf
         hUfq9SbBaaqBgjLs6NYvkT79ACAjXY+DnggJE2RpvbWzZqYTTXuP7Q9fTVbGo1dOxB+l
         2K+w==
X-Forwarded-Encrypted: i=1; AFNElJ871O9sE8k46al3qathVBdIJKVwbsPoHAO1Cz2bmKwFj5JgKQuaDIvaWUHfR9x/dPqXpKXex1Ho6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKrQNlHbA+HIJWFgHC23oukDS6lyANeX50I7BjgDuVAaPAtEh
	nAyyU/XDJbSQHjiEaI0JnwIH6ModQZscN9OHJIh94rwMagoljqiuzDyZpnd0hTJ0TKQ=
X-Gm-Gg: Acq92OEP5fZlWsw8paQVTOuqblvfPSOTJmKBDptQmEDSfrmPArsiAaAObRKcZjTAumo
	4VGQh7BzWaVg063luzoYAvGLvbSeNco5gK3VQ9IbDQSCcvB70klGK0YmfoCdTcr00LnWxb5y1Gg
	WDI6HmhXFHDK1gNRmbpannxYyKC6UUUhbHMRacBkCPiei2rjJDfD9jwX/oJd+s07N2bbZt86SYN
	ZGYeQae9GBFQXBD6a5PbXlyeoQkX352ckyH+8Me+4S7R/bRcmicin4f6KQfaP24IOWiS7uUbUeN
	F2lVSWuox9+CmjvUR6HuU1deF1gsCNWVflMN0vFz+MKoYN7C+Z2GRepg8nb8ib1xLkwk3UTqg9t
	BFnoWv7mB4QCN9OmZxC8PrLhJilQWDyptS0nCA8Q02zixWj4+vNvn172788WLNmFTCeaN+oA+78
	Q1Oj2qDByBB3TJE9VwUjOUiOQWOZ0gAV1UttMLpXPMKyJaQQsbb9VN3F/xNLSB
X-Received: by 2002:a05:6122:f84:b0:56b:8023:b89e with SMTP id 71dfb90a1353d-5865fcf7d81mr12318821e0c.6.1779874288265;
        Wed, 27 May 2026 02:31:28 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-588c129cba5sm17140729e0c.14.2026.05.27.02.31.27
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 02:31:27 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-63129bf2af0so4279964137.2
        for <linux-sh@vger.kernel.org>; Wed, 27 May 2026 02:31:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+SKyR8EkqUyZwCTCLWJNaq7lpn1CeXvVn56sAlAn63NTEvRSmq+LKJkTd+ovT9SDQVhz3uBAtAZw==@vger.kernel.org
X-Received: by 2002:a05:6102:54aa:b0:633:75d3:3545 with SMTP id
 ada2fe7eead31-67c84ad8af0mr10485506137.30.1779874287601; Wed, 27 May 2026
 02:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com> <20260526175846.2694125-30-ardb+git@google.com>
In-Reply-To: <20260526175846.2694125-30-ardb+git@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 11:31:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBcpw8NTg+EVBmwiRWY1001EN94J9XstHG9o_hyUg8yA@mail.gmail.com>
X-Gm-Features: AVHnY4LA7PW8Q0XMk7lUiX1q-1VC5_AKr651tENC3X6CCFiZsD9Tq-B3NK3PBjs
Message-ID: <CAMuHMdWBcpw8NTg+EVBmwiRWY1001EN94J9XstHG9o_hyUg8yA@mail.gmail.com>
Subject: Re: [PATCH v6 13/15] sh: cast away constness from the zero page when
 flushing it from the cache
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 May 2026 at 20:05, Ard Biesheuvel <ardb+git@google.com> wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> SH performs cache maintenance on the zero page during boot, presumably
> to ensure that any clearing of BSS that has occurred at startup is
> visible to other CPUs and DMA devices.
>
> The __flush_wback_region() function takes a void* argument, which is
> conceptually sound, but given that empty_zero_page[] must never be
> modified, it is being repainted as const, making it incompatible with a
> void* formal parameter.
>
> Given the above, and the fact that __flush_wback_region() is in fact a
> function pointer variable with multiple implementations, take the easy
> way out, and cast away the constness in this particular invocation.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
