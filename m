Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884F12D21B
	for <linux-sh@vger.kernel.org>; Sat, 17 Oct 2026 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210485; cv=none; b=GMoi9K4YIgqrOl+OEKRXCh/G99z8pJNVcxs9p32IK6HTm4vP8KykbsMbm9979yJwniQhHDPH3K0F3pXsZjBKzhZkKSYwEKOa4miarS9ja2zXnsooxaahumVpFgMGISS/eL7lm4u/5vwI8B1XzKU/ylbpR6i+v3RhNijLnN7JE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210485; c=relaxed/simple;
	bh=giq9R9eqXmt3OIYtNymBZh0IZK3MauoJ2kjbep0I9gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9rtpgAxN6AWKxhLe6SjlAmAyU1z/2V9wsp85XsTfbaV9nnK7sECV7gQ1dhuvmitWBZxIemOBI5ALJDrCXxTpw7yj8nmyjD+67hh9KBXNsRn3Ze6mpZ1fWfXma+a31iwiiv2rZAZHIbpZIHbBebb9Hucl04cX/s50/J6MA/r1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=YsScbDnN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="YsScbDnN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso2412815ad.3
        for <linux-sh@vger.kernel.org>; Fri, 16 Oct 2026 21:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792210483; x=1792815283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4P0SuxHGLACHNAbcWpcrEkq+SWEhLrJUpTGxCsDDCE=;
        b=YsScbDnNS5JTnJ/sGCRWoeUgPKjzpQ4StlQDRo+w4CD6rrDB45eO/DThcOvNUO3zJs
         9xK34DyPGC5J9tRTmXoyWfplP1hAg0r4ukx7NqooRg18LhUPxy5G5mbiEviGAhy0Rrco
         ZHy9aNeA2WVsittRZ666b1Gzl9x2gc9Wqu7qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210483; x=1792815283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J4P0SuxHGLACHNAbcWpcrEkq+SWEhLrJUpTGxCsDDCE=;
        b=0b2hjbL3+w9GjvjV+DTsS2F9qgPN4wgf8B76c5UWJ8P4WLoHEUpHkKtwYKQnMuCjLQ
         yi7X+JMnY+ly8/vjEqbOVcis/ht/HRfOWWGq5P78nv3fnzP5yTsWkrXCrMCU9yF+et1u
         Ea1TUxloXfq79xPsCvRsYDS9xxryKXGmUt3eBib7sSMTwEKMK6luGmAhru4ULlLe3KsF
         qZJNHjVasDbv6BT+UNz/7KA1QPHt/eMVSixy16FKxX53K6OQoEHGyhSB3jDulM3witCM
         /KNTqDrBV9rkb+zF/DLT/LSlw5n+fF3+b9gRzDlKZ98txnBqtFgQ7mky//KDOIqeQnH9
         iDMg==
X-Forwarded-Encrypted: i=1; AKwUvBxLqXR7vHLPuDDJ6gP/4U08r8SNah7guViq/D1sHO7lkfeJcljmI5AzmZtMwSF4KNsVk70sQ3mJSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIEYhdrpuUl1d0iC1ieNEmczqnUR/fxDKy9BvMeFVuTsD7fALao
	Bx/rqIW9CGCShzLmPgfknB6cNgZDkEzbD5KkmshgnpTSvRb5LbroGsgdmGK9R4ePdFiqdj2D/Jv
	Emd+D
X-Gm-Gg: AYBFou2/+NRF3fTbJE9d55RUQx0LRiN39HnqkC+SmIwF/aG9mLTWU84OdyB3fHQwDUG
	A/fkR9qcoUrSX8O9eQj3dTG7tXQt+V32Kd+QxytXCr8yXZud2oKek60y5+xLmJKbHE7d2Z7FDnr
	glD/m/SqnhHdsO7hlDYNyJusfHsPDYpfoAhuZl90IJic8pfJoCd05n/dIsnJIoYlpnX1a3x+unf
	80cBpuHo/v0/ZHO/7AL42Ax8cZnDHbunYknRaYbXt+FfiEiv7Nj7czuJq3aK6U/C3yxt+g8Pa8W
	eDF3s4C+eFcOHDN6sX1DxXUkS4OAlHbiM959iwvmHyYpIsCTvXX9pz+FZ6dW3sL6Z9qyCBpRXen
	+2HrvHwHtPSkPSoPAhkN+H6mvvvS1ljQSy5xQqVp1zL5Jjt+KFpneL65VFoDQWkDa4KE6zVs7YZ
	04FSyynasHldQQUi2aFKk5qh4Kq1REIP5Mw832cKLHm/C9S3EiHOgJ9MybXrnYubmQuuZfhXqax
	6r/AMnJ0SCx5EPpysKw0EnTwzMPUQm4//dXHG3w2ygETSNju/Q=
X-Received: by 2002:a17:90b:4ccc:b0:3ab:9f1a:3825 with SMTP id 98e67ed59e1d1-3acee2937ffmr1451115a91.4.1792210482363;
        Fri, 16 Oct 2026 21:14:42 -0700 (PDT)
Received: from shiro (p1722188-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.142.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm11609714a91.5.2026.10.16.21.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 21:14:41 -0700 (PDT)
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
Subject: [PATCH 2/2] sh: landisk_defconfig: enable PATA_ARTOP for the ATP865
Date: Sat, 17 Oct 2026 13:14:19 +0900
Message-ID: <20261017041419.311921-3-daniel@0x0f.com>
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

The landisk defconfig currently has a similar but incorrect IDE
driver selected so IDE doesn't work out of the box.

Select the right one.

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

