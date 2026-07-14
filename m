Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195763624C3
	for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025928; cv=none; b=AVNlfkq2EwNGR8huk8gjzKZyoN+ECoNSM2UqG41xFQGM7Ebx9UeJGn15QWxzKpG58zJAKIpZcZ+HsFY0oTFpgCen2udBXv6jpwEtOhQfjbTj031k2o8zCUfDKUsmMa68msfz0kZxkR+N7ZfwczhFryVrxMC/gaKQi4yEpDZyKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025928; c=relaxed/simple;
	bh=cqjwLKPmWQRZoIjhZmnnCuX6lPobdGKWZdx8AgbPR2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZYgXzfyG+V2FGR0B0mZBubaOx7/3yQgmrdiQwL8IB502/C/93CAuRzu+oQGId5V7zwaHEh4WihVYNghPxeOaD7vHzh2ymDWs0nC5FsY8WlWkBgXfUj7AlgkwE6KnzqAHIhFDb+noKM/7P6v3dZ6w2Rbq48aC/Cs29klSBnSOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+Q2OSul; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+Q2OSul"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so35727615e9.0
        for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 03:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784025925; x=1784630725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mpNtz8GlFERmeb7xa04S3bJbr2p9nAg4CTylYMAg3pE=;
        b=R+Q2OSulpdKegXnWJELa4QZxJzb7UZxtD56b0dfLla11Ixug3J6JjOiF80fT2ZKREQ
         lK0MAQ+UNt5UGYmYyMIsS9IMvUShZLuIrlhPqgCyIq1dfy5uZPgDDqdkqbL8CHMbd7aY
         lvbf0femrczQgw3gnhDM4/Y0F0dU340NIC6fgirIM8GvH8cPflheulcxq8rAUhp5xMHS
         BhBe355eJgAIvop3Ut0cNrvjqy5my/jwwnWAYykduslRwkEotDpFmcdvBEfDotCNjQHk
         WvNnJqHeHYzCGd4pUh9HgLrxJEoQ4Ki0GEnIMnA6pchq5l5xN8wfwx3wRL+LvWWyFbIS
         lepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784025925; x=1784630725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mpNtz8GlFERmeb7xa04S3bJbr2p9nAg4CTylYMAg3pE=;
        b=pOkkOw1wLFLdx84Tdr5Yot5354Q6kGGGhxhPaB80CO6zqIL1cT9hGf4VnLoMaoqHyO
         oRwfQDHa3sGfyhHPFUUU8ckm+gpKeMqWWew+iSuc5lZcZ6qhdvzUI9CNAt211N59qwgM
         nspKPnrLDnFNhk5ehbHtH+ksCzI1h4phLD3AtvO/6gpeRRrhU/9m0RnLbm5T9pqqAPWr
         CHeEpXglJyBLnGO3qHYpWwlHcw9D90ei2SbxqCrv6jhW0EVXeABOB3b5OQY/h5wr5e7+
         +uqY52I0wgAmEBV80E5371aYKmxMxsdENYAFYUatB9gGOiN8AiCg49WjDF23ly64cFcY
         GajA==
X-Forwarded-Encrypted: i=1; AHgh+RqxSUGMpO0JYGtSNSHEFmvV6L+xAprsVHeio3ISzumdEmG/1Lttyb1ATwDhZfUWpWKDmxDLAJT8Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GX1KCF/laFbAyYrOnofu8KO0UVJWm55erO4LneQ5JMVl0EVS
	wDqUWS7k/nKuAsqsYzFU9PJwdHC8nieTw6TnNfiBIaDVzidtm+yJA+E=
X-Gm-Gg: AfdE7ckJOAcYrEbraNPymnAPPF1Zar3TSJgpt9d2V3uswBjmA74wbINPKkVf0gRuLVr
	+bUhqvXkPV8OMqteLwYNsoCOAfBcoQdZythJ6aw+hDm5UouyTHnNwf9EQJAQuiiSoa/chdAV1k4
	HxQ9vy8nJmaCZyU/uSbMnqowOxsjbVwCiP3UpeowuQv/Ft+EV03UA5TKZZ81xg48fVJ/rqkwnO9
	eyj1NzXMIJqTKqX57Fi/G2mEm/gNC0pLCSNkWtQOVq+k+W9q9BDznpNG17um7Lr6NCH6ADtn4fg
	QgdBYBCfGnKOry+DMi6XviUADLyLTkQayFhawkukS+VTMRODZ0DXvdI9Hdh6m95IdqOacfhOVTm
	+JXH5yRoDunJNx1kuLY5l4lNrCCehCaBQMOeK9oTHsugJKBR6wHwpDCFHS2OSnuLdbmC+UMxWT1
	oBAU7XdlSpcGgkZ99ai1eTyyqZIh4sCg2i3i4RUchOqrvRNm8veTCxk9RYv3TQ8gOOXr9y
