Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7371C433EF
	for <linux-sh@archiver.kernel.org>; Wed, 25 May 2022 12:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiEYMka (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 May 2022 08:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbiEYMkZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 May 2022 08:40:25 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692F7CB19
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:24 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1EC4C3F1D3
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482416;
        bh=iyJ1o3EKMPaP9U9I8uxiOxxTU+2g3bHGq6iXs/oFCNA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=kyOt8MxqjZUZtSucVaO2YlJBslFtnFRxVNjBuDeSEufpaHiKjlmhDWOYkIRjqOqm6
         8uhGzV3QllkPrbzV0hHx6uU8ZdPMBvJ3mn0CGPDzhlpIMoXhdI24580m4+sUI0+H/Z
         WtllwlwGJcxW87Sxl5cb8CVGk3u7341QwqXql6xMHTeejzYVz90U5Ll+zXXpwKFd71
         LcMUU5j4o/zV/D076FDfKzTljhjOjNkfZfYKK07w6C+AV7Xt1oTXtRVS97BydvmONl
         IJ8NPdSjcAxJokueh2mOVdzDqUDfmqGOhJXZhpLCZM3ua3dd5V2qClKmYxz1W1Z27l
         dA0KCZbf3gzOQ==
Received: by mail-ed1-f72.google.com with SMTP id w14-20020a50fa8e000000b0042ab142d677so14828053edr.11
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyJ1o3EKMPaP9U9I8uxiOxxTU+2g3bHGq6iXs/oFCNA=;
        b=dJ/mbEClQeku3zYW5kn5baAtsH9kxGT5P0u8uCigrldOpDrraE45wFnwMu1YLFIsBc
         3w5uuMZitKsPVzmcynfHGH1S+1o/8EqjT0RzSBXgewZYX1Q0zSjMkxhLI+TIuZ6bOy2z
         fPN6WaBTzoXq1XcNurFt2XNL/K/hT9gTkRjGCNzahEnARl7V2OODNZRlou8H3MnuO+LM
         Vm5Lo5xK2goP4e9kmiEV/Lnw2XfVetM1q8gpm0a9shi42xNij2j+EIpm85qbaHMy2Tnz
         Oh/ZyimC7pGvUve0IpvptjAqTIoZuxL7nGsIkD8FPqck9c6Cu4LWs6y1c6RoKDOQXYva
         Bn8w==
X-Gm-Message-State: AOAM533IBSzHzu7Y0Tcp+Pv5AZ7g/wPbLBr1g5Ip0WSAUGjsXs5h2ZfV
        KqdWU6PXhUj3UhH9tyWAs2I12EghTY/OD94nshwnFqj+kZKLeR0e6nGrtZR8vpiSLQgVSwRFWsk
        ETNOKutf52SyuQKTpXufgchHzXYxScN0CvhId
X-Received: by 2002:a17:906:7953:b0:6fe:dcc0:356f with SMTP id l19-20020a170906795300b006fedcc0356fmr14554443ejo.75.1653482414690;
        Wed, 25 May 2022 05:40:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx83tUQ8lAH/eJDzSXN4oqG7jrKL0YqzLNVQoUp9dVB4Penplu8F9OeFkvKXkIq0sU0eOIrMg==
X-Received: by 2002:a17:906:7953:b0:6fe:dcc0:356f with SMTP id l19-20020a170906795300b006fedcc0356fmr14554432ejo.75.1653482414484;
        Wed, 25 May 2022 05:40:14 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:13 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 0/4] sh: Kconfig: Style cleanups
Date:   Wed, 25 May 2022 14:40:03 +0200
Message-Id: <20220525124007.45328-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

Juerg Haefliger (4):
  sh: Kconfig: Fix indentation
  sh: Kconfig.cpu: Fix indentation
  sh/boards: Kconfig: Fix indentation
  sh/mm: Kconfig: Fix indentation

 arch/sh/Kconfig        | 24 ++++++++++++------------
 arch/sh/Kconfig.cpu    |  2 +-
 arch/sh/boards/Kconfig | 12 ++++++------
 arch/sh/mm/Kconfig     |  6 +++---
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.32.0

