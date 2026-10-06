Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C33EF0AA
	for <linux-sh@vger.kernel.org>; Tue,  6 Oct 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318384; cv=none; b=I8kJcZ/pMsDU8WpB70tXg7joiS0dcFb/6Snyh2zAVJ0wjDZkDyYvWZGKTQMr+2qCA4bPAvCOpvbenWzGTAPgaAUebPRdtKQUF5tsWnBBmcoEypsZ9HoaR8wFSJnundcfEKkJNJGOPXCGHMG0yhDRhWtD+XdbmegPLFqmx3R48Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318384; c=relaxed/simple;
	bh=/HuvMcI81Zsd8Wc7EmFxlJdMGFhy1DHGBcuwjZ5cShk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLaa1qssE3ewKnp+RlKIfo7XzNLtoqLx1994Al1G+WDE+K5SoCfvm8wtbmYisxaKYKCnpJZENlAq2AL/l2uiDiY6ofzLmvf/mrlC1Hu1FkJzdQghkiUjs+XfAHonYRgxBJfRbSN+pys0762XdlnSB6aufadh0DDZw8nqIZhx8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU/RoUcS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU/RoUcS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b0d19cf7eso827541f8f.1
        for <linux-sh@vger.kernel.org>; Tue, 06 Oct 2026 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791318381; x=1791923181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JBu+DzZZbbueC/8QmlJUcOPlzBwqeEdGhoe14aARaOU=;
        b=PU/RoUcSq56DawPrtRBkIpcFnZIoYnRapgYAbAVp/dyzQcpei6TB123M4o/wOM7h76
         NlUkp5K7fic5xmNJoPn8t0hxBC64yedh7s19PGNV79jIPsF0Ri3Ep9ONkQiqI1DRBhWf
         U8RHr5YVRnxUtCXu+5rq+SW51/Sgyfxd20afUojOCT34eljaTxQH1uBsb+BIAW+XsQGf
         uTy4b9ZAMQrLZOQcwBhvqesEXYp5wreZd4mxHBrJCCMTwMFbNTJ5IefLKnhsyNMgDLFZ
         PavAcJpRZIZJoaTNb9KSI43dFYZx40b7JShc8mB65dzT6MwVTLJSngcvQTBBYcBvQwQY
         FAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791318381; x=1791923181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JBu+DzZZbbueC/8QmlJUcOPlzBwqeEdGhoe14aARaOU=;
        b=wQfPr0H8GBtYMut+6acACcW51ytcIoOefuwhRq+VC/6IymBh4n0Z5bdW9lgY1vDjCg
         ylPS91otp0B5j7mkqwphK5B4x+y+EcFafYTygu0wdTOjbiOLXhFHdM3Kq6ZL42cEQDeU
         YHObS+jHY42o3zragER7NeACeftNxjnpC1zhysVFtRLvfQCKn37R3wB7SC6v0ZHainjM
         nYxvkUBg5GMaGs/oKhzhh2Ap0aCM/7VHXTUzEdw4RSVMYSTBc7maldMIl1vnPGDx1Vsi
         G/IgBCAag09dLtNDQyyAcnSlQT7XBelWeCtCnSUognA3gzx+YF5h01IguelTvvsIqrqf
         i6gQ==
X-Forwarded-Encrypted: i=1; AKwUvBynISt4MWlrtG7G2znaQKwwIz7W6K1s/SKZLv/3tArrw32YEFtznDSMXRBWsgkq7xnUOu1b31W7CQ==@vger.kernel.org
X-Gm-Message-State: AFuF++naMUf/rY+YPGeaoFRol/oWFafjrzFJZ4A45LiM4RsW9+hVSQ8k
	gTYoyCW5Hkl/dHc50yK2pULUa0SpWos8ZpbHoNARVje+rBM1h7rv7Os=
X-Gm-Gg: AYBFou1sl6JJQAVmwxdwcU+BOQgViQwcsa6xMlnI3lxU/+tsg11wWWV4bSBaJa7kRFW
	fmt0M0TY6f8tTBocyAalQioAmKtt/4dHJxewLXZgtylFbsO0lSSgd+eW1hTwgIuW46uoRXul9Ow
	pY8E7PnfqO/oNQZVwKS1BxyYLzRQVuMpPv6VMMp85uJkbTeUe4m8pq+IpC7GJCP58NHaWH0cS5a
	UHJ/nuVoxzXQ25SwFfdmancRh+iYQ2XaunpWVPu8P4A2uGGdmghARAtonqt279AvaNX1aaHVlIU
	D0cjQ6Piw0EYskU8YBpJtsyxCTc9uuvYv91kkpxN7mueyjcIEqzi7ryEWuK9Atm3bGYcCNB2E2+
	cpWyz6cTr6JScwux1HMGOTlOtDORzPvdG6wzqt2fI5toa9HgfUvsAlMugY3lQiXfaWFCLQAbHow
	QJ81MqtUOr0/nvO1a9aa9K5/Z4Q6nL727fNNifQUARNhVvGJOyGy6QkJUKkh3lzeP71DvZIrdx7
	B+pNiS7f30MASn/PuamrIfaaNKP5BwEFcdMf0E6mdRteXTr0pDymQ==
X-Received: by 2002:a05:600c:348d:b0:4a0:1ef1:b62b with SMTP id 5b1f17b1804b1-4a18043b443mr114185e9.10.1791318381123;
        Tue, 06 Oct 2026 13:26:21 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:d1f6:bf6:35f2:f07c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a17f5510desm9065205e9.7.2026.10.06.13.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 13:26:20 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fuchs <fuchsfl@gmail.com>,
	yoshinori.sato@nifty.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sh: lib: Restore r4 in shift helpers
Date: Tue,  6 Oct 2026 22:25:42 +0200
Message-ID: <20261006202542.777358-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 940d4113f330 ("sh: New gcc support") reuses r4 as scratch for
the jump table offset and pops the saved value into r0 in the jmp
delay slot, so the helpers return with r4 still holding the table
byte. GCC can keep a live value in r4 across the call, which leads to
runtime data corruption.

GCC calls __ashlsi3, __ashrsi3 and __lshrsi3 with a special convention:
value in r4, result in r0, and only r0 and T clobbered.

Pop the saved value back into r4 before the jmp and copy it to r0 in
the delay slot. The shift sequences only operate on r0, so r4 is now
preserved across the whole call.

Fixes: 940d4113f330 ("sh: New gcc support")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v1->v2: Make commit message more accurate

v1: https://lore.kernel.org/linux-sh/20260714104147.2016549-1-fuchsfl@gmail.com/

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

