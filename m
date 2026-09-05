Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F11FCF41
	for <linux-sh@vger.kernel.org>; Sat,  5 Sep 2026 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591227; cv=none; b=gZTM7Ntj/4qUq1grwUWJch4IPtVUvhWNY0rmwHtGjL3ARsRf8VPxU7qko1r4db3kreIEzXAvojoy1PNIRfbaHPOPw393ykRtQ+H7x4DcLmxuiX1qmFvfTQ5SSm8ilaEMkg44bxNagtWpuFG+TYy2FYcTcH3Lohu59FdcCKHoFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591227; c=relaxed/simple;
	bh=OknyfiyJG/jvudI209flhWpAFbE5fyIocTe7Sp/Xf3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ck/L7iGKVapeAogQYUl6YrYdMZbU0RRn4H3rHsBppYOWWHSGepVxCNVNzjzcoo9Vllb0CqtLS0hWH3zkZms6QUkgSe7mQk5fuJQAE6bC6p+u570ySBiaejmT3/RLNmFMQpzxOZNf2eTDBKkqrqMEW+tBCy6Qo7RCBdj2hEYqn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FverlNNj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FverlNNj"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4859245e493so170453f8f.1
        for <linux-sh@vger.kernel.org>; Fri, 04 Sep 2026 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591224; x=1789196024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PiScRkv9wjUWZ92xVqW5hMwzJV7HraqrGVlAuZKMuVg=;
        b=FverlNNjNS2H9F2tYtPul5yweraxNuCmu2Ag26Tai1V18CBPc4keQ7lYB1uB5/wzG8
         CLEP5sDFN6fSxURvjbre3dDyNJa6v1xr4XS6tPNYk9bmfBvy+gRCEEmb3DJTbd17/w4Z
         6HoD3wj1HmDTUZp+n3sDTSwudbIzYaR5J+uAavfBOdo0YTJaL+0YH+gVpXUTzq8SHdlI
         i2XZWaosb//XgvCdrOot4W1KEQyZP97B++yqlb+h37UP39Of6DbI+zlhnlqK055Xt/2f
         i6h7PHkBK6XCVBNXWns/pEyoVYLTGqgs3l2KN+cCSf6aDpfK0BGxweMGEyrRrIbddIrV
         a8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591224; x=1789196024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PiScRkv9wjUWZ92xVqW5hMwzJV7HraqrGVlAuZKMuVg=;
        b=GlPP3DbqEm9kUspElMtyegTr6u5uQh6F7diMBwEuaTuPaCaCa5fZ4ckPLLJPhom/Sy
         bDMcdBJ0Gh6pU0spnzC2jeI4Ag9jmuQ2AAoRJ6P+014/W0L4ZepEqXnYNM9zZ/PSwLgi
         UMobl4kiFpk6nrY7rQvxPjvbGiWEJ3SKoDHba4SpNKsp/LGS7MMicX8SPMTGjyC/vmCo
         x21/KD6FviZHY0EkC79+lbHYJwO2TTIaLZjIQ/2loXWqUbeGoCeLyMii6+CIrWuKOTz/
         SlPWapAvbroeaOlsvnu3F4lDcASvrupwj6aHcKGq55PqXX7dYutbPS7Yf7DKv+PoPs+y
         YY2g==
X-Forwarded-Encrypted: i=1; AKwUvBxkg5oRQMus9mH5LX3GH0kPyBdN0Z3LbogHATYdstzDxcHFRWYXaZH0hDujeZBWNxShFq/rmvfdZA==@vger.kernel.org
X-Gm-Message-State: AFuF++k3/aKOov5XATIzuAgR0kvGSBgDJCTF9XyrvGlCvkheHVszH4KK
	mywA7DuY9nGU0+wNRW6B3KvejIOovAVmGQikUYRdQQ2AO/m4vVydgf0ecqx9d0CQ
X-Gm-Gg: AYBFou22/1SGOp85FIChT5P7hAPF+qfUMQf0u6pPYf6uV9RcknpvyE6EHhIlzgsVYUe
	ZRtH3rVFL/FXMBnl5Cf0/TvQYS4nKyVfZPgyCyaDRRX2CUw48k9DXDRCBerOeHR1wCyWwl21sQ9
	CWH19LzNeLiFJfxNK5aPKPvAr0AtmzwyXcvhsvms2mzQoO2GdndEOTquwm2HOg9/jYwqLz3zwzj
	hEaHC/dY5ru/yLNNk0sA96LjI6k5x7YvF+dv3YaNWvkeU6+Eofae2jaDll0wG3hobOukEffN6Tw
	ymjxGQT2FGACU7hWPKWUxaWfi8FPUta8tzu6GHLgGtkbtbT1DLJGRLtQzarqSijAhC/xzIIcdhO
	iu/UaA+TNpnmuGxQo0L4A6gKnSOWBodk7S5iOa8WKYouaQTQbQoOmjbBqJxKcmn38TtMLW2OMJP
	jPbLZZe79BmvPD/lIe/Cr1YxdtPDHh3wnA8NmYvIA4Su4aXYXje+/rLYifV8RzeqFFUPsZu12P1
	8Rrx2UO1jrJVUA9OgG7Fp75I+B1H80828VJELGXbPzMQCCgUfEACY2zr5DXrXsiH4eo+OdDSMUg
	X8Mj1fhRgfSCW06mz5mlF0IInCXJDfuzk7yJqnAVFPyKS/3YXD63SZ0Bgbx4RmSpoIg=
X-Received: by 2002:a05:6000:4304:b0:484:3fce:18c5 with SMTP id ffacd0b85a97d-485872d1d51mr10512964f8f.23.1788591224311;
        Fri, 04 Sep 2026 23:53:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm12147519f8f.24.2026.09.04.23.53.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 23:53:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-sh@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] sh: Drop the leftovers of the removed CONFIG_USB_OHCI_SH
Date: Sat,  5 Sep 2026 08:53:38 +0200
Message-Id: <20260905065340.24932-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") removed
the symbol, but four SH board entries still select it and one defconfig
still sets it. Kconfig silently ignores both, so nothing changes in any
configuration; the patches only remove the dead lines. Parsed with
make ARCH=sh allnoconfig and olddefconfig on sh7757lcr_defconfig.

Karl Mehltretter (2):
  sh: Drop the selects of the removed CONFIG_USB_OHCI_SH symbol
  sh: configs: Drop CONFIG_USB_OHCI_SH from sh7757lcr_defconfig

 arch/sh/Kconfig                     | 4 ----
 arch/sh/configs/sh7757lcr_defconfig | 1 -
 2 files changed, 5 deletions(-)

-- 
2.53.0

