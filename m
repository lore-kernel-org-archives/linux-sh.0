Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE384485CE7
	for <linux-sh@vger.kernel.org>; Fri,  4 Sep 2026 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525719; cv=none; b=srW256Hyuvb3/VYsLMTxtc8SaA54KwXPpw881rFp+QBU7K84EDSGKGJqf7R2Cl4v9rJffLAeKRtG02RZiK1EPk6m130HARQoFZaDSb+ugZh0mh2dlm77l41f3zlWj7ttu+0vBKGVX75fgFYb/yEw9sf1nmHQSrE8P+boAAiblro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525719; c=relaxed/simple;
	bh=p97xN+yxFG2kxLlLHkXwPxNJGFfneqahwIWA6jc93L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVCzBk78RSvXq5WJ6IA/4iUGJtEYJPTDTMJo8LKoo7VyhUua1JGskYYyPHNhieouM9rUn/WVngqP7pt81xqi44yVPPSrAE23UU/4bI1C7gRwjB+uhxiETFsmwVZE7IXgjpshNF4qHBTwgcLm4CAKtMQICHFN7dp7Sz8RoWXadkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2RQBz0E; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2RQBz0E"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7f48c750afcso910739a34.0
        for <linux-sh@vger.kernel.org>; Fri, 04 Sep 2026 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525716; x=1789130516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fo2cB7c43fEdTjQDwRU3AQpuND6TClsVlNexnSMYtm0=;
        b=Q2RQBz0ECZrz+Dp1itdysg2mivekYGX+yNjkyY7nsAnqBiL8QerOnwJKmYWYVBgm64
         ftm53vaLeocqE8WG7Jw0Hr97q4u9yd8gycmJWYeSt9iIMg4Hc9vnpV/fL5sWfQz3B/8n
         z3R8Mq/tmkDRROgfwwwtVlRqQJ3JTrCUBmZvH/fFQwEJUFVGq6nira9UVXowIBv7ITCD
         xWpmkDDUt0PS8dMyE5RWyUPI+CrW6C8JaU1ZucigejeVYyqxb3IjiKrgWHEIdIjTMEIn
         TjLUUW4fGuG0n20sf3MBTv8QnOHKcCPgNq1N1SamCkuPcC56gxbHGFQfA2A0q4LZbtwf
         xueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525716; x=1789130516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fo2cB7c43fEdTjQDwRU3AQpuND6TClsVlNexnSMYtm0=;
        b=RAgZ5tIWyI/6CcPdsz5M3qhIvdXWTuXqGbX6aQdh2h2606qQYqG5Ypg3VShAYR8JTI
         2j+mc5FCK06QSInZRscs2rjft1JkX2y659sLp89rwRwaAjJnWyFe9SyFYFAsioAp7U+g
         7eoSErt6EcABLBgsY+FTj7Z2ysvVImijaMUQXv8lFMKcqxLuxpljyYjSXg5mcEM22YFP
         EvyCSSArw5+Gh5SJAkv1+R9GcA+P6uGvUoe/a9+X5veH6A/9zKekHjxOb7JAGblyq8Me
         nOtwq+hNq1C7iMwgOdBxb/iPvi5S88fAxujelKuhGyQCMXyPmYv8XtZyUh6EMBeQq0mp
         fm7g==
X-Forwarded-Encrypted: i=1; AKwUvBxTyndEEtXb3rzmkhRDppqHt+aYn6Y8i5EVxlgTsYI+bFbeIGGptQzpC3pnz+5Myw/PjRG2HjgHCg==@vger.kernel.org
X-Gm-Message-State: AFuF++nFPDHIgk9w2IPeL9LxY3A8frC7wBLuTKP6qy3NLkPUbgHOkXsH
	Ew9wlBftGAdUfwotJZ19Ity1Es2jQQ36YE7QO1pQpr2/bYfyELdS8OPy
X-Gm-Gg: AYBFou0I9+UuZSG+ihQBLrhQ53SXiqLKromlOSu3836bGJYMtjF86ovQC+Pq/7YMYgO
	XkDxR2Ktyt8IADc2ORqY/WJdvTj6VT/yDXDZ2b/5u5R8VTGQUbGstvk8LUFP442wM4rCgPcIKfk
	4X6mk+DbKEFngN19V235wf0OZsAjn3kLcREBodMSt57cCj9PRZsvOBNkpQRfZFFbc1zzrO0L2z5
	Dl5w+f735QGiOPB4JXxmRlazVIs8cWEBQVd7MRYFkIrLUliUdECsuPjR0H9jnAb5aliV8Cl0Hk9
	3dQEDQprtNaQ+BTsckzfZ8bh44XqDSthozt35Zy+yImreJJd1Il7LkmilgCElFIZdo30zmQSzkY
	saNxncprF0rJqICpl1Xfc22IixqbPVTxFLa0lKzZ3ZvnvQo2yFamaTu0G1DF69ShB7WZFOth80l
	sP13+aKXs3RocXTCseM2j4fz17CSQgrgzY+mmMFBqdnDOup4+gDwMVM19juVKUyeTY+H2RmIj32
	hd9suTqeCTRuDL9LF9dHCPYBA==
X-Received: by 2002:a05:6820:1c87:b0:6b5:ff0a:d336 with SMTP id 006d021491bc7-6b6f98d0013mr4299740eaf.6.1788525715601;
        Fri, 04 Sep 2026 05:41:55 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm6389550eec.27.2026.09.04.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:41:55 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 1/2] sh: fix typos in comments
Date: Fri,  4 Sep 2026 18:11:45 +0530
Message-ID: <20260904124148.4575-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904124148.4575-1-hemanth.selam@gmail.com>
References: <20260904124148.4575-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/sh/kernel/relocate_kernel.S | 2 +-
 arch/sh/mm/cache-sh4.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/relocate_kernel.S b/arch/sh/kernel/relocate_kernel.S
index d9bf2b727b42..deda2f60a8f2 100644
--- a/arch/sh/kernel/relocate_kernel.S
+++ b/arch/sh/kernel/relocate_kernel.S
@@ -3,7 +3,7 @@
  * relocate_kernel.S - put the kernel image in place to boot
  * 2005.9.17 kogiidena@eggplant.ddo.jp
  *
- * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
+ * LANDISK/sh4 is supported. Maybe, SH architecture works well.
  *
  * 2009-03-18 Magnus Damm - Added Kexec Jump support
  */
diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 8bc9ce541c14..0c205923e88f 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -354,7 +354,7 @@ static void __flush_cache_one(unsigned long addr, unsigned long phys,
 
 	/*
 	 * We know there will be >=1 iteration, so write as do-while to avoid
-	 * pointless nead-of-loop check for 0 iterations.
+	 * pointless head-of-loop check for 0 iterations.
 	 */
 	do {
 		ea = base_addr + PAGE_SIZE;
-- 
2.48.1

