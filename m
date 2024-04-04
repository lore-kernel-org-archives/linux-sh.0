Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD3370CD7
	for <linux-sh@vger.kernel.org>; Thu,  4 Apr 2024 05:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206874; cv=none; b=pq8DsQbQIJzjXYpnpqJE1P/UcwaxGibQAObaHoNlLRyohUvfwExTsIhaueKAOi8AgkL/u4ZsRteiB+x6YzuVYDyAr/mY4dSOjq25GjArilPCWwUC6ybQo5yHIWENO5Qjj+Ln0yyxy+IVm1iVaQZQAw/5VCQDOfJuiRnuhz0LAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206874; c=relaxed/simple;
	bh=17MFAO8Mxxt2rDxlaE4c9eYzawZE+YNTNwC92zwVHm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nzCPva4f92HnY7QZtwdTXLbgPIEVTHH8JcCEXTr7jA/vrxjPm4M88O1nRxJ/0OMLkKqVClCGai+kZQvQpbll/89zLm4P4OSep9A9QU4lmnakZfgOsCk/VFOm5OX7gRoHkNffZZ1A7ojMk69engEuzmU3PYhe7AVCeOiI41V2cwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id CA3961C016F;
	Thu,  4 Apr 2024 14:01:12 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [DO NOT MERGE v7 20/36] dt-bindings: serial: renesas,scif: Add scif-sh7751.
Date: Thu,  4 Apr 2024 13:59:56 +0900
Message-Id: <31ee1a65b3636f8e496eb1bc84d4e35bcf979919.1712041249.git.ysato@users.sourceforge.jp>
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

Add Renesas SH7751 SCIF.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 4610a5bd580c..590f88e2ced9 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - renesas,scif-r7s72100     # RZ/A1H
+              - renesas,scif-sh7751       # SH7751
           - const: renesas,scif           # generic SCIF compatible UART
 
       - items:
-- 
2.39.2

