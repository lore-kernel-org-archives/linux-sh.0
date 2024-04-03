Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0A5C8E6
	for <linux-sh@vger.kernel.org>; Wed,  3 Apr 2024 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130817; cv=none; b=MznjzlTefRLouaVP92/3IKC0wURx0QlqEXgcgno+N19FsM8KANc5PnoAUVQsu4sYM0RFmcNa8+MKx3BQ/DvhW1mN2PgJJOvwsOYIsyv0pTVhdcbaHfVqtoBcGsJtJEktbOjTT6gvUA3rELs44NfbqZjGkfzJFhRd43ZCQznM+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130817; c=relaxed/simple;
	bh=lu4lr9wamx7dI/HCTq6kawIsHy+GqxMxRmNu/rjakdA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BoAQNbHb94wtF3VjW77vXc1sstNfOptU7g/LRSxhbvmF1NBKKNFj2MZa6bRppnw28hX6r7vJs1Rx+fi0sPEDH4AibDiM3K0BiTotB3rXkIMBJ4lCcu3vuKjVTl2suLksOvKuv3OizQf9cq6LXhEs73TPy4ETjsdEC9l9JOwJpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrtYJFNn; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrtYJFNn"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7db36dbd474so1614085241.2
        for <linux-sh@vger.kernel.org>; Wed, 03 Apr 2024 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712130814; x=1712735614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z7p53XmkkGTALNH4Ix0xvzQLOZKvgVhwnYYuHGcSQF4=;
        b=MrtYJFNnPC9VhWUTMqaUxXOT+wiTRoVAdLq9f65kxYqzmMsr6NQGUYzD05TmJEnEcf
         ar69I7VjL3kPopRwa/Y7IgDEzVYlqrxlX9S2dpsOHNC/e0atozXduTBZl6fZNHUAfsdi
         2JVFtNvgnue09yJkbZI5RWzzJaem5TdDik5BhUbu8IxVAoxYr9f0sTi/uy+kulwBX2P+
         750tu0rewg1l6uYRl1GX8HQuX1W/lkzmx9QCiE0pmKs9/BUePI79DvY0pk67Fp61bSUe
         JnoD7Rp2k9iVeVjCihSXRAVrGCkzfdjjTOS5wasdJ44XBCojFqI/vWJfyRH0ZtkzboBd
         704Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712130814; x=1712735614;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7p53XmkkGTALNH4Ix0xvzQLOZKvgVhwnYYuHGcSQF4=;
        b=MtQ5ITwq0xKuMHhqDAZdMFvAfQYvHJ5sWaKjRbqHL1uroSF+HoO/1t1BQ4FBtvWVcH
         ReEwkCDy69d8HMfuFwVy6B/NDqiJFkYLYPWX6NVYCMLn1s7ldGwoE7r1bA9V235qQmdm
         iKGhUwKdKKl+17SlaBpxzk9J7PRbhv++mI2mipM9mrMyYoz33j9ZWpIzUdbuRxQEcLSS
         zJdnE7VBwyGui4iyfAViXBJ+aZ6Fpy+SMj7TEAFYWXFtX6E6DGLF3D3FYW5GMBGpq3/f
         TiunczZpuOY7N0/KB5iBuQDYqf6IuqsL3LDiKQsZ+0nASY8RDPp84t9/sWiIpIr/OWpx
         GI5g==
X-Forwarded-Encrypted: i=1; AJvYcCUWSObPkCbudPUoZtBnV9QvslnXca03ljx2m5J3vYvFBSCwml3Wand8cCSVK0qtgTzYIyM6p4nDObzm3UmkdwXlBwpooPCwZo4=
X-Gm-Message-State: AOJu0YzMIMcEQqLJd9uJjzeRlpOwI/BGsDPmU3jH1iW+TRt7OdfCpQNB
	L+qQYDrIQf8d6RFGSUafk1N1kKVhqy1mLazVM9PavWo13MWQup393aoOuugwaxKDDucA7xzyH9q
	bzNxtbL3iuRHx/72x0MlBJQADSHWN9vypyE9djQ==
X-Google-Smtp-Source: AGHT+IG60A9cZw5q2ghP0j48oSICnM4EvMleBb57CwMtDkNbKO547PHL78ohs2lagIPlHsnadarK5o/Vf4QbZb3wFa0=
X-Received: by 2002:a05:6102:4bc6:b0:478:8714:e1e with SMTP id
 id6-20020a0561024bc600b0047887140e1emr8289869vsb.4.1712130814422; Wed, 03 Apr
 2024 00:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Apr 2024 13:23:23 +0530
Message-ID: <CA+G9fYvUwyf-5yB=xZVAPXrF3C9z==7bbhDYBnX9jdJ1PxzPnQ@mail.gmail.com>
Subject: sh4: parisc: asm/cmpxchg.h:60:24: error: implicit declaration of
 function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
To: open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	linux-parisc <linux-parisc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Rik van Riel <riel@surriel.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The parisc and sh defconfig builds failed due to following build warnings
and errors on Linux next-20240402.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

parisc:
  build:
    * gcc-11-tinyconfig - Failed
    * gcc-11-allnoconfig - Failed
    * gcc-11-defconfig - Failed

sh:
  build:
    * gcc-11-defconfig - Failed
    * gcc-11-dreamcast_defconfig - Failed
    * gcc-11-tinyconfig - Failed
    * gcc-11-shx3_defconfig - Failed
    * gcc-11-allnoconfig - Failed

In file included from arch/sh/include/asm/atomic.h:19,
                 from include/linux/atomic.h:7,
                 from include/asm-generic/bitops/lock.h:5,
                 from arch/sh/include/asm/bitops.h:63,
                 from include/linux/bitops.h:70,
                 from include/linux/log2.h:12,
                 from kernel/bounds.c:13:
arch/sh/include/asm/cmpxchg.h: In function '__cmpxchg':
arch/sh/include/asm/cmpxchg.h:60:24: error: implicit declaration of
function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
   60 |                 return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
      |                        ^~~~~~~~~~~~~~
arch/sh/include/asm/cmpxchg.h:62:24: error: implicit declaration of
function 'cmpxchg_emu_u16' [-Werror=implicit-function-declaration]
   62 |                 return cmpxchg_emu_u16((volatile u16 *)ptr, old, new);
      |                        ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Steps to reproduce:
------
# tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264271/suite/build/test/gcc-11-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264273/suite/build/test/gcc-11-defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org
