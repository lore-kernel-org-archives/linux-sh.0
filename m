Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E63D3CF4
	for <linux-sh@vger.kernel.org>; Sat, 17 Oct 2026 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210482; cv=none; b=b+tqO7kKCO/w1j7U0RPzFJXf+XE1zYO0BfpIqLkJCC16lPmUhDWdrxCsUrrleLzgbeHNK81fLPypeKo3opqrex4TH2GKLnv5sc/mqNR8aAm3h3XFs4XYm4iYayyU3DldAk07QpE5JlMWGuYOPUuwQDP0czAouO9jXHSHinoFy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210482; c=relaxed/simple;
	bh=NqySz2E/JSZOr5SjYr43G9CD36sDZm2WAVtIjCeYOsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB8MHKaYIIf35bbLE861iNFu4VR7eEp2qPmKyDYE581xIHmZla1fUeSmpKlUHX35uN+7lNShPtMhkvBXEV477gkDBhTcerTz9hXXeyEg46SUaCWCAN+Octa0piuFXwuYkcaZmn516gsTcpNZnY5A5FFDPiAt6ItvkknB6JZcuvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=bLq57M+F; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="bLq57M+F"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so1102093a91.1
        for <linux-sh@vger.kernel.org>; Fri, 16 Oct 2026 21:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792210480; x=1792815280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MpOuznd4WHUcHDSy+mj+fYIUFYiq9dGMf1wtGAT9+I4=;
        b=bLq57M+F0+ewhS6C2yWyBS+p6M12IleOPIOJzegIC/ig3XtfLaOBO6JqOEX15ySD6G
         hBmg/A/WiQQdl6WnJPEsGMRe7zzt+UrQpeDo4ZVNDrRHOwla2mHQD5h6rp/D/Fm0pTex
         9f7eObfh2+nLJ43PE1w2hhSnL0rJicbzPzJgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210480; x=1792815280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpOuznd4WHUcHDSy+mj+fYIUFYiq9dGMf1wtGAT9+I4=;
        b=Nko6l34T+k5BjNq0lw9LV0jjKAyHAvtM3nBhgTzyGb2E4owYW2HiaVboQJcNBR7lNm
         fmimPox8qeaRWu80tiOphU8EvBcmoFHHk2W0OuVyp5QDS6OXvEZfyoGtEH5SsD8kZQd0
         5sczpOCQX10Gf4znugQ8+zXYMKCvrM4D3k/SBnS3VsUrjRJg37xDg6dMc1cxbU30y/gb
         M6sEW2LKKjgKVbxEyqdcE+wQnOHy/SdKLU/Q99O2/RTMaBfIrmpubP6dvmKL/cUtmTT2
         f1AOGHSVwJsLEzthEsyYtHeTdgYRa/KE3yQeKy5+8x7pdPzLXVQEoTLUTVj//wjry4V4
         /psg==
X-Forwarded-Encrypted: i=1; AKwUvBw6W7Js1xJxn/RZaDEwaN0iO0CCDARXhXTTRZhPYkNCUBf9vRSKUaNQeq6NPIXk8gRxZw50o3xJvA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKbhlG6WVBWjciYlkn/IDThqMUsdOUoS4xLTntj1lxxEPPE3OIQ
	HWfqau3h4kvjj5H1Y1g4L7z+5fnsqpChf1Zimu+9+72yLckhPQZbjP51SGBQI1zK4VE=
X-Gm-Gg: AYBFou3BKIK826dFmcEUsxHsJNowxzq/BNzx476DTKqgow6FmK3t9DDAdz6Tllg/+Fu
	T70JrZCIXPXk4/xBhaFb5zMuUufrMPOQ5TYA4rBfID8yLnnbSJO/VF/4ja5Jmw0BhimngNM9knY
	apMgR9IeWAxHJCaDnsQDph71Papleh/r3AR9cXsZpV/S4xzvh7UtruM/qxdL6imCytqSXmAJhtB
	XfI145v7YItjLqavpFqbJncVZ0KuOoaaDKk5psgbNNIWrSeul3NG9vfolAfDPYuGRgWDViU1wak
	x+AsB9SL7vZDfNC9hjrLSFf/fa9WwmzUcPflFkH9OkdySmDCZWqS3pia/sBIVb/z8sMWl5vw+WX
	kTAZ89OfPyVJcVCDXfO6QV91h2uY5zgpPh5xQVFNcYMGaTeAoTMpARmGpvvzeiT3Mc4Q4/GaY4F
	R0uu0z8SxcItQ1jvJTnNt3xbjAb5LNRGzkAjWpJhQJOIrI0XPDTBuPdLrOtQErcFtAKn3vJniOa
	uNeXCrGJ1LR/QKVKsqugfTKUdvyDtSyjmWmMEyyS2m6w+wKhVw=
X-Received: by 2002:a17:90b:574b:b0:3a2:bb9f:f87d with SMTP id 98e67ed59e1d1-3acef1455e2mr1103745a91.21.1792210479754;
        Fri, 16 Oct 2026 21:14:39 -0700 (PDT)
Received: from shiro (p1722188-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.142.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm11609714a91.5.2026.10.16.21.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 21:14:39 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: geert@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register through pci_iomap
Date: Sat, 17 Oct 2026 13:14:18 +0900
Message-ID: <20261017041419.311921-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017041419.311921-1-daniel@0x0f.com>
References: <20261017041419.311921-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
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

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/ata/pata_artop.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 9f8d41639a62..351ff4c8e48e 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -405,13 +405,21 @@ static int artop_init_one (struct pci_dev *pdev, const struct pci_device_id *id)
 	case 1:		/* 6260 */
 		ppi[0] = &info_626x;
 		break;
-	case 2:		/* 6280 or 6280 + fast */
-		if (inb(pci_resource_start(pdev, 4)) & 0x10)
+	case 2: {	/* 6280 or 6280 + fast */
+		void __iomem *bmdma = pci_iomap(pdev, 4, 1);
+		u8 cfg;
+
+		if (!bmdma)
+			return -ENOMEM;
+		cfg = ioread8(bmdma);
+		pci_iounmap(pdev, bmdma);
+		if (cfg & 0x10)
 			ppi[0] = &info_628x_fast;
 		else
 			ppi[0] = &info_628x;
 		break;
 	}
+	}
 
 	BUG_ON(ppi[0] == NULL);
 
-- 
2.55.0

