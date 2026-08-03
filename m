Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84D2BE639
	for <linux-sh@vger.kernel.org>; Mon,  3 Aug 2026 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800450; cv=none; b=uRv2bi0IDPs1r08jhVAaXZtjBs1dXlGH7l/h/K4iS7G32C5V3Y+KgCbY8S50KLxvzlw2w6Fd0hVe2e4SzpGXWPY/90W7/YG1yyPLc9RJL2t5rdNB0TqTY/6BJI0RdRLsJe4/oH/bTNEE+P9oiEFLXFTPOaXzia5XIE9Ica0Ty3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800450; c=relaxed/simple;
	bh=xmWuIF3gvmbx4DiLSNyVNuxpNp9mTMt+/4AKY0oZYD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r8pyytyDZ4T3DN4rwFXdAlEcS7ZlAow1HzjGr/RaZ9gQTNysPRz9of+cx4xmLD29HyWVJ7mFWePn+GzpWreCt6GYnH9GTFTvuLZbOaVbGDKWg6nQvKrkUrM1swrWjO5rvldltODOhQAiyiOOkZ8iUbRY2PZXZ6A/4WX1SzWBslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJqzHwRr; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJqzHwRr"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66899c7b57bso5939707d50.1
        for <linux-sh@vger.kernel.org>; Mon, 03 Aug 2026 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800448; x=1786405248; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U+7Ru6jZFSxz7ibFdQEbmpjCAkPd7K+3B96IxICOxK8=;
        b=LJqzHwRr7gEY9qMY/x/cI42n0OwdoPFXgRESTQ97I2VdoFtzXbrmZSPJaOUyZ2fuTv
         Ei2oFFCfMIBsvyPXpu+DyAm3x67V7slOIcW1z2njG6Qf1AcFaaDraIMTiCy2wC7u51Lk
         Ypg+CG2tfZOcvajkhdeetluhMfGpUs0k/mF+21AmLvYWxGCNBQDnqtmZOEuDwbMPHapc
         2g/7VXvApzJRTMzjT3kF/yjt79JL1cXQjclqecc9oloCPHNOusewSzMFHOZH8wQqW3na
         wFpJlUDfNYAWjNvDSuIoVyLBLPWZf9vm3ToxDPPYL8Ne912bYEr5utodA0oZD5gI18mG
         2j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800448; x=1786405248;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U+7Ru6jZFSxz7ibFdQEbmpjCAkPd7K+3B96IxICOxK8=;
        b=sSG20MzNzN2+b83uq4omXjhRvjFOSWoIrYueMoFDLC36fiyCm6ctL0X6c4MBNmcT82
         BSfnxtCLJVeP2+tIvhpZudKc1Zxqm25vBAxs40WLI9Pbc5LvNqNrciOXHFERjGQ0qnVs
         QfWb/bDRetg3DuQg7Uw6YJC2qyrOUvcCwjJbP+gtoMU4CmXQO+bofGOWRX/jorrH3FB1
         vdWKd6LUdvYrZa3USS/h9hkuEnpqNMdResdM6o3oREu1vmSy1EF/1p7NEjOnu48dYuUv
         6dDjlyDWFAChIsi2EUOwzJdoIxL4srK03KysFgi2dmRNRPCv1xZl3IhDu4tuA7Kh8tVD
         zWDg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+mGWreYBcozEZ6eJAkbPnkfgkv98FMmmH1do552U+ZwDdwpsXHF50gKAd9hO8mPz/4rwQ10k32g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaT9Z6Lt721ct1GGuVvjrVK2AtWc3uppIUzFOif+ruEyLaKsJw
	r0XOd2WUzsUVsi6fOnlBtsrXf4HljAiqK4qePzuKUVyi0IOojGgZR5+l
X-Gm-Gg: AR+sD136tVHSKVk/wQRzRbw2P4UcpKXMfmviZCel3yOEvrLaxhBH5Rmy/X+fn9pI5ej
	vgnoGSq+hMbcq9elNyybMZ0EsOmT6cH8MLuV1pnzvTFTrnvva3QmeDnVY6JwGsU1uDQ4hNN1Q6t
	aY/EQs0XAcRCTF0zVGh/2/TMFZsIrZnOV7loJMlMq1qseEr23JjZngzmvqAI/diSYGqqqNrGLjS
	LZ8IoXpbRpNmXF6zQsLL+UpMC/WJ9NKLU71tKQKA+jJoG8Xxerqx6G7+nLYPD/mK6Sjj9tv3nVN
	7zhl8j9JPaa4uwPZ+MsVMFqiiJOQMIhoOXCfRfj60ORu3lYNTFW+xjyytEM4d0ZlGJ7l7Y5Ku0s
	nf0zMQGSRRw/ttponVnXaWU3F9lXq928dLn1eK5WratXMsgfsRTV18P63T3f9e/APE0DbUCStTl
	R3pmzzZKm5/rPHumaVTM9oad4Q0r7Qu/HgN1ksq9o0nkYizx6a9bsDuPGv7Kg+yqJx0m8JTzij
