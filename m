Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBACDC433EF
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C914C61130
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbhJFQpz (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:55 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:36628 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhJFQpp (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:45 -0400
Received: by mail-oo1-f41.google.com with SMTP id e19-20020a4a7353000000b002b5a2c0d2b8so1029974oof.3;
        Wed, 06 Oct 2021 09:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVDBxu87TJi7lJ0TsvF77hW6cToukGJnTBFK4bAPEHE=;
        b=yK4hHPrJnssJl72XgmZ9NbKgB+3h/U3+gTnqb0YNqjkHpu1j8D3hNTaK3yGbgAJq8d
         bAmEzwSzcMtAQDMnteCAkdbK4pXAlpPfJzrgN0w4H5vvfi5knIM/2ORXE556NGhk+kvU
         kYkfnZruyykjXwB9YVTz7uE3R+xiWHw5OfzFl5KLUIirNyEYvqK3xRP60q5BCXRd4lgI
         NqDqIZSKlnLNfVWIEfJczsXfZUumIIKmuBvHacdbVQFDXxQktOvzN0kqtTV8EWDpZNQb
         1fdtPzUzz8neXqmq5jnye2bjusqMFuRDl9Dv/qTDxsophjznuq1x9ALq7MNCF2PWSme3
         7txw==
X-Gm-Message-State: AOAM5339ZnVjNt1rY9IHmf/ZW1KkVkqyvc2ipKgoieQzp0otrOZxPp55
        RFubDWIanJ/fTxsa+j1Hbw==
X-Google-Smtp-Source: ABdhPJwSo3vtevHig5e6wcfYzHn+p/9LVu6izXiBqHPOZc+ml50aXK5vctwJYkE3EswfiMHjHBf9ng==
X-Received: by 2002:a4a:e597:: with SMTP id o23mr6391984oov.96.1633538632948;
        Wed, 06 Oct 2021 09:43:52 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:52 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 09/12] sh: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:29 -0500
Message-Id: <20211006164332.1981454-10-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Replace open coded parsing of CPU nodes' 'reg' property with
of_get_cpu_hwid().

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/sh/boards/of-generic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 921d76fc3358..f7f3e618e85b 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -62,9 +62,8 @@ static void sh_of_smp_probe(void)
 	init_cpu_possible(cpumask_of(0));
 
 	for_each_of_cpu_node(np) {
-		const __be32 *cell = of_get_property(np, "reg", NULL);
-		u64 id = -1;
-		if (cell) id = of_read_number(cell, of_n_addr_cells(np));
+		u64 id = of_get_cpu_hwid(np, 0);
+
 		if (id < NR_CPUS) {
 			if (!method)
 				of_property_read_string(np, "enable-method", &method);
-- 
2.30.2

