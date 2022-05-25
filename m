Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D36C433FE
	for <linux-sh@archiver.kernel.org>; Wed, 25 May 2022 12:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiEYMkb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 May 2022 08:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbiEYMkZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 May 2022 08:40:25 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69B37CB26
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:24 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DBB203F201
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482420;
        bh=Nbms1BIDguDm1zi7ndfMJ73ax9St3z++nLzQuG5Ak/k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=trMK2smxfVEapvmlf+MUz9AJFvFLJn9JFpgGbuHHINvBAn1l2it4C7AHXF6Xt22te
         Vs57yqm1jixhLWJzRZCHT/gS50+57IOjLBl1LdHUvuIrh5v5hQRHrSv6K44aebLCS8
         08xnbaXT4R50tgH/CR4Qklke4+hACqKVmT66DJ1WnQIKaAFceAmzHJNYrv9kjx9/w9
         TS9vS3z6I2wZf+UulFsPvQQBoVIkjfxKPOS0O8jJhN8sD6n4PjWMT3TsMN5WXUp7EA
         DirkAzRed4XK7yN/MaUeFZkPo7JWzIMbyW5Xo9QId30tvgXDBhtM+cV62N17MZYem7
         NMBF97emspFOQ==
Received: by mail-ed1-f72.google.com with SMTP id w23-20020aa7da57000000b0042acd76347bso14753565eds.2
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nbms1BIDguDm1zi7ndfMJ73ax9St3z++nLzQuG5Ak/k=;
        b=E+8xWCfLJh1G2w9A4xVfKleXn1QnfJt/ItrS7mOWC2/HPtRhZc5J8FZ6ZQBTAKduCN
         d5yp+nRN6qdjoLoCxsEBYyQ8qxSE0k7ZWMyWPpQLOxaX/Qcjw4ERHqjQHOIQFNvq9Bom
         bwhBJak74QefuZ+nUtKvnfF3z0rqpC2H55D5yqwo4KBL8jzrjaI3z7Oqlo/Cetfnbv+z
         Zj9Egdr+XH1PslD/MZYI+wqlSsTZbhI79NWMyzvscy/XbxtMad7czbevJgFVDnEYqxH1
         OLKPf7X048HL7RQDwFdbWpGiQmUXJGV7BXIs8I4tNe0bpFmT7mQRiLEwZ6U4KDnLCOX1
         SLPw==
X-Gm-Message-State: AOAM530VS7KKf73rJPUA31JYBtHb+sfqvPE86zTxcBQvXzrLu9oHyWe5
        M3fOEOPnJQFfqonRqdEveozeJ3WjwtLIbHQB4lAgsNNTFwNKWzqhwIQGV2aHFZ8bawzR32Dj0e6
        BN6VivUNcJMj0eu0fNJZ4Oo8vGVKYEkyBOJHW
X-Received: by 2002:a05:6402:380f:b0:42b:27aa:d4cb with SMTP id es15-20020a056402380f00b0042b27aad4cbmr27457555edb.211.1653482416486;
        Wed, 25 May 2022 05:40:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSVRDBpKldg6LggqgxHhGIYnN9PDBOldp7DiB44jJIK1opWpXyqEqjmjKfjqbVJ1rQegRXTA==
X-Received: by 2002:a05:6402:380f:b0:42b:27aa:d4cb with SMTP id es15-20020a056402380f00b0042b27aad4cbmr27457536edb.211.1653482416298;
        Wed, 25 May 2022 05:40:16 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:15 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/4] sh: Kconfig.cpu: Fix indentation
Date:   Wed, 25 May 2022 14:40:05 +0200
Message-Id: <20220525124007.45328-3-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525124007.45328-1-juerg.haefliger@canonical.com>
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/sh/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
index fff419f3d757..7b0bea483eab 100644
--- a/arch/sh/Kconfig.cpu
+++ b/arch/sh/Kconfig.cpu
@@ -2,7 +2,7 @@
 menu "Processor features"
 
 choice
-	prompt "Endianness selection" 
+	prompt "Endianness selection"
 	default CPU_LITTLE_ENDIAN
 	help
 	  Some SuperH machines can be configured for either little or big
-- 
2.32.0

