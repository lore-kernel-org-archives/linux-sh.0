Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11327C4332F
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A6A61130
	for <linux-sh@archiver.kernel.org>; Wed,  6 Oct 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbhJFQqA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 12:46:00 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38636 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbhJFQpt (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 12:45:49 -0400
Received: by mail-oi1-f173.google.com with SMTP id t4so3023591oie.5;
        Wed, 06 Oct 2021 09:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDUPVdWmFpBgvCkQTCBoljrAdHSMkkZBVQWsyUTyf5E=;
        b=HVHty+JRfnGzPW9Uo8hUF9uAy0GUQ5hz+A6ojh62JFPwD8ymg62r9rc2xuHrOoXyBO
         kqra0WEDPi6OI/C/+x8ZdLw2w70WbtbNaySVHimH3UEgapdR9m9bnAUBgXdz7iU4nvNN
         dEvPW3Z7JXx85jC+Xnt6JN/M2scp096213JrhH++5GRkHPZPGd3kdwa1gdWluq+KaO0v
         JSb64lC0btDt80WXbRfaGa2ExGKQjrbqJfQ53m4B8m4e6ARAIiU3DppHbMc0RYSPpa0q
         8n049PdDBPwHiwCPsWyJ0NH3Z370lYqevWnd+u97uc1PLN2HsT9Firntb4y7X6sv860T
         iBEA==
X-Gm-Message-State: AOAM531RbW6CdzG/XJfep5n9ukX1jAmRuE7puVac4087rNta6Ywgo7W0
        nKQYVTW6x/+Q7d7S2XVhww==
X-Google-Smtp-Source: ABdhPJzdKu+vPdU6QOPaibRhZZ8V3BXWev73rJIyB9NkWGThVarWr5zcXuesMdXl3XDSlz8SwXuIcg==
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr7727342oiy.178.1633538636692;
        Wed, 06 Oct 2021 09:43:56 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id s29sm4236628otg.60.2021.10.06.09.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:43:56 -0700 (PDT)
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
Subject: [PATCH 11/12] cacheinfo: Allow for >32-bit cache 'id'
Date:   Wed,  6 Oct 2021 11:43:31 -0500
Message-Id: <20211006164332.1981454-12-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006164332.1981454-1-robh@kernel.org>
References: <20211006164332.1981454-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

In preparation to set the cache 'id' based on the CPU h/w ids, allow for
64-bit bit 'id' value. The only case that needs this is arm64, so
unsigned long is sufficient.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/base/cacheinfo.c  | 8 +++++++-
 include/linux/cacheinfo.h | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index dad296229161..66d10bdb863b 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -366,13 +366,19 @@ static ssize_t file_name##_show(struct device *dev,		\
 	return sysfs_emit(buf, "%u\n", this_leaf->object);	\
 }
 
-show_one(id, id);
 show_one(level, level);
 show_one(coherency_line_size, coherency_line_size);
 show_one(number_of_sets, number_of_sets);
 show_one(physical_line_partition, physical_line_partition);
 show_one(ways_of_associativity, ways_of_associativity);
 
+static ssize_t id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct cacheinfo *this_leaf = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", this_leaf->id);
+}
+
 static ssize_t size_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 2f909ed084c6..b2e7f3e40204 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -48,7 +48,7 @@ extern unsigned int coherency_max_size;
  * keeping, the remaining members form the core properties of the cache
  */
 struct cacheinfo {
-	unsigned int id;
+	unsigned long id;
 	enum cache_type type;
 	unsigned int level;
 	unsigned int coherency_line_size;
-- 
2.30.2

