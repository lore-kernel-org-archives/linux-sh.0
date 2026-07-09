Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0451A3FBB72
	for <linux-sh@vger.kernel.org>; Thu,  9 Jul 2026 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586535; cv=none; b=L8hhgJs94ANMyUL9Tistr/YbWm8AMW5kHVnyV152BjEA0nzRwRhHWSlXNKhsVXHA2ADgSQ7i9Nf/2RCS3qHbs7omcOc9M4USXQIrnXo02of4K+38dN3KuadIqjOb4YPlyKNmN4xn77rrOR2Ed/CNcEa2bu0njoRK2C6yCqHvOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586535; c=relaxed/simple;
	bh=vcIYcFn8wOu64JToHCd3V3ghUBsco6aWxPDuriYHfZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RV9fQuO54VLMfYs6Tb7VMNUKIx0RJJ+6/I861Kj7D9QPkKT5QtgUCi8XaXH0l5Yai+WKlvNqELVlxAi5mbL0krG39j21Ceh28pktcz64/LM6v+FIrPWrneznRfVeE1PlgWe8UTi9WUTGvzOPzX7fwDcDEKtmjTaUYOvKhIzkWTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9690c99c917so553928241.2
        for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 01:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586530; x=1784191330;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=NnelPFFxAsNPMa//9J87E7UGO1SwXKSvJoUfQ+ZRiSSzsdlnPmN26p1CCZPGsSHNs8
         wVqQO54Lps1+sd32X90On8bMJOhqeB7IsEdqiQ3tHAYTriMA4kHReb/ANg2XoHZ9liL9
         dVI3LlPT+RTpBF0aFONh1hoh5JGIA+wFofaNffG9FOrg8b9/zaDj3oMvBPHQoFGbg1Wi
         IjnFnp4V5GgPJ2gCvi+pZZ5rg705AEU0ihLqrHu8REdurZ6+Xz/YpsgbGBKf10YeMfuX
         il3q4N+jIaQmflDEGBPNky/YHZqFdFxa0ySoc2YNy7zNAjayKhCUvAZDMHZbotHt54Oq
         CexQ==
X-Forwarded-Encrypted: i=1; AHgh+RoX3Otyvkiwc6EQjkrT5DXjEqUejkqyNNbMEb+Bu/J0XNtpqKym+XLpj0BZkcH8BtBWWlYlWlpQVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxLt6uoOuwghU8JspmBfhwTh+4d8vbQ1nRJ+ldImPTbJdtnER
	NDSZz7GRlH2uWumvmuzZ9kTu8cixj73o6h3uVPnmqPH/iLlYeunALz6TN3eDhN8L1dk=
X-Gm-Gg: AfdE7ckhhH26tOC8E79B55J3+x7MQR8L26GqkvoB4ytk7u1Kdp/WucvEbSIdOM2u9Wv
	eh9niyB51ZTiylmUIGsAStRrHt0gJYIOMG7QE7Xz8n7IuuvHMlENUnLQP+9hbrjNQmOTk8H2RHu
	63nQJff3v/ezIwIkTbrkkeZNDwg9lGlN7r60pmjE6cbjzRpiA2WTOLddP6O52p4cn8J2zSoP97f
	duVpgwEg0ysU4KwdO/au14ibsPpTFiYCz/G00OObeFPwwwlNaTw+nKlyNo3E5u02L4iIpdaCOZo
	J93m48STB9BOsm0Y/Fu3ZocWRglYeW8SvdLo4ZG5fYWmefCxBXvI/gKvim9Hgm6xt2LO8yWr4aY
	TE4xx0xskc9aOvQJwiPXxjFmZ/e938y+aD7fIhv1T+yzPcYE+Myy4Afr0m7g0zaTH9Z1r1A9ZJA
	HbjE2kubMBpolIWoMtVoyWl3anE1CzuegHr5FzgwaGH1BQ9H9akg==
X-Received: by 2002:a05:6102:418f:b0:738:1fcb:f276 with SMTP id ada2fe7eead31-744dffbeddbmr3721990137.1.1783586530070;
        Thu, 09 Jul 2026 01:42:10 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed258bb75sm2718222241.1.2026.07.09.01.42.08
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:42:09 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9696369925aso494415241.0
        for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 01:42:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rok6Yn5YXdoAPvROm1e8vh7E2+nuWO+Jc7/sGkV9gPhQXUzsg7Owp13W9GZJQIp6ZETfoEy1s5Zow==@vger.kernel.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
