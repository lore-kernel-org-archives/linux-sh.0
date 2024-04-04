Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA7574C1B
	for <linux-sh@vger.kernel.org>; Thu,  4 Apr 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206883; cv=none; b=Yk6a927x/CGhT/QXov+Fn5bCdVh/gisJFi0ZNa6arq/epyXReg5c8WvWqQODl05LBDWgtXNxECruVGePtjk8od4IMhLl54l4U78Yp43EAUG11iv2zykDSIxlwZoLHmOMam44jDG6P/RSObVnM/lPRSb4s4JubrUuD0H9uity8fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206883; c=relaxed/simple;
	bh=yT32dw2MA1l/u3K8YlVvTRqYbgKjGsuCai8CvdMaens=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mctPi8MqTfuHblF1V1Hgngnkj8zK3l0ph3C1QO0a+/6AKkf1Ih6DCAunpGb3IqStD4vBNo0kX7xy+u4NhYpKNN1lhBtAZk9jqNMzhIVagu3GOCF7ccXmD1jwmfA2MvpDTGzYQlCSuJ+SBxvYyhC7EtN9vB+ehRijkjduyx4jeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 9CDD91C0DCB;
	Thu,  4 Apr 2024 14:01:20 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [DO NOT MERGE v7 24/36] dt-binding: sh: cpus: Add SH CPUs json-schema
Date: Thu,  4 Apr 2024 14:00:04 +0900
Message-Id: <a0d5a48ff2dd9e07942a16b538b6a6a03aa8ec06.1712041249.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712041249.git.ysato@users.sourceforge.jp>
References: <cover.1712041249.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas SH series and compatible ISA CPUs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/sh/cpus.yaml          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sh/cpus.yaml

diff --git a/Documentation/devicetree/bindings/sh/cpus.yaml b/Documentation/devicetree/bindings/sh/cpus.yaml
new file mode 100644
index 000000000000..43e079b8753d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sh/cpus.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sh/cpus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas SuperH CPUs
+
+maintainers:
+  - Yoshinori Sato <ysato@users.sourceforge.jp>
+
+description: |+
+  Definition of CPU core with Renesas SuperH and compatible instruction set.
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+          - enum:
+              - renesas,sh2a
+              - renesas,sh3
+              - renesas,sh4
+              - renesas,sh4a
+              - jcore,j2
+          - const: renesas,sh2
+      - const: renesas,sh2
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  device_type: true
+
+required:
+  - compatible
+  - reg
+  - device_type
+
+
+examples:
+  - |
+    #include <dt-bindings/clock/sh7750-cpg.h>
+    cpus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cpu: cpu@0 {
+            compatible = "renesas,sh4", "renesas,sh2";
+            device_type = "cpu";
+            reg = <0>;
+            clocks = <&cpg SH7750_CPG_ICK>;
+            clock-names = "ick";
+            icache-size = <16384>;
+            icache-line-size = <32>;
+            dcache-size = <32768>;
+            dcache-line-size = <32>;
+        };
+    };
+...
-- 
2.39.2

