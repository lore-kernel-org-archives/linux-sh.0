Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466246;
	b=Bwq+1K/svz+U2By78kbdIPxrHsAfw1SZooPrT5ecdHYaKuVryIF1Uw4VjobrKMHdYS25
	 /HJjL0/7YNr5MN4gPRoqv70gz0zosRBj9rOq4SOQWWQUVgsHvpvAT+LgohgYGrPo+QKF5
	 CGLluTbC+suPzn/hiWhByjuAg+y4xPJw4qIfsZjsftadr47v6sj4HE44dco+XLSVTX58n
	 HXT6aZhStq3ZDZ2o8F1fKfbFX+SsJAYNCLCrHRb46s6ULxa6IGD7fa9sBKHlmLZUMBJNw
	 rerZ/W/cvcLg+wAjQ/bah8FDeIHwNj/J3jW+SSsLt5DZQ3sZjQXsg5WxRmu5EuKhpbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466246;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NT4jdGotJzxNuTLZO5N6SjybiH5BTjQ5c+C2HwxxXq4=;
	b=Wds4yfSJ3/39QpSa+UfOUif5hz2mOH44orcfK0TExYsDMTYvsc3ZrcRQ98SjuYaJT4pE
	 rRUjgSQCSiFc2WbReyMR2xPmeaK+1/8mSN52XOhYp3qBxu2Mw7BDmYLQGs+G1Y3gOQpAj
	 DFvHzKgDyxfHUWSUOKSM388h61MdtQWKuS4FLbvkc4gaBsMkde9VqG3J8WM9xqYXTph9v
	 T+OI8iEVM8sELOvVZX4Vjlz/T1glF2Of06DUPsxpZL3u4TaPrgFQp5Pjwyz8sW7wj3jzf
	 8ehsKSVJfQC2Bq32iI5hnBfASn0xZX8rdH06uBe7QrqgIeHrrIvUBxb3pOroUzmirHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9w1Bdv7;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A0606DC95
	for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 06:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F03A0606DC95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T9w1Bdv7
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd69954c755so2793972a12.3
        for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 22:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466245; x=1795071045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NT4jdGotJzxNuTLZO5N6SjybiH5BTjQ5c+C2HwxxXq4=;
        b=T9w1Bdv7HosVhLD3a83j84pnZVg5YS0p+0yDGBed/EdkNMQbcVElIpfp0Hrtv2m5TT
         zGWpqDTJuiEXvcVnzJwxkw0rO29SGi5SR8y5sQDHNHczPkaLHK48V8qj+KWhwEMVk3CG
         mtdgg4H7TiDipsZ+DnE/oKYmX9gEsFBTIcgqaOH9ptsL4YD8MszIxDdqo2XhNjJs+4dh
         mU/Pbau9lStyaGhcErPKYoTvmHb+nDHd9STzPt73qF2DI07topNWjf4I3PwH6kx482cL
         sArG/f3xb6mAHG5a+1Zk+AldIvcOXKcOOkh1Y8zqVEu6Mf7i1ev2R+EwHtaMVpUHFLss
         x8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466245; x=1795071045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NT4jdGotJzxNuTLZO5N6SjybiH5BTjQ5c+C2HwxxXq4=;
        b=y0hJkwSHbG29WDJXdPAJOEQcD8NBw21g5a7AmtRCEM+MdIaO+ouy0KW5ZC39Zh/nHY
         j3N9fnw/Krtg0SbPkEdA+HeuCMAC2ZtuYpBFbzRb4l1BjH/hlTKCylFHiUf6CXnMFwe/
         58EidHC5Q+n9LslmFCNhzGIu3Q6GC3cH3vBxpl6Yww5AeFjTbhw1F4jVK5l/tH/TixQM
         tKbIdk9s0U2d7qB9JTzmu8ijKTXxzKbTHrd+K1JLnmXeyTXG9mlwCtu0MWqUlaP0EWo7
         e5iDqlTJlonpRUO4hQ/Dg8M4c4WIetWasirkU1hNYKLKtZdkUGHiIAD41IaWsx5z6SiL
         NffQ==
