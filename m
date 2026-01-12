Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E22C159E;
	Mon, 12 Jan 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215744; cv=none; b=Gp2DYUcmJmPwd0JTInEHc1IqC6QZAp9QHNd8Mu2aPRJ48rUBjU3vs1OYqguIlGTYhwv+0u5ZL50qc3pFIRWAhVW/yLACgiCTGWWdoSmiMwb7vjPliAi9EobjqrJii9niiDA63LnDkXZ7o+4EAS3FbT6HblCQvFgSrkKbJ5Q66J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215744; c=relaxed/simple;
	bh=IAa8kAIr8igIXYoAmJsieGw5X+7r4/60mVrE4LvaaK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lHRv5Q2a9a/pyKsoe55VOOnXniMYswlmwAvA0w9skYH6/9kvrCEaHsaSEaNPY/kQ22E2lM08c8JnXDk/vb2jTsdqJx6hEyl80vlMExBVmG4or/YAGODs9BAmvWSM1urU/o8NRv6WBOOqBf4mQ1KwuZP1PJuQE4m6YmQq3W9oxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3BBwgYK0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YOevUfWr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3BBwgYK0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YOevUfWr"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768215738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U023K304bJTKo1/P4/kEmxrXnT/F/Lcy2Swt5fcx2U0=;
	b=3BBwgYK0nGbYqfkxrmsJLZv6E/BoACptu59OXJFJ0hiafJOhLj3olHPrjb0OijLRIt1023
	BABL0DANp2U5zlsDDz9mxNFYSNoN9elzXtJI+Yc9B6DjvisgC4HpHyiA3smRcD1v4Qhrj/
	easzEyFUsHTRi2CfcqbDYRarDm6/zX9j0DiIQGACtB+3w+EKeXr+frTtvh8JU2xq5GbqZL
	19gBp485b7PogLWpVDEISD3rRjO4K7O+KO6e3/Zw2luk+iJDbVsY1isaRDiZ7BMqqUV/6g
	m28QsVCvHzDoedOmWjmrR0zNBuzAk3NnPUvzzoY3vPRhQ/08ACGZffzw9cQH5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768215738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U023K304bJTKo1/P4/kEmxrXnT/F/Lcy2Swt5fcx2U0=;
	b=YOevUfWrvL+A2BDUvA2lCoLcld7DLkuXBXzO3W0PmIRLdjCNu6mosshHTr4GTPdPtnsxUl
	jFBit6CSKf0ad3Aw==
Date: Mon, 12 Jan 2026 12:02:15 +0100
Subject: [PATCH] sh: remove CONFIG_VSYSCALL reference from UAPI
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALbUZGkC/x3MMQqAMAxA0atIZgNtUEGvIg6lpjZLlUZFEe9uc
 XzD/w8oZ2GFoXog8ykqayqwdQU+urQwylwMZKgz1hIebhPUiG5HvVVSWJHjnDFQ5yyxb/vGQKm
 3zEGu/zxO7/sBdPx6V2kAAAA=
X-Change-ID: 20260112-uapi-sh-at-sysinfo-ehdr-f26a12ec5940
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768215737; l=1388;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IAa8kAIr8igIXYoAmJsieGw5X+7r4/60mVrE4LvaaK8=;
 b=rUXELVLk/lP9Pi4q5dB7aCtuysdnKkWs33Iyr8wxGlKn3iVbC+ho83OSYfW0u/4984wTYoBsB
 tkjf9+c8bmeCY4Tt2dqx5gZ2lSXpz4lI2qJfIlYp305wza8fT9Dv64i
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The definition of AT_SYSINFO_EHDR was gated between CONFIG_VSYSCALL to
avoid a default gate VMA to be created. However that default gate VMA
was removed entirely in commit a6c19dfe3994
("arm64,ia64,ppc,s390,sh,tile,um,x86,mm: remove default gate area").

Remove the now unnecessary conditional.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sh/include/uapi/asm/auxvec.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/sh/include/uapi/asm/auxvec.h b/arch/sh/include/uapi/asm/auxvec.h
index 8eb47ede7193..63fcc39e2c6a 100644
--- a/arch/sh/include/uapi/asm/auxvec.h
+++ b/arch/sh/include/uapi/asm/auxvec.h
@@ -13,14 +13,10 @@
  */
 #define AT_FPUCW		18	/* Used FPU control word.  */
 
-#if defined(CONFIG_VSYSCALL) || !defined(__KERNEL__)
 /*
- * Only define this in the vsyscall case, the entry point to
- * the vsyscall page gets placed here. The kernel will attempt
- * to build a gate VMA we don't care about otherwise..
+ * The entry point to the vsyscall page gets placed here.
  */
 #define AT_SYSINFO_EHDR		33
-#endif
 
 /*
  * More complete cache descriptions than AT_[DIU]CACHEBSIZE.  If the

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260112-uapi-sh-at-sysinfo-ehdr-f26a12ec5940

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

