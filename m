Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7503596A
	for <linux-sh@vger.kernel.org>; Fri,  6 Jun 2025 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194313; cv=none; b=aO5TPvgqL5QMRi9ic3pOkiCDCuJcymaOLxx++MedJo8m6mdl2jbEahp/RPkczBNIx5FvFEfHgRnKciKd02Ioi0cN7AuX2inE9n3kRUmdswLbeT+QJVomER+s3EVNtAg0CogBp427OQbc4saAn0N5JS0DgmrkZTHpb6SM1Jiixqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194313; c=relaxed/simple;
	bh=LaOOXqiE8ZKJNL+43OidHoTm5IKe5hqfIUXpflKFAw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEjQWQVqGq5+li/5qsZzOv96erhYIc7xRE3523lQ7DOOGP98l671UObCenpufY/FtKIe4OiNqdefoJDL29EYO1pEPXr/hP1JZ3SybIUSt/spHYhRUnGDyFa8xfrUnysmccvkldmzPoGWZRaoG2PXvtFx5PPHYsQm8wBFXcBaCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wo+xc0FL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wo+xc0FL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749194309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IlWE4DmD6EWD1m2VhNj/8GYWjoektD/thvKh08m1WlM=;
	b=Wo+xc0FLLxbYM4kK4QGn8GPMNDT1+rGDiviDbTpCu2OUUlsZRgLSLotKl1M5iJj/0uIjM9
	diHZ0hsaZQNC1QP/KlG0NGkqWZewa4EJ71Qo79HOudPlWktvNQmcJF/nG8dnTSNVPpG6+5
	PJv5PFCOmJuXzT/5lTERbF2Q5i9cw1Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-JwgilXfGOXOgYnhb-PsZLQ-1; Fri, 06 Jun 2025 03:18:26 -0400
X-MC-Unique: JwgilXfGOXOgYnhb-PsZLQ-1
X-Mimecast-MFC-AGG-ID: JwgilXfGOXOgYnhb-PsZLQ_1749194305
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eec544c6so897128f8f.0
        for <linux-sh@vger.kernel.org>; Fri, 06 Jun 2025 00:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749194305; x=1749799105;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlWE4DmD6EWD1m2VhNj/8GYWjoektD/thvKh08m1WlM=;
        b=tRkVy5aFmThNoHCtCp0u4mSn24pWuVUfJdzJw4k4/igvDXcdkr9Q/2rHqZvXA8xaie
         riQewrpTkR6IB1I3Ko4gtiyXFKXZTtNdDVfrYeCclZVLJJAEwW6ddeTqmElxrlGpZExg
         cjFfvCVP+KFfxPDGjElblkWIgnjWGSGEWC8p7SB5PMjzT9UQNj6jZrBKU00rCGRJLD0T
         wBl87mJZzK80sD7X3iHjAbBwitw1UJNF8z4F2H9dnpUQruixHU81OwQGh4auRoPWFNIi
         R0DFYGvxe724CBeiGdPBh5WPdddBkQdCsW013pS0d89Q9YSVxbx8diMfTCIp6sX6E2AM
         XbJw==
X-Gm-Message-State: AOJu0YyazYKDxTy6Tmj0y8ADitAGXxJAYs3DbNHUtASHc+3ZGaXqqcip
	mHZDyZscK9D5cKwTMnenWBcNbvsnytxrYJKhvkeSOE21FiZDtrHdN6hLbvQMo48vKbcR9gthGQf
	ibDouoqTMsVNTwqZH7nizCIj9bgX5qNXyrtSHuZOAhvZlSWXnHGgWCi2psM6xwerAiVQjPNs=
X-Gm-Gg: ASbGnctwW8ozhxeIFhEOuEkPUoGxsqJmg80HMm7s6OAFyun9ZYRidojqZnkceNoLhxR
	D6nKKMxIn6W4Aiyl0UXfMlrv9/Qu07rujUDCL+XPVfXTtDmiUh9q9Rk0cWEaIsflg6EdYs0kIm7
	dBCCKO+dFTTi+6SGQPgCo4LK8mRHWzRquIuBW7iNKdnY2HhknyPlmFIgpW8tIbJYu2bFk2f7J/K
	VH6GhRs9F8riOXBnF8zA0Ogu2gK9ggLAyDji1UyApO6e77vtZL4FUanPC7ZZbV9QYqV6qf5+zXT
	e3f0BXZOq84qbGYvDl0LIxqZwuY6Y9ryZOpbKH32dD0aD1NUHsrJYw==
