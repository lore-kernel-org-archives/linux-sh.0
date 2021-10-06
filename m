Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB58C43217
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7895A61131
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbhJFQp5 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:45:57 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:45968 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbhJFQpr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:47 -0400
Received: by mail-oi1-f178.google.com with SMTP id v10so4795392oic.12;
        Wed, 06 Oct 2021 09:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J13zoIHrX4tLH3WneJUTeWV7jFKNgk6/LfnJOFSAv7E=;
        b=D2q5si30HENPddgh9NAhi3id+d7hMzBibYaQjh8aFhAXmC5sZp1/uZXxxVFK2U8bsn
         zVlUIobvs/vlwbDEJ7KS6FVppDsLt97lCDGB7DBkx3Iu5xsr+SJLnxwcnQD51GMFdBgK
         TtB1Wybv6C99jAXp9Y1+D9BvzQv8edrYlJhI1ACAW8w1/Y4Ou8gnY63xdyHKm7sOcQqm
         uFUDcetrGuffv2EipBxUEyS8TS2MvjUX/Ae4Asmjlnes2ArM7hAlQjp8qntUK1zKe8U4
         0Pc9JpZKqoBSvoCs9guqtHqzPLJBq75BnrYJe6t/NH8rtKF9NhMWUUAQjYt/5NaVEdb+
         h/fQ==
X-Gm-Message-State: AOAM531ImG11BE73+oeNwxbv9089HTclcJBdPuP4LJbEpt+YUFaS0QyN
        LA9F3X9Cfu0Z2mhKWqrYkA==
X-Google-Smtp-Source: ABdhPJzsmLqvAc8ULa8uzHfFQAR3YkQa63E6ZsBRL9k77fBu+BE8j4mODwWxFxPISSskaMe8DkKEfw==
X-Received: by 2002:aca:c288:: with SMTP id s130mr7509039oif.138.1633538634953;
        Wed, 06 Oct 2021 09:43:54 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:54 -0700 (PDT)
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
Subject: [PATCH 10/12] x86: dt: Use of_get_cpu_hwid()
Date:   Wed,  6 Oct 2021 11:43:30 -0500
Message-Id: <20211006164332.1981454-11-robh@kernel.org>
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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/x86/kernel/devicetree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 6a4cb71c2498..3aa1e99df2a9 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -139,12 +139,11 @@ static void __init dtb_cpu_setup(void)
 {
 	struct device_node *dn;
 	u32 apic_id, version;
-	int ret;
 
 	version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	for_each_of_cpu_node(dn) {
-		ret = of_property_read_u32(dn, "reg", &apic_id);
-		if (ret < 0) {
+		apic_id = of_get_cpu_hwid(dn, 0);
+		if (apic_id == ~0U) {
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-- 
2.30.2

