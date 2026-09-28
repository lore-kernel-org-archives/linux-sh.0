Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07313277C88
	for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567660; cv=none; b=VL9ZSedkclYLcq6Ovc716/orS44WGPE0Buc5b43on3SA1vn3FR97M+qASo04pLw8FacVcKVwR/o4lFxYv6HlUmKwIru8kWQpqPwBw9vhwfwL2K7x3c41XS6A1eH4qEBjEBv/f7uCd6tvtsyKxnex8RjhBY1KQb9IMiaBTaxYlps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567660; c=relaxed/simple;
	bh=7eF32BAwWvHa46hCkMDvszKhaveU1FL/Fi8VoTSqenk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fw8q3n5OlzaNa8KnMhKYtGDpbee5TxktSyzITwhH1gP2EVBV+ub3M00fg0Cq/UEpEvJvHfxCEsbPQp0b1X21271mjyGgNQhhyR6Hd7knl6LKtgeW/RGcxB2pOLBGak3HR5l1Xk8CHaeCRF903ik3l/Tgckxy3tQNHjDrNXW05fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltGbGnUs; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltGbGnUs"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so19698435e9.3
        for <linux-sh@vger.kernel.org>; Sun, 27 Sep 2026 20:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790567657; x=1791172457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5xVcdOiOb9J5e1Z54m87jRi8taiPSd14uPnyeRFY4qQ=;
        b=ltGbGnUsIcIYrnoLDVo15KOqWB0ydJFmGe7kj5SRbVnQQpCWqj0YaPvHugO0UofGzg
         0y5dR3t+QpN1628LK/1QQHaIPM5dytEUkG7asO1sv1ZJ12wt7VTB0nWGV/R+ZBeZob2P
         UTf/WNeMhuOwk9TZLxIV8W0VlOhyvXBo9jFkIHUPxsniOEjvBYVJ7LLZXdNptFOWLp9a
         AgtotddM/0elAAa1c+uivLF/H0bTSzvYyzqO2EXSZP0grTWi14KNoCKcfB0hVc3VjyEy
         NPzH32WVNKl7t8Kf9EcoqFK82jzwVaYzOMycYNuBHcnNQGFtB5WRP/iHuFluGdk6ykke
         cZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790567657; x=1791172457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xVcdOiOb9J5e1Z54m87jRi8taiPSd14uPnyeRFY4qQ=;
        b=CiflDLE/8LNbBcEmBl7FC8W9ShvBY3aPagq6ATW71/Ea8s30YNX1hMiWNlOM5jlU+J
         +/PkAxKu8Fc8CJLxTMj9KEtm338U0RjjnZ08L8LknxYGWRfYZa16PmxtaHjHp/cxq0WP
         DCOp1B4+E0pvuj/ykBI7+gFBv/J8F/q/dn9h9boNEDXHxsrC81uJdOD+0Q33w/Adql1Q
         Ej6HMZA3G0AzmzDMjADp10q3Ud2BzoEmJu8sGW1ceOypEv6SP61Svha/+umQ+s90x62u
         Kek2QKy1sLRzDkm9cZOL2V4VRDGD/hIobTxqTWOzcpzKOmBeFDuyb8QnvH/ClHSmG4yb
         no1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxmh7xGgHWI2kv6jfF4vmSxm4z4D9pjfumzgPlYPN8y/t3GaNxnGzzgVd2gaGwXMmLThQP94eeeKA==@vger.kernel.org
X-Gm-Message-State: AFuF++lpF3CIf4rjnPkazAOgwatuPpAhOnOclfsUyDN45ONAzpe8mZWL
	XWlP5ttlhURcVQZfNMMvj1Re4yuqCOLsYTKrB2Pt/sl0WzDjSxKsNDRK
