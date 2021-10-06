Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFAAC43219
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2894C610E5
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhJFQpb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:31 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42791 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhJFQpa (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:30 -0400
Received: by mail-oi1-f169.google.com with SMTP id x187so2464376oix.9;
        Wed, 06 Oct 2021 09:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uA/cSYcpVyY62IJQPXwhEfvcH0a7DNNoh6QF/gbSv/o=;
        b=ODDM5tXYhSPxk2r/bCjAb5vFG1of6jbKB2UaKspq/dUbxxnFM9foFyghdlXZvWqxeJ
         3q0DQJ5gkypQ+i7dJ0Id6IprWk22PuoDb3Ig+xEuyQKjUBTYLLxT22x3GTiwv/Oosco5
         oslX8k+wVOYYJfmNdGJM8EiSGAjvQeptoK4Q1RmWInxnIsASFsKBhTfGRcHdUI5pqCNd
         CMMa1NPTe+UjJt+WsUNPbPn1jPNQX/uK7+9pSlS0qgz1X79wOzyooUTU373PYGoXTKmT
         t+PTgYTiAT0m3y65w6RWVx9jXPS4nBcn/xhUVzkBj819Y4fpXBOybO2OzdlpLw5+2gmT
         2O+Q==
X-Gm-Message-State: AOAM532RtxGJ8v/7tj8ZHsPCewZ8T5MtEdGeTGTrnxh6QktQEAK6tvCu
        yA7Jq1q4EmEMHPJjk9NCvQ==
X-Google-Smtp-Source: ABdhPJyz5HqR6tKtFIEsHk/GSarLhJvs4xTI3uQnRBWEIdAL05spj94Pn3luIAFrkmprFHNc17eP4A==
X-Received: by 2002:a05:6808:231f:: with SMTP id bn31mr855081oib.66.1633538617237;
        Wed, 06 Oct 2021 09:43:37 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:36 -0700 (PDT)
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
Subject: [PATCH 01/12] of: Add of_get_cpu_hwid() to read hardware ID from CPU nodes
Date:   Wed,  6 Oct 2021 11:43:21 -0500
Message-Id: <20211006164332.1981454-2-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

There are various open coded implementions parsing the CPU node 'reg'
property which contains the CPU's hardware ID. Introduce a new function,
of_get_cpu_hwid(), to read the hardware ID.

All the callers should be DT only code, so no need for an empty
function.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 22 ++++++++++++++++++++++
 include/linux/of.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f720c0d246f2..e587ab44be22 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -286,6 +286,28 @@ const void *of_get_property(const struct device_node *np, const char *name,
 }
 EXPORT_SYMBOL(of_get_property);
 
+/**
+ * of_get_cpu_hwid - Get the hardware ID from a CPU device node
+ *
+ * @cpun: CPU number(logical index) for which device node is required
+ * @thread: The local thread number to get the hardware ID for.
+ *
+ * Return: The hardware ID for the CPU node or ~0ULL if not found.
+ */
+u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thread)
+{
+	const __be32 *cell;
+	int ac, len;
+
+	ac = of_n_addr_cells(cpun);
+	cell = of_get_property(cpun, "reg", &len);
+	if (!cell || !ac || ((sizeof(*cell) * ac * (thread + 1)) > len))
+		return ~0ULL;
+
+	cell += ac * thread;
+	return of_read_number(cell, ac);
+}
+
 /*
  * arch_match_cpu_phys_id - Match the given logical CPU and physical id
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 6f1c41f109bb..807f8168dad9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -353,6 +353,7 @@ extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
 extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
 						 int index);
+extern u64 of_get_cpu_hwid(struct device_node *cpun, unsigned int thread);
 
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
-- 
2.30.2

