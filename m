Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23235434E29
	for <linux-sh@vger.kernel.org>; Mon,  6 Jul 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355936; cv=none; b=HZQ+iBU3tZxj3xwq3r6lwi/enPz0+MwLdVrATFoP1loIcBJJ/gL+bReIG5BGoPjyP7A4bMmvtQgSz+OhrU8OR/pcQAPmZTx18NfSe8xG/fa4OAaSdG0eu+y3qH6UWb2OT2wNNBy5/KTYFwOO11+mZ/zEYYva7EOlsHvk4ryBGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355936; c=relaxed/simple;
	bh=dybo8/HrHeGrJGasUpHRaqT8xbB02VCrzfApuMlEzCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Noxbaql0qYSwaTDQAWsBUjnu/5AsexDS/Y7Ex/21HEb4Acv1IHGanpACCfbT7Ew8dm0IGP/lO4G1OmNOcUXKQQ3PntPqTfMHWFhW1Phs4K3nxGQbNtWjXdemLmeFluPnk2eslMi6qJs30TMgRUEcVIRDSULC0YvWW9Yk8p7e3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lne6RAzV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lne6RAzV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc8bc9d222so16393255ad.1
        for <linux-sh@vger.kernel.org>; Mon, 06 Jul 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783355933; x=1783960733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtnXNaxn+fspW0Xw1nKXB6TGSGdVBv01OAGdj8wNpN0=;
        b=lne6RAzV+cu2p2JVqlwsZIbYdda0Uvb726LljdYmoOwSncBxXb4br7ZAiZ0nL/E0q9
         pPaN9JgblE/CEVoX0vqT565Qg/BQJe776U0RjO2eLuVvLkbwKBQr5waiNBQ3y7F0qwQX
         xOcLPBKVYYQhglMMjwVT+IWUrKvaLMR3w5Ipd3DM/IuXi+aBguHWwetJlHcd3qFtoGGA
         HUbwuPiuLEP7zW8hwoWchJk2mKYpCvDuhIVOpCVl23LtDXqETO6QiDQMRsYdf75P0R+W
         aYjuK8ljitHUMQtswBzxOsCgQKr4A8Z/4TkGytMrJcOf8LSyIFtrY1YUEhJAE/7W/yLY
         3HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355933; x=1783960733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtnXNaxn+fspW0Xw1nKXB6TGSGdVBv01OAGdj8wNpN0=;
        b=fW959R6kvhEGUtTemjf+faL6rW0lyQE1sLeike3hSaqi25lmGKejXxJfw8bpheQnYl
         Q2/bsTZS/DnQk4Yl4pvHlvWztwWqBrjZjFDtA0/StZ2kZmZiZF70+pck57/L1fUmhViL
         F2m9fWDCOKRqHFDpAbpz4FmMebCz+TdZU5KYKX84K7OACqXCWLOiQFx6FPwnonrlIWX0
         Yso7QgutBPUAWwGcYZj7MRcmSVhDa3raJat2KERu6g1yzIkSUJfEgGd9eco//rrK/dob
         mgApQVUj+xWqFEy/k56tEtAYPBY2gKy/8Gvfnx/3tkBtgwwsdngWQfLqreCxJ/QMLzdv
         RbiQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBO2qP0O3BGxjl1qu8jbeNAdL1GPyvY2r75Du/oTj5TO+gdRYZwkUri5YCtam+a4/80n/MQBLUjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ51yckMEw4BXJF3fb5dLGSmCN4H+eh7Dp22CHpWlqxxCpjKV7
	KDYhE9iLP4Ts9wZWgwZQtE8MA8uD7Pcz/qe0EFRIxvWzG1PsEAqxv8tH
X-Gm-Gg: AfdE7cmnTEujYDwm7tyIfmMxSmRNwIlhVsKPOUUfFLXnJo/I3IacBT5QH+efVMAhrSF
	cttvkCZZYQ/9kwjAc68Cz8HDURKieGow4lfa0C17IapeQAUDgRqZCbXPPFAWi33WpLb7IjN3jVx
	DSSsRMUU59DdqTMGKplUDzSThJvM+y2zXs2b7uCoZwLr7egccwXImOIz2HifSl3SCjt/zhxEIHF
	XxWCC+vKiS8uvOkvkNeA6OEag9lmWFB7DTEHCayJEzOY8GwG1Kwm6hhyunTB4LCicNJveHEJQfl
	+4WNz2YtbBkCjnhKgDBQfjSZhh3KdogezN5HeUUyubLQoZ42056RTYF9vWyggfVQV18CJwkcpIP
	FnW4LdvlMpgrDLe2HAtLLdBeTVIY1QIuSsDsEfnrG9ApUFuN3Wiy9+w8WQLze1iIbYdU/ScdFNa
	o3akmSXU0=
X-Received: by 2002:a17:902:d486:b0:2c7:fae7:8af with SMTP id d9443c01a7336-2ccbf0105bdmr14950715ad.24.1783355933532;
        Mon, 06 Jul 2026 09:38:53 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7893a8dsm53103305ad.73.2026.07.06.09.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:38:53 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: rppt@kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v2 2/5] sh: remove unreachable memblock_reserve() return value check
Date: Tue,  7 Jul 2026 01:37:50 +0900
Message-ID: <20260706163753.193875-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706163753.193875-1-ekffu200098@gmail.com>
References: <20260706163753.193875-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reserve_crashkernel() runs from early_reserve_mem() in paging_init(),
before the same function calls memblock_allow_resize(). At that point
memblock_reserve() either succeeds or panics, never returning an error.

Therefore the return value check is unreachable, so remove it and the
related logic.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/sh/kernel/machine_kexec.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 37073ca1e0ad..ba9c412f14d9 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -165,12 +165,7 @@ void __init reserve_crashkernel(void)
 			goto disable;
 		}
 	} else {
-		ret = memblock_reserve(crashk_res.start, crash_size);
-		if (unlikely(ret < 0)) {
-			pr_err("crashkernel reservation failed - "
-			       "memory is in use\n");
-			goto disable;
-		}
+		memblock_reserve(crashk_res.start, crash_size);
 	}
 
 	crashk_res.end = crashk_res.start + crash_size - 1;
-- 
2.43.0

