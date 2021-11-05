Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B524EC433EF
	for <linux-sh@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC1A61183
	for <linux-sh@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhKEPsZ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55304
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232631AbhKEPsY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 5 Nov 2021 11:48:24 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C3FF040027
        for <linux-sh@vger.kernel.org>; Fri,  5 Nov 2021 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127143;
        bh=RNobqhWtnsfIoxXaYIoZpBxYqqusSLJy7zau+vw4CD8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=JcS7wmCFoqo16Fq4JG4EhbrHTjKVh5acSQD/yJeOkjkD/hdqJDrGD6FMZn+X8n+rP
         6OZ8OrN0sYoyTnUgC66RY5NNE8wOK06ZaMMLntO3HrO9U+Qdq52rUHyXeYiLV9pq9T
         A9blur1Qkk3xJI6VkwHTRa/ijh2i/MdVAk0ZvYaL20LGnQjByFX/69NrPIkAiFuLoj
         +T20R66h07UYe6CXTU5Xl5TEtpdwrOftzlEJP9OsJ/N4v3jZyHInxyoimLIgkCw9ip
         Egm1AaBi4g5wbGOOZEVpCFzZdV/T56s5tydt00CgkR8p5eMYPk6mVeXLlCJNZckU4S
         4EhbeycVTOSUg==
Received: by mail-wr1-f71.google.com with SMTP id r12-20020adfdc8c000000b0017d703c07c0so2466137wrj.0
        for <linux-sh@vger.kernel.org>; Fri, 05 Nov 2021 08:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNobqhWtnsfIoxXaYIoZpBxYqqusSLJy7zau+vw4CD8=;
        b=M2iV9V4AS3AT6ec3eIWk2npnAlKMBuf+KpBk7mu7LZj7Gd33XN7Tu2jTrL7ntKbyKg
         /aYv3reLdm7tujWJ236mW4e/AXYuB35TYFeEd5biARevCWeT7oAkPW58U9YR0lO3YNTY
         s1daNDTaq5yn0wH3Njt0rBt+78xr4qoR2trLZ5grF5b9+TwtDe1ODIoYUsGng3QosWqv
         OpJHlWHswLWtJE7dfLVne0zCZrnYrE1yqsbPfCEYeiznQr6UFuIfvbgDsWir61nGTHr6
         24OJBbzVlu/LrUryn8IHokMnn9r+etKI7GTn4YcQQX8gWmWpUk0FrjRf7osALLEKpH9W
         reaA==
X-Gm-Message-State: AOAM533wmKSNer3HQhSD/NqPeGaIPlN8Rf4DXFAx6mMvxHc8GM4AyDhy
        8uNtims6ncWmnC1j5wbXpXepriSjrC3WOf3LtUnPNhQXPdG34Qmnl/u01y3+vag2oJKnBnpLfTO
        hKPqbYBu8dRnfvZ9pfLbOjMHGYiCwXZK1GGCm
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr55189832wrz.404.1636127142090;
        Fri, 05 Nov 2021 08:45:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZywTZdfrBqjkrXUHT6HtmWD9YVAJ3iwmoe2pIrt2a1HLvL+5pBL/kHDbOZs7Oh5iYcqB87Q==
X-Received: by 2002:a05:6000:248:: with SMTP id m8mr55189804wrz.404.1636127141914;
        Fri, 05 Nov 2021 08:45:41 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id z5sm15339353wmp.26.2021.11.05.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:41 -0700 (PDT)
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
Subject: [PATCH 2/7] Documentation, arch: Remove leftovers from raw device
Date:   Fri,  5 Nov 2021 16:43:29 +0100
Message-Id: <20211105154334.1841927-3-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Raw device interface was removed so remove all references to configs
related to it.

Fixes: 603e4922f1c8 ("remove the raw driver")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 Documentation/admin-guide/devices.txt  | 8 +-------
 arch/arm/configs/spear13xx_defconfig   | 1 -
 arch/arm/configs/spear3xx_defconfig    | 1 -
 arch/arm/configs/spear6xx_defconfig    | 1 -
 arch/powerpc/configs/pseries_defconfig | 1 -
 5 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 922c23bb4372..c07dc0ee860e 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -2339,13 +2339,7 @@
 		disks (see major number 3) except that the limit on
 		partitions is 31.
 
- 162 char	Raw block device interface
-		  0 = /dev/rawctl	Raw I/O control device
-		  1 = /dev/raw/raw1	First raw I/O device
-		  2 = /dev/raw/raw2	Second raw I/O device
-		    ...
-		 max minor number of raw device is set by kernel config
-		 MAX_RAW_DEVS or raw module parameter 'max_raw_devs'
+ 162 char	Used for (now removed) raw block device interface
 
  163 char
 
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 3b206a31902f..065553326b39 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -61,7 +61,6 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index fc5f71c765ed..afca722d6605 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -41,7 +41,6 @@ CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 52a56b8ce6a7..bc32c02cb86b 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -36,7 +36,6 @@ CONFIG_INPUT_FF_MEMLESS=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
 CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index b183629f1bcf..d0494fbb4961 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -190,7 +190,6 @@ CONFIG_HVCS=m
 CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IBM_BSR=m
 CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=1024
 CONFIG_I2C_CHARDEV=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
-- 
2.32.0

