Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4223090C6;
	Mon, 13 Apr 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077237; cv=none; b=dzVbd0GwRlvlf0mihf32vUG9fbm0uNPhhA3sNQ31WOpa3tD7d4GzCLeNvhRSHSzsP0egjBDuotEft99n+l1V5AXyjfU52HV2CRevfOSL1uGai6QcARxUv7Q0mT30WF/8SFEADcCS5Y7oMukjVE3WHRlfYscnyiyHZCVJGZ1jE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077237; c=relaxed/simple;
	bh=OaaQg0yScLb6753TV7501lpQBgyvDvfMGyHT767MQ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7ALkE55ttR4avIvggQfSeD9KSsA83hiSEtONMeDtNXx7GHxgh9cvvfAMDzkovYSPfJipBQ0taYNbR3A1lhslwgn2tL+A+S9Z+sCb0ZhJb5sR+CO+jInBHAJKcdvMVVSfVs82ENrqUBYzkMGMvtD+4/GPi3dZ/PffFekM1UWyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ7mybbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ7mybbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B507DC116C6;
	Mon, 13 Apr 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077237;
	bh=OaaQg0yScLb6753TV7501lpQBgyvDvfMGyHT767MQ7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZ7mybbJu3Z0ChneXhfc64irFPezd5EHKPKyHZVyGeTgx76pN9SdlJovI50zftpLs
	 msC0OQwyy6gGjM+xV3XJavTRWII8Wo6A7EoymqRz5rtcHMCIakm+fL0MY6fkOjfFD0
	 NErgp5rvP0TvSgYglufDK0RuB7817UGmESUZY8NfMWme/A+NWqk7mq5fjo6Ex4YWjT
	 fJrp/jGW0d9BptKA38ST/lrtsDkiUTuxhsV+X2CuxZzlh/YwO4RV6sUgQidYMLK/Yv
	 /WlI4S7IQqLGb28BVkhhk/mZfDjqWId2HNziEGvLE04KJnbOawlbvcdgXJbGAuy4q/
	 siiIXiO5ks7mg==
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
Subject: [PATCH 08/10] sh: init: remove call the memblock_set_node()
Date: Mon, 13 Apr 2026 13:46:46 +0300
Message-ID: <20260413104649.852228-9-rppt@kernel.org>
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

Without CONFIG_NUMA, the call to memblock_set_node() is not needed.

Remove it.

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

