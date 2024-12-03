Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FD1F8AD4
	for <linux-sh@vger.kernel.org>; Tue,  3 Dec 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243436; cv=none; b=gCh3EoQqpe6mAcrwaoCkazZ5RMCce4sG5y/auF6J/GtrTxPHeozCSx5usT9GKI2UX97/v6bs9GBjoOLiRdyNG0BYyKC3owzu9U4CnXAgscMgD3jJ2bwuGSx/SXWuvpTdv8eqIaewbpAGxYfMGEjCh7fopnROdmQailQj5hnzdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243436; c=relaxed/simple;
	bh=efEEoBOf2SwuQHLH5bISaYZP/7dimPAqaCuzSBuWbsA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKpG6/fMSoRPGQ1iUNSjEXLN8vtBOQXXi9IhR/4VZfOp9fRnEpPiFwMKRMMuCiOPS2lQSdhJiIF3+ILaaeXzlF0vWBy1QeyFfGJWBHIuU8eExm6WFkkp3TD2eoUcr+Wn6EU9jplDdMiXXjrvZ7K2HMMDd1b3qP5xubVxJe5C0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:829d:a1e7:5b32:5d8e])
	by andre.telenet-ops.be with cmsmtp
	id kGWX2D0053sLyzB01GWXK5; Tue, 03 Dec 2024 17:30:31 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tIVnD-000DVo-33;
	Tue, 03 Dec 2024 17:30:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tIVnC-00AXTD-W2;
	Tue, 03 Dec 2024 17:30:30 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Use plain struct copy in early_console_setup()
Date: Tue,  3 Dec 2024 17:30:29 +0100
Message-Id: <e097e5c11afe5bd4c01135779c9a40e707ef6374.1733243287.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using memcpy() prevents the compiler from doing any checking on the
types of the passed pointer parameters.  Copy the structure using struct
assignment instead, to increase type-safety.

No change in generated code on all relevant architectures
(arm/arm64/riscv/sh).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index df523c7444230836..1ed13ce2c2952547 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3542,7 +3542,7 @@ static int __init early_console_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->port.type = type;
-	memcpy(&sci_ports[0].port, &device->port, sizeof(struct uart_port));
+	sci_ports[0].port = device->port;
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
-- 
2.34.1

