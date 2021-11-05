Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2241EC4332F
	for <linux-sh@archiver.kernel.org>; Fri,  5 Nov 2021 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E2161245
	for <linux-sh@archiver.kernel.org>; Fri,  5 Nov 2021 15:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKEPrc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:47:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42088
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232115AbhKEPrc (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 5 Nov 2021 11:47:32 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 00A7B3F1E3
        for <linux-sh@vger.kernel.org>; Fri,  5 Nov 2021 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127092;
        bh=jHLHivxStKmmA/vK1gxbQJ1JTHvdFc1nwcxGtaT2GSQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p3Bcv7ezddS0q4rWcuzjW9ZWspRagCBWKN66RCMw4Cbv2U8fJQpnlfkJfckuEWgSu
         RhY+f/Yv10ogCLWjWW4yAhfaQZJe2SUbYEI+5LN2cgV8AtDzvdFLvdr82qw6mM37pH
         SEw0+0NJ6FLn8QBM31Oa8f7km9BIDhxNLHJymxrJq0TGEdOhjXJqjwzPOG8Zc/rA1M
         KGCXwOZmH0N/z4JBLsRERbboS703giTqAJPujpQyLPBKRlnbD8FtNRknKBYCJy8WJJ
         14H+52uTP4fc8UTJa8MuC/8ruGT7iXJQVwuyp7bIsy/E6GQqn3WM6wQqrafrtLHtVr
         Jbb5Zmdx4dpvg==
Received: by mail-wm1-f71.google.com with SMTP id c185-20020a1c35c2000000b003331dc61c6cso365475wma.6
        for <linux-sh@vger.kernel.org>; Fri, 05 Nov 2021 08:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHLHivxStKmmA/vK1gxbQJ1JTHvdFc1nwcxGtaT2GSQ=;
        b=Jg/Jhi6mu0VT/w8nHLT6i6js2LlHgounsFp/+atKPiIq0QPCo35NZ1yy4vXI3Nb3rG
         PU5ZhKCU+Jmlz6KlD/V6FowpFgxeSi3OPQFwxBzzZ0cRvlo5LVXouzuV5xAD0WLnP6A4
         mFe7lnXQQI8fgl5q7LQX9ZXzesgZ4i5smku4IkZcaiG226IfHnOztABYuwt229ikZP3E
         aPCJTcFFzio9vGH/BPGqiXRE974ak2Ag/Hg3Lh1Gr4hQEVesVRo5spoyW2WSV0r474dJ
         1nlHOvLYI50kfk3HaIZp+yM8vuNa1ZK6r2LGKxzab1ulG0cELAQykSbLaiYSzFTsaJgA
         0Osw==
X-Gm-Message-State: AOAM533Q1h8M4EdvDy/o5668I7Au9Qh4ACAJiKyPTTzyGW0VZYBWaK/6
        Mrl6T65BNvXk6bYtONqsiV5nQ5L5qr4IuoO9CDi5frNCsw7k/zZT9+nzaBFMePjI9JFRwD7lFPT
        SP68ix7N4bGMkDu0wu7cGZRKkfFKsQQUuxtOs
X-Received: by 2002:adf:fb44:: with SMTP id c4mr71913812wrs.179.1636127080669;
        Fri, 05 Nov 2021 08:44:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwubhhFLZ1HPTor4i3ntryLRhJH9bsSukDKTrsUDEYR79CovJvijb9h2VluKlN2+0XYoTfgRg==
X-Received: by 2002:adf:fb44:: with SMTP id c4mr71913748wrs.179.1636127080324;
        Fri, 05 Nov 2021 08:44:40 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id l11sm8178812wrp.61.2021.11.05.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:44:40 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Steve French <sfrench@samba.org>, Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 1/7] Documentation, arch: Remove leftovers from fscache/cachefiles histograms
Date:   Fri,  5 Nov 2021 16:43:28 +0100
Message-Id: <20211105154334.1841927-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

A few references to the fscache and cachefiles histograms were left in
the Documentation and some arch defconfigs: remove them since those
configs do not exist anymore.

Fixes: 6ae9bd8bb037("fscache, cachefiles: Remove the histogram stuff")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 .../filesystems/caching/cachefiles.rst        | 34 -------------------
 Documentation/filesystems/caching/fscache.rst | 34 ++-----------------
 arch/arm/configs/axm55xx_defconfig            |  2 --
 arch/mips/configs/nlm_xlp_defconfig           |  1 -
 arch/mips/configs/nlm_xlr_defconfig           |  1 -
 5 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/Documentation/filesystems/caching/cachefiles.rst b/Documentation/filesystems/caching/cachefiles.rst
