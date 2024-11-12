Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9E218955;
	Tue, 12 Nov 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439429; cv=none; b=Vx2Xcqz26Dks4jWyoMHryXEJabtAAt0LrBUygTZWV0lrSYkfL0clHq4xgq/S4jWme9nOjp09ifFrJHFfgpNOYoSoWpT7QPgLv2eikag4wwIPBkPmYAh64ARJrd6P6gNUGWpk08za+K8o0Bo33GifZtw4fw45O8n1j5Ttb2Nw8bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439429; c=relaxed/simple;
	bh=+DrR08KfgaMqXVQj+WLjAF6D4Vz9hZ7grhHhm6KdRf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYRw4vnMjH8ybrUsAN7bPaAENASZWgk1XZRjRzReQfjMgW1vBdYzx4fqN4akM+dV/mDztacUXmFICyQCIVJs59RlMqyswSg7CjZ1Dph63zjZEhjF8SvWSD/Dv7Vy7i5MbdxwcHeks3asV3TNN/4fHX8eWOUSwX5PnBoqbIjutrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46089a6849bso42059391cf.3;
        Tue, 12 Nov 2024 11:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731439426; x=1732044226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=514Cwwg37cjDwGlks2Htu/DlMLs4Z4YtnMfe6cEDDuc=;
        b=WpwcsQoiTvfM89sfeBHlB5qtN4udpjZSxai9R+no1xf1lYiGjSAgf0JVKbmWsKPmhu
         oCCiKp9RfJMkOnsgQwct8wjnPiJx3TGLyMyUic7KQfx8iPskCxK/Kr8CUpIvKips9+v8
         M7Uq7jJyHJDwB+ahCUh3xOULa0CjpR+fJlNt4hGD4g05hCEjyrHJskZ9knxanskCKAfh
         P871hdurJmIenAO0Rh8kjNh22mAa5BvAZ03cFRJxHrLFhBhDqL823qhF3D/pcBxcXSUG
         A2jxc3WdasHwuwA8vjU5zIRGuHGutkme/JeaGgygwXzQB9W1U+R3dETjXMY5hA8QWmtm
         t4rA==
X-Forwarded-Encrypted: i=1; AJvYcCVe6qNIA1XEJ1uwF0ysTdQ2JJwv0a2sGjZGXDSb+/yO2d6QdsGZUtF8B30ng9vnUGPeOU72mxIcUls=@vger.kernel.org, AJvYcCX6Rj22sw9ZgnW/qN2Ic6BKjRMRKgsxYl34XHYG46l3Pa8vSipRaZ59kr5cOYYBK81CRqrWpxvslUGuWMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgUj0ApM5JhGXTLBPUA5cgRfE7NWaCoFHvimWva1iCM+N8bizZ
	Er2ZrBKexdWEQe7EEzCgwzi16hJm8CrWQT63flD3HzRktBBlE7sP
X-Google-Smtp-Source: AGHT+IFAV25RZuV+YLWpg6EdKcKzgySKuq8aCBmFO8uEZ8zwSx4/O/r1QU70TbuTgKB1JLBzWjC4HQ==
X-Received: by 2002:a05:622a:2c2:b0:462:bb96:6d5d with SMTP id d75a77b69052e-4634b498491mr4540641cf.10.1731439426030;
        Tue, 12 Nov 2024 11:23:46 -0800 (PST)
Received: from [192.168.2.12] ([70.24.125.223])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df26csm78311031cf.12.2024.11.12.11.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:23:45 -0800 (PST)
Message-ID: <71165bc1-8886-4846-bf11-d1dafae040f2@vasilevsky.ca>
Date: Tue, 12 Nov 2024 14:23:32 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crash, powerpc: Default to CRASH_DUMP=n on
 PPC_BOOK3S_32
To: glaubitz@physik.fu-berlin.de, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com, horms@verge.net.au
Cc: =?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <20240917163720.1644584-1-dave@vasilevsky.ca>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <20240917163720.1644584-1-dave@vasilevsky.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-09-17 12:37, Dave Vasilevsky wrote:
> Fixes boot failures on 6.9 on PPC_BOOK3S_32 machines using
> Open Firmware. On these machines, the kernel refuses to boot
> from non-zero PHYSICAL_START, which occurs when CRASH_DUMP is on.

Hi Eric, and other kexec people,

Is there anywhere else I should be sending this patch to request a merge? I don't see a kexec tree anywhere.

Thanks,
Dave
 
> Since most PPC_BOOK3S_32 machines boot via Open Firmware, it should
> default to off for them. Users booting via some other mechanism
> can still turn it on explicitly.
> 
> Does not change the default on any other architectures for the
> time being.
> 
> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> Reported-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
> Closes: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
> Fixes: 75bc255a7444 ("crash: clean up kdump related config items")
> ---
>  arch/arm/Kconfig       | 3 +++
>  arch/arm64/Kconfig     | 3 +++
>  arch/loongarch/Kconfig | 3 +++
>  arch/mips/Kconfig      | 3 +++
>  arch/powerpc/Kconfig   | 4 ++++
>  arch/riscv/Kconfig     | 3 +++
>  arch/s390/Kconfig      | 3 +++
>  arch/sh/Kconfig        | 3 +++
>  arch/x86/Kconfig       | 3 +++
>  kernel/Kconfig.kexec   | 2 +-
>  10 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 0ec034933cae..4cc31467298b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1598,6 +1598,9 @@ config ATAGS_PROC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config AUTO_ZRELADDR
>  	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
>  	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ed15b876fa74..8c67b76347d3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1559,6 +1559,9 @@ config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  	def_bool CRASH_RESERVE
>  
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 0e3abf7b0bd3..7ba3baee859e 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -600,6 +600,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_SELECTS_CRASH_DUMP
>  	def_bool y
>  	depends on CRASH_DUMP
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 60077e576935..b547f4304d0c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2881,6 +2881,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config PHYSICAL_START
>  	hex "Physical address where the kernel is loaded"
>  	default "0xffffffff84000000"
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8a4ee57cd4ef..c04f7bb543cc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -682,6 +682,10 @@ config RELOCATABLE_TEST
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	bool
> +	default y if !PPC_BOOK3S_32
> +
>  config ARCH_SELECTS_CRASH_DUMP
>  	def_bool y
>  	depends on CRASH_DUMP
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 86d1f1cea571..341ef759870a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -882,6 +882,9 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  	def_bool CRASH_RESERVE
>  
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c60e699e99f5..fff371b89e41 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -275,6 +275,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
>  	  This option also enables s390 zfcpdump.
>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  menu "Processor type and features"
>  
>  config HAVE_MARCH_Z10_FEATURES
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index e9103998cca9..04ff5fb9242e 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -550,6 +550,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool BROKEN_ON_SMP
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_SUPPORTS_KEXEC_JUMP
>  	def_bool y
>  
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index d1fe732979d4..7f39db779574 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2092,6 +2092,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool X86_64 || (X86_32 && HIGHMEM)
>  
> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_SUPPORTS_CRASH_HOTPLUG
>  	def_bool y
>  
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 6c34e63c88ff..4d111f871951 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,7 @@ config KEXEC_JUMP
>  
>  config CRASH_DUMP
>  	bool "kernel crash dumps"
> -	default y
> +	default ARCH_DEFAULT_CRASH_DUMP
>  	depends on ARCH_SUPPORTS_CRASH_DUMP
>  	depends on KEXEC_CORE
>  	select VMCORE_INFO

