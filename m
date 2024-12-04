Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85E20DD57;
	Wed,  4 Dec 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330469; cv=pass; b=tB+r+lVk7FkyWCRYMkvd7n9ZHIrg4eLAnQRsAQForbLP77C96nh7yH2fnCHwJ3fBEIt3oiR36awVw8uwSHzawcF6Sw3k5pTaktTDWutOq/2so/9QuNvf3DewmPcxz+npIRFfTq8f/NGAAa7e78cAKSS7WLpoa+KMIcmE3ledO+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330469; c=relaxed/simple;
	bh=eryuLDvmmbLftO01zifGIFMBK9atEa5hjuNe1vBCoUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=blYefpB+bNRUUzv29hH3xndQceuyXVele0dNYEk+DclKxNFJnMWNcy0O3ZEZ8AgsGRu1NzXASAdKJOqtf663E2TEN7kg9QfROLtNQRp1QMt2TCF+6zKSYHPCTLgAlax54nkKRoRV4084R5EXgcNHS80Ooc9V90NITR+SPBVAkxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=fGoqj4Be; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=QIdAotBb; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="fGoqj4Be";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="QIdAotBb"
ARC-Seal: i=1; a=rsa-sha256; t=1733330454; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lc5XhTSqN5jHKATJGIZcAbB+BEyDUFJFsW5YcMyqG7QDohdchMPDCXqamltZXkatiw
    9mVNBP6MACMrh5iD7UYDw7bJAmu8Ypz/ksTL8s/oQSuy5FLY8vfcwqd1lYIDQCgAoY5n
    NFKpPS6zlzt4Dv8Ml4PZDjsvUqz2z9JRWApTKlvG50/p9SyZTRDtwoM0+zMN1ifEKE+M
    K58mNYuxQeCPbrUaIBrzuHSkL+sGiLtmzS9IVwsI93g7X8Tti4Fx4XJzfbFk6dzNjVnf
    itrXgphQd7uv4DSdigDDxnkVcygmxJ2eWeD7Ey9zvzTJfpGYOr0xBjxj5xc21qhGh5oO
    VjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733330454;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4Xma7fhGxTfx7BBhKnsUPv1dB06IlM6G/DN6OKrivtI=;
    b=jDLyADiCe8QVNA7wa4KH6Jq0avPrne1V8Ue5hzo9KP0BciBfrRwQCxc6Dhzo07wTBo
    l+N6osZpMGYE+XANsbp4H26aoG6du/AmezQYcgkDcjVZZnI7e309Hle/p1tLm2H/WELO
    bN0/oub7Dnczs8WsAkB8UIKMefdQYBagETXE7tEps/eCemj/x4TBSJaA9G/bsPf+0i+j
    c2a2ozGTYMBMEVBU7mK5MSduOIBU5xQqK+0CXRZ/rWiHi0PDmlyS9ci8nEtuDuFq1k4f
    h1m8UjcJLpmKexvQr0FRwXrhRUFj5p8tUl+d0XR1cS2k2GVRofjKUDwOMNDlTnudaGwb
    Iaaw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733330454;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4Xma7fhGxTfx7BBhKnsUPv1dB06IlM6G/DN6OKrivtI=;
    b=fGoqj4Ben01CPmgIUwFuX802O7VY9wXZ1wchuc/Xe5irPVeX5H5tfi+K+kMFe4nn6I
    V7sKJirFY0aBl2fJBMs7OQ5z+sKY/gJz0zH5LTa9cpfKS/CehVWckXPvpea7czPTHA7Z
    cBRLZwIuOSmNCcXbzYizh/QsuyRFRZ0UATtmslUUINqlgb/bSh2VobA1KyGdK0NxWQvt
    oUpRjJaaKL4PMoVzZkWsO+efBiWq1wwkqx+xcwQABL/O73q7HC/jzok9VhUMzyVhAkqg
    nCjS0H+1NjGzONyWOz/EvyTz+blZbFqm8V5L5QgueQqjPNb7DFQj8C27mj3DUoxxdBO0
    7xjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733330454;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=4Xma7fhGxTfx7BBhKnsUPv1dB06IlM6G/DN6OKrivtI=;
    b=QIdAotBbUboSBf4KiW51l6tPrSYxhu0f2kqOaHFG2Wp4Pm3pdVe5ntNn8UGLOSjO3A
    PL36l9cb72jq1poKWIAA==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Ja0a030B4GesXdc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 17:40:54 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] sh: Remove memset_io from sh specific code
Date: Wed,  4 Dec 2024 17:40:20 +0100
Message-Id: <20241204164020.48361-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Remove memset_io from sh specific code and fall back to the new
implementation from lib/iomem_copy.c. It uses word accesses if the
buffer is aligned and only falls back to byte accesses for potentially
unaligned parts of a buffer (i.e., at the beginning and end).

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 arch/sh/include/asm/io.h |  2 --
 arch/sh/kernel/io.c      | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf5eab840d57..3771bfa984af 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -269,12 +269,10 @@ __BUILD_IOPORT_STRING(q, u64)
 #define IO_SPACE_LIMIT 0xffffffff
 
 /* We really want to try and get these to memcpy etc */
-#define memset_io memset_io
 #define memcpy_fromio memcpy_fromio
 #define memcpy_toio memcpy_toio
 void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
 void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
-void memset_io(volatile void __iomem *, int, unsigned long);
 
 /* Quad-word real-mode I/O, don't ask.. */
 unsigned long long peek_real_address_q(unsigned long long addr);
diff --git a/arch/sh/kernel/io.c b/arch/sh/kernel/io.c
index da22f3b32d30..16e963bab595 100644
--- a/arch/sh/kernel/io.c
+++ b/arch/sh/kernel/io.c
@@ -95,17 +95,3 @@ void memcpy_toio(volatile void __iomem *to, const void *from, unsigned long coun
 	mb();
 }
 EXPORT_SYMBOL(memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- * This needs to be optimized.
- */
-void memset_io(volatile void __iomem *dst, int c, unsigned long count)
-{
-        while (count) {
-                count--;
-                writeb(c, dst);
-                dst++;
-        }
-}
-EXPORT_SYMBOL(memset_io);
-- 
2.34.1