X-Forwarded-Encrypted: i=1; AL+hErGDkLkL6RcmbdP8zzgKc+Z7L+qWcZzXfz30XY67kLswyJZbISoew3hRwcFyqU0IBo19IjyrwFAPDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+H70N84ng+/VeeGBhSnJR3ipfSK6UulHXG/ycM7bG2qSY4PuCt
	Dkmp++nCQ8D0786n0pBPrGDVZB1z/ECESbkQUPOeeYGXH4/J6mwtVy6P
X-Gm-Gg: AYBFou0beDM2ZCBsIjczzxd/Lrc5l+9ipXL8ySvPBbk0BAtBeahRUv54cRRbWWuCIVv
	Ua0DZpXMIniAs02ZlcePmpBp8OB7uUG7usEyH3AelQ6AaAOXeID5n72QqsZFIxOWeq+dYFu0olG
	2NH2sCxOZIg6DQ50HI7hSKKIzPPx5rOCFWUud4lrFtEZetnq4TeD3dOwTfJCL9PS+4kObAz55Xd
	EvjhSv5ESZo79XC8ys+zcQ6FXblpxtA+mQuzb01sVMaOowUNTHO8jF6kTvf+i1Bf1TMpMEcX9Gw
	udeMWDKv6mHXurc5oKdFK4P3oXSsTX0M2XCV2Ol6IJvXufSrEoBLWRyAwYqv6rKamgLB/13QPEl
	1bLMx5f11EgjXah6UlrsasdsvUYB7Tg9rNOemsrH+5oA8o4XN1+jQldqCvHMvsWij3VLkPOdVpE
	EajBPzIerBq5t5FnlMpjaoxJ09WT/hKeUmNEM3ssl7Uwe5K5bQCF2lmst+CwaXS+Qs4O16fjFKY
	j6u9QguUelKYl9ISCPe0NtD3Gh3cVF3pFDN3f/cf6ucdt8PWCRaWX5Vohop9Yjs5JLtseZOrAo9
	zd1A+s3T31rcLVa2mNei6k/5GOy/wCABlDc4oWJE9JCZ7WD4LYFF5ve2qRyYmR1i0Iih9sckOQb
	O7t8I26atbDuWL9L+
X-Received: by 2002:a17:90b:224e:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3b182f198d0mr4826630a91.57.1794466245413;
        Wed, 11 Nov 2026 22:50:45 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:44 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-input@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] Input: tsc2007 - fix minor coding style issues
Date: Wed, 11 Nov 2026 22:50:35 -0800
Message-ID: <20261112065037.1800467-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
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

Fix minor checkpatch warnings and checks across the tsc2007 driver:
document the mutex used to serialize I2C transfers between interrupt
handling and IIO reads, remove an unnecessary blank line following a
loop opening brace, and drop extraneous spacing after a cast.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007.h      | 1 +
 drivers/input/touchscreen/tsc2007_core.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
index f65186b8e709..e5153b420371 100644
--- a/drivers/input/touchscreen/tsc2007.h
+++ b/drivers/input/touchscreen/tsc2007.h
@@ -78,6 +78,7 @@ struct tsc2007 {
 	wait_queue_head_t	wait;
 	bool			stopped;
 
+	/* Serializes I2C transfers between the ISR and IIO reads */
 	struct mutex		mlock;
 };
 
diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 51e4d985afcc..8197ad91ed8b 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -82,7 +82,7 @@ u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)
 
 	if (rt > U32_MAX)
 		return U32_MAX;
-	return (u32) rt;
+	return (u32)rt;
 }
 
 bool tsc2007_is_pen_down(struct tsc2007 *ts)
@@ -115,7 +115,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	u32 rt;
 
 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
-
 		/* pen is down, continue with the measurement */
 
 		/* Serialize access between the ISR and IIO reads. */
-- 
2.56.0.567.gdb80ae8cd5-goog

