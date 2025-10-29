Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149B347BC0
	for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755634; cv=none; b=Ce54oxWTElnv4yw6UDYE2WTQzGV1t5Ol4spb/2poL5SIdLDOvsnceEQ5Z5O3hXHx16j2+SjeBXb1nXnTeg5vbnASAnA3J6EFN6vnsakrTTgTmxE9K8zeKWla9chyUm1S37026N/Ggd4LOz35+wFiDCRC9bIDupOhS509hG/ylTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755634; c=relaxed/simple;
	bh=T06l1/4GOHE/LpDkePy4eVSTWo0uNva18SmJ0icOHLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btptMs/kJNmw5MDGkUPocgwSfYFmaoDpK9+TI4VVNcn9RX8VZepB70aUIT9mdU/uUtFYgbZthThMV3bIep0NUGdyBt42FKACMwUmONNphmV/dKJAHKqFRwCwDJwpm0d/9+q5R1x+QlK6PJJwuRTvo6s/jp+KytaF0dpvA3WYJus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6u7zSRA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6u7zSRA"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso15654466b.0
        for <linux-sh@vger.kernel.org>; Wed, 29 Oct 2025 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755630; x=1762360430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=a6u7zSRALXcD5cAfl7zziHXqingpPMwA+3HQpLoOUYAN+T4DZYbzvXQku88P5LytsG
         dSepd0zu7KwPEm+SLTpu7V5mZsAQiytCslwBZjiW4yUtTcTJQVUXYl8R4juqoTdj51JI
         hCf1+U2YwclJoZF5yhDg/VxPsE6YKgy2pkmrqgE4KuIgw4dbPiW6aPL5RpFKbASmU9Fr
         AQZoN4oxCVq06kTWykouoPPTYq731ySwec2CxMhlePbiX0q6OgoGOpbNmyKXbrtrsNd6
         Wt1rhpU4kMgjFyK9e0qmJH4LqvKrN/HO0Gl3VvRi3eWCGseFGqkfUaC9te4+Xnky0T79
         IADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755630; x=1762360430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XbRLU+7LExsM1Q2W4kgKdkH4Wh0K6zsU36k2L5dwa0=;
        b=YEiH6mmVQ593mRCwyOjf/rwyyotGZfV7igHzCg6/G3zbKcUpxZQKmnE6P8s2sGIUvR
         HH+7TAJi9QF+gjlcKhjqEaiX9ozj5O0VwEn7Ik9ee71zOKiyh1oyrOiCjpN+hbSlFWvI
         MqW306jdFEiEFgKjK16BN0fVBh8PZrVT4Tzf+/VlvpiYcbNTOT52ZutrRL2R5k6BWPi0
         mhUhaQfEEsnYzqToUFVLAg1BYXY+fb+cqueVvwo+UpoyH2mq6nM1zota2euPJN2jLaCY
         cIQnj2+zpRRLzU4ePWYHL6wN3bwrZoL7mUYvo/QNIFXHcg9jzOaSjVwXlmjSMadbF9fE
         32RA==
X-Forwarded-Encrypted: i=1; AJvYcCUKbJ0Fs0bJYrBQUzIC4HG8uECgip71ZJA1GxdsqTVjASY+fi8f3QhuwsRaATQh3Y0LSsfSNuj9tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGG9VEPiY/vWhH1Y3e3J88FKJ+LYqLcrX8MdgUt/1pmulBgk22
	4TnLZHOlmSoVqe1dDW5tjIYYJ1a5s1jgRhK6yLa/OxHmcVC/N6jwoMRU
X-Gm-Gg: ASbGncvuq1IRCLDNtR3y2fxWhICMmTskCWAWqX+st4eVPANdeHx+d74DckbFuQAOCdc
	ldNnsNrQxJrZZ0w2r5EemD//9yUYpK7oRjxnu0O2MHrsYsV5Y5DzM472E56CFyfKBkfKecGzU5s
	2RjmXLxck11t8mR4cYyjcatVpf2gWQVmTfdGbN0cg1c2QcYKcDaeODvCXlNqLFvzt+xnCvYiwpG
	ZKJDNm5xOxfPf+pyMmOvk59zM6g4yJiSh1mkeU0dpLdDtyNlBWRdi/tT6QI1ExLx7bu3uS+8KMI
	6gM/vTI6xQigWNJOVLuEfc5brtAX1QicJerlOg5q5CDijtqJ+Ak5Akpm9eELnTS5OJrgHZVWqg+
	lBpyrOiA5kBBf6QUuC48UkmHgjIWcWAjLELrZ/F9W/oWc9LSNObsi6PTo0+AgeGM9X1Sr4rHUwl
	UWwul5ktJe4n4kEi+J/cikz9yS2+O2/pc00rFiqpviGjpMVVLm2BoJpyb3ZSIEjgaHmNn2
X-Google-Smtp-Source: AGHT+IFQlpirQWvqETIaDsilJH4sjQW05iHSTqO+BVFy04krtNR3muOIO8OYFK3MmzGZwCCaLhUORw==
X-Received: by 2002:a17:907:1c8c:b0:b3e:580a:1842 with SMTP id a640c23a62f3a-b703d557003mr393915166b.48.1761755629552;
        Wed, 29 Oct 2025 09:33:49 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6dad195456sm939661066b.72.2025.10.29.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:48 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] bus: mvebu-mbus: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:32 +0100
Message-ID: <20251029163336.2785270-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/bus/mvebu-mbus.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index dd94145c9b22..d33c8e42e91c 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -130,6 +130,7 @@ struct mvebu_mbus_win_data {
 };
 
 struct mvebu_mbus_state {
+	struct syscore syscore;
 	void __iomem *mbuswins_base;
 	void __iomem *sdramwins_base;
 	void __iomem *mbusbridge_base;
@@ -1008,7 +1009,7 @@ fs_initcall(mvebu_mbus_debugfs_init);
 
 static int mvebu_mbus_suspend(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	if (!s->mbusbridge_base)
@@ -1042,7 +1043,7 @@ static int mvebu_mbus_suspend(void *data)
 
 static void mvebu_mbus_resume(void *data)
 {
-	struct mvebu_mbus_state *s = &mbus_state;
+	struct mvebu_mbus_state *s = data;
 	int win;
 
 	writel(s->mbus_bridge_ctrl,
@@ -1074,10 +1075,6 @@ static const struct syscore_ops mvebu_mbus_syscore_ops = {
 	.resume = mvebu_mbus_resume,
 };
 
-static struct syscore mvebu_mbus_syscore = {
-	.ops = &mvebu_mbus_syscore_ops,
-};
-
 static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 					 phys_addr_t mbuswins_phys_base,
 					 size_t mbuswins_size,
@@ -1122,7 +1119,9 @@ static int __init mvebu_mbus_common_init(struct mvebu_mbus_state *mbus,
 		writel(UNIT_SYNC_BARRIER_ALL,
 		       mbus->mbuswins_base + UNIT_SYNC_BARRIER_OFF);
 
-	register_syscore(&mvebu_mbus_syscore);
+	mbus->syscore.ops = &mvebu_mbus_syscore_ops;
+	mbus->syscore.data = mbus;
+	register_syscore(&mbus->syscore);
 
 	return 0;
 }
-- 
2.51.0

