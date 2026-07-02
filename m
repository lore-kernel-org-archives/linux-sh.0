Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9248AE11;
	Thu,  2 Jul 2026 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985097; cv=none; b=I20Xg52lYwkeDNiOEKAwVP3HZJNNlk/fVDQa3XsdtYbMHYroOqhL7eCTnYLvb8jyjKd58DvaXrQrfdjeZ2+X2AzHhioVFQTRJnNKL83wh2A+PGOM6bRqFkt3eI0me00NBc9VLTD0WVAtaJli7BomwHSKUE9hE8cEhrfFQgUPNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985097; c=relaxed/simple;
	bh=u8MugJLwFkbGKRHYFPPeJDXzFp0R8NHuiatxr+m7Plk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5BSgkANDvOb1oaTF9LzSSRrGeFXazFuk29hjlkPIiUl4M2G+jtWAJ1KbYtpzUfhJj7nJ0OH9DITGxwIohC5dkhKASkuh17Rn4OznRnoL849vCjeme5EB33vyqM9uanyJVz/WZ1MBk8RdfvclObwyMfdNRGs4s7acX+8XHzU/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL/JsLxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL/JsLxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9FB1F00A3A;
	Thu,  2 Jul 2026 09:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985096;
	bh=LuNp6PoxicBFh9epmeKx1f4XkMKVUuWTDnBIrOcUr68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OL/JsLxbnEDzY4iM9kZaNHx7Xsr1Z2jV1xCxEYSxjEPueoSOQ80Tj6dPFw7NezoJZ
	 C0am4Vs2drFQA+HT1wSgmwEaLmeyTP0Q3FPruDGylc4z+HRsir4fxS4YVtjRnYifGd
	 2E+ljprNELN3w9eZ1w68ztAk7lOBYnSqjah2fpceNWip4cahCoMOCgAsyAoF8U+/6n
	 4QhhBUVGy94gdCNH/UYrcqn4jE4MSfGsMkNFGsDfSOCD5yhaX0DQbp53vCADSklNTs
	 78t5JUM4nFKD0jKJu5HRd1BXXHamzw7oIHzEzYuX179v2D1cnstIUF96YxPnrWF4E2
	 qhGnq4C6Lp1Vw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:56 +0300
Subject: [PATCH v3 07/10] init/Kconfig: drop
 ARCH_WANT_NUMA_VARIABLE_LOCALITY
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-7-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

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
index 5230d4879b1c..e8ea2d7697bf 100644
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

