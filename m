Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733B3537E5
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914132; cv=none; b=umuugL9oY/ChinbF8a9oFHUe/JRFMSJF3p0xAAeIeRczG+4FegM9kjt/1WryMIjLMKTNiVTcX62CDkLSU7rWgwICmX84kWeZk7/8YLrMoEqCVTY2aZ28laek2J3E8Wq3REmm6dNuGNsQf6nm6fA9CMjMidvSJSxrzOxAbhnm86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914132; c=relaxed/simple;
	bh=7XRI4vbBHvoU0c00q1fKY0+7WXPupjkAVjxqudbQDSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBFDoq8MeDGkfBe9n4uRqa/lmgWigOJBCyfqxDwUs6EQg+nRCeyvpdT4IpYewJSdu8z5nehTGYpCFviwKESWf8RUh8MjW5boWX95DGhN2EdVkJO9Hd3s+CDDL7V2mnkbzA0wuniOBnoPYB0qlFccWGZq1/R/osMCp2VJZF37x6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnUFcrsJ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnUFcrsJ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so3265328a91.1
        for <linux-sh@vger.kernel.org>; Thu, 01 Oct 2026 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914130; x=1791518930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6O/z/8/5Yc9n97DG94yFXZDvw4y/3pPf2qeqOHuqdA=;
        b=MnUFcrsJtdWQVFnaJWb+zK58yPZ0DkTHAGdDfct9luuyV01dATgBC4GntKsv2BduGA
         LD5ChDx/7or6Q89Jx+G7UUJvjEXBmwPlbgDpd/QVpVkBZg0PjcqmO8kZhgdaxgtBoURc
         ubm8dWdIDTKOkQ+74wdCJTJt5cGE7XeWdVQj6HJUvjhLy5k4PMWa7eVc9gVuTiAbhgn6
         HeUshb5uCzqybRXz++LL92uei92P1L7KsPmO/s4BFCiBCKlym3N9HZA5q7UlHhjA4Z6w
         mK2pPYopoOOR4LntbuwIBY+posM5mdA7jzKW14PdOCFwhJbHcAfCJQjxrI56wwrdsQqd
         EYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914130; x=1791518930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6O/z/8/5Yc9n97DG94yFXZDvw4y/3pPf2qeqOHuqdA=;
        b=MMVt8Vfmy+V+eUjoMEunX6siu1TxdPDKn3j8ZkFYz7uNTsXPtAMIe6lolkFDnwzA+I
         +EM9U0uhl0BGS4/+rYCfUkrQZu6VuVFEpBG5jzDQdFVSx/kSMz1f8Ct90a5BdFaI89Kf
         5M696A+e9ITxoY7D4EKn9w5OSByH6omUWjP7XzyUdPAAKBWvscLyFqr2e6+1H6J8zm2u
         jmjGGQnSV8VXwKinpwFuYw/CqfGYK/7yRPv1DE694rDUlHyMeZ7CcdeJrwlsbshb3/TD
         ASCN9ziSNEOtoimSRYSE/sBkYfOJ9+5QrB5gjLWxNURMpora+uZithrITDmIkjr78Hox
         kyOA==
X-Gm-Message-State: AFq9FYLhQKTgjStsQxZMx/iw+OQg94roHcA4bIfaUPDho0fBfmaBXme9
	O3A6rWHaItXDPZSm1l1EZQS/OhQ2BlEt3IzA4aWMn833ZtspHd63O3W9
X-Gm-Gg: AYBFou34eAW0c6zZE4qk9UDcfWvuiZuSmhQXP8YOitB5ToZpw15KcFFAid/Mm4BmQu/
	xF/ElOS9AEylkmdSDQ4xXpVebr6nVICv/5ixn8iuIxVic5tNeDZhWC8tzUlx1MQenG4XCXmuRQp
	cqI8Xk3LTvUjEHBvm6fHlTmPLLWGi2//nkKxkN08QpXBLNU9VPY6UTHGQH797JyOmdHXXJdCCYj
	fIZD4kCw9zwBQ2QIwAoCPxR4rmqhOXQ5e9sR2pG6DOgtDgOKeoj/dniRvPVtg33dyTdq2igO8US
	Uj21TG5Opl2+vHF98dJBtRvjqbaCYBbQY47f+lgWdZea6DlWbK6uJpsityLGk0lgaqEHY89sdNV
	duENniUS+psU0ULjNPmlgGqlfRO+kPwyc9+EOow3SXpVnuS0casIwoQ6bzQEF0LLc/gi6WHisi+
	P6B/KPwsjR7L1oDLWgAACk9ulq3qVhWcZr8GXTmmA1M9hDkMjnb1e6r4qzn4+byZB6AzlwtOoka
	ohKhRLydVJcTaWcxPjTcDWaQLRkMgkCNBnmBBWlxtJa44Uc
X-Received: by 2002:a17:90b:134c:b0:3a0:eec6:b065 with SMTP id 98e67ed59e1d1-3a6ce97cf78mr843635a91.13.1790914130355;
        Thu, 01 Oct 2026 21:08:50 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6ccc92646sm2119079a91.1.2026.10.01.21.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:08:50 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cacioandpepe <artem122novak@gmail.com>
Subject: [PATCH RESEND 0/2] sh: add initial SH7305 CPU support
Date: Thu,  1 Oct 2026 22:07:58 -0600
Message-ID: <20261002040800.131862-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: cacioandpepe <artem122novak@gmail.com>

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


base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.55.0

