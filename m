Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD273B42CB
	for <linux-sh@vger.kernel.org>; Thu,  9 Jul 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624989; cv=none; b=feu5Rs/xm03yi0P2szmoUgL4p7PlhnzhR54SVZAP1w4jIt58yKcsiicvOr6wpZX1h4C9UvSpS6GyVeR8x8hYGQnO4ERuhgtldMrDehH6JbwrX1aCrdiOMYFgmkot+1ydNi8MtZpigiWMKpbo/YZDwo0BEpVtGcx64Zi/tuitweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624989; c=relaxed/simple;
	bh=pbtl6l4SC9HiVOGfOcHRXhA3k1Vdk2xBr4FG7cem0i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLeTKOTku3/NOHVSI0m/Azx8PPn0J7ZpWjF6SyXwk/F16ZeTxxuMIRCaLSYSU8maNfrIXH0hDGfeEmHS4wVBoLbES5c2u6/vvCE0vOL3330P2PeKzaniq+NvcxEGA4bM8bMSQoiig0l0SLpbRCsLtxwVhB690XxALwY3LJG/bvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMtsPO+b; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMtsPO+b"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso1654175ad.1
        for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624986; x=1784229786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bVq923fN3xICcTFI/CD38blZ0rxbZHjRTcEK6CjQmAw=;
        b=kMtsPO+bVnA8eUHu0DTgQBV5sqIDS3vr8VWCFBGbbAHm2Ca4VAq8Oy0ILXmPn/4lJg
         1vAPI3MusgeRX0kclfcMEEjzZU7s2XE7+X+U4VMc/DOGS1Kg+fuxEGsZ6OFhtkjd7k8z
         to6tLLFYZ0+PrX5fAK3Sek/JGmksy5VzPLsxHUDTo7TgwM3nODkwkYETRoIPMmNNVfM3
         tzvn4mXZwzZYaADG1YDKhxJ43WB6KIGPq/hkDHItolkfEq+xA4UP5JhHbSEkLipRmiPG
         oN/pJznQBddOXRZxoJvLuAzxzjaR1HToGTrNImCE4XRSOF7OnCXgRbKtVuzv+zpCo8F3
         r5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624986; x=1784229786;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVq923fN3xICcTFI/CD38blZ0rxbZHjRTcEK6CjQmAw=;
        b=rFjnTR3DzRmLWRvZrudbXkVoSuhRtCErKbVNCNsS4qFEaJJk+je3yN8Uu1LBpRbK8C
         D70pvQvvkQ3NLBW/sxw/KnEzJvr3VAYsMI15qjImeXodX0kajP1StlYGbO1zfHRQo9aV
         Vu+pofnN6vtXhZfuJo+bvc4343N+IRGMWn1+TTN806D8SjAnsy6PfbW59d0WA0cVs9Qz
         TzyuPPZsxARJ6QLWY8MxhBAnGSy7TCXvMwGOobDx+UKmUsmxecH9/Y9exaCQEVLAEROj
         oGlkzXDqSNUU7e2RL5fcCUc2cbgp4Y45jPrvYyzf+tZilFLGhjpDp4K3RH/PtbqCv6m4
         bZTw==
X-Forwarded-Encrypted: i=1; AHgh+RpBloKRiV+Q/dizXnH6poCQ24nyC99Yc47b+/Iwh5jzixvoXG4CaBcqOEfJFW8mXOc1uxG3OyrCcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu58The/Lcj4rBheIaAdMveMBwePmt8Aa4NszikPm79RwApkzK
	BrJrAhJzpv8vbKaYZbLbdVVztRx+sTIAcCORPDL++lMuNqNnSYfX/QTP
