Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A32396587;
	Sun, 10 May 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421376; cv=none; b=toEffk3iKGYLlQzXx9gzncMLU4Ipq040H4LVFcKvh8vCIcQzxOuqJaAT1rzb4fyLGBoTphrXF3epUczh2nTAUUGOlRyzuQp8ZzRGFq9bM6AFQyifGaKHfMJVTqkK3Dd/a+fH3hvKp10v9zCuuTMJyLjHo/Qj8ss5tKWzTM5qiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421376; c=relaxed/simple;
	bh=IdEPlXw4dkMVbwrrWqpYiCW1jHNUxW961O1EvYNalsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzIkhKzVmiwzUhUCNcvxCOwUzqUP62r4wDhyYEqfyXSCDVEXv87fF39cmUozAaIwl4Pa7eQmtoOcBxUeh3rulkch4fzOHx1avihQATPRmfU/JgKE1YUrmeqAPmthb88dvWQ0ibnI3CjIQVlhlmTOSpxTrrncHx3D8rUEi4jvSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTx6zCQ5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTx6zCQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712DAC2BCC9;
	Sun, 10 May 2026 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421375;
	bh=IdEPlXw4dkMVbwrrWqpYiCW1jHNUxW961O1EvYNalsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTx6zCQ5dh4qEwZhqFS99kQ5etYMSIjj7tuTxSW9d8G0j3zKW3JMWXRROevWzF2+o
	 WVEzflU7g2gZvElHmKuzMOT1DuJUWKMpAGPLOYagNzJf5+bM3r1BYbns7L08gj4z3m
	 zbzuff/MucIrEeU2n0sqfJfsTPivTlYUOHxedwJRwUKXn8YLH/7gLLN/F8Vg3YSGBX
	 9iVA1KwQhEtECeQVIjj3uzhSAOtpgEBmOENTVcEuiUGSXe/L55ozKCofEEfZgG4IOk
	 wqJVrRPOmoITukBYPBVQhgz/jaKAye+sx1R/wL8qHMQ2cSeQRfa2XQfRxv6p6zFhSA
	 bmRFv31RUcjIA==
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
Subject: [PATCH v2 08/10] sh: init: remove call the memblock_set_node()
Date: Sun, 10 May 2026 16:55:44 +0300
Message-ID: <20260510135546.13554-9-rppt@kernel.org>
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

Without CONFIG_NUMA, the call to memblock_set_node() is not needed.

Remove it.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/kernel/setup.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 2f2764061003..43d0f7b62b03 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -228,9 +228,6 @@ void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
 	 */
 	pmb_bolt_mapping((unsigned long)__va(start), start, end - start,
 			 PAGE_KERNEL);
-
-	memblock_set_node(PFN_PHYS(start_pfn), PFN_PHYS(end_pfn - start_pfn),
-			  &memblock.memory, nid);
 }
 
 void __init __weak plat_early_device_setup(void)
-- 
2.53.0

