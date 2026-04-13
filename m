Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567643BAD94;
	Mon, 13 Apr 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077234; cv=none; b=UP/7deVdnJpv7skBP4SicMMYCWwf2Ax7X0Jc0vKLQF2+DxfLxo+WlZDLxMGjKHWfcVLnapxaN+01b0cSmR6UrEkAl410TtoFywrgZhoX3Da6TFq7d2YpzcOkARyUVpahkB+K04NqHE/Oqd9xuYJ4NKmScrQDOFrWTXMYd8md33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077234; c=relaxed/simple;
	bh=w9l+WDeNQIEjr29WOlkvK0OiSqXu58rsWU3JJJ9mskg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRSMxWgEmzs/avioT7Mj+y3K2yIZ0bUQRptOxiVRgcbbf9BuXaAZvsX5iBWDHWfCDYpdWA37lRXjnd6tQi9rRlRfgZAj7Upks0G/lFy3d9A798ArDQHSVMP2xx3R3SwWMaEmfjrg0mpqCsoxyDRqFsblytlTbZWADpI3pwnjoyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFWh6Njy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFWh6Njy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A66C2BCAF;
	Mon, 13 Apr 2026 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077234;
	bh=w9l+WDeNQIEjr29WOlkvK0OiSqXu58rsWU3JJJ9mskg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFWh6Njy40ZFutVv1Le8/k0/LKKAasphDLxpZJoBJ+HkrOQWeJx8deVpGFN/j7OcA
	 QMIOEZDqPTdUEz0M88LItJyYZ+ZNriSYOH0VEurK7Tl4Lpzmd5jqxNVA5h4KT6hxBc
	 D4ig52tzPvVGzjSmaGD6YV9fHXAwBafV2n0hgSYHAV+0aeBURSd6jXis4H3xykikjQ
	 kxexg88DsDwXGs+Ybdbtk6Kj8nNS1sBkZh3/B8Suhj0toGNAX4mVSzS/tnybsoGDr7
	 ib7BM+u4Z0Ajvj19yIl82GcHrAoJeVt8t9QLc8TQLKxbXyxdhDf/K44OCo7lZTNY21
	 ZY18VJszwwCwQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/10] init/Kconfig: drop ARCH_WANT_NUMA_VARIABLE_LOCALITY
Date: Mon, 13 Apr 2026 13:46:45 +0300
Message-ID: <20260413104649.852228-8-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104649.852228-1-rppt@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

sh was the only architecture that selected ARCH_WANT_NUMA_VARIABLE_LOCALITY.

With NUMA support on sh gone, there is no need in this configuration
option.

Remove it.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 init/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 7484cd703bc1..c31fb292729f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -987,16 +987,9 @@ config CC_STRINGOP_OVERFLOW
 config ARCH_SUPPORTS_INT128
 	bool
 
-# For architectures that (ab)use NUMA to represent different memory regions
-# all cpu-local but of different latencies, such as SuperH.
-#
-config ARCH_WANT_NUMA_VARIABLE_LOCALITY
-	bool
-
 config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
-	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	depends on SMP && NUMA && MIGRATION && !PREEMPT_RT
 	help
 	  This option adds support for automatic NUMA aware memory/task placement.
-- 
2.53.0