X-Received: by 2002:a53:c745:0:b0:668:43a3:9db2 with SMTP id 956f58d0204a3-6694f17d897mr10635045d50.32.1785800447478;
        Mon, 03 Aug 2026 16:40:47 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948b98babsm6681654d50.0.2026.08.03.16.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:40:45 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/3] alpha: fix floating-point exception state handling
Date: Mon, 03 Aug 2026 19:40:44 -0400
Message-Id: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsGKsvpKdBBbcyFMNEIQ/550H
 JiZDJECU4S1yRDo5ci3q9C1DWir3EnIR2XoRT+JWQyoLm8VGo+UNPmn6hFHLeWxkBilGqCWPpD
 h9F+3vZQP4EcgZ2UAAAA=
X-Change-ID: 20260803-alpha-fp-exceptions-5c77d9e057a3
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

Three fixes to floating-point exception handling on Alpha.  The first two
are a pair and should be applied and backported together; each commit
message explains why taking one alone is worse than taking neither.

The first fixes ieee_swcr_to_fpcr() setting FPCR_DNOD unconditionally,
which disabled denormal operand traps for every process using the default
FPU settings.  Instructions built with the software completion suffix
never reached the kernel emulator, and the hardware silently substituted
zero for denormal operands.  This affects anything built with -mieee,
glibc included.

The second stops hardware-fabricated exception bits from reaching user
space.  On EV6 and later the hardware writes exception status into the
FPCR before delivering a software completion trap, and those bits can be
wrong for the instruction that trapped.  alpha_fp_emul() only wrote the
FPCR back when soft-fp raised something, so whenever it found the
instruction exact the fabricated bits stayed visible to fetestexcept().
The exception summary register is now passed down so the handler can tell
which exceptions the hardware attributed to the trapping instruction.

The third makes the emulation determine tininess after rounding, as the
hardware does.  soft-fp had no notion of the distinction and always
determined it before rounding, so an operation that trapped for software
completion could report an underflow the same operation would not report
when it did not trap.  The two paths disagreed on the same machine, which
IEEE 754 does not allow.  This adds _FP_TININESS_AFTER_ROUNDING to the
shared soft-fp code, as glibc's copy already has, and sets it for Alpha
only.  It defaults to zero, so powerpc, sh and sparc are unchanged.

Measured with the glibc testsuite on an UP1500 (EV67), with
CONFIG_MATHEMU=y.  Without that option alpha_fp_emul() is not built at
all and roughly 830 math tests fail on their own, so it is a prerequisite
for any of this being reachable.

  glibc make check subdirs=math

  before                              831 failures
  after patch 1                        48 failures
  after patch 2                        28 failures
  after patch 3 (and glibc fixes)       3 failures

The three that remain are a GCC bug: a long double to float cast on Alpha
is lowered as quad to double to float, but C requires it to round once,
and the intermediate can land on a float halfway point.  Two glibc fixes
are being posted separately to libc-alpha.

stdlib/tst-tininess passes, which confirms the hardware determines
tininess after rounding for the results it produces itself.

The shared soft-fp change was compile tested on sparc32, sparc64 and
ppc32 in addition to alpha.  Only Alpha was tested at runtime; elsewhere
the new code is unreachable by default.

---
Matt Turner (3):
      alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
      alpha: don't leak hardware-fabricated FP exception bits to user space
      alpha: determine tininess after rounding in the FP emulation

 arch/alpha/include/asm/sfp-machine.h |  4 ++
 arch/alpha/include/uapi/asm/fpu.h    |  8 +++-
 arch/alpha/kernel/traps.c            |  6 +--
 arch/alpha/math-emu/math.c           | 88 +++++++++++++++++++++++++++++++-----
 include/math-emu/op-common.h         | 23 +++++++++-
 include/math-emu/soft-fp.h           |  8 ++++
 6 files changed, 119 insertions(+), 18 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260803-alpha-fp-exceptions-5c77d9e057a3

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

