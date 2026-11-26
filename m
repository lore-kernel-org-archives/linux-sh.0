Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795736632;
	b=d5KUSrm+03yaeT2HIOvhWkvaa0LbVsJN1GkfjPs8WhHprQL18MxXQIxXLbX3uYrsow8A
	 5xe1Qyj/94iK2N0JSjebHhjYSb9Ru0LMw9+efZDb/BZ+U/CAgvXDr2DWD10PcC8cVpUkI
	 3ECGISUbVYg5ae6WllLWFavRdYCnn8RdjQtomq6TGZYUPWjuN5sfr6RLgkU9GEIwmgw6E
	 fVSrbrHDJWt4NBzXhXkNIN6mROdhKDmNvmuItm72TX9mMxtEXHq1MjuuzGB0z43/9yO2v
	 wquL1DYOFGeC/1ulF5GUxutQCgBSAMr5k6PhviDAhgy755nrDgAWgDRtYhkWO11woaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795736632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=nabDe3IU+lYPz/hho1p8Df8ddg25m4scBSKD0WbOpWg=;
	b=TNmRhHYgXg1mAx2vZ9qtXLnsx0vBAGQv4XN3814mQasgPjMZMINY5fPSzGgkQAzuMWZb
	 BznwZcEZebcO0B4XiewEVhJ+oaMOb7813o+fn3ytgyxSmP8f5ZvCP79fN8K4DjNfk+1aH
	 3aNdroOPqpt3gzdccnat8Ejn48FyghVo+a32oa5J+hNRs5+7k4EI74fDI6+wNwkQx1Bak
	 jUt0YXd3e6DIGl6Kg6OLcw7/TBR9qfWRPA6cNBHWVzXnig5gPMrSZB3atQ/6rfu4ev66/
	 Yu+aTeQExVEyZUSCi3s9o439rxJCGCy1z+q1KR5uVxOaVlqwK0Hqtii1juufzfKfbPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PWsloo/P";
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41EB606A31C
	for <linux-sh@vger.kernel.org>; Thu, 26 Nov 2026 23:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B41EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PWsloo/P
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so4485839b3a.1
        for <linux-sh@vger.kernel.org>; Thu, 26 Nov 2026 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795736631; x=1796341431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nabDe3IU+lYPz/hho1p8Df8ddg25m4scBSKD0WbOpWg=;
        b=PWsloo/PvjA5g6LQHjM5Y5EhQ4f8S3XxTwIe8Tzrv4Z7CqD68w1vmx0a15FO7VQdMZ
         yH4jcTSVVgbAXOnyM69SIFi4Ml9Pnbp/D/bDCEijY51cBZfVAGyV0Q5rW5Usn4meHVuo
         zUcYmKtEqcWVHhd0PAZ/lYyzWmDbA8KO2FWZ2SBhPfHeO3Tez1Jb+cQiUdb8oSla2t4d
         2n1J1UpKvUlvZxPp5c83tMvazzCA1fsnplomSahONSZnXjn7E3L3sMkqDUXP2bOAjjLs
         E8E3UXm3VxylBaT8EGhxAdNQLJEESGSNCKgA5kbWGTLG1SoDQgJgoFnzdeCkZi5ITBcF
         7u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795736631; x=1796341431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nabDe3IU+lYPz/hho1p8Df8ddg25m4scBSKD0WbOpWg=;
        b=AHDR5/JdIafB/n7gcjFXw2L8a8nSjS82IbPJjWzg+UzGzCgw6GLSLQogfSAbi65pdq
         utidf9j4RHbgYb1OZaB6ovy4IWFOt+tUCRR4SmuOw81SWSuAeseFeEud14AuLupjrX5u
         4m3uuv3aiberBcPgKGV7CThk+9nyxbgAUraUxYVd36cMWwKI/kl/4nTr7PW0wVXkjwao
         m+CMrU47NTc4EGbqVUaKPunYDY19hOQcSJp0sTbgNZH5F0yatWj9tuLV7/mZWA7zBNrn
         lAFuu+BqMdnPOdls67whQ4n624N/O5/aQ2ylKTMKulHDUYwGXxXaa/jVx9nqU/UcMI4x
         7A7g==
X-Gm-Message-State: APuU4Z/6ReKBvxX8dLAlK75KUYoZPQQDQzVI/eHUMkKW8P2XXx47qsBm
	2GW6RjrOj5Zfq0OX4+TvqnnvFdGYtRW9LOAsJse8LiNVrgszXIBhH5RV
X-Gm-Gg: AZFdTZdvPwTVlrAX2wo70KnOqA5rWv74UXE1rCLkP2KE9daQaPMmBGHVFAqM4VSEIqT
	jRWVs3GDZuxji60qRyaRs7nh+E9IjzX9YI6a3hPpTjZtiGfDJj+wtU10w1KKV6rkkFRB5rs9qbJ
	RNLIqcB64wc82/1PGHmSqBqj5KLtQbkzLkQxHa4woXFwgf0SHIT6hu2NipyQsDhFlOSo0TaZZWM
	b18oIUa3LXW3XZC+8LhdTFixf3vB/PhrsANM3ZkFKn0gfNMUrK9tcuHLiTkRio4bEBIyOWukYh/
	6V6AcSHuVY+N9lkLtjRngpFOUppGvjuCwfdtkpKSvjFFSJiZ59ODcMHCE1At1vn6W8RmZ/TTyMA
	cjHAHazkzcm0DYRYjT+ez4D05xRCNY1xkLqkIzMbkDxBr/LBBeOSUl61Rs+4X9zFWCfoK2oHTc5
	Ubgux1B+utyNEikYEj/5+byJLwCvj9Q/VSDXxKmtRm9wfgJ29xQPt1bolv5siAX4bzESj558tcq
	L0SkyZuZ4UTXXC3wmpiu7cDXVXtT99hK7roJtaY7MZysN2SLBiOAxOVQVo3EttiaYSUaagPmPfY
	pRG4JHRiqniKZC0Nj0QQ89YC3SQTeU8e06XXKyjZKBHaz0fGrQ==
X-Received: by 2002:a05:6a00:4c10:b0:8b7:6ffa:f201 with SMTP id d2e1a72fcca58-8c7ddfaf8ebmr15763613b3a.29.1795736631025;
        Thu, 26 Nov 2026 15:43:51 -0800 (PST)
Received: from fedora.tailc1fb0a.ts.net ([172.219.65.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e4d7basm11120665b3a.21.2026.11.26.15.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 15:43:50 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH] dma: dmabrg: remove trailing whitespace
Date: Thu, 26 Nov 2026 17:43:49 -0600
Message-ID: <20261126234349.74357-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the tab-only line from dmabrg_request_irq().

No functional changes.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/drivers/dma/dmabrg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dmabrg.c b/arch/sh/drivers/dma/dmabrg.c
index 3778c6a363ec..1fe63b2e4c61 100644
--- a/arch/sh/drivers/dma/dmabrg.c
+++ b/arch/sh/drivers/dma/dmabrg.c
@@ -132,7 +132,7 @@ int dmabrg_request_irq(unsigned int dmairq, void(*handler)(void*),
 
 	dmabrg_handlers[dmairq].handler = handler;
 	dmabrg_handlers[dmairq].data = data;
-	
+
 	dmabrg_enable_irq(dmairq);
 	return 0;
 }
-- 
2.56.1