X-Received: by 2002:a05:600c:628f:b0:493:d1e0:a4f1 with SMTP id 5b1f17b1804b1-49538ff8272mr16763805e9.0.1784025924834;
        Tue, 14 Jul 2026 03:45:24 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:bae1:d42b:869:1dc8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4950a2edd6fsm66347595e9.11.2026.07.14.03.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 03:45:23 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: lib: Restore r4 in shift helpers
Date: Tue, 14 Jul 2026 12:41:47 +0200
Message-ID: <20260714104147.2016549-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 940d4113f330 ("sh: New gcc support") added new shift helpers
that use r4 as a scratch register while dispatching to the selected shift
sequence. But, the helpers return without restoring r4. With GCC 17, the
register allocator can keep a live value in r4 across the helper call.
Clobbering it results in runtime data corruption. Restore r4 before
jumping to the selected shift sequence.

Fixes: 940d4113f330 ("sh: New gcc support")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Without the patch, the early boot on e.g J2 gets a kernel BUG at
mm/percpu.c:2604 / "can't handle more than one group."
        PCPU_SETUP_BUG_ON(pcpu_verify_alloc_info(ai) < 0);
As the static condition in mm/percpu-km.c wasn't true:
        ai->nr_groups != 1
nr_groups contained 60 - the clobbered value from the shift helper.

This change was tested on the J2 core on the Mimas v2 board. It can
theoretically also target other SH2 devices, but I don't have any other
than J2 sadly.

The flow of operations matches now the state in the libgcc, see also
in gcc: libgcc/config/sh/lib1funcs.S
---
 arch/sh/lib/ashlsi3.S | 3 ++-
 arch/sh/lib/ashrsi3.S | 3 ++-
 arch/sh/lib/lshrsi3.S | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sh/lib/ashlsi3.S b/arch/sh/lib/ashlsi3.S
index 4df4401cdf31..73a9d709b169 100644
--- a/arch/sh/lib/ashlsi3.S
+++ b/arch/sh/lib/ashlsi3.S
@@ -63,8 +63,9 @@ __ashlsi3_r0:
 	mova	ashlsi3_table,r0
 	mov.b	@(r0,r4),r4
 	add	r4,r0
+	mov.l	@r15+,r4
 	jmp	@r0
-	mov.l	@r15+,r0
+	mov	r4,r0
 
 	.align	2
 ashlsi3_table:
diff --git a/arch/sh/lib/ashrsi3.S b/arch/sh/lib/ashrsi3.S
index bf3c4e03e6ff..9962d7c587df 100644
--- a/arch/sh/lib/ashrsi3.S
+++ b/arch/sh/lib/ashrsi3.S
@@ -62,8 +62,9 @@ __ashrsi3_r0:
 	mova	ashrsi3_table,r0
 	mov.b	@(r0,r4),r4
 	add	r4,r0
+	mov.l	@r15+,r4
 	jmp	@r0
-	mov.l	@r15+,r0
+	mov	r4,r0
 
 	.align	2
 ashrsi3_table:
diff --git a/arch/sh/lib/lshrsi3.S b/arch/sh/lib/lshrsi3.S
index b79b8170061f..9218f0bad1cc 100644
--- a/arch/sh/lib/lshrsi3.S
+++ b/arch/sh/lib/lshrsi3.S
@@ -62,8 +62,9 @@ __lshrsi3_r0:
 	mova	lshrsi3_table,r0
 	mov.b	@(r0,r4),r4
 	add	r4,r0
+	mov.l	@r15+,r4
 	jmp	@r0
-	mov.l	@r15+,r0
+	mov	r4,r0
 
 	.align	2
 lshrsi3_table:
-- 
2.43.0

