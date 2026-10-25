Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899879;
	b=OL48QyV7+/fvoCtkZIxCYuwFo4AtRphDO8lvg3q7Iu1Lod5m3BsBXuiuUzjTvec1LZ+f
	 AeqLUrvc5ZIh+SIt5SqiGSF3/VtEMzzqRYfuTufiWNP1hqFOtkkZAE8v9EWMY/SllUKBU
	 Wjsjwr/lrcnaXT4HU3zvC47yshGI/nPQr1zl5vH+rybD/KBZOQwQid7QgKL3u4MiJq12Q
	 tE4Bt9yPh9OspIchzTebtBQPaR7Uj+3ZsWq4+9F+ELImCiy0IOSGuK6j4jAiY4Khq1cE4
	 GF1Dk8VIYV310ep1RCWD7rWeqZExP5H2SfBNjA2KT8LoEO7cQbPai70H22y5z0ZhYUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LFDK+1ulkRfFlkLwBfdTjH+FHi2P6fwT2yU7wsIpXvs=;
	b=NRRXqSq+JNIspJRayivIoWpVJQD6KIEM3qCcorvSxIxeaMBz23WSXGIne3Kdn1yz4/no
	 W1dQqjDe2nEQE2wrXRqbEp+N3bWaPdcvGmKbSR97KAYi/fNdJOQzoCrikFG1H+tws6T+9
	 AAEencYzkoiVoXQCrUWZ5KTFS8hekJxQbXmOlrpQQjttf7OO93VU0JukENBUfBUpag0cS
	 ivfo2VPMypjnxDnra2v0ULf2Iwgzx9iyz2SRi99/Fp5CmhVeZUMvqUtRLNnVEAk94q0Vz
	 jaq+3FYu6MAUD03S4bXpWgl3NoRmAdRdQ7ETE4SAEdqxmRxarwgxDhoO/CpMTzmN+qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=Vw2qb8eu;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F50606A330
	for <linux-sh@vger.kernel.org>; Sun, 25 Oct 2026 03:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08F50606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=Vw2qb8eu
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9eb579c0eso10514455ad.3
        for <linux-sh@vger.kernel.org>; Sat, 24 Oct 2026 20:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792899873; x=1793504673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFDK+1ulkRfFlkLwBfdTjH+FHi2P6fwT2yU7wsIpXvs=;
        b=Vw2qb8euRlJUMv45mYZE9Io8oRd7Avf9nw74WzUdB1H/4vBSaXMrLJjfphc9q+wfya
         sFdmWtZ/ZANGnObXe/kZiRxWie0Cl/PvMqqXrmKT5CJTBND1p83Pn/55Zi35T1UF+BO5
         5qPNXgM7l/OmB84SlIpdL5CnFJL+Sf8LtUmF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899873; x=1793504673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFDK+1ulkRfFlkLwBfdTjH+FHi2P6fwT2yU7wsIpXvs=;
        b=DrTp/OqmRlW9XrT4eUT3UjqxEI+gZXDJv9KWRUmb3C0BBGkxrDTcPHQ+moZ1GuyWIU
         vxd8VsgHptZVdSrBrSukhjoSNuowFI+KKIEhgLP9dtIJamGfi9teD6F8NFlU8/e/g6YR
         HJc7iVS0YPZv08EorXYdGM0oJzujGNG5FgRqlWsUyKZuUnHQ4r/i1a0gQPlhzmEv51D6
         90CkW6Q3VUIBG2GSwAmFVIk2PgKxEoLCqGhKezyUKIUpuZChX1gtbyPRWcEwrDrjLUJd
         x2Z5r4oSOgp021J44UgKP/zbXhOcN0cG2cPQUTxDnVgbcoJi1UD0MklSZ4ZauldGrFu+
         GsGA==
X-Forwarded-Encrypted: i=1; AKwUvBz80S5wfSyA6tSzV8Oz7F7JX3ptDTqyAOrxC3kO7t3MfB84bdOJ0T54+DroM0v/POMMkJ1I1DN7Og==@vger.kernel.org
X-Gm-Message-State: AFq9FYLYgAjIjrKWL6mY8f3qdrFJpOC4Iw69V9kNyf8cqYNedpyM1cPP
	twbhHB+gPeFxJlFKF7Uza/MfHgUIUUTuIQBngq2yu+b6xUAd9iHn0Psmw0rWPrwIXCQ=
X-Gm-Gg: AYBFou34miulez5wlFX4i5pVSOw91UWa2lCjHNndVRLnr5r/YhhYrw0wUt8rmCU4vH6
	dgzN9QE6xSUv11IoXVKXyA9AJFdniLXBTMKDRXVcWxB/z0EQprpdC7XmuQIpMHUNqEeSFDRUVIZ
	VmuWuPMvl4f5PcVGj+fu5b0UFQo+u54mp7EFMn8JtviFuZsMn19hr3Vg5xWI+AmuZk+zJ+LvGAR
	TWFtTRQag9mLT1hnhRezxaLedjN1+J5OQfz9e1LPXRMJm7c8YxCtEdyPpxVD9yFX7I0PVsky9/k
	ahOHzkDjiBDCp1MAhFuY0SsblzrCIWHSdi8xgwcOyYhv8/kZtntwGW5W20QjRQj86k3pG62IeiG
	Bk/2y9qlWtMV8dBtYupF8JqxJ615AO+1/nnh0Jbsz8/C9zAOjxhHxDST1O6QP/6yLUd+UMLp/W6
	wls0w6GfnChooLeJNhroEnmYmeygM6cWqYGP99/hyD8HOYxenFLqxpJ2WBhQ/5wpbFRmDLCQt4t
	mzO9a6VJ7zv+BEmUy/W+zjDnZnAhpmn/ok893Tin8uUtViHmfAsMAemseQ5eb5RJNclsRY16pUC
	lTzeY8BVieDNyll/6pc=
X-Received: by 2002:a17:90b:4b05:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3adeb197eafmr2837181a91.64.1792899873454;
        Sat, 24 Oct 2026 20:44:33 -0700 (PDT)
Received: from shiro (p1469046-ipxg00b01sizuokaden.shizuoka.ocn.ne.jp. [153.223.97.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm4181927a91.8.2026.10.24.20.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:44:32 -0700 (PDT)
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
	Florian Fuchs <fuchsfl@gmail.com>,
	Colton Pawielski <colton.pawielski@gmail.com>
Subject: [PATCH v2 2/2] sh: landisk_defconfig: enable PATA_ARTOP for the ATP865
Date: Sun, 25 Oct 2026 12:44:10 +0900
Message-ID: <20261025034410.808796-3-daniel@0x0f.com>
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

The landisk defconfig currently has a similar but incorrect IDE
driver selected so IDE doesn't work out of the box on the models
that use a PCI IDE controller.

Select the right one.

Fixes: b7aaf16d10bd ("sh: remove CONFIG_IDE from most defconfig")
Reviewed-by: Florian Fuchs <fuchsfl@gmail.com>
Tested-by: Colton Pawielski <colton.pawielski@gmail.com> # 3x LANDISK
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/sh/configs/landisk_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index 2b7e10c9acee..6b5ec1f3ad71 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -28,7 +28,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_ATA=y
 CONFIG_ATA_GENERIC=y
-CONFIG_PATA_ATP867X=y
+CONFIG_PATA_ARTOP=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-- 
2.55.0

