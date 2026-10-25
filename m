Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899871;
	b=5eGshx2hMgv0cyvOVkj+4xiMLbAFOmuYkq7TSt8q8ukuc6BRo4knui221I60L0lSRCd5
	 joKk5vVsM0lSYZay/BhvVc4dsnx9ny9YkqHXd+kzpJlP7DT05QXmdLPPLPRDYkq1RR5rR
	 qa1XU4upEqWJnKgVWQzGkSEpa5R4SbrigYLdWLVYxqFFsPn2uu+QViMjqzburrTSRA4eS
	 HyoBG0803DEK2NOPgHnmb+Hh0Cr96IuhtLiPp+IQdaQ2DLahUMOvWAKvylx4hkWh/RGf4
	 t3J3AkEIqbyospdKzQvlufXSBqsJdgYURVSJUPbIUD6IWX0p+hQX0PvQAOjiAPj+xKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nLhrdlfGEEQVpNXjJ/3dwvsD2HKNQITBUrA8qv3QdZs=;
	b=cd5KMb+oq6i0p1xFcejMqp8XGhkGvYb5+1goaO7LpeZzLMH0Rra0LfBMy4SuGp9RNkFh
	 AveX/4vs6Gb7xIJDMiJNZYs6u/9WpXRZinJnGziYUFmlcPauqiq+LZUJJ01IaZ+90FY/Y
	 3tFkGkF+yuwXsW/+Y1zfW4dWbQjalb/y8yxsj4ip2178051o+KxBDfSPxORl9oNhrflVb
	 Lzl/sCFJtLvR9GpLMatTWyCrj+X2smU7r4uWRevCFpKtIMIehY7A3938EX9gJ2xqgnRkN
	 ljpU5tj9wIX1zH+IG86zWJvFMJA0VPK//voZAxcvo/Ej+QWwr9H8yvA8p/l8iyxxN2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=CL7gqfoP;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6F606A31E
	for <linux-sh@vger.kernel.org>; Sun, 25 Oct 2026 03:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF6F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=CL7gqfoP
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1460332a91.1
        for <linux-sh@vger.kernel.org>; Sat, 24 Oct 2026 20:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792899870; x=1793504670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLhrdlfGEEQVpNXjJ/3dwvsD2HKNQITBUrA8qv3QdZs=;
        b=CL7gqfoPzAf0tKBE0R1WzWUpkrnFaZ2UOXiQwKa0WMzt8aEPjF91xBjWat5xV5T+UV
         3xAT+B3LVuDLTuK1PC9dQfBryj+1VYqYqEu2VXv+RpbVcYOuoi038JF+BNpeqi2qNWoZ
         bDdKNZFypMWBgcZPIYeEMVdbIDuoBLmlEtobY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899870; x=1793504670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nLhrdlfGEEQVpNXjJ/3dwvsD2HKNQITBUrA8qv3QdZs=;
        b=dcQ8bzodVptOk6t+FX25aXAVYXWZ1QXVHOj+e+9f2pylc5DPMfet51aVlIeRT53ORN
         OixEbZXYhISN9XqleE5YtW11QkBbE+YRslN2Vyc8o0C8tcTM1LjK2b/UEY9LOgvTeBTm
         0io3cn09lMiwmEmIP7U26oFOpx3pnPYw40CbeE+bJzbFcWKAQ34FPZwD0+Pfux4s1mDi
         zB8VQfFdxtQGbvjGbM/L88nwcdLSwaikH637M/MkYboWuI1hAAbpwnRAtVanMAPxqcWd
         sdcatORoLNyCLkB3sr/IzmPmpJ4PcId34W2e0l3jN523a9E2Dro0KOt52sGlX5gPBxl0
         ifww==
X-Forwarded-Encrypted: i=1; AKwUvBzhoIT82/oZ3MaU3APQvhTI0wmDUbrWuNZ9zb78pSIOndL/KNbsJQ8YfqntfTN50DvK5b7iscydOA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK0EUiutqBNhRjv6KA870HalRNYsloeuEZ/QsInguiQhsnjLem8
	s1uam0ky0Fo7WpGM8Aw4t3QDLAv7ky1mJw03ixyz1sSXJe3mfSuEX6/jIKFiPWCwZTo=
