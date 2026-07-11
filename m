Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61483C4B68
	for <linux-sh@vger.kernel.org>; Sat, 11 Jul 2026 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783772967; cv=pass; b=MaskBmkjg9SofkBeuFw6QeFEdMMBdSPbOSUoSR30lhkHvVqJSwjiw4tY/A0HbTncXLdERMuV0NkzGyaSSrcyaayNbfd1uzZWdBXWIvPTT+wy1F5Pbq5i/w1A8bGxLOWshGKFAJzdJsnPF48gLeD9EDOk6gLN6V1Wi/8neX9YNew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783772967; c=relaxed/simple;
	bh=lgplXt8OmmYK0O5s0vGlPCfavq5E5GB8C7ljQ3QichI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n51OnNR2EJHP6s4FDY8ikpgPAfV7O7yhLpcGNGV5g4QsQyZegb/jJS34phenhluhgkKbDSxBbeVrqJ2i3Qice+kZCgzeszscz9cad28kh/Qqq8/1EgLfKWozEDx5ovyoO8NdKCvifA+7RR5WFkMD0OT5PxOs9yl9qZYpU2G3wu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhVAsJnP; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhVAsJnP"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so2732024a12.3
        for <linux-sh@vger.kernel.org>; Sat, 11 Jul 2026 05:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783772964; cv=none;
        d=google.com; s=arc-20260327;
        b=XH5PZm6FVEBsVdX4W4vj6gviC7qY84PudC2PEIPWar37xJPe9DZjWJOl42nyQ/GRZA
         WAr4oTyWNbbFK6opG5taWe8JSVMC0ZS1p5i0/NV7KvCcLzbLl99S5BGuYe4TjodU0X38
         nMEKu/60iz1wKB/op8abQEdMZCQj7by2Fk8TAcQg+tNIKWFr4N6x0f4h19Cmqjgiaazl
         QpRaxTkvJeD+NRtBA1UaE7BcNUuTQ9037wJfNBZ5ZfCe7qEWBj2SAKgIwQAgHVP9Ut64
         TEEba8lhaekKl75iO6CSmqjUEe6VM4fV8vhE6w9oXYQQlFLc4lXl+qEyD5aJu+mShpcQ
         4S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        fh=pJGkRVtQs3VfgAt0mrg9bSZhH74wuz0HhOr9lIIkpN8=;
        b=erKsyiCukGvGSCeIquU94KhJYfYyJ8L4LfTyXOW4xEmA02HUlZFpYLmgAvtkOqCLnC
         J37hIO9gRwWADnHQKLOC63WVDl/mAf8UMRNbHcF64TihFfzAqaYBT3jT33tbkcY3vHNL
         cp1nXLXxlyecC9047hLHvsNe2AI61hMVU3am/FeU3sWrR1dc8KG/QyH+8EOCQ1JCMiO6
         UW8ci2KNDykk0//FwpiSoe3kxMI3SOCnNmOaW+MzbAlSLL/PjiLWpTo1c5j7yAu0kEMa
         cllGN6tGRyl0f/M3SzONakhS69WACqD7M3lWzao10U2dta/VubU0aYpgmojEc7WEM+rf
         nd4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783772964; x=1784377764; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=KhVAsJnPccLQtlT6BW0pZOI6M33Kq5peNIi+brKc9mXt9N7FYBNxZiwumx0gXF4fIo
         sAO6rzobNlVEoIHs9Nr5Ud7Pqw06Wde6xz1P1K2kPK3YZyfFF/QcLy13zXrkpb8v6zCE
         wa1FryKea8CiALQ/FW+b66R5gxrKvaJKvQ5Z1BuPJv6JghHzUORCw6XB09TKL/k9s/1r
         i0N8avEwa/AHjCgBU1q0AZKoEW1/H84E5Jz1kEDp/nKMXzLRh+UDioLCoc7tRKEjgsZq
         3/2AvXjdSUp8fEKFVNQm320lqiCV3PxeKpLmb2suZXyxqugmSpsqzHjcuuYpicZfDTox
         leNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783772964; x=1784377764;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=83oOaaTreHaoFIhiDoHcddDWSjKDujW9xu9zE75la/o=;
        b=Z3z8MZn07j157Ys9wEgwVVO0fmodxY89H7ajt8yRHo2tIOUAt+j1aa0+V5r8DHzakl
         6xkc7vWzwIt7mxhg/X6wxbGRfxmUvHW/WCfl0kSNRbWr9JgSsHAl+2fFxt5ZRJhbMljX
         T2vaSY4xOJL55i83lGxHE+jrb0MkPAQ4uoLjPS1V7KcFtFd16UFiltTGx1I2zqWXkHfP
         uH6MqUqhzq+ulLIp3GDX2MSSiAKaV6yiWNb0L5X/VjcfodbpRW7gC3rnC82vnllDXYjx
         PFRds0gV0PvcfAy14Qpl6CyOVbdhoTBSrg2Q7gT4SNv/0Z0l8TlQMPMjL15jG4D34CCM
         V57w==
