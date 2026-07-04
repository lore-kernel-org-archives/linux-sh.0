Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D28377561
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144669; cv=none; b=Vg1Fy4ZpFs/E/fB5IUqYs/5h2t35YveMaEot9H1D6mKHhIKpnDu7QwJiL1/CXz4ni93o8ArJhoGsSg9TOr11gZYnGMnVtLl+ASD3+6s0ojSDmHzac9WlVQiSQ3Hf5qFRSkRqgR+TTWOdM4FWzWjBs6FHQsmvg1MSdPneAGX4SNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144669; c=relaxed/simple;
	bh=Iui5gWYSUynRCagIZf1r+I5yOOQ4yuu5YgE0mJR5/24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VC2g2lAW7G/KqD9KP1B9nEkbitYo/xU2EiSVbgp/X8HIqMvgdprGM9GWFuBqnuL/ejUUM7REmds/PpaXEv4C03DVAK+o8RxFHUHabs8KivxNVkNJl705MtgT1q+VHFff+FX4nDAJ83rKP8H8aePtaSuI+0z3Azyo8w2l3KO+PzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cET15dzt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cET15dzt"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37d70036426so808820a91.3
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144668; x=1783749468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/P2FegzAbUFBaPcGw6l/wNkWF21hDcB/lwqrEd+3RkY=;
        b=cET15dzt8Edk9DYPrWDJRrFyyPQooFwN7rnoBYHNgF3LUkrRXajWM+4Dg7kuRKY1av
         vV2DmeMXQ6T1J2Eha/rRvWLSZ9WCPbTrVitcUmRA/umxjzZ+CCqnhUho2ufOTyjbrvWS
         VsUcwIlzEMQRUNcV9Yp1HOkzSY+jkEIiTJbudl6Rs0LHD4NJbLO268QFGZWdLDjtDB8l
         Gd3WUgDORNMqib0CqTfR1Ivku5nyAyyW3+C4jFsK7Vx3I2rU3PGPLB7HSltkbPd/OavD
         NO3KeIMpTFo+FyjH+liAKeGQMTmaf1T8L/YEEI8fI/TjzcAOGJz6XePzdc/7PvWfh52b
         sGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144668; x=1783749468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/P2FegzAbUFBaPcGw6l/wNkWF21hDcB/lwqrEd+3RkY=;
        b=jepAnt9kqoiMwXWwHjOBqoCFtFdAajAR4fcpmqHF3HeY/FGK9IrcWYZ2uMBgOG1o1v
         FkFan0zYo47ygM+BQge6FSgT2QUipav5QDOSHhF+ihxhAEsOoUcb2D/wpvsTURLob8YQ
         mB+NNXecwOFjz2VHUeyrgIlxMNLIc5ar/Xq0y3aZ9PnsTCxP8VtZGEad2cyGVOUPg3q/
         f9eJu4dyv+6ThLA24T84BXZ83htfQ0edW+uY+juBOjiG3uFGiO7u7pxcetktoHXzdE8U
         cKiOw8b1BBiXWIZaSNdLX1O+pArLXkv4Cq9ThIu3CvhbhUlweOgUW6AC26xl4z/gfm/L
         qCvw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+vsGIF+oFdpWSUWkeNzruFGd3D5gOYX08qXjESwB1R75zyc5zd8swKwYPiWXf2aCvUGSRCKYswQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZo5YQDMpqIDS4gKe34KXzPiikanC5xkjTkoSLbRk8w8bljupV
	h1tFB75KlHD+wrWyTP9F4HciGVCIozAnTX0BxRT2gKtkhwInnWVg9U7s
X-Gm-Gg: AfdE7ckrjdJJw19z8AolH4ALqQmuyBrofX1NoNbsB9ZllQ/yxeMRAx5joB12XEVQlAp
	sbkmLY7u4xVBbURY7Sts21u+qPMKHmjLmSe79+/cNjYpwMl9F1Nn3OZzg5u1TxLSBF0OR9Zkri2
	9fXBhxLfbLIbiZDLQAczR7QInLuVJ88c5vEre6y4eRbAe/+u1W9n6vPyNsJ6+uAB5ajvtUXRH24
	9tmDWmP5fmOMgHkLbwJg4NN2KaYv1oO3TV3mNBaK5s11eGt9zR1hsi+KqoucTKuRSG2A9SViVhe
	lOKCfiWRDjCbMFNThE1gIOgD3lSLYFWp6/8zrFgkpm1NNTLhgw9O4CGXMMkedWa0GkOBPX4QNUx
	Vt0JfYkvGr9Q1hTYHH6D1l8qF0CxAWMI30atHf8my0TfPMnievyAFQUDim3EnPMqWfvW3XPuGig
	Izb1PJNavYlRXbA/eoZME1CSjd2dor1olRe25EXVbADYEX3fjMnJndobJJlLMsox8K1FXYrKzYc
	ps=
X-Received: by 2002:a17:90b:4ec5:b0:380:f389:447b with SMTP id 98e67ed59e1d1-38280a9fefemr2264979a91.11.1783144667531;
        Fri, 03 Jul 2026 22:57:47 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:46 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:32 -0700
Subject: [PATCH 09/26] Input: maple_keyb - remove redundant drvdata
 resetting
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-9-41e424964da5@gmail.com>
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

The driver core automatically resets driver data to NULL on probe
failures and device removal, so we can remove it from the driver.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index a245774acc55..0c92138bcc77 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -212,7 +212,6 @@ static int probe_maple_kbd(struct device *dev)
 	return error;
 
 fail_register:
-	maple_set_drvdata(mdev, NULL);
 	input_free_device(idev);
 fail_idev_alloc:
 	kfree(kbd);
@@ -230,7 +229,6 @@ static int remove_maple_kbd(struct device *dev)
 	input_unregister_device(kbd->dev);
 	kfree(kbd);
 
-	maple_set_drvdata(mdev, NULL);
 	return 0;
 }
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

