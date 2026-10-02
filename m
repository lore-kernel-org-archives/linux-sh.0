Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA32F8EA3
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914354; cv=none; b=GdRR1wb1TS4YuG88vFZhoU/DYCLGM5CgYziBYJlJU+/sF8IlyLslfSKLg/8jj0RFnFs+qQ5nMOkrZNsEaECMkMdvm+alvE/6boT0RTMGDZKByND/40uIy2akKAjyUOmYG3a2K/LPPbl1pYPwsq1FHFBZoeuSG4W1pMXXkczPHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914354; c=relaxed/simple;
	bh=0E1g3hXNc5T8+/OlUAY8brg1X8dtkBJnFxFcV9oaR0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cwi1VakhcZx2uNPNw1OgXAmXljMIkzSnS0OUFePkVnPtKQb50Qnv2zsJeiYiy31JujPjCfZhe9uab8fJct7Yo0kr617nTj1CIKHPfDfPudhjyZkobOzMVNbEBApd5yujgkpixhxvY58cFj1gXJSE/hLBBnTL8kWYixZTCXHppsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snqNe9pr; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snqNe9pr"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so57697625ad.3
        for <linux-sh@vger.kernel.org>; Thu, 01 Oct 2026 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914352; x=1791519152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cCFmK/EgwoNthwJ9N2KvLBJFDohYa1KogiEhV4aDUrk=;
        b=snqNe9prnhr1KZNXyod+lUQDu1cbnYtQ6ssPcD3N2FrsQ4Swcy4EsTcueXQnmFT3j6
         X0a7yVkqui+PY91QevG/tAsqa5eTfM4gwf+ZPyNNecRh2liovZEdvCgvGmJED+ZtUvgN
         XeotJ2nuMbSz4QIJJt4b5y7QjA1w7wgHRGdmkjXhLyIq0Ln4h/XkP0jBwEFjeoddjJ7t
         p1oZ0bHSdloPFDI5SOHhv+KoNFk1AVXjIzapRqn/UbR/GGYeCIdeHv6hS+Ks+08wrwMy
         bzKMPtqCK5Ps7KpgznhtnzhDc/r5Nazq5MelzkmRYVnGI0SfrDO9elUqCQMW74bMuDY/
         E8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914352; x=1791519152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCFmK/EgwoNthwJ9N2KvLBJFDohYa1KogiEhV4aDUrk=;
        b=D/dUswy5GNr+6/lXKXXpxBd9XCDuw7Bx0MTOjVPERjYi/og7l6PUk9qho6g8MtH464
         xkwnmr25QzMbVtVcRDTvk5efJTxhrEY2AY+NpMXtz9gncPF911GdIxbKvtwNjvBqr6IQ
         0C0wgGHMXCp4hb6qt/I7TfYL3Zs2K0ZcIKVYA2RxI/uiibQZRqlnG1a9m3rMMeb+FM0h
         YmGgi0KcsHg5UnVyVa1LAKylk5qAYNR3fdY9wPfMjM7PITFMV15lQVm1U2gKYMIrftsq
         G6lpkm46eUum0C51wvQWlhvJr+ubdgVmh3K/0hE9xkSK8i24mTCivnRYPHELIxW2uZWt
         /Pfw==
X-Gm-Message-State: AFq9FYI84ZLJBqiHyaesx+vt3E8NCGFjWB2uNbxmm4ne0Ywk8bQVBYuV
	Xwj3HAF86yy4yrWzQFQMNAYrgmwPzaeC96+uzRM1d5hYDwBF+fQKTwjVt5663jVi
X-Gm-Gg: AYBFou0ykuhGO/FlZ4GOpWx6v2Dd3Dt1hAWTnxQHi9LOWXi4hEtsofCpSapTiIIasam
	PicNVH+/NWe9+2W51V+xj0YvOLVF5Q32+u+cjtqjD2g9GuUei+gzrV11EsXjX6UBFtAPrB750hh
	CGnW8T4zLFvwIk/wKTBsTjlU+44OQyXG0V3/cdh/3otjAStGt1URdvl+IyXfn1VbxWbW0+T5pO1
	QtZ/s4lwHzFbk6iNqaoEFOfl+8YUxxyuE8hWeVaksek5Ahi//glLy9eNbpzeh6z7vvL6bWeLhKF
	NgZfgyCD2tDSKvjDci9uwC53VcEeES0/uPWxgSSz0mcR7hczKhXR1OaJloUEqQx+D8vK5q8suro
	E8HFq6i5dZWRvrBUY9oDqlav28j4HQlyKeeFzPdJK5v/aDSSte67hZLaREYH100ygdyQasob/dp
	vR2wKbfwaq9886A3ycTN0g5yPvv0Nu6qqe+w8rPyNyy2xNT+QkJh9RYYJaC4GtKrPibvFu7IBzO
	hI7lNkXu//IDpJrOeHuCyCzQtkclBJF0xcGpA+ArteT/BOtoQ4tp/DfOMQ=
X-Received: by 2002:a17:902:d492:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2e499f0d039mr14172415ad.3.1790914352482;
        Thu, 01 Oct 2026 21:12:32 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f680403sm3484055ad.25.2026.10.01.21.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:12:32 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2 0/2] sh: add initial SH7305 CPU support
Date: Thu,  1 Oct 2026 22:12:18 -0600
Message-ID: <20261002041220.133911-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial SuperH support for the Renesas SH7305 processor.

The first patch fixes SH4 compiler flag fallback handling for toolchains
which support SH4A targets but do not provide the plain -m4-nofpu
option.

The second patch adds the SH7305 CPU subtype, processor name and CPU
probe.

This is the first small architecture level part of ongoing SH7305
enablement. Platform specific clock, interrupt controller, timer and
board support are intentionally left for separate patches.

The SH7305 support has been compile tested with GCC 14.3.0 targeting
big endian SH4A.

Changes in v2:
- Use my full name, Artem Novak, for authorship and Signed-off-by.
- No code changes.

Artem Novak (2):
  sh: guard SH4 no-FPU compiler fallback
  sh: add SH7305 CPU subtype support

 arch/sh/Kconfig                 | 9 +++++++++
 arch/sh/Makefile                | 2 +-
 arch/sh/include/asm/processor.h | 2 +-
 arch/sh/kernel/cpu/proc.c       | 3 ++-
 arch/sh/kernel/cpu/sh4/probe.c  | 3 +++
 5 files changed, 16 insertions(+), 3 deletions(-)


base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.55.0

