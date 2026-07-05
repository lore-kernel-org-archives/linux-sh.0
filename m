Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F12433E9B
	for <linux-sh@vger.kernel.org>; Sun,  5 Jul 2026 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783227886; cv=none; b=kv9mwdDaf/HwsVixUuvGck3DsDEqTu3PnXQJjLw/gxwa6Kuqa9nSwOigo9Mx0Cj9ZNYThQMczhDTTf4WFjzyjverLkZ9jKsxKc5at1CdifBE8jCycoK+wqMOGzQ8KF2d3EuDUcvoF95jLxgYavKpCqHosxh7h0sn9h1uQBu3l/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783227886; c=relaxed/simple;
	bh=Tjq/83B4J/uKP7YCemt4P9jq94zUKaC1m7dw8ibXtRg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RkrpMrGhYUTvh9KQqkxL5w72JNEmQmvQJjzIY3rlbkSddg04Vn/akDDFEvsapeFVRALue1WU1rNlhyTqOY8HVjQBBOvN/MEu224RoThbrGM+ZXnyjTIzInDcV2dZN2b3u77MPZ7fpAj86Ocq6N7YXwheQn2vgKcss07mfz7Tow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGVBtREB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGVBtREB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381ed661712so1401896a91.2
        for <linux-sh@vger.kernel.org>; Sat, 04 Jul 2026 22:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783227885; x=1783832685; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkZ31Cr+voBHcb19FfREB2WJrTY3CdkjBR3taofOcKQ=;
        b=oGVBtREBsPqHtxx+tDrVr8Qec0Zrn3ESpvdKtpnY7KYZoID75gkgQMZOWFAHjEyVI6
         5AfTHC7F1svBAThdPUGruQ0+XeQKmmNOFf6vqWq2pfZwEtxrPMPA6u0daPBlkVfYKe2G
         SFLQk8XwG5MhuA0bVSstmU5CxPBnbfYo6V/6OkHb/KTRtesNc1owVh2uGlHXWFLitsMN
         tzp/BHs6dpoisPgwWQLkNYBIAjTjtl4mr5ZHvSrSEs6Z5VgYRKFxFjgo/GfKlzAhKMYI
         m7d3JRDaBDKAulXZdNqn2WY2OqZCxoohuu4ihV2dRUP68bFUSb9LHuJh4Rd+Glov26pA
         x0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783227885; x=1783832685;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkZ31Cr+voBHcb19FfREB2WJrTY3CdkjBR3taofOcKQ=;
        b=SJ2XFijWd3nV34NqKtQwkLiT0HlREQzXI2EEOn2RDTMpUsRleXn1XEfeDjMiQyklil
         iXO2kxB81wAMEYkShmoLPJ0gbXXkyoLdR+UR0YU62EWTY+9rLlC/cxcPtpv4z7RHKBrM
         ccJ4+cd91ny425r0cNztVn+ELJ4vhBeYjQZ4x2u6kTWfEJUhuskDySXIK84hx/lf8O48
         PwrQ1p8MBzDXyeAPvUwoIJgApmBrxqEKgav6YsFB332e/5Z7sRqJ+ZwV4HBnjGlbtM6U
         9tCG5Z26Yn2gDax8xpdC9n0Trzu0QHaTC2eTQjAgZRXGb5Jtyk3KLmrc701aY2FUR2hw
         kfwA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5LGkC0iToR1EnmMqTxxmwBqabXDd1bhVX64gJaKDyZVbirc7Tyd2gBaIVeeq5FL8JkZV6PyUWzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUu7/byPTQZGl5LS63w6fJoMD4g3M8Air/MjASBwxH5sWNKjjz
	szTssQG5D+e/PZzhwOwrXNcK4wcP1887+AKwqXDD2PSX5+LE3X88OHd9
X-Gm-Gg: AfdE7clXMkmBl0Pzo2y1G1KBDkvKwBtGCFhUmQj0auxRNKMUysMkT8KyISyqgw24NEg
	nJOL1BLs9YTvvzPGdDpkTWJu0DAgJNlKGNBEzD7W8rtORJRG7K2YcdJRaq6D7GdMufh7wJeesYX
	rgRMYZ0HQQ2XnWpXxaxqZtnjpPUmyXIi3x7eyYjqTEdGyKa6APtyPH33r+PHk1T0MzxAd/JcqRB
	qaRKDwArHk4zsHlO7bA9TXc0syKtUIMaxbTNipnR9HWzXbi5OaOo+LsobDNobuwKYsX3LUHzmoW
	0+kOXTHBEoChiF2JXJojoVZo7hmZ1h196EOHQFemkKziPbQ1cD01kv++7gMZWo4ggSMJ3rI0BWh
	n2fhQ0sYI3sqACe+ZczJj/s/h7DsycqzRSrg7TQOdS2dbCq4uBqZ0ulGiAwnZED2V2v6jXAW2i9
	SKLes1il5fc+zBo8VllnpgHF+bHq6L3FUrICmMQMoGqR2grQS+NPzVj9IQidFIuANvrTF3dUgfj
	w6b
X-Received: by 2002:a17:90b:3842:b0:381:77cd:38d1 with SMTP id 98e67ed59e1d1-382808b37cbmr5235011a91.10.1783227884553;
        Sat, 04 Jul 2026 22:04:44 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4560:aa1b:b33a:15b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3b252222sm19585414eec.23.2026.07.04.22.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 22:04:43 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] sh: mach-x3proto: convert gpio-keys to software nodes
Date: Sat, 04 Jul 2026 22:04:36 -0700
Message-Id: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTlSWoC/yXMMQ6DMAxA0asgz7VEDQK1V6k6BOKAGRIUQ4sUc
 XcCjG/4P4FyFFZ4Fwki/0Ql+Izno4B+NH5gFJsNVFJTNtSijrhVcwxLQP37YBkrx8a6uiXzIsj
 dHNnJdj0/39u6dhP3yzmCfT8AlyEkdnUAAAA=
X-Change-ID: 20260627-sh-x3proto-swnode-3feadf472a92
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

This series converts the legacy gpio-keys platform device on the SH-X3
Prototype board to use software nodes and static properties.

This is part of the ongoing effort to remove platform data support
from the gpio-keys driver, allowing it to rely purely on generic
device properties.

The first patch adds the software node to the GPIO controller, and
the second patch performs the conversion for the gpio-keys device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Dmitry Torokhov (2):
      sh: mach-x3proto: add software node for GPIO controller
      sh: mach-x3proto: convert gpio-keys to software nodes

 arch/sh/boards/mach-x3proto/gpio.c           |  15 ++-
 arch/sh/boards/mach-x3proto/setup.c          | 165 +++++++++++++--------------
 arch/sh/include/mach-x3proto/mach/hardware.h |   2 +
 3 files changed, 94 insertions(+), 88 deletions(-)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260627-sh-x3proto-swnode-3feadf472a92

Thanks.

-- 
Dmitry

