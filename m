Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16933D669D
	for <linux-sh@vger.kernel.org>; Tue, 16 Jun 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634612; cv=none; b=V3XpuMoZnnQ3upie50/xvR/eTTr6vCb7l9RD58exe+PGFlo9ge93eD593plV6hbUvHdsApyQP29eD3SQJMEGEMsMmWW1xBUQ+pW8vqVlapVzQ0sCIkuLuwdzPIHGZ/aoqlsXpPGxkuYJryu+HqQjJbqVrb0nvZZ72T6nhGareSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634612; c=relaxed/simple;
	bh=U2bfHtoJeOkasncTz6MQSAvgazv6WmGLk781Lw+Ys/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsEnFaDT2xCU7iqhBvj2QhTJEKQzFa/JG7Pj9xF4KnQmYW3aEiGBJNazMraE6eialKdirrsFO6p2Enkr72PE23tR2Nvy8IOqobLC/t8oUy+K7KTtOLSR04Gr1adOnNJxYama3Z2oy4Wn8JKAeLtwfP4XFMOJYJfGmF1zp9Qtkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuerNG2a; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuerNG2a"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36bb3551f6eso3892048a91.1
        for <linux-sh@vger.kernel.org>; Tue, 16 Jun 2026 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634610; x=1782239410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv06OEZvF8tRVAKSy2Zj2XParkcF+9FcOKnYnV3pt4w=;
        b=HuerNG2a9yoXsyaM0HVW7teZpRnwceBOEr0gIuh6ZZaE2G30auaFWhu2GV39UMNCAn
         SSQwlxfwWlYju09FoeDT5oRKz7pAv5w7r0Zf/DNHmh9VLB6mQK2Ne4wWRgg6Mb3WThh7
         wQKwXG/PngJlGaJXQoOA76iUiZeHm8BPPkj1S7g1EBkU3zs5oPon4v+Vt23ilSY64F7Y
         I5HOU4IRhdH6XcHsKRr7GCR8sp39Qe0F0AVnCf3szITP524hYvd8iAYU/enLhhvJygCL
         j5jRZPplDJ5QwEValn3fPQClflYdkdogvRzrBV4N8e6IeML+4jGzjYGkTVukP4hFWeAt
         VyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634610; x=1782239410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv06OEZvF8tRVAKSy2Zj2XParkcF+9FcOKnYnV3pt4w=;
        b=p1EhDGkHDxczDUqLtKz0DopJx5QkcmFJ3tZm9o8op8ig4XKT4iIkTvAF7r9mcG7BRE
         myVwO2w4abr23HkY4U8usfwUaKjGGLnI4x2skGxxANK8kY684MJFcFVMl/sDrvMAKJTp
         GzXGUfTk3OWhqEYebISC/G4eJIO1XA+CYRdL1X2DFQIz3+fOkm5E3l3WCTmaP7B7/lzm
         rCMVtmswPVThz3qdZVCdZx7/weNXJDxd+V+IhPiW6qgBNqzN0qJ6C5FoBicAB60hxcVK
         tay7oTCwGZdhfHvDr5YDM0H1KVjEXHbP9uQNEY5wctTtnc/pV5S5UYHC7McwATwfGER4
         IShg==
X-Forwarded-Encrypted: i=1; AFNElJ/XQggL6e+eJV3LJHikXeHCzvCYD2KrBTXavl8M5LK2OzU5rFk9uM29oiZqMUf9XzSphWQamGjKlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1ZW3WXCRFa1IYhg/ZTXfccFBG9DWYh5c3n0diZHTy2AE0TzZ
	LrjF2e4yOKj9n/S9fnrSalIfEZgP0up9h/gRD4gVPYIzX0BASNEYdCws
X-Gm-Gg: Acq92OH6fCluKn2vykBo8veKfaah7H0IBqf2Dgj6CNIkpRa9I3Ed/3HAgd0pv6w+saC
	tFpflpK1CQSgY4fX0xl9KbEltZRXrHU5SW42uyn11d/lamT6xX5FpEUaCmEWuqJD4jk6fHIcIIN
	VRcamvqtAMMFlJgx8Ddaep3Sl/k1WZRNUw+sSPTJUiZs78SDWhbvpxky4+XEKNlMZHdy1gscUCB
	4B/YV0VK4QMavFxj/qRNOV8iZFtpQwL2HlhW5k8K63PwxW6rYznj9aQsaVy+N5457jLl4vm60j/
	lcK6YT8A/8BbUIFVI/o6RUQaMgHPa20yNYXnkmP31w32/rv/iGqdOf8Oj6pgr9E6tqSt3yBI1/T
	yItHsL/G/97612zM6llRJ9cRT0QJQpZ9bioef4y+rmPx6hDZJaKQmYdQ5LHC9y7T8Cc+A2Cnvc0
	ELB+Km0MnvERdYMOwMdg==
X-Received: by 2002:a17:90b:1fc4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-37c9343455bmr629532a91.8.1781634610240;
        Tue, 16 Jun 2026 11:30:10 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43345e3ffsm141092685ad.71.2026.06.16.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:30:09 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	x86@kernel.org
Subject: [PATCH 0/5] treewide: remove unreachable memblock_reserve() return value checks in early boot
Date: Wed, 17 Jun 2026 03:29:51 +0900
Message-ID: <20260616182959.2429774-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_reserve() can only return an error after memblock_allow_resize()
has been called. Before that it either succeeds or panics, never returning
an error.

Before memblock_allow_resize() is called, the return value checks of
memblock_reserve() are unreachable and can be removed.

All the call sites are in different trees, so I split the change into one
patch per arch/subsystem. The patches are independent and can be applied
separately.

Sang-Heon Jeon (5):
  x86/setup: remove unreachable memblock_reserve() return value check
  sh: remove unreachable memblock_reserve() return value check
  powerpc/fadump: remove unreachable memblock_reserve() return value
    checks
  xtensa: remove unreachable memblock_reserve() return value checks
  Revert "tpm: do not ignore memblock_reserve return value"

 arch/powerpc/kernel/fadump.c   | 14 +++-----------
 arch/sh/kernel/machine_kexec.c |  7 +------
 arch/x86/kernel/setup.c        |  7 ++-----
 arch/xtensa/kernel/setup.c     | 13 +++++++------
 drivers/firmware/efi/tpm.c     |  7 +------
 5 files changed, 14 insertions(+), 34 deletions(-)

-- 
2.43.0

