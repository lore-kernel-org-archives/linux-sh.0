Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582925522E;
	Wed, 19 Mar 2025 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376754; cv=none; b=ZgYJFpGkSKBnv6EvAhA0gW8nIBQsyKiCrk9SfIZ2/AU93MZoCmzhzE/OhHqr7vyM9kRiCSaeWU0pkTSdLyRvbNHCvxACNoBxcaD9ITysAds9knVE335iXa5o0ERrhohCnmvT5Te0MuZaSjanr0svdxMRM8Md+ccd65HzQYdzkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376754; c=relaxed/simple;
	bh=5Xh7etPCdWQRnh+9lDIdRBiCYs56zAWYuiuU1OYrZMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfVHa34zVQ6fuN5pHNzDIiksTa4jkYTUQQPpI/81ZLgt8gC3jiixRu72O4uxaKlJST1FY+H97VaWYqgo2Z8YcilasGJxJpY8Gk3JLAXPSnqkaudr99robr9BKvWqzgzwU4jOG46UYQ+ank6fy3JBRSjRBpHhqkbwCvLGeraDBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM+oFrnm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM+oFrnm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFACC4CEEF;
	Wed, 19 Mar 2025 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376753;
	bh=5Xh7etPCdWQRnh+9lDIdRBiCYs56zAWYuiuU1OYrZMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pM+oFrnm5vNszGzXPRsvJh2e4sgCNGnB65JPuUy7oFSjOG737Ai9D4FMHLKbctgYY
	 6ZyuUQ9aNVBoyrlidHfMC7vysupoHj4l/7Hpg1LfXSAcfWTFdbDlMyIpjtBW0E+Dzm
	 YIIGaoIXG9aSU9GgEhReeRSp99odWhFjNKkSLHm2yt81ySbMiTebYG1H/pMkOQ+BL1
	 lRBJ0YAatNOLSJ5VE9jv5DIobc37rTtuVdezEy4RHZJZ3hrEa8vHkfdqetU+w98A4V
	 5YAD5CnraWc2BLMH3SdjU6ofLB5+WIYTA+dGXWtjbuwpIlLBNT9KKrlBVXca11gwtM
	 LiqclYJ5buosQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Subject: [PATCH v2 33/57] irqdomain: sh: Switch to irq_domain_create_*()
Date: Wed, 19 Mar 2025 10:29:26 +0100
Message-ID: <20250319092951.37667-34-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/boards/mach-se/7343/irq.c  | 5 +++--
 arch/sh/boards/mach-se/7722/irq.c  | 2 +-
 arch/sh/boards/mach-x3proto/gpio.c | 2 +-
 drivers/sh/intc/irqdomain.c        | 5 ++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index f9f3b14f70d5..8241bdedcc82 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -47,8 +47,9 @@ static void __init se7343_domain_init(void)
 {
 	int i;
 
-	se7343_irq_domain = irq_domain_add_linear(NULL, SE7343_FPGA_IRQ_NR,
-						  &irq_domain_simple_ops, NULL);
+	se7343_irq_domain = irq_domain_create_linear(NULL, SE7343_FPGA_IRQ_NR,
+						     &irq_domain_simple_ops,
+						     NULL);
 	if (unlikely(!se7343_irq_domain)) {
 		printk("Failed to get IRQ domain\n");
 		return;
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index efa96edd47dc..9a460a81907f 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -46,7 +46,7 @@ static void __init se7722_domain_init(void)
 {
 	int i;
 
-	se7722_irq_domain = irq_domain_add_linear(NULL, SE7722_FPGA_IRQ_NR,
+	se7722_irq_domain = irq_domain_create_linear(NULL, SE7722_FPGA_IRQ_NR,
 						  &irq_domain_simple_ops, NULL);
 	if (unlikely(!se7722_irq_domain)) {
 		printk("Failed to get IRQ domain\n");
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index f82d3a6a844a..c13d51b29702 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -108,7 +108,7 @@ int __init x3proto_gpio_setup(void)
 	if (unlikely(ret))
 		goto err_gpio;
 
-	x3proto_irq_domain = irq_domain_add_linear(NULL, NR_BASEBOARD_GPIOS,
+	x3proto_irq_domain = irq_domain_create_linear(NULL, NR_BASEBOARD_GPIOS,
 						   &x3proto_gpio_irq_ops, NULL);
 	if (unlikely(!x3proto_irq_domain))
 		goto err_irq;
diff --git a/drivers/sh/intc/irqdomain.c b/drivers/sh/intc/irqdomain.c
index 3968f1c3c5c3..ed7a570ffdf2 100644
--- a/drivers/sh/intc/irqdomain.c
+++ b/drivers/sh/intc/irqdomain.c
@@ -59,10 +59,9 @@ void __init intc_irq_domain_init(struct intc_desc_int *d,
 	 * tree penalty for linear cases with non-zero hwirq bases.
 	 */
 	if (irq_base == 0 && irq_end == (irq_base + hw->nr_vectors - 1))
-		d->domain = irq_domain_add_linear(NULL, hw->nr_vectors,
-						  &intc_evt_ops, NULL);
+		d->domain = irq_domain_create_linear(NULL, hw->nr_vectors, &intc_evt_ops, NULL);
 	else
-		d->domain = irq_domain_add_tree(NULL, &intc_evt_ops, NULL);
+		d->domain = irq_domain_create_tree(NULL, &intc_evt_ops, NULL);
 
 	BUG_ON(!d->domain);
 }
-- 
2.49.0