X-Gm-Gg: AYBFou2JWKJhrbGFSb6c19ugpSx0YxVqRaq/P6+Yamtlgcnfw4lf6fD143vRsCWfVu5
	o91UwOgm46RMgIGHZKh9TbzyBx8A8jt4UPevB/bF5zT6e2w70JINSv5Y5d2eSQ8IgL+TxVwKeYY
	dkenlCVyjXB1CbylLJY1pWlXT55zXw+zvrpgFesvmgPlgsLUbWOi/7QgxWD8JOVdN3uEqyHJpra
	4rlgzIgkMnTBPHtxgRl03lgY3nVtHmkc75EUkqXC09cNXoXAsSY/OB1imrPy7/nvlH4NY4pmf50
	1NSdlBaJUXPWrkI1OytbQgpDbuO/edyLAtjDXr4b8QyrHdPOiWmIyG+opx4acRNvWI9N9G2C6Lp
	rhWExkB2LBesaDPp0SmrEzzKzg6N10m8iqm7Vxr2iplFgqHHd1sK1ClK4SafvFx/heHPfRRp0g9
	/5YIieAu98sVKz63vYYNE40OiAxjDMMVciP8vTXmkiwxB+4Jk6tbAaQUst2EtR7iRVstX3QzrMH
	lmLeIELgdCvbFJ1Gb05l11AP0SBTic8aL2LXI2FC4WhunDKHmmpX/BM9h5EU/QQWQs+ukAnt96Y
	XqiUXmYSEBvpW5pv8QUrqWQQM7eKzjWWLegj5EQoQgRHfBLAh+YQVO0Bc6+F71AAeqE3NzK5TjK
	1fEEIOg==
X-Received: by 2002:a05:600c:4583:b0:49f:d087:6526 with SMTP id 5b1f17b1804b1-49fe670d05bmr227822225e9.34.1790567656854;
        Sun, 27 Sep 2026 20:54:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a007be0761sm6697185e9.3.2026.09.27.20.54.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 20:54:15 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Artur Rojek <contact@artur-rojek.eu>,
	Rich Felker <dalias@libc.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/jcore-aic: Fix lost IPIs on SMP
Date: Mon, 28 Sep 2026 05:54:08 +0200
Message-Id: <20260928035408.25871-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for
non-overlapping affinities"), handle_percpu_devid_irq() only runs an
action whose affinity mask contains the current CPU. Only actions set up
through the percpu_devid request functions have such a mask.

handle_jcore_irq() passes every per-CPU interrupt to
handle_percpu_devid_irq(). The J2 IPI is not a percpu_devid interrupt.
j2_prepare_cpus() requests it with request_irq() and IRQF_PERCPU, so its
action has no affinity mask and cpumask_test_cpu() reads through a NULL
pointer. J2 has no MMU to catch this. The read returns whatever is at
address 0, the action is not found, and IPIs are dropped as spurious
("Spurious percpu IRQ20 on CPU1", printed once).

Pass only percpu_devid interrupts (the PIT) to handle_percpu_devid_irq()
and the other per-CPU interrupts to handle_percpu_irq() again, as before
commit d7e3fd658248f ("irqchip/jcore-aic, clocksource/drivers/jcore: Fix
jcore-pit interrupt request").

Found with a two-CPU J2 model simulated from the J-Core RTL. Without
this change the boot stalls with both CPUs idle shortly after
"smp: Brought up 1 node, 2 CPUs". With it, the boot reaches userspace.

Fixes: bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for non-overlapping affinities")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Notes:
    Tested on a two-CPU J2 model simulated from the J-Core RTL with
    Verilator (J2 CPUs, caches, bus mux and AIC1 from jcore-cpu/jcore-soc),
    kernel v7.3-rc4 j2_defconfig with SMP=y:
    
    - unpatched: "Spurious percpu IRQ20 on CPU1", pending IPI messages are
      never cleared (the message word of CPU1 grows to 0x6), boot stalls
      with both CPUs idle after SMP bring-up
    - patched: IPIs are handled, boot reaches userspace on both CPUs
    
    Not tested on J-Core hardware. Testing on real hardware is welcome.

 drivers/irqchip/irq-jcore-aic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 94c05cf974be8..b4fee02997eee 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -37,8 +37,10 @@ static struct irq_chip jcore_aic;
 
 static void handle_jcore_irq(struct irq_desc *desc)
 {
-	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
+	if (irq_is_percpu_devid(irq_desc_get_irq(desc)))
 		handle_percpu_devid_irq(desc);
+	else if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
+		handle_percpu_irq(desc);
 	else
 		handle_simple_irq(desc);
 }
-- 
2.53.0

