Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52E3905E7
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144683; cv=none; b=WwesZAlHcEnrFkk7Qi/LdUBfMWpgIpHPQzGzV77SjdYg+1KPAmP7T59D3rg7HuBSfyQt1oDd/hcdp7e729W33uatfsTi4qLjivlMXendL7SQ2AKjEFZmMLR5JgNx4Tpw9D5AzBsrTTnTGqU64tuDvxq7EFGiy1aV5mr1Xk0izAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144683; c=relaxed/simple;
	bh=Fs6EjUYWLfgk7BpJioQZmhwclDt/RhFo1HMJtLPrH44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYfD+SKdUu8ov8UdK0jlfP78dlDJUlJHBnC+cezgwrMbGtGx+2XcUDKensbIlVWXHwCkqVzewshwmz2SoaHzve7dWKY7MjBMHgF3ZJuJFsEHh4oVqKt/itbcl7dpH5VWnaEe1w65Q3RxMd45SX3lBnVUWuiFux8p5C94BHJLBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPhypgAd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPhypgAd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381018b9375so1019676a91.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144679; x=1783749479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G71WVzAdPJBBE0mgQ/IIQpuK0upICMjfyPciQ2pRo20=;
        b=MPhypgAdyoYKMZnkLwwHjELlsE3TmjuGkLpz8RNyB0U7H5SFSdg/xPusCjuTplmHvD
         C++euyUwAlFmiI03mYEzMEWcv/gaX5947O3JFEOmSK8zCf952mAPULfLH41nbVPj5y/v
         pSSyECN0ZofHJUkfUN/MJXpAbh4iEsK/E5pVKW38ZcijU2ai/R0PuxV+ieNqfgSXL/TW
         xhjszvwMcpeXViGHIyaRQ/4ZvPpXmp6+gyzBDIFluOhpOEXpA6ncB14PGi9wVvIZsflE
         LAeVjSdt00EWPqioduLkRsg8m8V+reZqayzFp5K8wyH21/7Js+EZ8p1Zf42tlCLq+8f9
         oZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144679; x=1783749479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G71WVzAdPJBBE0mgQ/IIQpuK0upICMjfyPciQ2pRo20=;
        b=pg+IBWuqIv6cv2GV7PgaowNBKt5LJZAt+9OXMp8cR9Yiq5s0LDKywGHdtZd846U072
         fRIU4zwZO4zm1L+2CqpjS/bYt76MfvXEzF+pcRqHVaZ8fg4kJd2bg4AxpjpC8Yh3Bi71
         aEOBQ1T3L+NZ8HF4Ma3iKwA9q2NcAvCUbE8d9dyZODRNjcoxtQQ7GVi1Q1sHdGrGMX6L
         getQEbeLeBZE4uwPZGW1B8BL8ZR8QqaNUmM27bKhOUJdu34KEl1DmRygBwUJmkNaepzb
         EaNmMY5E53m/hNsKxsK+LeIsdX+lJnaCeETzfsM4uKClrmf0avokuKOdT4b51PcScbpe
         0wDg==
X-Forwarded-Encrypted: i=1; AHgh+RrmpnqS7xd7hmYCP6QedpObF3JBGs9iK2FbFoDk6aps3u1ffOvc1KvExFGKVLwqXC/Xrb40VJroQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+YtQHkqGJF/Sbhps9BbsazJqhveJEAQPeQ9J4EJls98g0tWf
	MQBKxvLzR4RLxqPPobqZe4LZ/BPWU3WDu5buXV20s6gB3U7TYp8eQfe/
X-Gm-Gg: AfdE7ckdjzMwSkZwZ9RjY+9mw9EeHsQJ/40kzxkQxmx9HLrFXUkiQX9FoDl8cUp6mn3
	d6hEL6rrStvfE1m3iQhcRtmR32EIrNHWISqqtbv50AIgUROffxxNE3mEt8OboJ1bSPDbDKdxytT
	KeHa8qAoZfRo5KnlHJpliVQbx8EcIoBjY0F5BNBpp8ctg2Cmy+/HmdhxrMk+sYjwGZJkZ0wujmu
	fyWjMBzHutf3/Pn2Z63Agq33TncbJKolnFtAfTl4rDNbnwPnodk+9Kh58ltiEfZhXKBESWEEvSI
	jwDJHFNlytabq4QG2YuXi5toDago2IvrxCBhg3JDSyLf8V5GRNjWrs0aBHDgZ6yiyXbdcaK8Qz0
	LOMlNuX2+sEr0E+9t/uvt7miawnszAaPTw/pyZUhZ27sYFbLpwMjAbNjlXt0WRG8sMyRHEWskbp
	9d11LjTnRmM0G6TCP61m/5ZLE1QQ/VGRzp1bpe1U6ORiysRXXG6rwR0ixA2MW0HjICUPkWmN8nH
	aU=
X-Received: by 2002:a17:90b:1810:b0:37f:9ce1:cdaf with SMTP id 98e67ed59e1d1-3829f9deb8fmr2518876a91.29.1783144679425;
        Fri, 03 Jul 2026 22:57:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:39 -0700
Subject: [PATCH 16/26] sh: maple: remove unused driver field from struct
 maple_device
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-16-41e424964da5@gmail.com>
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

The driver field in struct maple_device was not really used since
commit 1795cf48b322 ("sh/maple: clean maple bus code") which removed
the reading of this field.

Now that all the writers are gone as well, remove the field from struct
maple_device.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/maple.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 22f2930251ed..90c26c86e3ed 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -64,7 +64,6 @@ struct maple_devinfo {
 };
 
 struct maple_device {
-	struct maple_driver *driver;
 	struct mapleq *mq;
 	void (*callback) (struct mapleq * mq);
 	void (*fileerr_handler)(struct maple_device *mdev, void *recvbuf);

-- 
2.55.0.rc0.799.gd6f94ed593-goog

