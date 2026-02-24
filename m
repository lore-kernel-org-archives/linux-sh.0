Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AA2737E0;
	Tue, 24 Feb 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947346; cv=none; b=rZdAXbkQTxluCXT6CiBdd73EE+7Fy2JPo6MMIsHs9VjPKMu43DS2RFUO5u6HDy9Om2XlieiyauBNVazLpBwwW4skEuIO0XWQCJyd0wqgyiWXhqsLnuyRvCCBsGrG+D/RtVqPC5vKMbgCzxAUX7falA9aocY3za6PEbfd98nwTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947346; c=relaxed/simple;
	bh=9S+moLFFxnY/EVu4ih9EBMS/B0NIpHNS8ULxjwr5edg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fU7DX1rtJFN83M/ge5/iQ0sHPFWJbV9/DFgP0TLlMnIKroeEjbmZ6o1KiihSakVjimnxcmMRforJTnlQWs0sVnSOXKB1bv8MKnVNKwRDZ9OHMv7mkRDajfd65S9Sv0WvD2DY802DyhIpp3iEBILuCSyEfTVInxq6RGyD0hAcUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zKc2JHoM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeCvcqik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zKc2JHoM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeCvcqik"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771947343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JC4021L7nqvC+vS6uIlGus6ygUQ/RpLKsq+JbLpjzM=;
	b=zKc2JHoMgCwogoxbEMzBbSzD0O/rx4cyltZjJTut0r20dbUPkK15pPcP61noKEYbHr6H41
	onKeT9XUd+0T3vxs8e5Hm+USjMiF/Lgfq2vWOIZSYTSJAwh8un+E8LbQ3Rq7qdg+REW/pi
	agw7XxvE2lVJtZbQxqU+psrBeS+HYSi/sMe3SiPoyYcphFn9n4WGioXsy6dyS/qi0MK7r/
	si/WBQSegLLvIQkXA3LeHWuOL8SGVeBDdXfrFgd1JzATmoA6Y36hex/C9CR+9RfjiAdpmK
	knl0LZPr2IWLscFFlcJUJf9mMz9BzT9hK8rwU9RQzuYG2B5fFkfoSS3F4iMnnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771947343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/JC4021L7nqvC+vS6uIlGus6ygUQ/RpLKsq+JbLpjzM=;
	b=IeCvcqikiVgHprRb5i7Ib71CUI1+axbqxRyOEUDGqYfVmPsDwjyB0cEjIZoNqwmFq0u48n
	FTYJUFJLdoo9OXDg==
Date: Tue, 24 Feb 2026 16:35:31 +0100
Subject: [PATCH v2] sh: remove CONFIG_VSYSCALL reference from UAPI
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260224-uapi-sh-at-sysinfo-ehdr-v2-1-b309fe77ca04@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQrCMBBFr1Jm7UgmaLCuvId0EZuJGZCkJG1pK
 b27sRdw+R789zconIUL3JsNMs9SJMUK+tRAH2x8M4qrDFppo4g0TnYQLAHtiGUtEn1CDi6j18a
 S5v7aXhTU9ZDZy3KUn13lIGVMeT2OZvrZ/82ZkPClyHlub9YY+/hInMacoixnx9Dt+/4F5noX9
 MIAAAA=
X-Change-ID: 20260112-uapi-sh-at-sysinfo-ehdr-f26a12ec5940
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771947337; l=1740;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9S+moLFFxnY/EVu4ih9EBMS/B0NIpHNS8ULxjwr5edg=;
 b=svRl0x/Bze7dBZAZjHgB6eOHyxcmfWfLua0abRZTD6kSxUmEgZmIRHVKwfakvfqt6OAcIWT4g
 dlknWjyn929Any3wc71wvQUozPm1W+JNUCLY6mh9knbsK5wMv6kvdJ7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

AT_SYSINFO_EHDR defines the auxvector index representing the vDSO
entrypoint. Its value or presence does not depend on whether a vDSO
is actually provided by the kernel.

The definition of AT_SYSINFO_EHDR was gated between CONFIG_VSYSCALL to
avoid a default gate VMA to be created. However that default gate VMA
was removed entirely in commit a6c19dfe3994
("arm64,ia64,ppc,s390,sh,tile,um,x86,mm: remove default gate area").

Remove the now unnecessary conditional.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase on v7.0-rc1
- Flesh out commit message
- Link to v1: https://lore.kernel.org/r/20260112-uapi-sh-at-sysinfo-ehdr-v1-1-b01dfe98a66a@linutronix.de
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
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260112-uapi-sh-at-sysinfo-ehdr-f26a12ec5940

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

