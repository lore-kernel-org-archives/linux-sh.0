Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5D3546F3
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914134; cv=none; b=FZHHRaW8jJT07wN5O5goPQzwnw6ch58m6c3NMG3tneteLeUZ9GEjwhih0MCrrTFdK9DTrejSsKjhHc65nOInxJeMcKR2WL7rxnQGdhZZptfVj+AdFiCF/AzUgfGOCN755Us+y+wW3KYYhbt3zQFmdvkASokuenpo3HOJp8x1AJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914134; c=relaxed/simple;
	bh=qgQ8o9DjvH6ieIOzSmEYyyIFGQLoskqnrUq7Jp/a0BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNne0149f9DVnhb04zgT8brkxFK81WEDmojxOEOneS2BB+uWpriENLcIht/6NC61M8c6C7EoPISLN2oFtpVF6WBjV2I9mfR5Btsw5NIwu53W4TSi4FjGQz8ul65sPOukZvmuQZoQ7RRjRjo3yRfGfWFZvbhGAb36CJFCuxL7iYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8vO6E8s; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8vO6E8s"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso3786538a91.2
        for <linux-sh@vger.kernel.org>; Thu, 01 Oct 2026 21:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914132; x=1791518932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wr3tkUjUJP2wlDJBZdeQAQPJN9CHKV3kl5+7OASdaKM=;
        b=E8vO6E8s4e11RUmevWzNzQAqSGa3esTOD8Ial//gutNvxx8anAsBEpv82VPLNe/pXk
         Zxa4BsRW8Dl0zQ4DRKNyZLXtfFm3Ytqxw/egsawl4fzcE1MBoVnY2cpclcNWYXmEewff
         s0Vd72nc34H0ZSl7KUmpWuHbLcPkzUD9WCqOcEvqujQFgdX4ZIXXFqRdlk+pCISW7D+j
         2VixliFsTFXBfVSiqUzkGBPrLFWbfWHMICcA+wQT0sZVLj8c4nbMIz/ToFd9G3m04mWC
         oYFJhp2Dg2J3XVeYClFuBOKtqpSqffq4oeYSDFIEmkel9SIqh97mg8gu3RFEDCMauXjy
         YJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914132; x=1791518932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wr3tkUjUJP2wlDJBZdeQAQPJN9CHKV3kl5+7OASdaKM=;
        b=oPS8HaLOPsJCmFpoTbEoUZNjxgssuD3UAozIqxEim2n64hmpEmgZ6+Ckl3081GxWhX
         HzC2WYIZscHZYlzS72XKPCiYr7Y0nfieOdjUkL/13ebNfZ6LLM7UVxAfNro1VwcSm6Qr
         P/rUTzWEfGNDNvh23tC2aYpEf3CeQJy2bwSsWh41xZQsQnmPc/DDyGXPXgJWLdjHx83D
         89MJw63xIcDjFhF9gXRTBehprFZq8sEXqo3dWCzHKZI9Inx7IEiwd7+pW+zGrHcrcHoV
         o2+nhhpSgjzNU9Ww1yC/v+MQTwAQy33CpJUh6rtPWpE2aFkkheblvtoyRRfUW8aP3jcA
         0ZbQ==
X-Gm-Message-State: AFq9FYLJH1AQarcorMVLYBC043TgASMIioNl7TtUqDuxUl4RE6YrO/xo
	2PCH7oghbJOMLhJDZiMri55mkrjY5/qUWL+Jnw4hJWWqTXmOtZowuHP/
X-Gm-Gg: AYBFou2dnV8bFAbxs5e/dCN5joJpTBq5T3NIzIF2b3PTVRP9r/znEi27Qx9fmL+Td3Y
	h612ltW5xePzHxxG5wUYlMjA0ZljLp7tZamfDyZ6YO9eq0erv2BONk41/sDNLqHE/Vq40MIXlI3
	DzfuQY/MR9TKB0mb8HVWPbv/btheQm43Szt0JA+d7ncDKTvG2z1csVmdjlGvg9B0WDbYpzJ+Z+A
	e8pWbM248tC+CC/c/H91lb+OfBe7ypvwbfPNWI13QeRjE7NTooH+2HCyNSJdJHb8+9Zv7pLSRDK
	6YXw7s7I42W+O0LeH8aMVRDo0uEK9ntmLVTgMjZGnQ/mPV6MY5nlBCECeRIMAP+nhsVG+un/A/f
	gSNwHJ6LPeb+Ar//5kOZN/LTLeRbtm4PPzXFlOXE23iPmzwByPSIlxpPMb1Kxt5uRROP4gJD1pA
	/NjJyY2BJvALEqN2PVL1itpRUoP1+PpAS2BFVtJMP6P0Ds89e82A7L9gvGWkdfJvO9Rcvwuu4XI
	dPa0D5MH1uOVKgQRTu65mhgKUIG10MZiuTJlPmkgp8/o7lay4WAx45Wgnw=
X-Received: by 2002:a17:90b:3cc3:b0:3a4:c673:7636 with SMTP id 98e67ed59e1d1-3a6ce77cc67mr1445077a91.26.1790914131522;
        Thu, 01 Oct 2026 21:08:51 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6ccc92646sm2119079a91.1.2026.10.01.21.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:08:50 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cacioandpepe <artem122novak@gmail.com>
Subject: [PATCH RESEND 1/2] sh: guard SH4 no-FPU compiler fallback
Date: Thu,  1 Oct 2026 22:07:59 -0600
Message-ID: <20261002040800.131862-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002040800.131862-1-artem122novak@gmail.com>
References: <20261002040800.131862-1-artem122novak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: cacioandpepe <artem122novak@gmail.com>

The SH4 compiler flag selection falls back to -m4-nofpu when
-mno-implicit-fp is unavailable without checking whether the compiler
supports -m4-nofpu itself.

This breaks SH4A-only toolchains which support -m4a and -m4a-nofpu
but do not provide the plain SH4 -m4-nofpu option.

Use a nested cc-option so the fallback is emitted only when supported.

Signed-off-by: cacioandpepe <artem122novak@gmail.com>
---
 arch/sh/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 7b420424b6d7..238c701ab14b 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -36,7 +36,7 @@ cflags-$(CONFIG_CPU_SH2A)		+= $(call cc-option,-m2a,) \
 					   $(call cc-option,-m4-nofpu,)
 cflags-$(CONFIG_CPU_SH3)		:= $(call cc-option,-m3,)
 cflags-$(CONFIG_CPU_SH4)		:= $(call cc-option,-m4,) \
-	$(call cc-option,-mno-implicit-fp,-m4-nofpu)
+	$(call cc-option,-mno-implicit-fp,$(call cc-option,-m4-nofpu,))
 cflags-$(CONFIG_CPU_SH4A)		+= $(call cc-option,-m4a,) \
 					   $(call cc-option,-m4a-nofpu,)
 cflags-$(CONFIG_CPU_SH4AL_DSP)		+= $(call cc-option,-m4al,)
-- 
2.55.0

