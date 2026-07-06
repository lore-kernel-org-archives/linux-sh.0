Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9D433BBE
	for <linux-sh@vger.kernel.org>; Mon,  6 Jul 2026 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355924; cv=none; b=diHX1b1o8CozrE1rXyFx6UxQkZMaXCAs0lkzlwptFol8jEvTmuSJZcTV/e5FjuK6csF7xgWcs/jXzEoeDJzEzEXaIs7iyG9O4aWJe4dqTnPLN17xkFxxLfikbuILHuFXLWokMcP9RsfuWjP6Muf6P3W5pmFwEDYY/MUtKJU0Ve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355924; c=relaxed/simple;
	bh=LXXrq3WMYH21RRXwHJAbth6NPDMWCz6wLIPT6J2ldC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4x0H4qfyq+BvfJZi8R7f6qGItcIQOtMscuv1kQwPoLwEf+RfheBlsEz/y8yqk9A2E4/BeQhJvD3vDyvlc3Y93kZNMbf9xjsOmR2NzUyo8xMvaHkPiVAguriVCkNaWoS9vIF+OwtJGFZK5Atr/3erhSsfAaWiTszu+e8ZQULhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9VRxS/1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9VRxS/1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cae134bdc8so17550445ad.3
        for <linux-sh@vger.kernel.org>; Mon, 06 Jul 2026 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355923; x=1783960723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3YBRTaja8Io8T+OBzHFe+6+gYpexbpRi1HdwVacSuQ=;
        b=O9VRxS/1r2n68dwwwl5HiLbZmhRXu1QgFeMCRXvycDeqR4/D0UMp40vfjuqj8CsS+i
         cs2trHxfoCtLb0D4tTQ99uNwqMTDq750BNFry1d1VMhHEeiJSPYdYRsBXDsH+4ZEVVoe
         iuvcQiP9R4Y+HvhqzsZOjmO6PUmfkq41YebMPn11ipcSujYRS5ChntitjdNP8MisI7wC
         eJDsIpFwAj//Euks/1b0arbQDn+yitFaHhwxqGOHch0RHJvst0Ys6HUYfwV68Q977E8s
         dd5R0gTOaIBU4cgcxEoVpsPCXeQDEUSyS0hZz8yvHWbQTMyK9HLdTehvDML65DCWw1H7
         lXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355923; x=1783960723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3YBRTaja8Io8T+OBzHFe+6+gYpexbpRi1HdwVacSuQ=;
        b=OKDxMnvh0GBmDiVrDjQy0Ld1tjG95PTPPRhs0ZALkpyiT3FdwSPPO/oiKFxy5aI3Vm
         nBlr7btagxuLBHQVozBGSaHKU1EalPKqjS+9og/oDjvMUMIb8N3jGS3a+AjBwmz35GLN
         ayuso6BSdNAL9Rk7kZ8BEtwvFhqRYxMnm7O30x0+Syvp5uQgzJDrT5nH75xTpBVXo/Q2
         ujEu+WgW5chqE4ZEFcJ998bCXnKQux1XNW8ITn0f8PnF+PhVDWn2HZ1FdKGUgWqEvO7j
         7XbhMKA2As4fQrNMa3GQjjK1+O1h6gn3ZMy/mWWqzjfJhvJNiwik8H9vNQRcr3tForhM
         IV+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp+ykrVAT22DH+/I8N11DZ224y2s0u/ulhrq1KiQpHkCUl8duaGD8kDiXseV/I0UvyHv9KwGr1gEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysw8rl05ILY7xBHwPi8b/YKMCZL3s2y4E+boox2VR0/g2Fdy47
	ThS5JGl0KIggSS7Y7gpIvNFmQUqqNAVe8jVzIdGs9LAkYN9J+DXnx3PD
X-Gm-Gg: AfdE7clrxL//U9dZBIND6/2f7pTTw4inrnvJ8ZZ5VI//T6HxTatImHXn9ecJEt3LWVt
	ZiAzB/Awn7+X0TSvw6ZxHQcCghKkeHzs5CTg1Q4GKB+IbsoRyET/NDquqfef/XFid2tBQGq0Xzj
	r177HHqSd7vxvl5FRRMPCF8/6SpZ6SIZmOWmlql3QbbvHug+VpnMr6j3BBceB8Az/HFvmGVYqjK
	2fFM+gpQqD5wzQnkMqkDDpkHitjPHBYWVF9rL/JPbPjxXUbzAiQ3glHCUzHVXe/Q6vnMhiRsMea
	jeaibPutkSXaK/koIFaQq4N/haNkZmkKzxOq/w7S4rw+p8ZvdRsZpPc3ie81KrvoDXBbXHCaMdw
	7NKCLrnVbBgDg59iwlVr+nKqGu/Ow+75PoapFPN/+FVP3h5wY7InRiC2ZbuMMF936Xjh7KBorjp
	jKUNUdD+s=
X-Received: by 2002:a17:902:daca:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2ccbe729635mr13347365ad.14.1783355922667;
        Mon, 06 Jul 2026 09:38:42 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7893a8dsm53103305ad.73.2026.07.06.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:38:42 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
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
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	x86@kernel.org
Subject: [PATCH v2 0/5] treewide: remove unreachable memblock_reserve() return value checks in early boot
Date: Tue,  7 Jul 2026 01:37:48 +0900
Message-ID: <20260706163753.193875-1-ekffu200098@gmail.com>
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

---
Changes from v1 [1]
- add reviewed-by tag
- rebased onto latest memblock for-next

[1] https://lore.kernel.org/all/20260616182959.2429774-1-ekffu200098@gmail.com/
---
Hello Mike,

Like the previous memblock cleanup series, could you review and take this patch series to the memblock tree?

Thank you for taking valuable time.

Best Regards,
Sang-Heon Jeon
---

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

