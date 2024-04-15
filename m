Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3F57876
	for <linux-sh@vger.kernel.org>; Mon, 15 Apr 2024 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178035; cv=none; b=VtZAD4gGq1qwR3eubjFbfRzacl+gnsDfSY80qorvhjslkE8ubC/Cbzc/89mfxJ32ubSaSUkLVOYpgUbxCXUn71eiQIbCRo7RWaO498ZhQUZxJcti5jlLLQ5iAsb7J+x76NcdgSCjWB362FIeaydDIwPabWyp5NTi6Qwa9uoX+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178035; c=relaxed/simple;
	bh=W2Fbao+/FlwxfuGH1OFvZW2kvHWXUxBXy9sroyi2Gh0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Xui0O0wHb4NcFBnBXc75ikFYpAs9P4Yam3LfJHCnyYI0LIZlRhPZgcoUzovm8distMAJI+3X4zlaLWBz7R1eR0OpFfwLOF2imPfpkna2Ce/Sv466A7OsA7GQvP/DEfG4OyF5qkAdm8v4UP0foJZmeySSv6w2OUR/0FitjUANgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgCYMAmR; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgCYMAmR"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-479c0e8b1c5so894711137.1
        for <linux-sh@vger.kernel.org>; Mon, 15 Apr 2024 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713178033; x=1713782833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5kbitX8QbhgxnsV5uCd0z4f/iShjUxkr6d7+ekg5tWU=;
        b=GgCYMAmRx3oR3IwqHhCAAzppu7jBJndHHIemaE/dDrZzLwIbVz2vSyEF1fwNwlKi3J
         unT4b+vNvAoA4N9fYO+ohqdbZdjzuRcpwdWr0e8BkJLMigBH+mj+W3OLCwPKuQKPs1MU
         mlFY98HFmeBDcjeq7tsb8QsSK3eVGT42mspwhODnm/o4Pd2eLBW53LKYTsC39ciJ83Xb
         lCDCSNqeulGVBve5ayyfZeE9nKJvjXCK2cfc54jZc6hmQz4EF77isuNHYelB6OrDy22G
         1/wQzu4cKh17DK13euQVm1e8bwCF1HZ/K6Eg98bibP4us6Tl0Y5ltPdapOEAqpKVom9u
         c5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178033; x=1713782833;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kbitX8QbhgxnsV5uCd0z4f/iShjUxkr6d7+ekg5tWU=;
        b=SeFn/LRG9/jX4rHKuLl8QVXvgTHvPiTKbzTyfcLend0O/injY1yPPuOyuLZga0kwnl
         dJQCQRJfsmbWxi3jnAFcqrIWgGIJsqdz+HSHFi+UmBTwsk8N2wJsiexHsid2dT9J2w8L
         dyxxqPvygz57a6/DIB1B1QpO1DapUCaeKJ0sUlwV0R3UaT+7BC1ly6AP4c5L6BGkDjdf
         auB87pq6YlLVjEON9iRndUfHF7o67Kv/EtkadnzRFutt59jqA31GoRbAWcO6VKal1y89
         lycZGFMQbLaqLvSgAe09Z4elpfHP1Yuqn03RgAp34iKDGJqeRCDvRPBzLP09a1O1PK0V
         6jvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVZAMnLevRGk/6yaHJldcIJx+obaDQc9LDOvhtE2uVoxhi4wmYfdYkB/rLa+sasaw0MSlXWQ9PjTR+XYkmhNuPdwIO2p8aT/E=
X-Gm-Message-State: AOJu0Yy2+cS51k2COik2LjwgFBD8VkyT+Kfj+iGjICqe5iANXE84QnW2
	ukxdE8V/AdE/KyXGMvt9MmK/rrShbJAvsHdso2/fLf9hKuHhcLCHD9W8pbfKlfZU+o/+B4x5wYF
	A15leNzEqh98tWIAaDs64XtqhhHhNwxIh21SHJQ==
X-Google-Smtp-Source: AGHT+IE4veDIOcK0vTkuxFAc8PebEblKLgDeLZg7etQEi0PYMGKyP1c0eS0dCvLk7/PMRnxeklqAIbshIYBCJ0ceNwA=
X-Received: by 2002:a05:6102:3590:b0:47b:8ef7:bc1e with SMTP id
 h16-20020a056102359000b0047b8ef7bc1emr175678vsu.15.1713178032756; Mon, 15 Apr
 2024 03:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Apr 2024 16:17:01 +0530
Message-ID: <CA+G9fYvMdqT3BFNkspktVVtVqd=en8-x3Oz1Ekfia+cceV2LHQ@mail.gmail.com>
Subject: sh: arc: cmpxchg.h:50:12: error: implicit declaration of function
 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>, linux-snps-arc@lists.infradead.org, 
	Vineet Gupta <vgupta@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"

The arc and sh defconfig builds failed due to following build warnings / errors
on the Linux next-20240415 with gcc-9 and gcc-11.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Following builds failed.
sh:
arc:
 - defconfig
 - tinyconfig
 - allnoconfig
 - vdk_hs38_smp_defconfig

Build log:
--------
In file included from arch/arc/include/asm/atomic.h:13,
                 from include/linux/atomic.h:7,
                 from include/asm-generic/bitops/lock.h:5,
                 from arch/arc/include/asm/bitops.h:188,
                 from include/linux/bitops.h:70,
                 from include/linux/log2.h:12,
                 from kernel/bounds.c:13:
include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic_cmpxchg':
arch/arc/include/asm/cmpxchg.h:50:12: error: implicit declaration of
function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
   50 |   _prev_ = cmpxchg_emu_u8((volatile u8 *)_p_, _o_, _n_); \
      |            ^~~~~~~~~~~~~~

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch arc --toolchain gcc-9
--kconfig defconfig
# tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig


Links:
---
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240415/testrun/23463978/suite/build/test/gcc-9-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2f7sIl2MlKB5Fgq7JtTpYQ9lnXw/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240415/testrun/23463981/suite/build/test/gcc-11-defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org
