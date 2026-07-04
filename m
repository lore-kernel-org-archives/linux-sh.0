Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EA38BF61
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144663; cv=none; b=d7GfI0l1jxNKgp/xiFKArPqLRYqZfdlhL9xtlRruwaE2RJQV8JB0NXh08tJs4TObB8AS2ZeXmNgnXBOqfRqeb/zhQeafSN4FmbWFa5NxMErXi0EfmzaMNYgiNbXsh8XlA8xXKOXAfscenhorbF5lLArbzGE3gMtrd1oH9XdZGYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144663; c=relaxed/simple;
	bh=DdlG5IdkoCXBQ907RBiN6XiEFgItuIUy9eJMTMGaJEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9E0mztUshwVx1xkqPBihezm3oE/BdQGGO5+/TKJLzeRE+JMv7umu1rgu9Oi5fcI+qmgiQAYtRvthk3QIdOUz/s30n9/QfYH4buM04aZ8YTOIwIRQl47cmGRGXPCYYLp30wtiqy7vRG6YPrjvhM0h3aGNFhuaVevyFDoh0rdhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2fEraH3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2fEraH3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cc61541f8cso2655225ad.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144659; x=1783749459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpRM5xO2P6CrGv5fZ5v8OZOm8BQmO2xLbX7VVDuxobU=;
        b=e2fEraH3wg1AbdS1O2L9iUT6PRowvs9aZUOZZjeJg0pd+nRm3owQDX0+ko6XioW8y3
         jnSRzFRNpp6rwWgAV5TH3/qfEiiWf9MBw0CHxdWvFbeRJcbevgdM1JDHCTzGnQK+MjId
         Ya8LxFSD/E7knlZzh9lTSC+oot/Axm1c9i0l/dOV0VkdRhEvN+TVxg90VaN1zmaSq71J
         xMBbNvZgKw/ZQmbOlYK40cFJihnpcZB452X6hqAGqs3D9kV3J0n1SElvr8WT8FNQmuQl
         n/2SyAYFWeR5SUA30GmzjRvGlz8JBU2k1RxYwz+oeDSePFg4isf66ahJAFtHCDYih/gf
         KzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144659; x=1783749459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZpRM5xO2P6CrGv5fZ5v8OZOm8BQmO2xLbX7VVDuxobU=;
        b=k0BiOGhRDzFfZ4xuPHR5ePRYY7oH7aqi1V6ZLc412zQhvzp+fdI+6K4Bu65MhQNwLt
         mJ4pe09OKxMpC9B/dPaqVhGAUBRHFauX49SxZspVSD3PtlmeFcCLXsPrJ0f2c/4Zkwga
         lIncXjJoJnkebzb1HILnog9QoqcyZElrdTJCfS0ZFjyQJVsvWOr7xYPt++14bDK2mnL9
         monzDSFHJGnfl0J3Qhi4oObXig16MSxH9Vb39W3i4CvIMiZlomZS8Bf3eY4eaN6XmdCJ
         YMl9YTZMZQJWRRN4PaEbeQfLf04W1KbnT7b94rogtHO2ZYqGbftRTPpkYGTxVL3/DZja
         sIrw==
X-Forwarded-Encrypted: i=1; AHgh+RqhlNIWgKpoKR+Np1q8WKxGA02XxD0S3Can28EjSP2m6SQD4aEhLxYWHHpPE5XClcZyp9sdcmb7Ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQ78+fUQAhjsDco+3MUuOaEu1oCkE62srY3KK2PHuBW6iieie
	XxjEDeiLibdp1CiibCElRmL9X5LOYJFXxWgQi0eGFD3CPLjy3nQ4IDA5
X-Gm-Gg: AfdE7cm3/HLLLYybAi5783YLzl4hEw80DuMOxYPcs5yowOLmKCYGt39EgQDrTDRa/eL
	uWDPB1/QeT8lFp6TtJNQAALbbJ2vFwEr7fRI6oSnnMM0jMg0tzosDsoqNwiNK2RUqVzy2SW+Ij0
	PZ4/D6fmS7XTwbTXHsBA/MgE4fnAdrqVbXjpJm9gfmnePJ0jhFhpvaMWXkiTWRl4vCTKfjXcPz/
	75SckaE0GZCE4Fm/ePBCfCVIHz08xveuhi1u9Q/RFZVhds7Hzni9BEynmJqwAIBCOQXTKLaqUl5
	dodtzKF5oWj+bSo+8UAqwAuoxW3+/jQcBtltE1E4yyRaNKuTOMkk3WLZhu8X4OUY8gDq8OXraNs
	9bVcg6wNzthhXEk8fHaDw2d4EAlKSfh5Itck5GKtLfRVmGR37zXRB6ZOckGyiTsuI0cxsz2u3FW
	PfSANKwOHKzrneIGIzCECa5UeYmTkvM0tb2GnYCHa94ZmwUZFIt1RdVgyrc3Hf5f3OExODqRdGC
	/k=
X-Received: by 2002:a17:90b:5251:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38112063c22mr7851183a91.3.1783144659437;
        Fri, 03 Jul 2026 22:57:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:38 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:27 -0700
Subject: [PATCH 04/26] Input: maplemouse - stop polling and clear callback
 on close
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-4-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

In dc_mouse_close(), pass NULL instead of dc_mouse_callback to
maple_getcond_callback() to both stop polling and clear the callback
pointer when the input device is closed.

This makes the manual clearing of mdev->callback in
remove_maple_mouse() redundant, as input_unregister_device()
automatically closes the device if it was open. Remove the redundant
assignment.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 0c8f7d1b02aa..97d520e7d66d 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -60,8 +60,7 @@ static void dc_mouse_close(struct input_dev *dev)
 {
 	struct dc_mouse *mse = input_get_drvdata(dev);
 
-	maple_getcond_callback(mse->mdev, dc_mouse_callback, 0,
-		MAPLE_FUNC_MOUSE);
+	maple_getcond_callback(mse->mdev, NULL, 0, MAPLE_FUNC_MOUSE);
 }
 
 /* allow the mouse to be used */
@@ -122,7 +121,6 @@ static int remove_maple_mouse(struct device *dev)
 	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_mouse *mse = maple_get_drvdata(mdev);
 
-	mdev->callback = NULL;
 	input_unregister_device(mse->dev);
 	maple_set_drvdata(mdev, NULL);
 	kfree(mse);

-- 
2.55.0.rc0.799.gd6f94ed593-goog

