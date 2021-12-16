Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F2C433F5
	for <linux-sh@archiver.kernel.org>; Thu, 16 Dec 2021 09:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhLPJtM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 16 Dec 2021 04:49:12 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:50152
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230345AbhLPJtM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 16 Dec 2021 04:49:12 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8FC1C3F1C0
        for <linux-sh@vger.kernel.org>; Thu, 16 Dec 2021 09:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639648150;
        bh=WUEOV0Puf0rdsNKOWUqNq9jf3IbOHS9FDzqSlVW9pZ4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Clp5ihNV6qIXRi6YTXTqJY1F/KwOGRGlEU/7tNnesZ99csUKFsTzc537VbW/LjgYE
         NKIrH59n2pXN/fQnbPMy+3GVbvyTOePNVhSzEciHNoZacOMuqJN1sglwbCrD7VfWxq
         2NhdD+SyM5z+HQrXt4rDBwSAPavpTZ+Igb8QRI8jBQpm/m6aqLWqf+zmhixybrUqoN
         FZ+ToNNc0D4ssl5Agb2fYbWb62P9SHwqm7SxpGPGt3i5YoQRYXFx6aVRussdHTOEnb
         f3j3UxLap0utIIUBHD/HL+n76XHfFJoRS+SI4exLF4LJBC/AQUSjAbT2WfUDzMdLMf
         F/Vkcfs+rdiIA==
Received: by mail-lj1-f198.google.com with SMTP id u28-20020a2ea17c000000b0021126b5cca2so8299009ljl.19
        for <linux-sh@vger.kernel.org>; Thu, 16 Dec 2021 01:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WUEOV0Puf0rdsNKOWUqNq9jf3IbOHS9FDzqSlVW9pZ4=;
        b=xwBa5zJCFCeeVotsCqM8xgcqyXrg3Z1oXaF0YUts3H1tXh6EA4hNwjJjZTORaJ8Tvh
         x4O2xThl8cJHdwsE13e3ZvIu5D3YYJ7fmbFUcMzmL7NaJkt8aeAl7XticgPiJE3sW8u2
         BBETZxPZEkO4lvyMeNN7Ot61eaLcrwCJF5mhLNqvXpVcS+UhQWNfWXqLOOZRK0Q2UPW3
         2tgMZuD0wHcFC0VoIAylCmisw34vjesg+CR67jNX/bpjuw5orUU3zAQ1hs5c4WZOhrXl
         dqeOYKVyvswzv/GV+RI5J2ZUWnqnJSZrmR9KETWdTuqYQ9l6kyWyCd6NUI+OV/kpiv5H
         tyMw==
X-Gm-Message-State: AOAM530xvNzumoazHa099Q53pJi/CVAuQXFSqpzv7BKLpXvPioYf4/Gd
        orEduCMg10xlX44yBxbEL9ILN4c7T0LAug/l0wA356ZZHbtpOXRaYgqMC1QNQgt/DboW/7hDJ42
        vyIse6UU5NpvVav6GSEe7Qi2YThUFYIcOox2C
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr8274615wrw.283.1639648139312;
        Thu, 16 Dec 2021 01:48:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4D7RcuSiJhn58Bkp9nDVxQgFgFxFbQZtRi6SJVIaJvvuUPrIa3b5F/cBoS8baOoKUv8xnUw==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr8274584wrw.283.1639648139155;
        Thu, 16 Dec 2021 01:48:59 -0800 (PST)
Received: from alex.home (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id m36sm4145891wms.25.2021.12.16.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:48:58 -0800 (PST)
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
Subject: [PATCH v2 4/6] arch: Remove leftovers from mandatory file locking
Date:   Thu, 16 Dec 2021 10:44:24 +0100
Message-Id: <20211216094426.2083802-5-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216094426.2083802-1-alexandre.ghiti@canonical.com>
References: <20211216094426.2083802-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This config was removed so remove all references to it.

Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 arch/mips/configs/decstation_64_defconfig  | 1 -
 arch/mips/configs/decstation_defconfig     | 1 -
 arch/mips/configs/decstation_r4k_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/mips/configs/decstation_64_defconfig b/arch/mips/configs/decstation_64_defconfig
index 85f1955b4b00..e2ed105f8c97 100644
--- a/arch/mips/configs/decstation_64_defconfig
+++ b/arch/mips/configs/decstation_64_defconfig
@@ -144,7 +144,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_MANDATORY_FILE_LOCKING is not set
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/decstation_defconfig b/arch/mips/configs/decstation_defconfig
index 30a6eafdb1d0..7e987d6f5e34 100644
--- a/arch/mips/configs/decstation_defconfig
+++ b/arch/mips/configs/decstation_defconfig
@@ -140,7 +140,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_MANDATORY_FILE_LOCKING is not set
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
diff --git a/arch/mips/configs/decstation_r4k_defconfig b/arch/mips/configs/decstation_r4k_defconfig
index e2b58dbf4aa9..6df5f6f2ac8e 100644
--- a/arch/mips/configs/decstation_r4k_defconfig
+++ b/arch/mips/configs/decstation_r4k_defconfig
@@ -140,7 +140,6 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_MANDATORY_FILE_LOCKING is not set
 CONFIG_ISO9660_FS=y
 CONFIG_JOLIET=y
 CONFIG_PROC_KCORE=y
-- 
2.32.0

