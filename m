Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA9C433EF
	for <linux-sh@archiver.kernel.org>; Wed, 25 May 2022 18:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343656AbiEYSbv (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 May 2022 14:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiEYSbu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 May 2022 14:31:50 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664DCB0D36
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 11:31:49 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2F0543F5F0
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 18:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653503507;
        bh=5tNUlUVpdULW1mlAGUWuXCcSV4iIrGrel9EcAzu6+B4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Nduy37e/5l2XnDMt5arq/ZzYZb6c0hYMGFxVRuwNN2S+94j90Weutfi8vuMTf9+NU
         jM0L4CvhAJbPkD0rCDmxJsU0h2J1rB12R/DMHPVZ8vEZmu8PyLGfnNxz3GhohctAS0
         UkHcXmJAbJ6XgHd4KQCq4Zp5kQkIVkla/Z6AWSwIRxcpFh+cVFBIa+Om5CESW2Ho5n
         AeOM79Qq6p28yt1k/u39cPtIldbRl2Vwa7apzw6woNgAVSvvZIwLwSSVSX9fD9tfaE
         XKKz3AOLOuONhggxiRFozfkEOxdXBqqjo2U/9zMpqDGn7EUMQVVwM/YK52+yGJmNOV
         zPbGXDUrcMtfg==
Received: by mail-ed1-f72.google.com with SMTP id w5-20020a056402128500b0042aa2647eb6so15477351edv.12
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 11:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tNUlUVpdULW1mlAGUWuXCcSV4iIrGrel9EcAzu6+B4=;
        b=gmcGIsinqLUBZW+YB6lj+D4aZ53SNTOYpVpSiJeaxq+Thr1FAXRv6kC+onae1v+gLZ
         svawXHGYocD4C/d1/JF4b+1iuADdWaiZvwItCgDEVJ0fd77KmYJY857UI9EaXIPCXVx6
         I1BI29B6DwYS/gRR7CKrhpld4mKfabH3aTXMY6NpKyqy3sbmkgVIKqK90gp+w8WmteKl
         PknrzWjbsz5QCP7lK8fiWof8ySiFFKaSXodBN5Gyp9SIgVdvunZKmgKcal2lB6l7L/OJ
         2JIc5VhgL5oP+X4ps5tXSKSDhojf15pBFuaDnuS7VMv8XQ+OfZ1KGm36PdB3S82GW0V/
         Uj3Q==
X-Gm-Message-State: AOAM533c4i6p/CqrPICRKSeInoNFFeCkpk2XsxTct8AM8RdnyaLRu6Su
        e6kdcJAre5zeVjAwQim04AAw22RX34QX0yOjGK9gdbXnSMr7BeNtRREc1HfwMn/7q3NYdO2d81y
        u9sSh28uad+Y/EtlKq0XbFH0B5Bu+2UPz6/sF
X-Received: by 2002:a17:907:72c1:b0:6ff:c5f:6b7d with SMTP id du1-20020a17090772c100b006ff0c5f6b7dmr5744761ejc.676.1653503506885;
        Wed, 25 May 2022 11:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysyVgERCvAJ0QRPxB7iHXO2O/vKYKmVAbpc8ojL3ige/psMupEER5vWokV9iKl86T06Ea0pg==
X-Received: by 2002:a17:907:72c1:b0:6ff:c5f:6b7d with SMTP id du1-20020a17090772c100b006ff0c5f6b7dmr5744744ejc.676.1653503506687;
        Wed, 25 May 2022 11:31:46 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7d641000000b0042acd78014esm10847985edr.11.2022.05.25.11.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 11:31:46 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/4 v2] sh: Kconfig.cpu: Remove trailing whitespace
Date:   Wed, 25 May 2022 20:31:33 +0200
Message-Id: <20220525183133.71044-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <0ef0b83b-64d5-82fa-0b31-fbf714c75470@gmail.com>
References: <0ef0b83b-64d5-82fa-0b31-fbf714c75470@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Remove a stray whitespace from the end of a line.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Fix commit subject and message.
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

