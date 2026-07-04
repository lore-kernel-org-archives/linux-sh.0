Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857938AC92
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144675; cv=none; b=nUTGJfU5CqZIqOsDyJQwTS22gmtVjbq9ca8HjBN3wIHWAHQIByXfzgaN6LswDaJx4K95FuV2tKSafnGg75yGpjb1J4+UB7MeVGVzEehCpyutig29e7P5b9UWUiRZx03nGK6e2VgEBBhZ/m2TyFeBjaugUV0f6B7iYOGt0K2Y0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144675; c=relaxed/simple;
	bh=YIF7ar5wz8/hkgAvDMQQcbu0A00u2r8cdOkNUyS5mpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kNqPM+PDA7P2as/hkeajiq8NhkF60lL+GNBgGsyBehQ0brRSCzkIGtuUpbeJHAb8kIW1r7cYyQ2bqG59Z+cKgSQ2z2bUMjK2QA/eMEut9HZmeLpfDm5Y2Mg4wOtIT4KeemZ/ACSuaazmxVVTR468Wphe9E+TLTwe79KAHGTQeb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaoZaSd1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaoZaSd1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845f2909cd4so820766b3a.1
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144669; x=1783749469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHrM5LSEGqI4QhlJVp2LQ5Kcemj6Dk254XODTohARZs=;
        b=oaoZaSd1Bb3yqAeqhQtGSi8gC0MSLZMzPh9985YnfBFEG6Y7lxWSQ5iTf159eU3kIY
         HqqC1DEau8++AuiygO+J88zeVIdxCwA9Ka06GqQPX/5rco8t40eeUmizmNRPoyDukZFf
         SBzrgXijPvxjr654gBYWOa083qGcWmyqC//HjEHBbpuSagi/uGRviLaJEqgriXu6qoM9
         lZIR1xBo0GSPAsL2SX2hOCl0oCkmRhi4saKdpjx1ApZyc1ECQaQYPGQA1g1fU77RwlDr
         zJY4J6Xk3H8BC0TDmtgZEz8XZd9+dUqvvoNlbyNPcv7dBME08pIUK6J3tCULTHjxajId
         ot5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144669; x=1783749469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lHrM5LSEGqI4QhlJVp2LQ5Kcemj6Dk254XODTohARZs=;
        b=iQi6pjbz8mOy3GILVs2VCz9Mpk389M4MFGD4tzZB3u9AS4kh+FKXAqFkdMWLJE4i/Y
         HTdUBwAl7EtUvccoEHxpj5l1olaBXoAhK8WO2JO2bJjVcS3aHdnZKUHRHNhPpQiuqLXR
         vLRixVgG3T6XCdpb874QokLUv++VybwkN/8Pg3XK+iuxEy3rgy0UxV96HUiW8c1nXb2K
         oRq8wYe/4Ew3exbKUvc4FlArh3FssVIIRbct5AWfcQAyU9CMAMeRwMQfyLFcHUDpLn++
         Rc/hHciD+pe0ituKR+7vJHHxwIYlyn8MZOmXD8n+5vssMqY5DlBolevmJw9CLqzFufou
         UdZw==
X-Forwarded-Encrypted: i=1; AFNElJ95iJeFxuriXaKXoaBZdEspQEo6YW4Ze1+isXw72EHYiFSBUXyNf1+auNHW8v25ZmGyqE51Yeu7Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7RYOrYWd7BVu4LNSTDsDsgjGe1Ve0u0PNQthvdzZbQCFnX0VH
	A7EiTIYZIqLQFcoIsNo93PR5gp16Oo3SzSm+LruBpvBFhhjtm1vpB0SV9nd/Rw==
X-Gm-Gg: AfdE7ckOMFPFqDzrVHi9s6x4NxCDUHFF93E9OfRZE1Z5oaBjV1WwZW6q+eWWDlDh2/D
	nTwTwRRbfTxd+sy8LsFiA9LyEs6y3FCwsfsuCL/Ac6l6BtdgX/AR5fVt0maOXFSyA3cmpc5WF9v
	iT4i2B8AIdAXt2KIWUsCtphajQVLPglvHlb2Gu2MT0DHm45zSzSMDHNvWKy+8925SLW/eG4fddF
	Ubl9vjGgil870YfJ8o5vloPIJLDEjuOmFzobJ35jAPgizoloDh9ZbVidIwBXKZNQXnl2J/L0iXw
	MAlrJmqY5U1L0n5FpsZygtENHoPCd5OCHlc3C8KpcrkH8bSjpmiKL6u1EPWGaqsaq+RoZo8xVfq
	tqvfo5C9djKGBEVtrk3uT3JI6o0ci11qgKOYsMP7OlxcT302gY2oTpaElWw5Y2H/H/zsB3Ivmx1
	vbGZNv6LeuzxC4DY9UZvIsKy2+QYHvu2l0w5J0TI6OeJAIcg4DyHj2DksPYn2Q6iYHEJI73HQLh
	ohoEEqvNDAx8Q==
X-Received: by 2002:a05:6a20:d70f:b0:3bf:b4ed:5579 with SMTP id adf61e73a8af0-3c03e4f1acdmr2369689637.59.1783144669308;
        Fri, 03 Jul 2026 22:57:49 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:48 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:33 -0700
Subject: [PATCH 10/26] Input: maplecontrol - remove redundant drvdata
 resetting
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-10-41e424964da5@gmail.com>
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
 drivers/input/joystick/maplecontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 9d623c9e8f22..79cec89ad52a 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -146,7 +146,6 @@ static int probe_maple_controller(struct device *dev)
 fail:
 	input_free_device(idev);
 	kfree(pad);
-	maple_set_drvdata(mdev, NULL);
 	return error;
 }
 
@@ -156,7 +155,6 @@ static int remove_maple_controller(struct device *dev)
 	struct dc_pad *pad = maple_get_drvdata(mdev);
 
 	input_unregister_device(pad->dev);
-	maple_set_drvdata(mdev, NULL);
 	kfree(pad);
 
 	return 0;

-- 
2.55.0.rc0.799.gd6f94ed593-goog

