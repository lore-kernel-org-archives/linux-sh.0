Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466249;
	b=NHOzzoB+N1Wt82q8zTIXIE1xgFZ1+mJBGklp/xq+pS2H5FSa9aP2HN36b1m9WLXlC2je
	 CPYgjAMUSGIr2YdmyBMqliHG0mNdY0SSVULhaOs9m897Lo1WFb7r+Hl8MfTOa3UCaVSQ9
	 KURf6ZFmqRs3JndNsjhWrdf2Z3M9nRzZJ6SgtKdtWWbTuyNhCj7DUp/SJlY5sMw5U1mRt
	 p2MQv64rnXFsqv+nbv9Udp5RcrmpsVYFI2kqAqwF2NZWT0R50ILdqNXltIqhe11hcIiPx
	 nuZ+ImVhUyIc5Ue+FKcCO5tKek3I4NalKk14dnCeK9v7Fusn6UBpgjXn4bx+bynjmZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=euqatSCyYoCPYOksC8l3gC7RgvSB8oPL7M4zUMdiov0=;
	b=nKB5rKs/NE4TbBVz/y18+tORx7uH3pCE/YyQQD8TcT2pmAILjPJm44/DBeukA9gO3uyc
	 1Q7bcldTNj5qent3fLIkbUvPTr7VGaoZ8CkzfGJeWpAfzxBCUtSWmD1MBAOYX7/5rrGOJ
	 PMTLHm4p8n1Qh2rtoC9QZkK97IvkwMix7bWKXkzfhh/eUj2lJjwvQf8PGgCEE7vSG53QP
	 Jiwf5RNol2HVCESHpXp/GLXCy+6qG9ErD32kQNEXrvfXP9fzHQYkphFtscnb9RAYyxSdE
	 uY7daQD0xus/j46AGZ3hajT1opPB+7ts0hTlLbfVT+MTYzaS3vweHTAYuki0Opspaag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zreSoGMN;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D28060A3803
	for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 06:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D28060A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zreSoGMN
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1680678a12.1
        for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 22:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466249; x=1795071049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=euqatSCyYoCPYOksC8l3gC7RgvSB8oPL7M4zUMdiov0=;
        b=zreSoGMNrTJC3Zn1q9S6QOkvTQMU1FITVvkgPEb6jkGbOa1grqbqUWdBG2XMuCtz3h
         YVIzsqYyUUKpHbbBTzHbP6yBp9TZkHN+/HQRzu5HxiVc2Cy1QTzDUYO8auFhX2U8q5xG
         nkg3sNTaKTJQ7yG/P7m7cHD8HtRnf8vd0FkfrHtRdTtMr59uBwKcfqPzVCf41yTePx0O
         rYS3N+L5z1v4ZKiGGCKoHodV6e7cmm/3IEaRJpbWJ1jbu/6Olz26iAFzbIX41B2vwN06
         Gjai4LecFguZbpE2WAqo6R+ro/Kz1pAbvLDNSJHD1B5PYOzrNNHhFc30rr0I99lpTR9c
         Waww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466249; x=1795071049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=euqatSCyYoCPYOksC8l3gC7RgvSB8oPL7M4zUMdiov0=;
        b=uzuDqacj/5+0ajOjFikS8HrBpDKicfC3ly9ZH6IhDjePE9QNOx1xRa1vZTen2ULhBp
         iKfS09vToiMbcroFxmUS/k1Au5n5Smu1FY5irJL/djW+WY0FV0NVhJpJK45ZPGtqyvCU
         vBF9mxy791fOieKcnvCtRlbcokTW1d+Z+70YPIaDEZ8a6c4OZdCUU1zox4vvxzI3G6oY
         1rFliN6P5q5CsEamMYyP9zeTC0gOmfFOqkMoxGUCrwdjBDJ6SVuMSMpE2714qFO50MHB
         Cj4hEQjTqFjynRESOrtRe4y56e90Osd/TlMbRny3lPtFrIFY/ab2EzMlGIAMzeMudcC0
         qw9Q==
X-Forwarded-Encrypted: i=1; AL+hErHlAxIhYm7UgYNZdnGdyw9nPjw2cj00E9B0iRTqY0OSCUcTs7ra7L0EHNiUw0GLUJqgOFbATw17QQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/EDF9+RwoaKrPyrkrlfT8N70un1lULgrnZQbHV7P8iztFqI8K8
	fB+1UdZHwFYr3mjOuQUjp1xFNcXewXvOPQKRvStweXyKxSN/4WaU8okY
X-Gm-Gg: AYBFou3zp7uciou9aaS1drkUlwjiTL70kkqrB9MWt1DAlES5rdIiEn+23c1S+dUq5Mu
	ex//rRWIRHTFkvdCTXUyVMyVCbsVm2RoAIElrAQdPX6E3k6YxIqOC7wCW8iYqokq0GdtCH2VGVc
	HDnksp28rOKo8xod8WE2wYzoS2bDyQ1JLfWnm09uwfmliFkG84FNq0tBukJKgviOxPoEQwIWN+B
	a5HSyh9TUmpxptWGWeh49rpK3f/WNkh9rGVANyWs/ofP5kb5PqzGNBU/97WSisZwJ6Z19vR7uOj
	VtcjAw57M9Cj5GdnLPQpggPxnJt1zfKCbAadUxalCuMztDt49MXByA6GS8f+wjKI7CUOPji8XrF
	k/+STlBkcvTutLHQzBxVbgdIN2PRtHr6WYidqXGkmJmD1C0hMxJR0WIzMbSTytc3sSDzSVOKmVm
	Y8uuPiktD6dqn6eUm/Cd8SWlhv6rO7Wkq+Umkqru9xwqE0Dz7aXbCzR/L2uUQzE/YK99+ouwrNT
	IpZw5NPieI5m4QSX5L7V7WfwEX7p5HYE6r3sEPANxBofM9XWVpSsrEsJsLZ5O2R3OmWc1cqa8H5
	W0Q0ytJyGKd9vazwPnkJ6pvqA/0+FzNfAU6GEPwIb7z5Cmjd3SPHAZUBcLWFEZTOxL2vXB1JkW6
	bjMQsX7R5hdtUo4Zg
X-Received: by 2002:a17:90b:3807:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3b182fb6665mr4729745a91.54.1794466248801;
        Wed, 11 Nov 2026 22:50:48 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:48 -0800 (PST)
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
Subject: [PATCH 5/5] Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
Date: Wed, 11 Nov 2026 22:50:37 -0800
Message-ID: <20261112065037.1800467-6-dmitry.torokhov@gmail.com>
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

Request the threaded interrupt with IRQF_NO_AUTOEN so that the interrupt
line remains disabled after probe until the input device is opened by
user space. Explicitly initialize the stopped flag to true before
requesting the interrupt and drop the immediate tsc2007_stop() call.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 1fb2c26189ba..7660504f58ff 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -270,17 +270,17 @@ static int tsc2007_input_configure(struct tsc2007 *ts)
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
 			     ts->fuzzz, 0);
 
+	ts->stopped = true;
+
 	err = devm_request_threaded_irq(dev, ts->irq,
 					NULL, tsc2007_soft_irq,
-					IRQF_ONESHOT,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
 					dev->driver->name, ts);
 	if (err) {
 		dev_err(dev, "Failed to request irq %d: %d\n", ts->irq, err);
 		return err;
 	}
 
-	tsc2007_stop(ts);
-
 	err = input_register_device(input_dev);
 	if (err) {
 		dev_err(dev, "Failed to register input device: %d\n", err);
-- 
2.56.0.567.gdb80ae8cd5-goog