X-Gm-Gg: AYBFou3IahUk4sM/ulXzpyGObHP2IXXDOdRaeuxQi3VwbffYiqV/rKs6UFk80Mxeztl
	wt8hulUAZH9qH/efwEjAexVAHeuTeGYAU2n1ynN461TQK3WP7Op0IXsCR8aflUaUxkfQYOadC8y
	/Qm1COMrqrdOq9kwRssxMPlIS0XKucgaircz5z5yv/B2FnyOuEmizZmCMuc0n8R/kZ+WDjhQM8D
	U4zuJog1iiKDogKTOsmuew3xqDAhcd8274qXTHWuygGKF8EqWBq7nAfdxEqDRRcfSajKj14XMY3
	Nh/fhTcoFiwgOXkMsTUZOeEZxorhB1ai+587HuC4b88IRKMEI5onEWseHdb9bKS/Cn0vghHdU+U
	hk3gThWfYFyqmzlQGxsDb+WtJmo6Pc6MXM0PpNxhEe8d0FaR8x2IDL2E+wQbwrvSlw5ZTiyiDST
	3Nhi22yBkGvSYp7KQkMxR4LRrf8gPRUhn5XxgxeS5LMcTGlAcZGaYqGm2iJIzoJdfLyJk/iwrs8
	bPhchFpuZRwX2V2ZyMT4mukiTafw+vIESFwDpdMquyZ41iH7VURSy0GBC9Nb1FEgiSCXkxRrm+m
	u44biAr+CG9Wp9+/KDU=
X-Received: by 2002:a17:90b:274a:b0:3ac:7874:639e with SMTP id 98e67ed59e1d1-3adeb0fbb29mr2728664a91.46.1792899870088;
        Sat, 24 Oct 2026 20:44:30 -0700 (PDT)
Received: from shiro (p1469046-ipxg00b01sizuokaden.shizuoka.ocn.ne.jp. [153.223.97.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm4181927a91.8.2026.10.24.20.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:44:29 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v2 1/2] ata: pata_artop: read the ATP865 mode register through pci_iomap
Date: Sun, 25 Oct 2026 12:44:09 +0900
Message-ID: <20261025034410.808796-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025034410.808796-1-daniel@0x0f.com>
References: <20261025034410.808796-1-daniel@0x0f.com>
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

artop_init_one() probes the 6280's "fast" bit with inb() on the raw
start address of BAR 4.  That address is a PCI I/O address, which is
only a usable port number on platforms whose I/O port base maps PCI I/O
space one to one.  On an SH7751 LANDISK (identity io_port_base, PCI I/O
window at 0xfe240000) the resource starts at 0x1400 and inb(0x1400)
dereferences that address:

  BUG: unable to handle kernel paging request at 00001400
  PC is at artop_init_one+0x10e/0x170

Map the BAR with pci_iomap() and use ioread8(), as libata-sff does for
the BMDMA registers later on.

Tested-by: Florian Fuchs <fuchsfl@gmail.com> # on PX-EH40L (LANDISK HDL-U, ATP865 1191:0009 rev 10)
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/ata/pata_artop.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 9f8d41639a62..7c5e778d19cc 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -390,6 +390,8 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops	= &artop6260_ops,
 	};
 	const struct ata_port_info *ppi[] = { NULL, NULL };
+	void __iomem *bmdma;
+	u8 cfg;
 	int rc;
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
@@ -406,10 +408,17 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 		ppi[0] = &info_626x;
 		break;
 	case 2:		/* 6280 or 6280 + fast */
-		if (inb(pci_resource_start(pdev, 4)) & 0x10)
+		bmdma = pci_iomap(pdev, 4, 1);
+		if (!bmdma)
+			return -ENOMEM;
+
+		cfg = ioread8(bmdma);
+		if (cfg & 0x10)
 			ppi[0] = &info_628x_fast;
 		else
 			ppi[0] = &info_628x;
+
+		pci_iounmap(pdev, bmdma);
 		break;
 	}
 
-- 
2.55.0