X-Gm-Gg: AfdE7cmrAOF1S9qXd4fkUuUL5UBoalH+d9206Fad0EU09ANa2y2asCMNGiik2t4Ye1+
	djphU2jZLjmrT3uqwdtmYajI023YQDe/XBub2ISNOZA8ZIXNOa6QQ90amIgqCy+UXC0K4Vd4O5T
	lkwNtIh7kchYOs1aJ4uIaOU5DYWSIdo4y0NPjH3jsNSMMD7AMkIA3wsRExKU2ZGXH6+hFtGla7/
	qMQ/u0cTYsh3rRIOnSn7x+i7rK6Ym06TVBC82b4BGOTYPIyIz1uxNjMoDP5VIw6YNawcxCHmP77
	7GPqnQ4WqrA5EgtOLgNkLLdDG79YaSDAQYbEdYVnWhephh+IDMnjndnpT1adTHJgEwDy/d4/wAp
	rpxagnF42yNhYjPJ4sC8m9ch93k3L7VzM8cGicMD09yM9VTK7zSay/orcp2Svz+Zbo7e/uKpF/m
	i9YM6buGh0yj9dNgRltNfaoI3Jqg72HZxmQ2PU7FhASecYab0+78EGu+kvg7se
X-Received: by 2002:a05:6a21:6e8f:b0:3b3:1951:489b with SMTP id adf61e73a8af0-3c0bcbc046bmr10368851637.45.1783624986079;
        Thu, 09 Jul 2026 12:23:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm29005934eec.14.2026.07.09.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:23:04 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:52:35 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 12/18] ptrace, treewide: Rename
 ptrace_report_syscall_entry() to ptrace_report_syscall_permit_entry()
Message-ID: <ak_0g7JaD9Z_ApYe@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.280015701@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.280015701@kernel.org>

On Tue, Jul 07, 2026 at 09:06:44PM +0200, Thomas Gleixner wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
> 
> Rename the function so the purpose is clear and make the return type bool.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Vineet Gupta <vgupta@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Brian Cain <bcain@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> ---
>  arch/alpha/kernel/ptrace.c      |    2 +-
>  arch/arc/kernel/ptrace.c        |    2 +-
>  arch/arm/kernel/ptrace.c        |    2 +-
>  arch/arm64/kernel/ptrace.c      |    2 +-
>  arch/csky/kernel/ptrace.c       |    2 +-
>  arch/hexagon/kernel/traps.c     |    2 +-
>  arch/m68k/kernel/ptrace.c       |    2 +-
>  arch/microblaze/kernel/ptrace.c |    2 +-
>  arch/mips/kernel/ptrace.c       |    2 +-
>  arch/nios2/kernel/ptrace.c      |    2 +-
>  arch/openrisc/kernel/ptrace.c   |    2 +-
>  arch/parisc/kernel/ptrace.c     |   10 ++++------
>  arch/sh/kernel/ptrace_32.c      |    2 +-
>  arch/sparc/kernel/ptrace_32.c   |    2 +-
>  arch/sparc/kernel/ptrace_64.c   |    2 +-
>  arch/um/kernel/ptrace.c         |    2 +-
>  arch/xtensa/kernel/ptrace.c     |    2 +-
>  include/asm-generic/syscall.h   |    4 ++--
>  include/linux/entry-common.h    |   25 ++++++++++++-------------
>  include/linux/ptrace.h          |   13 ++++++-------
>  20 files changed, 40 insertions(+), 44 deletions(-)
> 
[...]
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c
> @@ -326,7 +326,7 @@ long compat_arch_ptrace(struct task_stru
>  long do_syscall_trace_enter(struct pt_regs *regs)
>  {
>  	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
> -		int rc = ptrace_report_syscall_entry(regs);
> +		bool permit = ptrace_report_syscall_permit_entry(regs);
>  
>  		/*
>  		 * As tracesys_next does not set %r28 to -ENOSYS
> @@ -334,12 +334,10 @@ long do_syscall_trace_enter(struct pt_re
>  		 */
>  		regs->gr[28] = -ENOSYS;
>  
> -		if (rc) {
> +		if (!permit) {
>  			/*
> -			 * A nonzero return code from
> -			 * ptrace_report_syscall_entry() tells us
> -			 * to prevent the syscall execution.  Skip
> -			 * the syscall call and the syscall restart handling.
> +			 * Skip the syscall call and the syscall restart
> +			 * handling.
Hey Thomas,

This comment `syscall call` sounds a bit weird.

Apart from this, Everything looks good.

Regards,
Mukesh

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
