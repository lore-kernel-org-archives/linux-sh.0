Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C1C329E54
	for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419618; cv=none; b=sQVgx4r+N9a+4n2Kh3arl1eRCEzHrlT4VoGiTXPCLJfjpqYgAPZ9tQaoXvKb4JL+Uki+xibxswHJsN2WcicATqFy82FFhLG9nNyL9a1TqIS0lDVur78da1vRILgvI/gCO1U394usmDiMMEd2GqmMjrqz4foklCSUz85NShGhzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419618; c=relaxed/simple;
	bh=U80ZMZgaS9Ii1A+REvrTDtWQulgxMTiROYJNr9LAoYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5rPdM4XlOU51K6HoH8nrEUsgr/5Wd1T+3hyv2quWis87fZOckUoUOnsrn5CbXmzon/M379Xd7CV8o/OIzuxIG8RQvz4JsawbQeXVJ7Ccq1zWQDpSvoaLNhGp1who7l2ME5j5I+6wNprh76yaWLbsZaaTMbrU4zXVxUesnBtwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nECZm54M; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nECZm54M"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so7856528a12.0
        for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763419613; x=1764024413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqjVzwOXi9ucrAfreZQkaGIBXDLGjw4pTmj1sbX0vDU=;
        b=nECZm54MlCvpeA8UEE4gHy/BAz5opc6zGEBizWJ/K6b5UrRW50cEXOSPUqJXjybxAu
         MGrsNEk4B++QLgVSVjL8Yu9izgG8Kd+/yxrOuisSaG45WFJ93X8PCBWlgpfssO2pUNJI
         KOVWfxgf07d7P6YMqPFYJXrekZiROuDwhIFGoNZQ00GFZGb1/cvW4h1ytHTjXP5em0k/
         8F7418NcIHUSWghAA0yKqwsibuZnUn9pooWl2KJvhFgDbONKwWO9EBOzOywFyzFm2jRM
         M+PYeRQz8T520XxQ73NKWfsCshWPsNh2md22RajjBTIvFJUhwcICU+2v9tanKRMmopcu
         joLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419613; x=1764024413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TqjVzwOXi9ucrAfreZQkaGIBXDLGjw4pTmj1sbX0vDU=;
        b=JNseDP80ERYqRvfMEcrXVksxuEddD5IQQfXu+LzvT+UwkNND99tmgolJypzwEHhoM5
         2ca26K7jhS60LXFbZ9DzTP4JkhGAYNEzpj27RN61PDfaXd4scAumxDUMeaFvr64VCEwb
         6bdxIlmPlUfl/MqSCUBjYFzg7p6TYvgDXkBUlpPgqY9HbMB77cfHOOVbWgnylGTnY2CJ
         7RUMFZanDtw+G3SUTylWmwlFr1YT3m6UePoEonhd1NEKLtphG8krhL1lf9l5HFnm4ZEb
         TG96dgqpWz+BBN9q/QR4Kz7LntjjTSJMf/G2ofqJKvU/vGD7+7kbvH1nJpFZ+ZRTedVR
         rDdg==
X-Gm-Message-State: AOJu0Yz72MvCmGu/J4EnioCsBiV5tVmQxU2jmYBdtMtIIKLcqPjbrdYW
	Ym5zsCKfUU3ZZyMgcrRfynnAmSrVpHy6Kx3pKPvrmIjAQoG5O7Riek4=
X-Gm-Gg: ASbGncs5vJxbTW3vmVDZgfynmiqZBwe+r2cvHkuZs1AmmEFLG0mukLhuVIBqzdNxHYH
	AQwsCAoguihtmaZvOJxT1qYQhMygcNiQxvAFymxfphiGmZSB7Hh0LXjalA3xyCkF/EESOmp9D89
	JguvpmPpLN13MDrbGmE3sAaTFYZeS1BC/WKQh1djuzMm2AxY9+DrqY9mKq9G6fkBH1jLlTB+tU7
	/O/djAxx8qP3Yq4df5EBjoxS2p/RGMOFYeNZvZnxmbFv7sGUn53d4iuynKvWJaUOAwg89bHbl1n
	KTO+Hgrjb/2mD2rWyLmcAVMNFoS828GZj1aT7BO1uQVRseOG1MQ7rpPF9Fg+M1lfHipSbK28oaC
	3DIdTadvSiLPPylByYxGVN7xxJpszaWwDD6LB08tNzmHDBbwz7fXW4QgHTbf/kde5iIBZ3Be6fd
	gHP8BC+JKZNmfbGfkACtMIFvV7Lu9e2hXmgnGCaawcYzWDePQ9jxojMfghVjlUifg6mr9n
X-Google-Smtp-Source: AGHT+IFChHkH3iNr7D3j5wYleR6fkrjGzcNRvIh5kZKRQIF53XrPXDvKUvIepBMOQl9Opng3Ft+0MA==
X-Received: by 2002:a05:6402:27d3:b0:640:fb13:6b8 with SMTP id 4fb4d7f45d1cf-64350e76054mr14056228a12.22.1763419613498;
        Mon, 17 Nov 2025 14:46:53 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:232f:6d66:f093:4e68])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6433a497fc5sm11215357a12.22.2025.11.17.14.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 14:46:53 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH 1/3] sh: maple: Fix build error due to missing include of linux/device.h
Date: Mon, 17 Nov 2025 23:44:06 +0100
Message-ID: <20251117224408.498449-2-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117224408.498449-1-fuchsfl@gmail.com>
References: <20251117224408.498449-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 313162d0b838 ("device.h: audit and cleanup users in main include
dir") removed the include of linux/device.h. Revert this, as
linux/maple.h embeds struct device via struct maple_device, which
requires the definition. Otherwise results in build error: field 'dev'
has incomplete type.

Fixes: 313162d0b838 ("device.h: audit and cleanup users in main include dir")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
 include/linux/maple.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 3be4e567473c..22f2930251ed 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -2,10 +2,9 @@
 #ifndef __LINUX_MAPLE_H
 #define __LINUX_MAPLE_H
 
+#include <linux/device.h>
 #include <mach/maple.h>
 
-struct device;
-
 /* Maple Bus command and response codes */
 enum maple_code {
 	MAPLE_RESPONSE_FILEERR =	-5,

base-commit: 97315e7c901a1de60e8ca9b11e0e96d0f9253e18
-- 
2.43.0

