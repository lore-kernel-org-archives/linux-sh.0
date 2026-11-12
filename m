Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466244;
	b=4NveRugIi7YuUZVJDFUfxHzbWKglO7y3x6beV0M4fRaM7O6rw85k9oTA4XVHF9PiaHLG
	 XpUxBvk2CBm/wGtaSkxW9Y8ZFiLWsiMlc8U5nqmPgoe3lAKHx0eNKoXg0mihN1KfdzoQB
	 z2O07FWw6DsPJ9gP6h5oe825JoPos8ULNZ0gnJMoNt5edYYuN9flQmtgH3rVN/n00x6sf
	 OI6bXVntLOOmqMssp+Z21oeNT+Wx4W3CdUsTR1xw7qk0uwePztiF0PPqE0qBtYb7WxZgH
	 S85tYcinZR6uoTwcI7WApe47VX69MGQGRNof/aDdJXQGrIkzhPj8qmojzCSwzAIIN4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iEBOkObUh/AxvYQxzQbYn4+DPmNA3eLC0/205PmvV2k=;
	b=tGyK9EemhZfkmhAb1TLjObx+8tnDgT1UfIitzuCniaXlZLr88xbZN7r54t6WK5wp7Szr
	 FdDmAOuu5bXkEsuMsWjRJTyCTD8bKI7ayy2Lu81bUUtPz74wrONgb+e6eWSrdFmYxvntO
	 WCDAFn2qfcOdTlqUFnr+5Bq7zqa5bVPuOE17+d4iquCc/v/3fN1+UxbMIMwMFl6bv1U68
	 KuE6gdJtEGHgKA4J8gSK0fLvCslOP5B8cPSxE/Nmv2BU55fTlzIYInzH4DMhV+Ksu+yxL
	 HA3lAzkT84oLiV3Itxscj59tsk0gY+Mf1U5xa2WZLqnhNFruIQ9Tvt2hk9Fm9lvvvAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RASHtTpU;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898D60A2635
	for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 06:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6898D60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RASHtTpU
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc751eddf25so2129137a12.3
        for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 22:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466244; x=1795071044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEBOkObUh/AxvYQxzQbYn4+DPmNA3eLC0/205PmvV2k=;
        b=RASHtTpUa6G3Vjd5SL01RtOojB+8z2ad/x7Fwc1rhK+x6p4zOrdGvGJfk/SgLDH5Bt
         tpyA4BfsftJjostyJ7+zKifD2K1hAJlYwXqK6dQE69sBprIi9px5cd16i7tGRWMU9pWz
         +whOqNUkqPfg96EMCNLXR2g7qj5I6W93rKdt9UvCU8Kfp3P2yLi6it7ZSSlAuBAB3fSl
         PRF686aEDeZ+Poig7xV5ccCA7VazDt9LKus2CJNFpstgiqyjDvCzD3JXM2L4LzK/2awb
         tHkEiSiRgSioKpI64uOg6Q+VoMdZ4VtSRIPNzEnZhworbUHUtqgBWNTEI9opIBPyDGEE
         kEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466244; x=1795071044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEBOkObUh/AxvYQxzQbYn4+DPmNA3eLC0/205PmvV2k=;
        b=0L/U7nlQJQqYfLj8stmLnTUNKHokr5DEUgD/WYrUFXdUkCxn1+LggOh2AZf0VYCc8S
         24xRqbWW1mym2r4RBsaX+vc140XzjMJtooMa2C6Quiuv8VY7Fmj6fJBNWLx3Mbr+xI9R
         39B9XNjo6pYV8oVE8dl/rWsElRZfpcP6lnDl7Ke1RuKh/S/F+ABc+b+UlfJqFGzZfBsS
         Sv8SHR9CgA+GMCj6KeyEoP4oRjYkm0G8mhXZnZffRHRYo1a/yw2n6ZvtytoLc8TfG6An
         9GigoykAcql/gQ4Xih3HgsOiQvDir73C/GAiBztd7dlOOAqbDoJZw0oC0WMaUhZB5vvJ
         2wJA==
X-Forwarded-Encrypted: i=1; AL+hErHIwjNxhM4P+GwKmoXWJPLYSGClisjfOV8DcHwnbCMULe1HJX7AeKfzLlYSBmyn+xAAeNghwd9WKQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hcAmqqp5Dpc0ta/7NW2Mvj4Zx+o6ooysFE8Uc8cLAtS2PeuEB
	f8naVbKp1cGDqHyfuqkb06owoCu6Mbdrjto5o3SoQHuFHcCi+crhKrdb
X-Gm-Gg: AYBFou11VEDYdCRbrGXmzfZO2G9+JE0smFoyhwZmYeYvGPdsd1GWQQivRWPqTuTZfiE
	2jWPqyxD7DXVxkCsWytp4RAFf4UPvtRjVkqJG+QKQI8iFuEBGnOz7tf6nmibbQuY0lFJst01Elt
	OKBUmP1nvvvXNuVjSHJb/tcbcWIYzH2KUW6GpyzZemOPUjAd4WciKDmzFz0sRQLlm3vaHluxxkr
	PR/5AHvbqM09UUFcei/9I7tz5eIXIASR1cl6k9WMYMu0g3tqNdt3Gk/pMON2nQaADdtasxS0MFp
	PJLujnt7wzL+cgSXLR0rJSzXozlsAcdH4ke6pD2BSoCDv5CVVJ35jl9VUqkl7F7tYN50NvKrAPF
	tpADZah9/t0KzYnAMrcUAZ/pusI2K2wtYGpgTw3CJyeVoAxfQEPhF6PDYlEgWH5oif1gQ/GxbJP
	MGcQV/gHBLiHCYzC9abNcUkrjvEXG5Y8g4QtO3nCFRsLTaYURkb2Ek63cpLWIfwCpdxpaLJj69p
	MSNHIFQ1aHWK3e2dTyRDDkjPGq80V7INhIlTYvIMqu25LaRKI+5G+BAvBiip/QPLw6hlmz1zbjr
	Lnh0ubtCz+6C4CZBUQ1Aj6AZ02GcN436yozBpoD2dA4Y0Jn3rsXKRhGb9xDpkxeqn16Dy1JCbnW
	UIIGb9o2wCCyKNsgX
X-Received: by 2002:a17:90b:4ecc:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3b182edaefemr4410200a91.29.1794466243863;
        Wed, 11 Nov 2026 22:50:43 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:43 -0800 (PST)
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
Subject: [PATCH 2/5] Input: tsc2007 - remove unneeded memory barriers
Date: Wed, 11 Nov 2026 22:50:34 -0800
Message-ID: <20261112065037.1800467-3-dmitry.torokhov@gmail.com>
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

The driver invokes mb() after setting the stopped flag in tsc2007_stop()
and tsc2007_open(). These mandatory barriers lack pairing barriers on
the reader side and are unnecessary.

The wait queue operations wake_up() and wait_event_timeout(), along
with disable_irq() and enable_irq(), already provide the required
synchronization and memory ordering when stopping and starting the
touchscreen worker thread. Remove the redundant barriers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index b3c4c0c9c42d..51e4d985afcc 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -171,7 +171,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 static void tsc2007_stop(struct tsc2007 *ts)
 {
 	ts->stopped = true;
-	mb();
 	wake_up(&ts->wait);
 
 	if (ts->irq)
@@ -184,7 +183,6 @@ static int tsc2007_open(struct input_dev *input_dev)
 	int err;
 
 	ts->stopped = false;
-	mb();
 
 	if (ts->irq)
 		enable_irq(ts->irq);
-- 
2.56.0.567.gdb80ae8cd5-goog

