Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F43BED70
	for <linux-sh@vger.kernel.org>; Thu,  9 Jul 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625807; cv=none; b=DVDUdE28/Hs9t8aFbLLXwdTSJ/DCklvf3cPor+7kWPR8YbcpuqfQS5FE55fcC/DXAHIe0RbKPzgX8jEbMg9bibljOCB+RDZu8ZMl8o3MsqPLP3eylFLDdworRuRDFA8CHW1tBk8hX9ZI2qeNCLdbivlwMtPYVV0NQqz3Zhnz1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625807; c=relaxed/simple;
	bh=BPaUOMStqjeisRPcDOcuIoBeHrZbI64A3Nn1AH5Ibog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qq+PFqC0s/MMiOIuHd6Mh1FaGGN7vIS+d3Q2XTXRY21cWR0SH1A/lFMcQ7uAKYRO3K3Pzgpdk0eSAQwbwzlTaUtlTCdu8obzRaP4H8/VQWey9lEy/ygZiDxJcbgBQDzu/EKZMyypPTbasQsP17fLh/Jdvbjkhe2I3wuyS5Dfi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+/LUAGn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+/LUAGn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so270940a91.3
        for <linux-sh@vger.kernel.org>; Thu, 09 Jul 2026 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625804; x=1784230604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9elVVpqR9aiL0byPjRlVnER0ZdQgMR4U6A5Xm6QA3+4=;
        b=R+/LUAGnG7vrn7Phl2DUAqgcAw7lPFoOO71gdhqG1sssaiN0mSoeLk8O1887TbsDt0
         wkiz6zn2WHHumXb0AVDPZTmHtRcIoE16hOdQdx9f31+BGxG2mvG3iZgmC3znkX9itrfz
         XTy+c/iwce74nuGwshuHh2q0oNMbUim3cdWIGLY8SzNVh3VQF5Pqt3rvejaWxrgJrZtK
         9GMySvfcm59rWQJ/5dHYrUuuAbAC9NYy1wUWqAMehYhhmQYT57+JZwtSBGkYkwcHhBOf
         GkXnhs+OlsV4BGf0AYeHU9daIeg1GiOOPYLyNPg9K1mKfOaypbjcaWYOmgja13GkYHKm
         fOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625804; x=1784230604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9elVVpqR9aiL0byPjRlVnER0ZdQgMR4U6A5Xm6QA3+4=;
        b=h/6mdp7afTl32hj+dZrHLvBTvBWEifs8p9069QT2fT1XPfm9sf7gw/t2SXvfTt6lY5
         IeHSC5lFpQ35c/vbueSNJPFEZDOiSTOPmZ/avCODYTp4qfiCEkragWT23ykh7+qAQ+MN
         VkTTZdTrAoOR0VbMOvaf+4mq5ntqVpvwSgzDEEoUzf3h3W16xiBrXxYBYUWJASQ5K5FR
         QW1qI5zlDFPDiajXlYNAPP/2MXVw/T9IulqgdWccUoD9Xh8jww7MIfKX1LSH2HFthz4w
         7n2C3bjaEaCstQp1gPIv64/jxOXxkPV0fC8PoTwvfHys8fO3L3CdUJiXU/83BbqNrsXJ
         8H3w==
X-Forwarded-Encrypted: i=1; AHgh+RqAQ6MvAL0U9sFJ79sYyPsNmmfcDmnX+KhNX/Ieult15yU7KhDNRHO8NOxmvGKWjhCfBxN6X/mq6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YysgCVuOsFXIGh8EzTpMwMR8tCkFg9AhrkHWP69HMdLpmW+pX5u
	27XbTHvG2OLkFbBhJ8fJXO9OvUMIh8ml2GQCUc1Fp5pfsTB7o0Y33g7S
