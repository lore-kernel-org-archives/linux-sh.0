Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752773BBA18;
	Tue, 28 Apr 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391733; cv=none; b=G1G26V1KZzgtgGBzxlATM+sKIzLNO/EO5w3iTB15E0wRwYuD0o+PYC8Ul6sa2vAXlBB0M0I21FFydme5w2j4LZEDcNTV6OGhjXKczHfV3FTHXDr8nu+eC7W/0/KxCHBjpBAW/hZC/dWNoJCezTeeBwivzAntuFlbsi72ZTJejtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391733; c=relaxed/simple;
	bh=75ld2ewRILgYi943fpVictpUlkWQ9Vf7v7jfrpBO0yM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qV3G424ekgPhhHFMVYaJP9eMci5tL6NpS7R4sNtWQezfoZg2oq+jP1ewa7B0s2hf1CWPBiW1KgbNLhlWqj5xTltu90/Mk2OpSPka8Mq83iZJiepI/yC6aojr92RH59HHFLnbHHo73d4zYM3Gk2BxLMw1EEIqcJkQ8hBq5HBQ9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc2Lv7JD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc2Lv7JD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4F2C2BCB5;
	Tue, 28 Apr 2026 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777391733;
	bh=75ld2ewRILgYi943fpVictpUlkWQ9Vf7v7jfrpBO0yM=;
	h=From:To:Cc:Subject:Date:From;
	b=Lc2Lv7JDbEQBaYT+EfFnJtYmJ0Jm3kW0CYw+LoekQtZqw4iUP22NbCVcLxtORYjIF
	 qLKAlat20pypz4a6y7QCFyZefAFa7BUPGyc3jVWtO776GwUjJHupDMlGl6ze2iwXuo
	 9eP1QN5EAQdqq6W9ZCzURtHVBrpf3MvhMAscGCjJ77TkNf73mKXsfqy1eWK3ffvkNQ
	 xbVOtBqC1vC2pumSD/qMu5hAYxbn7Sopq0iPwmTla24lQz0Ia2fC1ZhuJXJyJwISYY
	 WO5AQDKjldh8l5naAXhvpzQ286o5IscR91QnSG1SMK8GkMhk99/YiIkEMuPwqbty+5
	 CwADS/rJsUWwA==
From: Arnd Bergmann <arnd@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: select legacy gpiolib interface
Date: Tue, 28 Apr 2026 17:55:19 +0200
Message-Id: <20260428155528.3218943-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Many board files on sh reference the legacy gpiolib interfaces that
are becoming optional. To ensure the boards can keep building, select
CONFIG_GPIOLIB_LEGACY on each of the boards that have one of the
hardcoded calls.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/Kconfig                        | 1 +
 arch/sh/boards/Kconfig                 | 8 ++++++++
 arch/sh/boards/mach-highlander/Kconfig | 1 +
 arch/sh/boards/mach-rsk/Kconfig        | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d5795067befa..d60f1d5a94c0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -462,6 +462,7 @@ config CPU_SUBTYPE_SHX3
 	select CPU_SHX3
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select PINCTRL
 
 # SH4AL-DSP Processor Support
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 1af93be61b1f..d89b74177233 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -80,6 +80,7 @@ config SH_7724_SOLUTION_ENGINE
 	select SOLUTION_ENGINE
 	depends on CPU_SUBTYPE_SH7724
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	imply SND_SOC_AK4642 if SND_SIMPLE_CARD
 	help
@@ -199,6 +200,7 @@ config SH_SH7757LCR
 	bool "SH7757LCR"
 	depends on CPU_SUBTYPE_SH7757
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config SH_SH7785LCR
@@ -226,6 +228,7 @@ config SH_URQUELL
 	bool "Urquell"
 	depends on CPU_SUBTYPE_SH7786
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select HAVE_PCI
 	select NO_IOPORT_MAP if !PCI
 
@@ -233,6 +236,7 @@ config SH_MIGOR
 	bool "Migo-R"
 	depends on CPU_SUBTYPE_SH7722
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
@@ -242,6 +246,7 @@ config SH_AP325RXA
 	bool "AP-325RXA"
 	depends on CPU_SUBTYPE_SH7723
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Renesas "AP-325RXA" support.
@@ -251,6 +256,7 @@ config SH_KFR2R09
 	bool "KFR2R09"
 	depends on CPU_SUBTYPE_SH7724
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  "Kit For R2R for 2009" support.
@@ -259,6 +265,7 @@ config SH_ECOVEC
 	bool "EcoVec"
 	depends on CPU_SUBTYPE_SH7724
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	imply SND_SOC_DA7210 if SND_SIMPLE_CARD
 	help
@@ -329,6 +336,7 @@ config SH_MAGIC_PANEL_R2
 	bool "Magic Panel R2"
 	depends on CPU_SUBTYPE_SH7720
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Magic Panel R2 if configuring for Magic Panel R2.
diff --git a/arch/sh/boards/mach-highlander/Kconfig b/arch/sh/boards/mach-highlander/Kconfig
index b0abd03cac4e..cd3a553ce30c 100644
--- a/arch/sh/boards/mach-highlander/Kconfig
+++ b/arch/sh/boards/mach-highlander/Kconfig
@@ -20,6 +20,7 @@ config SH_R7785RP
 	bool "R7785RP board support"
 	depends on CPU_SUBTYPE_SH7785
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 
 endchoice
 
diff --git a/arch/sh/boards/mach-rsk/Kconfig b/arch/sh/boards/mach-rsk/Kconfig
index f0299bc4416f..3810937aa5d4 100644
--- a/arch/sh/boards/mach-rsk/Kconfig
+++ b/arch/sh/boards/mach-rsk/Kconfig
@@ -12,16 +12,19 @@ config SH_RSK7201
 config SH_RSK7203
 	bool "RSK7203"
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	depends on CPU_SUBTYPE_SH7203
 
 config SH_RSK7264
 	bool "RSK2+SH7264"
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	depends on CPU_SUBTYPE_SH7264
 
 config SH_RSK7269
 	bool "RSK2+SH7269"
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	depends on CPU_SUBTYPE_SH7269
 
 endchoice
-- 
2.39.5

