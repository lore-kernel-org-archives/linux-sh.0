Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A21193062
	for <linux-sh@vger.kernel.org>; Sun, 23 Mar 2025 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742757228; cv=none; b=fUWI09WwiwEApWlEtGX95DiQXFNj/90xyyBk9UECf7T0lBEN8hV7+bHSYj90bW4Ix4RrCDbE9ieWs1y4c9p/b2dghthSiIdw+NGzqvA+xLDlZgUPdKI7sqUteAIhbEUm3WAKwizkQWN/+mV25nzxpdKmgzdJus/slQ47im2ELKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742757228; c=relaxed/simple;
	bh=T7zbmHCB8GlyDITTUxLAGr4fSHQjGM50tYxt8RYvNrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjkpKL+SJ5Vup+lRra+Qz8b6bUjMPbGjlbkRHywpYeLMd75AXHMwmjxkSU9NS93N2seXaEC9nHdEYcBWbK6y46sIZAgQCe+1kUGdD9GWpjmFy5iPgqLPavCuxR1TcNowOIG8fJGJcwAVQOn1OwbXPj/iGS7YSmKSumhNfmqNVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAiq8BqJ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAiq8BqJ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so4394354e87.2
        for <linux-sh@vger.kernel.org>; Sun, 23 Mar 2025 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742757223; x=1743362023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cUCl0GJVWsS4HayT//EG+XlvndVCSfSv+Rw2M+ZHulA=;
        b=YAiq8BqJaXVUffFVMDxcVh6gt6nCyukEvgZXFFB2b16Cr9g62o4hf/eIEdlU6Vv41R
         goQ1WCgIbSlq5YG9vu5zCvKGHJgdVfeXC6wF/ccImA0K0rLR07UUc3INDyV7DXswbnvo
         4zfdBCRgWXNH3oyHXZfFCKXiPtWT3YdxklML4T5WeASU4TZsayInsr/F//ZklZpLCSjD
         V4Lt28+hX0jy2uTv/0qiwVPiiWp+N/RAUQDS9HbyEYEcgPvCL6qHm18Ynt9Ni7bS9qhx
         VjHXLrcnl1tlUNPfiWKgJdJfiIZIQxaEdx/x/QqiAalbX1ZRPET8jp3nzXRGEgVjPGco
         0+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742757223; x=1743362023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUCl0GJVWsS4HayT//EG+XlvndVCSfSv+Rw2M+ZHulA=;
        b=DNTh/2FA/kfJnoDMlSPYbpP9sFB8h6jh6grNVx12KNUZLuH/q3bRIsy+GqnZxq9T0e
         rI/RlNLjjOvQ2EgzRZlmA1ExSe+YxfF62s+vTAGvywD/8i3cocLhKK7YQpemS65qqQJx
         EYvxG0CRGIhguir0370JlhV4Ta5nOf3gZec7ooRuuQUyJ6NaF0Xz7gz7ieEnkkF2RjR+
         V8ZKoyihzgxUbgebMDfiOFBr/VCMgPXyzliQH/490BeiC5cVjtYcwaHMzQQdkDXfJfvH
         eb63W5xpX1cztsdhGf2SDMEVptfwERc7PC4/yod1pZ3Op7Sd1+ybKoWNzmoyd2fePBas
         B/3w==
X-Gm-Message-State: AOJu0YyuTsmfG05Kcs2lw7Qi7n53v8KmwnF7qnJ8plcoj6oMdhluuN1R
	svoXa/mww2eHrtwqpLItfGqDSQRpMfBX2KOnU6a0tkXC3hhyerdIxLUkgXTRDt8=
X-Gm-Gg: ASbGncvrfN/GNqmxtRNfx03l3Q42UIhoOkZ2q4NsEmtrZlcp/G3fb/NIpEImHiFbkfD
	bdkFPNrDi3PT65g4USL20pn7hxDsfvZuLJArKESlw7NSG4vyExYQBG4zLXzSCcsOhXjNDGR4aKT
	nLjQrhdtMJgYL0OVW0nkrbEv7PsQO44BYMpkF7Aou6fpA6+GdcMYkULYLYKIwi/wEa2x7n0uI6E
	pld7EAjIVldAhWa1OPHs4LvQN2PSXF0qD+98c1Ph68JAKkwz96cvk1ucinsFJ6SnbZHnq8nwMXI
	kHFnkqxpgG5WTAiYAFe48+PzblCcfV6piWE3xeDkW9+FqNCLDWoDjn2I3mZ1X4cKmvRZDUGtkWU
	95vfCBOLpD/rBJ+L/wLb81Z208mhohpY0B3WhmyjBuVHV5GqbFJL1UDoD8qIgLV26tw==
