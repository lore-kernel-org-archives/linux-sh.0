Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409013988E1;
	Sun, 10 May 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421373; cv=none; b=V4jGp96DxiB7bCUJvFkDstEFXDxxbucAZKie+fxKsZ1JDqy/iOBPoMU4TnytqNm38K5Qbahk3JQkuhPSYQBafsag5F2YeDrGYhQXa7gH83DZFoMWhmavonXYLrJJf6ESvCq8Fq5y1htyk4d3wWWSJ3vZmWRcI98QTiep9YUfvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421373; c=relaxed/simple;
	bh=tkwfagRVJukzEnsyKj09sXQJAa9mnqv0b5T/g9FZs3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Djce75XsmLUVvFHvH0ldFQrqzj8QhnUPs6/Wskz3zRrmDi7wQSuK17MC2ZVZKlxBq2Yfag/HojovTHexqBwdgQSEGVMODjtn8EM4qNDyMDvF7zn8v4J78fz+yxzW5bJyHiU+HSHo1nHMcRfHuIWkHleOodjcNdiVjPKxZiCYTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD0dsLZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD0dsLZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C20DC2BCC9;
	Sun, 10 May 2026 13:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421372;
	bh=tkwfagRVJukzEnsyKj09sXQJAa9mnqv0b5T/g9FZs3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KD0dsLZQY4aolmkr1gau+yr6NpTDiaJQ4wLWAigE+m0YYMN8BL86IHL7HAz9P3MAq
	 zTKtMaLddQ0wGCkvdp4K36xZLTLHNgd1OnYz5mEeakDh6geUhW/6h9JwnR01/2uWtk
	 w9e869Jc7W+ew7iLIiXkHfqfJmwZczH7IQUnoINX0pzfosswBCWg6PtMhY4GKSkeRL
	 QXbd67mSE5PIuP8u2Kcq+PryQmE+t72JP6eaL8PUO63xYQJKbXvNL60rNIuB4IFe7l
	 66BMMFIQCLb/eydQhhPfZUNT3ylau2HS6ctxUMwYvRjOCzrd/lThU/8zLgOQEzXIkT
	 hlrk2CL1XoWuA==
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
Subject: [PATCH v2 07/10] init/Kconfig: drop ARCH_WANT_NUMA_VARIABLE_LOCALITY
Date: Sun, 10 May 2026 16:55:43 +0300
Message-ID: <20260510135546.13554-8-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510135546.13554-1-rppt@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
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

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 init/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308ae..33337fde1197 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1001,16 +1001,9 @@ config CC_STRINGOP_OVERFLOW
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
 	depends on SMP && NUMA_MIGRATION && !PREEMPT_RT
 	help
 	  This option adds support for automatic NUMA aware memory/task placement.
-- 
2.53.0