X-Gm-Gg: AfdE7clykq8H8H2LS1kQHg1G65hlhYbxOqaYwYF5vzlKCew0o/H/L8MUvxiJ+rJMAaF
	8ZH5SyDtLgD07UnE8pxZBOXsWWdRyaPCIjnJdIlad/a0Nzl5pc12XT4+lfgB78clLrB5TbdMIaD
	62DV5KaXbC+J2HaYqHfxb5/E7zAnZsoYpQU3aianY1enHwh50ozbThc+RUWTe/MVb4YwWizlALM
	dpiHHExkhU8PrmXaj4czaljKhhs9Acmf2WAnbmZjjl1wKzVUf8+F9wvS7Lw8MnTnStJfxho3iSe
	iSuMsLtFnLpM6Fv1ZnS+XhXGDXuF7NCY25XWjvQ+jDbv1zO2nzHvVUm5vXgHk8gaP2Zjz4qZpeW
	dZ6OCGQcDXM3jZObYqIiTfxhhbUkOccJG+/mcvu635orfA9bM+nYRIUYPYs8R4l2KrerF7u7z/e
	Ur7Fh68AjMrFG7AapD4fgGAZjjb+8mjD/WgkO5B3SjOFPc8ftNZrpNaQ3vo5S1
X-Received: by 2002:a05:6a20:430b:b0:3bf:bfe6:ab6e with SMTP id adf61e73a8af0-3c0bcf49b4emr10854965637.6.1783625803970;
        Thu, 09 Jul 2026 12:36:43 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm33007037c88.0.2026.07.09.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:36:42 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:06:23 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 14/18] entry: Make return type of syscall_trace_enter()
 bool
Message-ID: <ak_4LT2HMSi88bA6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.392010241@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.392010241@kernel.org>

On Tue, Jul 07, 2026 at 09:06:53PM +0200, Thomas Gleixner wrote:
> This prepares for changing the return types of
> syscall_enter_from_user_mode[_work]() to bool, which in turn separates the
> decision of invoking the syscall from the syscall number, which might have
> been changed in the call by ptrace, seccomp, tracing.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -71,8 +71,8 @@ static inline void syscall_enter_audit(s
>  	}
>  }
>  
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> -						long syscall)
> +static __always_inline bool syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> +						long *syscall)
>  {
>  	/*
>  	 * Handle Syscall User Dispatch.  This must comes first, since
> @@ -81,7 +81,7 @@ static __always_inline long syscall_trac
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
>  		if (syscall_user_dispatch(regs))
> -			return -1L;
> +			return false;
>  	}
>  
>  	/*
> @@ -90,32 +90,32 @@ static __always_inline long syscall_trac
>  	 * through hrtimer_interrupt().
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall);
> +		rseq_syscall_enter_work(*syscall);
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>  		if (!arch_ptrace_report_syscall_permit_entry(regs) ||
>  		    (work & SYSCALL_WORK_SYSCALL_EMU))
> -			return -1L;
> +			return false;
>  	}
>  
>  	/* Do seccomp after ptrace, to catch any tracer changes. */
>  	if (work & SYSCALL_WORK_SECCOMP) {
>  		if (!__seccomp_permit_syscall())
> -			return -1L;
> +			return false;
>  	}
>  
>  	/* Either of the above might have changed the syscall number */
> -	syscall = syscall_get_nr(current, regs);
> +	*syscall = syscall_get_nr(current, regs);
>  
>  	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
> -		if (!trace_syscall_enter(regs, &syscall))
> -			return -1L;
> +		if (!trace_syscall_enter(regs, syscall))
> +			return false;
>  	}
>  
> -	syscall_enter_audit(regs, syscall);
> +	syscall_enter_audit(regs, *syscall);
>  
> -	return syscall;
> +	return true;
>  }
>  
>  /**
> @@ -145,8 +145,10 @@ static __always_inline long syscall_ente
>  {
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
> -	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, work, syscall);
> +	if (work & SYSCALL_WORK_ENTER) {
> +		if (!syscall_trace_enter(regs, work, &syscall))
> +			return -1L;
> +	}
>  
>  	return syscall;
>  }
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
