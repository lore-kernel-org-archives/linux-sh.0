Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2F486B99
	for <linux-sh@vger.kernel.org>; Thu,  1 Oct 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837875; cv=none; b=uSDGK7+afhUfd3N93FIB5qKEtmRdD+i68vvAd7oqnEnvLcdAvGl6UP6ClAqtX8qTrciqx7DKSdkW+hJu8JXiIubOrlh0wg0cDp6WB74lrVtrbt6oWIUsgVV45AL9kiD3+wQnoKS8BVIkvIElqXUEFJP+i5ZHFNaeKKbXAOShx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837875; c=relaxed/simple;
	bh=agRKSWSkJj7BFv/lJ1dRCVNIfmYIzPLP+8Hg8BkYKEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVNdKNucawZe8a/DHGcTIZOX4v7y6/Og5scfY1k3N0wPf3qF5ADevcZudtrYs3mTRStFQ5o3pkANgNB/jqm4HhoJpl4CCHyFNYpX6WRfLsyU6FrQLG2/fO9wLVhNNMbN94JAYVD1whWfBYaHi4CvqqJgg3tHCU8U3pkPuf9HqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5FPl09J; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5FPl09J"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so3567826a91.1
        for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790837872; x=1791442672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oLkVog5+7gE/hz07CtNRO13maX7LfX3q7W+IXftjb3o=;
        b=S5FPl09JjCJswmBUA1xyquXcMyvtM2ti8xPR1IGUJrgY4qBda7Jm7lQtqekRxrzGPk
         SXc3ThOb1ZzxE2O7YRBNJuAmT89HVJjt0uUj/4m32RBkN/pdomNQqrMkHjIbsrtEzw5Q
         3NYCgXLIZrMl58GiulWdmA3pUJLES68C1Jb0I92ku3c9bmYlP8+UTZokODeI6L9XzwcA
         h2yO0CQC10r7W/tHoPku+HrrWx6LeorDGAvIMY4Y3u0r6Qm91oNpIANAShbhz6P2sbFA
         IXCyxWThwq8CUpPbhY99MEwhiGlgl36nTskWhcZuxFGPyDlt3Vp4ND+NHUX56UkJDEuY
         EKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837872; x=1791442672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLkVog5+7gE/hz07CtNRO13maX7LfX3q7W+IXftjb3o=;
        b=JuXnRpw+zZGvOxxX70g3A30kVrCKuNK02d2x7JGGIzOjosMptyGhe0Dwq8KmC+pORA
         x/sWmom5RsNJX6ZP2SECdtrmBHxqZ0wtBmfUMjr2/YLu1AloFGZG4/r5cdQ30fuIm+wn
         Lva9wdJKIr1S+xVjtuW7QMr//jh5S0nJknl5CozMWfv4wYlRJLgmRBS/0iOgcCvWo9RX
         NBo+VDwor/o/pdaJ4rfMof2Wm0p8Vd6xNVL7OZG/OpFIUUEQNEw9mLcjn20pD2Mgh425
         mTlz6fmSTaUBpepJhvGVIlGHYcev+ouAkichKGrYeaUiyrAPKYL8xF1f/ov069cCVla7
         oCPw==
X-Gm-Message-State: AFq9FYLCeROq3dNmF/4gBibIhluvZNbHaLT4V1BZRInWV5fxScr6L+S6
	8MGYrJ4jY9H05LF1UjvSnXlIGxpSMQS0xeLt54KS3BZJn4mKGEthzmsMeoHrIIwe
X-Gm-Gg: AYBFou0zd47bWV4Gr3EMYy3J6K1pjC86/VpHSRzycqoPndCzpjbOa2CMx02588WAJdJ
	uCjSix6yI5NJYRAQJPazdeoqmDYX643ejr7RVXCxQRrWJ8C7VvjRbHBxLfboB9nJz1IKeucOC0b
	isVBbySsURgTGGqor356u3UBBQV69h09oXo9qdV5UrseUtfVxpo18VnDy6KTZ3DZpzPIOHIeF9I
	lVVRHUWcEL9UfPL1XOzLvXIyCslAwWkIrEV/FIngmmIx3vaQEbXks43BR+fkDuGhp4n/BQhK5Mg
	+TvSpXSbuLNcj6NN4G+BRQjst8JNnxePWqiBDVvVWwgOb6hSR85cp0ntTWwO8FKV3LEYlipOcl5
	tmO6yhVSUeL59lSpIqBm7+4EBs0takhA0txj2MNJ9CMv3CE8oep+dqdjpChmGJ8Axbb3zfj37CJ
	BGr8L1zmicc66wR8zqdslKnQe6pST1fDGlxZ52im55H+5ufLci6YTJO11tkKe6LyQ7xM4PX5aFv
	YJ7pI9eqBDjg0EYmvW5OlOLFDmx0ZHRA4UDP4ydWwqSn4iZ
X-Received: by 2002:a17:90b:4cc4:b0:39e:27e:2f09 with SMTP id 98e67ed59e1d1-3a4d1032530mr3271581a91.8.1790837871916;
        Wed, 30 Sep 2026 23:57:51 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44d0a30sm2873138a91.16.2026.09.30.23.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:57:51 -0700 (PDT)
From: cacioandpepe <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cacioandpepe <artem122novak@gmail.com>
Subject: [PATCH 0/2] sh: add initial SH7305 CPU support
Date: Thu,  1 Oct 2026 00:57:34 -0600
Message-ID: <20261001065736.753215-1-artem122novak@gmail.com>
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

cacioandpepe (2):
  sh: guard SH4 no-FPU compiler fallback
  sh: add SH7305 CPU subtype support

 arch/sh/Kconfig                 | 9 +++++++++
 arch/sh/Makefile                | 2 +-
 arch/sh/include/asm/processor.h | 2 +-
 arch/sh/kernel/cpu/proc.c       | 3 ++-
 arch/sh/kernel/cpu/sh4/probe.c  | 3 +++
 5 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.55.0