X-Received: by 2002:a5d:5f8c:0:b0:3a4:e2d8:75e2 with SMTP id ffacd0b85a97d-3a531cf3be9mr1854089f8f.50.1749194305348;
        Fri, 06 Jun 2025 00:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcAxhI7EXY/3UzW16/yNJ51i8+0aCOM6PaovRKwnETBGQOLAPOnUYY02XIQ9AP3+9L0EKpRw==
X-Received: by 2002:a5d:5f8c:0:b0:3a4:e2d8:75e2 with SMTP id ffacd0b85a97d-3a531cf3be9mr1854063f8f.50.1749194304832;
        Fri, 06 Jun 2025 00:18:24 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de. [109.42.50.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730d1636sm11532025e9.38.2025.06.06.00.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jun 2025 00:18:24 -0700 (PDT)
Message-ID: <4a3c60ec-67c5-4682-b88c-a181a91bfd2c@redhat.com>
Date: Fri, 6 Jun 2025 09:18:22 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/41] sh: Replace __ASSEMBLY__ with __ASSEMBLER__ in the
 SuperH headers
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-33-thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250314071013.1575167-33-thuth@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z8wyb3DuK97pTKqM69t6bcHe91Xd7eg8xecvbAISS_8_1749194305
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 08.10, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/sh/include/asm/cache.h                   |  4 ++--
>   arch/sh/include/asm/dwarf.h                   |  6 +++---
>   arch/sh/include/asm/fpu.h                     |  4 ++--
>   arch/sh/include/asm/ftrace.h                  |  8 ++++----
>   arch/sh/include/asm/mmu.h                     |  4 ++--
>   arch/sh/include/asm/page.h                    |  8 ++++----
>   arch/sh/include/asm/pgtable.h                 |  4 ++--
>   arch/sh/include/asm/pgtable_32.h              |  8 ++++----
>   arch/sh/include/asm/processor.h               |  4 ++--
>   arch/sh/include/asm/smc37c93x.h               |  4 ++--
>   arch/sh/include/asm/suspend.h                 |  2 +-
>   arch/sh/include/asm/thread_info.h             | 10 +++++-----
>   arch/sh/include/asm/tlb.h                     |  4 ++--
>   arch/sh/include/asm/types.h                   |  4 ++--
>   arch/sh/include/mach-common/mach/romimage.h   |  6 +++---
>   arch/sh/include/mach-ecovec24/mach/romimage.h |  6 +++---
>   arch/sh/include/mach-kfr2r09/mach/romimage.h  |  6 +++---
>   17 files changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/sh/include/asm/cache.h b/arch/sh/include/asm/cache.h
> index b38dbc9755811..e7ac9c9502751 100644
> --- a/arch/sh/include/asm/cache.h
> +++ b/arch/sh/include/asm/cache.h
> @@ -22,7 +22,7 @@
>   
>   #define __read_mostly __section(".data..read_mostly")
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   struct cache_info {
>   	unsigned int ways;		/* Number of cache ways */
>   	unsigned int sets;		/* Number of cache sets */
> @@ -48,5 +48,5 @@ struct cache_info {
>   
>   	unsigned long flags;
>   };
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   #endif /* __ASM_SH_CACHE_H */
> diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
> index 5719544741221..f46d18b84833f 100644
> --- a/arch/sh/include/asm/dwarf.h
> +++ b/arch/sh/include/asm/dwarf.h
> @@ -189,7 +189,7 @@
>    */
>   #define DWARF_ARCH_RA_REG	17
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <linux/compiler.h>
>   #include <linux/bug.h>
> @@ -379,7 +379,7 @@ extern int module_dwarf_finalize(const Elf_Ehdr *, const Elf_Shdr *,
>   				 struct module *);
>   extern void module_dwarf_cleanup(struct module *);
>   
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>   
>   #define CFI_STARTPROC	.cfi_startproc
>   #define CFI_ENDPROC	.cfi_endproc
> @@ -402,7 +402,7 @@ extern void module_dwarf_cleanup(struct module *);
>   #define CFI_REL_OFFSET	CFI_IGNORE
>   #define CFI_UNDEFINED	CFI_IGNORE
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   static inline void dwarf_unwinder_init(void)
>   {
>   }
> diff --git a/arch/sh/include/asm/fpu.h b/arch/sh/include/asm/fpu.h
> index 0379f4cce5ed2..a086e38b70eef 100644
> --- a/arch/sh/include/asm/fpu.h
> +++ b/arch/sh/include/asm/fpu.h
> @@ -2,7 +2,7 @@
>   #ifndef __ASM_SH_FPU_H
>   #define __ASM_SH_FPU_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <asm/ptrace.h>
>   
> @@ -67,6 +67,6 @@ static inline void clear_fpu(struct task_struct *tsk, struct pt_regs *regs)
>   void float_raise(unsigned int flags);
>   int float_rounding_mode(void);
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* __ASM_SH_FPU_H */
> diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
> index 1c10e10663909..d35781ab716ef 100644
> --- a/arch/sh/include/asm/ftrace.h
> +++ b/arch/sh/include/asm/ftrace.h
> @@ -7,7 +7,7 @@
>   #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
>   #define FTRACE_SYSCALL_MAX	NR_syscalls
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   extern void mcount(void);
>   
>   #define MCOUNT_ADDR		((unsigned long)(mcount))
> @@ -35,10 +35,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>   
>   void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr);
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   #endif /* CONFIG_FUNCTION_TRACER */
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   /* arch/sh/kernel/return_address.c */
>   extern void *return_address(unsigned int);
> @@ -53,6 +53,6 @@ static inline void arch_ftrace_nmi_enter(void) { }
>   static inline void arch_ftrace_nmi_exit(void) { }
>   #endif
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* __ASM_SH_FTRACE_H */
> diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
> index 172e329fd92d0..b9c9f91e66165 100644
> --- a/arch/sh/include/asm/mmu.h
> +++ b/arch/sh/include/asm/mmu.h
> @@ -33,7 +33,7 @@
>   
>   #define PMB_NO_ENTRY		(-1)
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #include <linux/errno.h>
>   #include <linux/threads.h>
>   #include <asm/page.h>
> @@ -102,6 +102,6 @@ pmb_remap(phys_addr_t phys, unsigned long size, pgprot_t prot)
>   	return pmb_remap_caller(phys, size, prot, __builtin_return_address(0));
>   }
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* __MMU_H */
> diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
> index 3990cbd9aa044..def4205491ec9 100644
> --- a/arch/sh/include/asm/page.h
> +++ b/arch/sh/include/asm/page.h
> @@ -30,7 +30,7 @@
>   #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
>   #endif
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #include <asm/uncached.h>
>   
>   extern unsigned long shm_align_mask;
> @@ -85,7 +85,7 @@ typedef struct page *pgtable_t;
>   
>   #define pte_pgprot(x) __pgprot(pte_val(x) & PTE_FLAGS_MASK)
>   
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>   
>   /*
>    * __MEMORY_START and SIZE are the physical addresses and size of RAM.
> @@ -126,10 +126,10 @@ typedef struct page *pgtable_t;
>   #define ___va(x)	((x)+PAGE_OFFSET)
>   #endif
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #define __pa(x)		___pa((unsigned long)x)
>   #define __va(x)		(void *)___va((unsigned long)x)
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>   
>   #ifdef CONFIG_UNCACHED_MAPPING
>   #if defined(CONFIG_29BIT)
> diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
> index 729f5c6225fbb..10fa8f2bb8d1f 100644
> --- a/arch/sh/include/asm/pgtable.h
> +++ b/arch/sh/include/asm/pgtable.h
> @@ -17,7 +17,7 @@
>   #include <asm/page.h>
>   #include <asm/mmu.h>
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #include <asm/addrspace.h>
>   #include <asm/fixmap.h>
>   
> @@ -28,7 +28,7 @@
>   extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>   #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
>   
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>   
>   /*
>    * Effective and physical address definitions, to aid with sign
> diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
> index f939f1215232c..bb9f9a2fc85c0 100644
> --- a/arch/sh/include/asm/pgtable_32.h
> +++ b/arch/sh/include/asm/pgtable_32.h
> @@ -170,7 +170,7 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
>   	(PTE_MASK | _PAGE_ACCESSED | _PAGE_CACHABLE | \
>   	 _PAGE_DIRTY | _PAGE_SPECIAL)
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #if defined(CONFIG_X2TLB) /* SH-X2 TLB */
>   #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_CACHABLE | \
> @@ -287,9 +287,9 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
>   				__pgprot(0)
>   #endif
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   /*
>    * Certain architectures need to do special things when PTEs
> @@ -486,5 +486,5 @@ static inline int pte_swp_exclusive(pte_t pte)
>   PTE_BIT_FUNC(low, swp_mkexclusive, |= _PAGE_SWP_EXCLUSIVE);
>   PTE_BIT_FUNC(low, swp_clear_exclusive, &= ~_PAGE_SWP_EXCLUSIVE);
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   #endif /* __ASM_SH_PGTABLE_32_H */
> diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
> index 73fba7c922f92..2a0b5713ab80e 100644
> --- a/arch/sh/include/asm/processor.h
> +++ b/arch/sh/include/asm/processor.h
> @@ -5,7 +5,7 @@
>   #include <asm/cpu-features.h>
>   #include <asm/cache.h>
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   /*
>    *  CPU type and hardware bug flags. Kept separately for each CPU.
>    *
> @@ -168,7 +168,7 @@ extern unsigned int instruction_size(unsigned int insn);
>   
>   void select_idle_routine(void);
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #include <asm/processor_32.h>
>   
> diff --git a/arch/sh/include/asm/smc37c93x.h b/arch/sh/include/asm/smc37c93x.h
> index 891f2f8f2fd03..caf4cd8dd2411 100644
> --- a/arch/sh/include/asm/smc37c93x.h
> +++ b/arch/sh/include/asm/smc37c93x.h
> @@ -67,7 +67,7 @@
>   #define UART_DLL	0x0	/* Divisor Latch (LS) */
>   #define UART_DLM	0x2	/* Divisor Latch (MS) */
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   typedef struct uart_reg {
>   	volatile __u16 rbr;
>   	volatile __u16 ier;
> @@ -78,7 +78,7 @@ typedef struct uart_reg {
>   	volatile __u16 msr;
>   	volatile __u16 scr;
>   } uart_reg;
> -#endif /* ! __ASSEMBLY__ */
> +#endif /* ! __ASSEMBLER__ */
>   
>   /* Alias for Write Only Register */
>   
> diff --git a/arch/sh/include/asm/suspend.h b/arch/sh/include/asm/suspend.h
> index 47db17520261e..0f991babc5597 100644
> --- a/arch/sh/include/asm/suspend.h
> +++ b/arch/sh/include/asm/suspend.h
> @@ -2,7 +2,7 @@
>   #ifndef _ASM_SH_SUSPEND_H
>   #define _ASM_SH_SUSPEND_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #include <linux/notifier.h>
>   
>   #include <asm/ptrace.h>
> diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
> index 9f19a682d315f..471db51730361 100644
> --- a/arch/sh/include/asm/thread_info.h
> +++ b/arch/sh/include/asm/thread_info.h
> @@ -21,7 +21,7 @@
>   #define FAULT_CODE_PROT		(1 << 3)	/* protection fault */
>   #define FAULT_CODE_USER		(1 << 4)	/* user-mode access */
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #include <asm/processor.h>
>   
>   struct thread_info {
> @@ -49,7 +49,7 @@ struct thread_info {
>   /*
>    * macros/functions for gaining access to the thread information structure
>    */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #define INIT_THREAD_INFO(tsk)			\
>   {						\
>   	.task		= &tsk,			\
> @@ -86,7 +86,7 @@ static inline struct thread_info *current_thread_info(void)
>   
>   extern void init_thread_xstate(void);
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   /*
>    * Thread information flags
> @@ -144,7 +144,7 @@ extern void init_thread_xstate(void);
>    */
>   #define TS_USEDFPU		0x0002	/* FPU used by this task this quantum */
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #define TI_FLAG_FAULT_CODE_SHIFT	24
>   
> @@ -164,5 +164,5 @@ static inline unsigned int get_thread_fault_code(void)
>   	return ti->flags >> TI_FLAG_FAULT_CODE_SHIFT;
>   }
>   
> -#endif	/* !__ASSEMBLY__ */
> +#endif	/* !__ASSEMBLER__ */
>   #endif /* __ASM_SH_THREAD_INFO_H */
> diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
> index ddf324bfb9a09..39df40d0ebc29 100644
> --- a/arch/sh/include/asm/tlb.h
> +++ b/arch/sh/include/asm/tlb.h
> @@ -2,7 +2,7 @@
>   #ifndef __ASM_SH_TLB_H
>   #define __ASM_SH_TLB_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #include <linux/pagemap.h>
>   #include <asm-generic/tlb.h>
>   
> @@ -29,5 +29,5 @@ asmlinkage int handle_tlbmiss(struct pt_regs *regs, unsigned long error_code,
>   			      unsigned long address);
>   
>   #endif /* CONFIG_MMU */
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   #endif /* __ASM_SH_TLB_H */
> diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
> index 9b3fc923ee287..fec3e89df0b10 100644
> --- a/arch/sh/include/asm/types.h
> +++ b/arch/sh/include/asm/types.h
> @@ -7,10 +7,10 @@
>   /*
>    * These aren't exported outside the kernel to avoid name space clashes
>    */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   typedef u16 insn_size_t;
>   typedef u32 reg_size_t;
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   #endif /* __ASM_SH_TYPES_H */
> diff --git a/arch/sh/include/mach-common/mach/romimage.h b/arch/sh/include/mach-common/mach/romimage.h
> index 1915714263aab..22fb47ec9b152 100644
> --- a/arch/sh/include/mach-common/mach/romimage.h
> +++ b/arch/sh/include/mach-common/mach/romimage.h
> @@ -1,12 +1,12 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
>   
>   /* do nothing here by default */
>   
> -#else /* __ASSEMBLY__ */
> +#else /* __ASSEMBLER__ */
>   
>   static inline void mmcif_update_progress(int nr)
>   {
>   }
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> diff --git a/arch/sh/include/mach-ecovec24/mach/romimage.h b/arch/sh/include/mach-ecovec24/mach/romimage.h
> index 2da6ff326cbd0..f93d494736c3d 100644
> --- a/arch/sh/include/mach-ecovec24/mach/romimage.h
> +++ b/arch/sh/include/mach-ecovec24/mach/romimage.h
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
>   
>   /* EcoVec board specific boot code:
>    * converts the "partner-jet-script.txt" script into assembly
> @@ -22,7 +22,7 @@
>   1 :	.long 0xa8000000
>   2 :
>   
> -#else /* __ASSEMBLY__ */
> +#else /* __ASSEMBLER__ */
>   
>   /* Ecovec board specific information:
>    *
> @@ -45,4 +45,4 @@ static inline void mmcif_update_progress(int nr)
>   	__raw_writeb(1 << (nr - 1), PGDR);
>   }
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> diff --git a/arch/sh/include/mach-kfr2r09/mach/romimage.h b/arch/sh/include/mach-kfr2r09/mach/romimage.h
> index 209275872ff06..f68bb480d3784 100644
> --- a/arch/sh/include/mach-kfr2r09/mach/romimage.h
> +++ b/arch/sh/include/mach-kfr2r09/mach/romimage.h
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
>   
>   /* kfr2r09 board specific boot code:
>    * converts the "partner-jet-script.txt" script into assembly
> @@ -22,10 +22,10 @@
>   1:	.long 0xa8000000
>   2:
>   
> -#else /* __ASSEMBLY__ */
> +#else /* __ASSEMBLER__ */
>   
>   static inline void mmcif_update_progress(int nr)
>   {
>   }
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */

Friendly ping!

Yoshinori, Rich, John, could you maybe pick this patch up via your sh tree? 
(x86 and parisc already got merge via their respective architecture trees, 
so I guess the same should happen for this patch here, too).

  Thanks,
   Thomas

