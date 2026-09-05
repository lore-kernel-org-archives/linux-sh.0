Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4F1FCF41
	for <linux-sh@vger.kernel.org>; Sat,  5 Sep 2026 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591229; cv=none; b=QeG8w0GsxLBkRKo1bI8k4PSmb1FI3Y6Ksjeq2D6PbB0Yia8jIw1YFSfkWltMYM4oJtKHxay/997jCSIsHgqHReSdRztXg9G+TzrKiahhxatCTezxlVNfi0pDt5ivyLdMFdQvVgJj4eMOqSxzv2RFDMdGXjgufQ4vpiIWXv7FTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591229; c=relaxed/simple;
	bh=ws3hzPoyYi4Z3s0mJgTC6gSYjNmb3sUpxVYHaKfotzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUANTkZsePtbNrHgu2xFEOYJXdubHLoD/Jj/Vl7hQG+XtmAAGdRmlsivXX0USGiKMnxSIUtqngoxRTlyHmupl7TtWGmjGdm64m4R0sQpY62zaMAnE8HzRxb5AxqBvWe5f6qiZu/xQBUJK113uSI+ajS7kyoJPSu+2xA1EWJKGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsJOo7q8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsJOo7q8"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-484362f5c4aso2170675f8f.3
        for <linux-sh@vger.kernel.org>; Fri, 04 Sep 2026 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591226; x=1789196026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7mWhea1hco/ZsGd6UPN4PUtkYWOGztlNzNEuy9Ftyg=;
        b=BsJOo7q8m4ENnlF+6grYmNb7hM4v13wsd3qN5eeWc9erNNEbhoFpvRs2VDtukylcm3
         77aHKiEYIMm3uTwPJTRf8m7bazDsgj+VZmpwasyTNCWVvqZxjxKLvDKofOJVYnFbAeSk
         OQ1NQKLcAVtpNTqQtbqH9vid8Rq+/ToIniBH0rKLAeNMbEKINZYbq/LB8TCUMsssFC1z
         +8zd/FsMdB0XIodZ0h9UBcw1YppR/YCLpv/oHXjcZxPpR3thjw3JPC8YyJoUw0n5Tztf
         R+sgg0tYYMp6wYCEpgTevLIGn/3IXwZ/tzHoXXKbadafdrZXBi3Gux+8Zp3NTNtZVvpd
         ZHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591226; x=1789196026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7mWhea1hco/ZsGd6UPN4PUtkYWOGztlNzNEuy9Ftyg=;
        b=G6cEQJluveT1wDhVJyKX6Zb90pGghylgwU+CSccJRYLJkl/6vY6MpIhJ1JLL/jGQTq
         QUFh9XlOfD92ri1NS+2+KEGBTd1oYsQ5ZeeRfofF1uYj9egOPjURCsoHDoEZaQAc2mX7
         yjinwcYRvVlnfKuoLhmqPqZ7tsh+gquEWgHJ0Y1oPN90bhrQ3sZzg0yxcprze+5S5Blu
         quTCXD4U5KLsEs3AZ37hsjUrvKkwnBg42t7v/LBUCC4P/0D6S4uwgAe83PtWgCDRF52m
         QtRrtBYBiWuXzoXxuyIfZtru0eq3+ejsOYvJSD8rk3yfUVfBs7sQGJei8UJZB6QrTsY/
         1Osw==
X-Forwarded-Encrypted: i=1; AKwUvBx11s+dcxGn4guhMKbUsyibD8j1FcescVz2PZmplnepVhizPFn4eemCmRPhLXfa1ufN8RWIzWN/xw==@vger.kernel.org
X-Gm-Message-State: AFuF++kia8la+EscIkzZZ+DuK+OSzoJGJTuVy0LITDblPCCqnjY4DC9l
	YWLzAqpm9GJWxtkgjO+gKxOQ0klPH+zurDySzO7djVVYqDXvitm9ioD7
X-Gm-Gg: AYBFou2VZOOGVmSD+xACnoKDiD6CEMlmRAh6mBlHUDqem742QBLKFtkg0nIXnTMjiqF
	IY93QzqVPAkjH7uCYLzlRFGzyoAVAgMHHouBrxJ4+zpVI7tgLDUQs67tKyDNrheHtZ8MLE3MSEw
	kFtlhyNMTHe3Sn96MYALZlvp18qfAxf8DaUN0qTOvogkDSol+lD382E3/UCRSOyiwDjjNqShvVB
	i1WxMEER2HFaNNKXsK6RHlIuntczsIuivxo8/1Xf7uHTrzrVFVSDL/kwIGcJATc5iVprjX1z00X
	Tme2labj5oDVt+WMZdnItuzZMrea/9PBq6JGf/agI1U7yB4u3PUlZx/UvX2JfaYjMJUnYl+uV4Q
	BVfjyXemHpCIf5gwM9ETKWtsEC5CVLhEDOldzTzhSpAV5eGYe+TQcBzK7nGojXpOTYPJ6VVsffx
	7dw1Z0MqONDJvI5dAR5C3J54xadzMLsOuKWVFTwTBXGadOk3yfDKtHPj0IqnI+hVo7YYpnE1ckw
	u8EfXNWTKD+AT55bXFhtsPl66ctct4fMB9y6Hu8nH0ArA1gdRRbwkwq6oKsDU/G5czGKfM40diW
	MJcVwPYVIl5QfstybRKwZ0mtPEVm+LEkoFfUUQJiA6sbqOMCBcVpePVGIajCLChFUBc=
X-Received: by 2002:a05:6000:70b:b0:485:8be1:378d with SMTP id ffacd0b85a97d-4858be14b94mr17101824f8f.12.1788591226398;
        Fri, 04 Sep 2026 23:53:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm12147519f8f.24.2026.09.04.23.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 23:53:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-sh@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] sh: configs: Drop CONFIG_USB_OHCI_SH from sh7757lcr_defconfig
Date: Sat,  5 Sep 2026 08:53:40 +0200
Message-Id: <20260905065340.24932-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905065340.24932-1-kmehltretter@gmail.com>
References: <20260905065340.24932-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option") removed
the symbol. The defconfig still sets it, which olddefconfig silently
drops on every use.

Drop the line.

Fixes: 4f6dfc2136fb ("usb: remove the dead USB_OHCI_SH option")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/sh/configs/sh7757lcr_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 93066ae429ec..a7ec7a23999d 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -58,7 +58,6 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_SH=y
 CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_SH=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-- 
2.53.0