X-Google-Smtp-Source: AGHT+IGmNxkz/jGHOwFH0qH2TY4Wm6EtTMeN8BG9U8aAwheVrCcSwys6vQGK29tIUYSx+IdMJ22RCw==
X-Received: by 2002:a05:6512:3d1b:b0:545:d70:1d0e with SMTP id 2adb3069b0e04-54ad6480a52mr4354735e87.3.1742757223050;
        Sun, 23 Mar 2025 12:13:43 -0700 (PDT)
Received: from yocto-build-johan.c.remarkable-codex-builds.internal (122.96.88.34.bc.googleusercontent.com. [34.88.96.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6508142sm849973e87.172.2025.03.23.12.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:13:41 -0700 (PDT)
From: Johan Korsnes <johan.korsnes@gmail.com>
To: linux-sh@vger.kernel.org
Cc: Johan Korsnes <johan.korsnes@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] arch: sh: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX
Date: Sun, 23 Mar 2025 20:13:30 +0100
Message-ID: <20250323191330.114640-1-johan.korsnes@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option was removed from the Kconfig in commit
8c710f75256b ("net/sched: Retire tcindex classifier") but it was not
removed from the defconfigs.

Fixes: 8c710f75256b ("net/sched: Retire tcindex classifier")
Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/configs/se7712_defconfig       | 1 -
 arch/sh/configs/se7721_defconfig       | 1 -
 arch/sh/configs/sh7710voipgw_defconfig | 1 -
 arch/sh/configs/titan_defconfig        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/sh/configs/se7712_defconfig b/arch/sh/configs/se7712_defconfig
index 20f07aee5bde..49a4961889de 100644
--- a/arch/sh/configs/se7712_defconfig
+++ b/arch/sh/configs/se7712_defconfig
@@ -57,7 +57,6 @@ CONFIG_NET_SCH_TBF=y
 CONFIG_NET_SCH_GRED=y
 CONFIG_NET_SCH_DSMARK=y
 CONFIG_NET_SCH_NETEM=y
-CONFIG_NET_CLS_TCINDEX=y
 CONFIG_NET_CLS_ROUTE4=y
 CONFIG_NET_CLS_FW=y
 CONFIG_MTD=y
diff --git a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
index 00862d3c030d..de293792db84 100644
--- a/arch/sh/configs/se7721_defconfig
+++ b/arch/sh/configs/se7721_defconfig
@@ -56,7 +56,6 @@ CONFIG_NET_SCH_TBF=y
 CONFIG_NET_SCH_GRED=y
 CONFIG_NET_SCH_DSMARK=y
 CONFIG_NET_SCH_NETEM=y
-CONFIG_NET_CLS_TCINDEX=y
 CONFIG_NET_CLS_ROUTE4=y
 CONFIG_NET_CLS_FW=y
 CONFIG_MTD=y
diff --git a/arch/sh/configs/sh7710voipgw_defconfig b/arch/sh/configs/sh7710voipgw_defconfig
index 99a5d0760532..5b151bb2bc43 100644
--- a/arch/sh/configs/sh7710voipgw_defconfig
+++ b/arch/sh/configs/sh7710voipgw_defconfig
@@ -27,7 +27,6 @@ CONFIG_NETFILTER=y
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=y
 CONFIG_NET_CLS_BASIC=y
-CONFIG_NET_CLS_TCINDEX=y
 CONFIG_NET_CLS_ROUTE4=y
 CONFIG_NET_CLS_U32=y
 CONFIG_MTD=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 99bc0e889287..e2928311a126 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -119,7 +119,6 @@ CONFIG_NET_SCH_DSMARK=m
 CONFIG_NET_SCH_NETEM=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_CLS_BASIC=m
-CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
-- 
2.49.0