X-Forwarded-Encrypted: i=1; AHgh+RqPdKZZ5eiiJvPWvrwjWoPLNbfxRhglyoNSGXGJbuad1Z45YAXhEHyTjkUuFm8QnIgIUl6bLAMhgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybh80fp5PMKYaO2pZuW/X7gcXChbzHH7F5mlEtwiurghqv68Ud
	QTy7vkvfPDRjNa7JTTW2g0dGupElR6CFnJ3/28aOmH2RDbfLRtl2WLP4LYzw7sVNJWka3d2vtz1
	Zawl6+Jdsukw3fBUADS/vrLnfhSgwwQo=
X-Gm-Gg: AfdE7cnV/QliwUdee54JM9CMUOdZMt8jpI+hz79kOpPnbSgaK3Z+kPkoHxYlU2Bk+Lk
	PDsIMAx86g2p3zojQc2Tq9ko9cnENtM6PXuAHWy6fzmgNumcEm4F94IUi7shp1vKBS/LwVeZJEL
	HmvD9JXJKy9eATDGWmj9ZlXA9QGobr+sqLXLx7faCbQ7hSJta6SJAtXH+wYmpcsudbMzIOttjlU
	dqVYLt5pr0GIFwiTYAOUaw9x19TX+gbM15y4wWm3bKaunZHQXLZvHXe1IcjBxzyaGx/0Jv+z+ML
	F9cDhFQpL9kERP8mZ4DGeW8olhm216NsVgCVAQsLAkLuVlOwtNcqeQU9GvQSNKA=
X-Received: by 2002:a05:6402:3512:b0:699:728e:48b9 with SMTP id
 4fb4d7f45d1cf-69c5edb9cb3mr1210325a12.0.1783772963919; Sat, 11 Jul 2026
 05:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org>
In-Reply-To: <20260707181957.433213175@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 11 Jul 2026 14:29:12 +0200
X-Gm-Features: AUfX_mzOlRB8ana7x7qPQc4frMU9J060tNH0Z2GPCNvL1LYqDKQBjM-XzHbrvno
Message-ID: <CA+=Fv5RpgQ-UeGAT+VcLufte2gAp0H=J5GqZEFR_SuQsmnzy=A@mail.gmail.com>
Subject: Re: [patch 00/18] entry: Consolidate and rework syscall entry handling
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, linux-arm-kernel@lists.infradead.org, 
	linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-arch@vger.kernel.org, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> With that all architectures using the generic syscall entry code follow the
> same scheme, apply stack randomization at the correct and earliest possible
> place and skip syscall processing depending on the boolean return value of
> syscall_enter_from_user_mode[_work]().
>
> There should be no functional changes, at least there are none intended.
>
> The resulting text size for the syscall entry code on x8664 is slightly
> smaller than before these changes.
>
> Testing syscall heavy workloads and micro benchmarks shows a small
> performance gain for the general rework, but the last patch, which changes
> the logic to be more understandable has no measurable impact in either
> direction.
>
> The series applies on Linus tree and is also available from git:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-rework-v1
>


Hi Thomas,

Thanks for the series.

I have an Alpha GENERIC_ENTRY series posted and planned for the next
merge window:

https://lore.kernel.org/linux-alpha/20260706170019.2941459-1-linmag7@gmail.com/T/#t

Only its final patch intersects with this work.

That patch removes Alpha's architecture-specific syscall_trace_enter()
and syscall_trace_leave() implementations, so the Alpha changes in
patches 11 and 12 will disappear once the GENERIC_ENTRY conversion is
applied.

It also currently uses syscall_enter_from_user_mode(), so I will need to
rebase it onto the new entry interface introduced by this series. I
expect the integration to be confined to the final GENERIC_ENTRY patch.

The Alpha-specific changes in patches 11 and 12 look correct to me.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
