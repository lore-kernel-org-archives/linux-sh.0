Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5148BD44;
	Thu,  2 Jul 2026 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985100; cv=none; b=SAHLdW6Kt4kbUz/Vaeolx2sGOQ418X9ZN+1I4uwt06A/pfDaExiZ+IfxAwl3bTHrB/KAt2Gs7CeWlQj1lTH/dZzWlTqS9jucRq8ALzIDyrS4riiczdUio0ZzsJU2HuscEY77iq6zqb1DFZk/Ol2lCr7XQ5j+Z0jNpdHwVWClwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985100; c=relaxed/simple;
	bh=DgRWmMzCMTi6Gkg8jwVtJ0G3ZHkNgPcP3SO+TpSVxBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAMbdrBkM4M7OKzbAJcGk8g2dYUkNqW0UCrxoKG4M4NiSlkRKWyhZAuhtBA2lR4m1E1pMXcor5P0Bwlq4j4MGtbQoO00eAvsE/5bnA6TYsRMoF0a0W8yqyou8t/ii5KX09qxTXUT4fHohmtGxgX0apGaba63+BqkttQ0Y6Ym7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jw8WuTfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jw8WuTfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BB71F000E9;
	Thu,  2 Jul 2026 09:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985098;
	bh=n1C3FBGZLJxzF0zbehgPaJJTy3zzicAWlgey4IEjIG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Jw8WuTfQmPaeB9yqjf3FM6+tqciMyZa3uJd57fPqZpBm0pKOA3L8/lyKY+AwtFj/A
	 GrEhMACFY8Os0Q7HsfYJOfIv4wSxdWPf3PVcmGJ28lwf5AOelFyJkika0T0cDJ0NSw
	 4QDoDmheLmBHo5k4Fi8lzJikZpJvAVSby1nudk5g7ckiRIcijAPuto/T49dvZwCqty
	 JwOC7u2Gf0/bbCjp2lNsZW3Hh4UbZso6EnYFsBdgg6i/nVU6kyomDJGGtVEjA18JYx
	 fCDpX5wtyiLLsW7+1WDW5+shIqDfMZQbZilC6XJLP+9nU/d/iLCzWmwqdXLZx5J8Xf
	 NXq1Pd9beQaqg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:57 +0300
Subject: [PATCH v3 08/10] sh: init: remove call the memblock_set_node()
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-8-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

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

