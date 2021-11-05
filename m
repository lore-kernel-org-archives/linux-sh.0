Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF27C433EF
	for <linux-sh@archiver.kernel.org>; Fri,  5 Nov 2021 15:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027526124A
	for <linux-sh@archiver.kernel.org>; Fri,  5 Nov 2021 15:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhKEPxp (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:53:45 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42646
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233765AbhKEPxl (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 5 Nov 2021 11:53:41 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EAC7F3F1D9
        for <linux-sh@vger.kernel.org>; Fri,  5 Nov 2021 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636127460;
        bh=0bEssfmXxHPGUprNSso7Mjq6wm8EF4TYvKsU8/02BBE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UAwsgu5Af/B6n+BUI/j1DW7lEXz6/ivW0OqLKlzZlus1RljO0HjgeLrzKd/i7C+O4
         8fsnYc7Cdkj8EeffK4dqpmbDc64FMPl3I1UsylUk+Qj7NH5uahBP1Lp2bQQDuDjsmb
         cZZG3gQiYOz3/uNYqYQPlOKd9ObfFOQUiw7hjnEsMHOKL0sGARAnLtLduym+qlc0HH
         rcLFPLY7T8a5i9pppXmFY0gFL410i5w1JK0ql/ICExmzqlA/LxYA1LgY9wFeW+HBLi
         cuxHMeAvT8ISuBBmNAtoTGF4PGJugdjVjKNZIA85MAt8QUPQv/I0LYV8qgZXBpLaXD
         iMq1MIZcccX7w==
Received: by mail-lj1-f200.google.com with SMTP id bn14-20020a05651c178e00b002164a557684so3227697ljb.6
        for <linux-sh@vger.kernel.org>; Fri, 05 Nov 2021 08:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bEssfmXxHPGUprNSso7Mjq6wm8EF4TYvKsU8/02BBE=;
        b=YsGByHqMWjtFPDZmPyORrX8iPlLp1DnkNoXXJDQztGsWDoo1KvqjhuFIEoTsFECUmZ
         lxf0jrNT8+M4itxwAsVvBvGrAM65qNz3EstdwmNteej5tqXGkutHk27qz+XueS9zOo15
         O6TfPcO/tNjmURGrfL3pOwMybCpDggv5WFJHizAt6ov2nCr+t1gQzjdIHc1IiitjrvNG
         x0M8v33XaSwgbB4q+JpGBGJzNdDy+Gbzo4cdkCRqGLf6wIyxy1mzj2YvQ9KcOR4coqkN
         r6olDKMCCdv0ObsrqUK+Oh9DDlTPO2mFv07KhmAvj/5/aI7Vi3EcdUJ5k7FeZfMRFbsb
         0UMQ==
X-Gm-Message-State: AOAM532cTAtavhtKzsiVv1DXJ4+1y4yZunBX1V5OyyceKOir4/7KCVn/
        HRNhcbzyCbRlfJZcaD7ncRSwOrCxd+IT6b80iKQnB45OkFy7mYaZFqYQjB0zrpH5nczp6t0d8TP
        C5zRo/rawyu2khBSH1pJECOp20egylBYvO0/I
X-Received: by 2002:a5d:468f:: with SMTP id u15mr60369037wrq.171.1636127449750;
        Fri, 05 Nov 2021 08:50:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP30QeivC6b36TFL+IkuxX7YAofe7sXVJxsbORnG4EhnoSVTTf2FUxAHUW+sOGX9Deb4eenw==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr60368997wrq.171.1636127449594;
        Fri, 05 Nov 2021 08:50:49 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id h27sm13219037wmc.43.2021.11.05.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:50:49 -0700 (PDT)
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
Subject: [PATCH 7/7] arch: Remove leftovers from prism54 wireless driver
Date:   Fri,  5 Nov 2021 16:43:34 +0100
Message-Id: <20211105154334.1841927-8-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
References: <20211105154334.1841927-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This driver was removed so remove all references to it.

Fixes: d249ff28b1d8 ("intersil: remove obsolete prism54 wireless driver")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/mips/configs/ip27_defconfig        | 1 -
 arch/mips/configs/malta_defconfig       | 1 -
 arch/mips/configs/malta_kvm_defconfig   | 1 -
 arch/mips/configs/maltaup_xpa_defconfig | 1 -
 arch/powerpc/configs/pmac32_defconfig   | 1 -
 5 files changed, 5 deletions(-)

diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 638d7cf5ef01..821630ac1be7 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -223,7 +223,6 @@ CONFIG_TMD_HERMES=m
 CONFIG_NORTEL_HERMES=m
 CONFIG_P54_COMMON=m
 CONFIG_P54_PCI=m
-CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_THINFIRM=m
 CONFIG_MWL8K=m
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 9cb2cf2595e0..3321bb576944 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -302,7 +302,6 @@ CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_PLX=m
 CONFIG_HOSTAP_PCI=m
-CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_MOUSE_PS2_ELANTECH=y
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 5924e48fd3ec..009b30372226 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -310,7 +310,6 @@ CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_PLX=m
 CONFIG_HOSTAP_PCI=m
-CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index c0d3156ef640..e214e136101c 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -309,7 +309,6 @@ CONFIG_HOSTAP_FIRMWARE=y
 CONFIG_HOSTAP_FIRMWARE_NVRAM=y
 CONFIG_HOSTAP_PLX=m
 CONFIG_HOSTAP_PCI=m
-CONFIG_PRISM54=m
 CONFIG_LIBERTAS=m
 CONFIG_INPUT_MOUSEDEV=y
 CONFIG_MOUSE_PS2_ELANTECH=y
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 7aefac5afab0..13885ec563d1 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -169,7 +169,6 @@ CONFIG_USB_USBNET=m
 CONFIG_B43=m
 CONFIG_B43LEGACY=m
 CONFIG_P54_COMMON=m
-CONFIG_PRISM54=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_MOUSE_PS2 is not set
-- 
2.32.0

