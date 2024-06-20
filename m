Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1504B1CEA13;
	Thu, 20 Jun 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906324; cv=none; b=AnfecTO0SV4/TkrTgTXzTsdKExcqxnXMvYNnj8t7eDaJ0HaqCY5QJkvMJDPAheNGeIlVnvOnlgCrXw864uVnx9wMegFXB06L88dvH5Fkirxm66pewb9wri1inGp4XA+1Z4zrH3w98gGll1q0+H0M1YgurWrrP6zE4fhXX07GgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906324; c=relaxed/simple;
	bh=EE6kuxbo5QGE7L7+DMLqP/XTIbnT3wTeY7rcKK6IYpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCylmWhbvG8thQ5nRFC+Cn19sK4wQJ8F8fZKPRmleV11UO0Q2dY9OvRJwgGAFtavGJDS9bh8ahgkOkSVhDii5ycnixvsOZ4SdjEFQeIeZMp6LVhCdGNrQIkVQSnrvGFt42yYkUz5rgBoT3aoNhIipZLwiQUPvYdcspX7QMgPkSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9UVvmWs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9UVvmWs"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9d9b57b90so5187435ad.0;
        Thu, 20 Jun 2024 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906322; x=1719511122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RrpOxxSwU6dhPGdg1a14uJwTPLPcla8GvMqVb4mdfc=;
        b=Y9UVvmWsyFhQcamnLC5CRk43XiZfPCq+QpeAsMtYOTLtQi99vMODJaos7uHq+qr8Jb
         3K58mOxQADlUh1enWELoS7tW8pYu5BFheBdFgYnQi0UP7UCiV9bSBYiJEFjzAYQrcAre
         AQzz2bmG3GdxiDn5YmwJXRBA1sf+6lO35Y855Q18+sqpsM6G2yHliSVETkgY5XTZJ24v
         bWLPkl4g39mp3PveDZHsUkh8nP2bnp5wxTAamT6/WES5sDAoApG0HoZBtJxnvTP9Uk+4
         ByoYXraPnlv5gWOY92AfYxavEirl2TpVGM5wR5RCQW3EDx5Q3YZYwpEhBRIlo+oSQK5X
         qLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906322; x=1719511122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RrpOxxSwU6dhPGdg1a14uJwTPLPcla8GvMqVb4mdfc=;
        b=D4BtWZXY4mnYlNx5iWYbMLjGv+PclqdCVoqhw1ljmnlULfDYsrtKAlDao23LFyOB04
         VrFTlHmkJ9gS201/DRnvJZ0y/sWZ6ZPLeAXITieX090H7T4OxTTNCP7MCdrKYly0UhVP
         uECcYBTm+9huKtaN6izEGA5p1VvjeknmMWR3X/QZWNWzwgKaQcPVb99zxHpbUp0M8lX8
         C78kJaAeFi9BeevLbMt1lrvCu32L7qgaKFxVvcGFBXittpZ8N6gYvTVW3iyZAXEAMMwF
         Ts+VKUEN1k/63Tm5OfuV49Mb/QsGhuymGWEC90LrJt4zNphE4Nke3bzr38NY+q8pYnoR
         Ja1w==
X-Forwarded-Encrypted: i=1; AJvYcCUmvebutdO1GGMCJRwKrY2145XcywipD10nYGCO/iuikbq9MHjUm5HRSeBbPXDeS8kQwYF8Md+VIb0gS5w/LZ8PLvq/uL3bj88=
X-Gm-Message-State: AOJu0YyIpvbtcyP5KOdJAkTyRInvgC2cCBZcEKSM5SDp7qT6qg2+YRrc
	xSX5DrxMas7jkWj4Gb0GkNmpQ6fZ+D7wc7jwCruOiPpNon4I7Dt0vU0hcX9x4Zg=
X-Google-Smtp-Source: AGHT+IFwR4KUsUwz3DVzTLlDW/Tyw/BDO/CoRLBHVeFWOs1T2umlbZqTuQWZCRaEx6Uoyiqs/GQXHg==
X-Received: by 2002:a17:902:db05:b0:1f6:e11e:640e with SMTP id d9443c01a7336-1f9aa3b07c1mr68642755ad.4.1718906322284;
        Thu, 20 Jun 2024 10:58:42 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f98841f6bfsm61533625ad.195.2024.06.20.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:41 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yury Norov <yury.norov@gmail.com>,
	linux-sh@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 33/40] sh: mach-x3proto: optimize ilsel_enable()
Date: Thu, 20 Jun 2024 10:56:56 -0700
Message-ID: <20240620175703.605111-34-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify ilsel_enable() by using find_and_set_bit().

Geert also pointed the bug in the old implementation:

	I don't think the old code worked as intended: the first time
	no free bit is found, bit would have been ILSEL_LEVELS, and
	test_and_set_bit() would have returned false, thus terminating
	the loop, and continuing with an out-of-range bit value? Hence
	to work correctly, bit ILSEL_LEVELS of ilsel_level_map should
	have been initialized to one?  Or am I missing something?

The new code does not have that issue.

CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/boards/mach-x3proto/ilsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3proto/ilsel.c
index f0d5eb41521a..35b585e154f0 100644
--- a/arch/sh/boards/mach-x3proto/ilsel.c
+++ b/arch/sh/boards/mach-x3proto/ilsel.c
@@ -8,6 +8,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/find_atomic.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -99,8 +100,8 @@ int ilsel_enable(ilsel_source_t set)
 	}
 
 	do {
-		bit = find_first_zero_bit(&ilsel_level_map, ILSEL_LEVELS);
-	} while (test_and_set_bit(bit, &ilsel_level_map));
+		bit = find_and_set_bit(&ilsel_level_map, ILSEL_LEVELS);
+	} while (bit >= ILSEL_LEVELS);
 
 	__ilsel_enable(set, bit);
 
-- 
2.43.0

