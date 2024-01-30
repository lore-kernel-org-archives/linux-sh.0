Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593587B3E5
	for <linux-sh@vger.kernel.org>; Tue, 30 Jan 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657247; cv=none; b=WJBkkHYIqUvV7+2PNwgoT5jLBNisp8wZ1NtfkyARvb0OGEe1Zysyj+1/it73mTUpkFkT8TJz8dMJps+PSYoWPo1pLnQQpyt8kfcbub60uKxirxzWqfig8WrHdz7p87wcBDoezsCO1Xul3LHpmbVXM9Avu/zs1pwRW/dOumu1LBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657247; c=relaxed/simple;
	bh=sOCwHJ8Q2pYqaViGMIp5ahANU0cmFlFhu0ydQtm2Glk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OR863OGSjaNezIKvXMSlVeOMJL4jgwe+xblj6Mvuz/aoZ4xIGHxfpj6WIkcBwWKDU8sxSwqjdhZPea1HOIpRl7a4DGyMqbbPfxLJMcLGaeboAz0atzyJJd2l53re1TcF19Ds+HbyllS32YtVgS8Z00P2dOwcvDlpYgGGcysn7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ACEWrIRw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ACEWrIRw"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso2894707a12.1
        for <linux-sh@vger.kernel.org>; Tue, 30 Jan 2024 15:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706657245; x=1707262045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTXXsmwzTjPyQq0o9yr9KqNZv5QrGu6RUP3Khobjfp4=;
        b=ACEWrIRwGv6nXMKTzmkIjh31/SKyfkyTGjGBnuH3/lktt0Tl3GSBGpLDmoBWTpd/bN
         yK/Hb13sXMN/4c/GWpgQfbKGKGDa2iTSmYb62vS30LhnlyeQXLNpXCKhDyS9eJn8uoti
         TxIg+52E3x4SjcXv6q2L6KRQTfzZB/+XumgfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657245; x=1707262045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTXXsmwzTjPyQq0o9yr9KqNZv5QrGu6RUP3Khobjfp4=;
        b=ZmQUHtFEJszn0zQg2fDwXdNygJtUrLjTRVNIFbTZLxFfaB56x1IGavhbbCDuoXdyy2
         Vzog3Qf6kgWvevOrOeW3iG+9ctf7jhzevlsByMCW1ZX12nUl3Zn0KppusqGRMXGvPWIM
         NuD4U4eUNzpniP/16HGopEppAHMWWhi1oZ0m3r87d/aoH/TgBaZoJV4QJ5dC5SmF4L08
         qdclChdGdi5SZ99Bxt5X/G66QKeWMx+tFXQkDoazxiXDLh6/BnJzaIaVBSnppy72N1fx
         ZZ/DJ5n/hs50y+sO16PNXLZ79FRIjSnvWkYADZthIitw4sAc81m/EuX+AkIiQb0aWISx
         tpzw==
X-Gm-Message-State: AOJu0YwAnd9C9HxobG4L741k5afNKxoCAPYptZYRGRKN4iCCQnstNy5R
	MdwerHkERHBtx51wr/B4S/2ikm2EHmcMfKcdoDlRmzv91G1mi/AnoeBcekipBQ==
X-Google-Smtp-Source: AGHT+IGCwsMMiN0BtC8YHTfKJ6KWrH0Lo33ohm42Z2CFNJgfmm1TAWJROBMu2J7IWq6ySVlvYEa6tw==
X-Received: by 2002:a05:6a20:4d93:b0:19a:508a:7f70 with SMTP id gj19-20020a056a204d9300b0019a508a7f70mr5160379pzb.30.1706657245557;
        Tue, 30 Jan 2024 15:27:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXXjT7jAns/aN2p87T+txOMPmldkeF5dTU38Qoz/OnAQZBVKzp+ZEKsoHBXtNdK8V91h3dl3e0v73W9fr4Iig+Ay1d/qEszLvBbBFPFaerwIgEqYYeZhGB76+WUcGf4jTC5SbQBG2cyIRYNoN64XJwHtqDWSO0x7ZDK3+bGOTfeOYsKKqeIyZPnQi7yIxO1IoerDlshlkFQNJkWVmu5QjLz1hl41VzqLRA3x9hnh/GzcNie2j5f+bs28Ei2Z1+ul9g8hpKywRWIEqBYsAp3SI74Q3h5jL9kXhUUIHpZdZ992XWmG6qqo/HrRkIhNw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001d75c26e857sm7646222pls.288.2024.01.30.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:27:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <n.schier@avm.de>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sh: Fix build with CONFIG_UBSAN=y
Date: Tue, 30 Jan 2024 15:27:23 -0800
Message-Id: <20240130232717.work.088-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307; i=keescook@chromium.org;
 h=from:subject:message-id; bh=sOCwHJ8Q2pYqaViGMIp5ahANU0cmFlFhu0ydQtm2Glk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBluYXbYzMwvQzdjb4LcQVxPeQiFyjaVT+WJc4sp
 l/6tgT3hKuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbmF2wAKCRCJcvTf3G3A
 JnubEAC1rdcv4mXd5Kmfw9RTR96KqhlOzXKsoSCQanjkimlERYXY9Zbr7+F0nO7Rcy+HL0sN42L
 HxNNvF1WpJM9Id4eCbxOBP6rPWCXAt+FsD47sETq/ckp9EnQESMOKNIamMkvOfh1gnNU7JMaEMF
 WJP0uxTKNN+FDY7QBq7khT1XfluHcDmSsBKn6XxS9sfkzb2JOkbGyYZ+eJx7+pP9THs04Pv8jLt
 GlLswu6HU6Je8vHJlkGH6oNFzjVLjOUVSspo7i0AwOt//pb13qzn3sb1G6TQMK96GJRZgbeEDQK
 +P9Cu47L3h2il/lpLq43gLCdV9HRCL8dROb8gTH84U+UXMM/7jvTsLrCbWJIC3UUeEAGP/WHHlu
 W8c8dYNIi8OX9D+63rGA6LHv287P1n3wOcMRxI3tAJIpTNd4THib8DIomIjO9esIEvBGaUnuEm/
 Iv6FV0LbnN8Cbhk7YcovFlcr3gg7uz+GX5J6UJUiaPcUj2/P7F4xvVgASCF1cgkCBHJLW4VNEAg
 R2w8HW7UYVD3JT5hvmVlpzAo13D5SC9Xyd3vFqex7KMcT5QP0Q2e2OL8rS4jrx2p2I/OEvtC6kU
 TCSal4XF0gQfvR5J+xOtJDdv9vuQUOmIBYFg4SlcZGqYI+bFAMcp8hKhTKVJ4l+naLk8sDL2IAA
 0JimCo7 8nxXvC9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The early boot stub for sh had UBSan instrumentation present where it is
not supported. Disable it for this part of the build.

  sh4-linux-ld: arch/sh/boot/compressed/misc.o: in function `zlib_inflate_table':
  misc.c:(.text+0x670): undefined reference to `__ubsan_handle_shift_out_of_bounds'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310416.s8HLiLnC-lkp@intel.com/
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <n.schier@avm.de>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sh/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index b5e29f99c02c..6c6c791a1d06 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -12,6 +12,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
            vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
 
 GCOV_PROFILE := n
+UBSAN_SANITIZE := n
 
 #
 # IMAGE_OFFSET is the load offset of the compression loader
-- 
2.34.1