index e58bc1fd312a..e59861458029 100644
--- a/Documentation/filesystems/caching/cachefiles.rst
+++ b/Documentation/filesystems/caching/cachefiles.rst
@@ -424,40 +424,6 @@ for CacheFiles to run in a context of a specific security label, or to create
 files and directories with another security label.
 
 
-Statistical Information
-=======================
-
-If FS-Cache is compiled with the following option enabled::
-
-	CONFIG_CACHEFILES_HISTOGRAM=y
-
-then it will gather certain statistics and display them through a proc file.
-
- /proc/fs/cachefiles/histogram
-
-     ::
-
-	cat /proc/fs/cachefiles/histogram
-	JIFS  SECS  LOOKUPS   MKDIRS    CREATES
-	===== ===== ========= ========= =========
-
-     This shows the breakdown of the number of times each amount of time
-     between 0 jiffies and HZ-1 jiffies a variety of tasks took to run.  The
-     columns are as follows:
-
-	=======		=======================================================
-	COLUMN		TIME MEASUREMENT
-	=======		=======================================================
-	LOOKUPS		Length of time to perform a lookup on the backing fs
-	MKDIRS		Length of time to perform a mkdir on the backing fs
-	CREATES		Length of time to perform a create on the backing fs
-	=======		=======================================================
-
-     Each row shows the number of events that took a particular range of times.
-     Each step is 1 jiffy in size.  The JIFS column indicates the particular
-     jiffy range covered, and the SECS field the equivalent number of seconds.
-
-
 Debugging
 =========
 
diff --git a/Documentation/filesystems/caching/fscache.rst b/Documentation/filesystems/caching/fscache.rst
index 70de86922b6a..66e31a6d1070 100644
--- a/Documentation/filesystems/caching/fscache.rst
+++ b/Documentation/filesystems/caching/fscache.rst
@@ -201,10 +201,9 @@ Statistical Information
 If FS-Cache is compiled with the following options enabled::
 
 	CONFIG_FSCACHE_STATS=y
-	CONFIG_FSCACHE_HISTOGRAM=y
 
-then it will gather certain statistics and display them through a number of
-proc files.
+then it will gather certain statistics and display them through the following
+proc file.
 
 /proc/fs/fscache/stats
 ----------------------
@@ -413,35 +412,6 @@ proc files.
 
 
 
-/proc/fs/fscache/histogram
---------------------------
-
-     ::
-
-	cat /proc/fs/fscache/histogram
-	JIFS  SECS  OBJ INST  OP RUNS   OBJ RUNS  RETRV DLY RETRIEVLS
-	===== ===== ========= ========= ========= ========= =========
-
-     This shows the breakdown of the number of times each amount of time
-     between 0 jiffies and HZ-1 jiffies a variety of tasks took to run.  The
-     columns are as follows:
-
-	=========	=======================================================
-	COLUMN		TIME MEASUREMENT
-	=========	=======================================================
-	OBJ INST	Length of time to instantiate an object
-	OP RUNS		Length of time a call to process an operation took
-	OBJ RUNS	Length of time a call to process an object event took
-	RETRV DLY	Time between an requesting a read and lookup completing
-	RETRIEVLS	Time between beginning and end of a retrieval
-	=========	=======================================================
-
-     Each row shows the number of events that took a particular range of times.
-     Each step is 1 jiffy in size.  The JIFS column indicates the particular
-     jiffy range covered, and the SECS field the equivalent number of seconds.
-
-
-
 Object List
 ===========
 
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 46075216ee6d..b36e0b347d1f 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -204,11 +204,9 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=y
 CONFIG_FSCACHE=y
 CONFIG_FSCACHE_STATS=y
-CONFIG_FSCACHE_HISTOGRAM=y
 CONFIG_FSCACHE_DEBUG=y
 CONFIG_FSCACHE_OBJECT_LIST=y
 CONFIG_CACHEFILES=y
-CONFIG_CACHEFILES_HISTOGRAM=y
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=y
 CONFIG_MSDOS_FS=y
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index 32c290611723..c97f00ece828 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -420,7 +420,6 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_FSCACHE=m
 CONFIG_FSCACHE_STATS=y
-CONFIG_FSCACHE_HISTOGRAM=y
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index bf9b9244929e..60ea102783d9 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -372,7 +372,6 @@ CONFIG_FUSE_FS=y
 CONFIG_CUSE=m
 CONFIG_FSCACHE=m
 CONFIG_FSCACHE_STATS=y
-CONFIG_FSCACHE_HISTOGRAM=y
 CONFIG_CACHEFILES=m
 CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
-- 
2.32.0

