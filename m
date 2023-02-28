Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156CFC64ED6
	for <linux-sh@archiver.kernel.org>; Tue, 28 Feb 2023 10:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjB1Kbm (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 28 Feb 2023 05:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1Kbl (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 28 Feb 2023 05:31:41 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E972AF
        for <linux-sh@vger.kernel.org>; Tue, 28 Feb 2023 02:31:37 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:9202:974e:f0e0:414c])
        by laurent.telenet-ops.be with bizsmtp
        id SaXZ2900G1hKVeJ01aXZmX; Tue, 28 Feb 2023 11:31:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWxGC-00ANGm-Jq;
        Tue, 28 Feb 2023 11:31:33 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pWxGf-00FbNA-3l;
        Tue, 28 Feb 2023 11:31:33 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] kunit: tool: Add support for SH under QEMU
Date:   Tue, 28 Feb 2023 11:31:01 +0100
Message-Id: <cover.1677579750.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

	Hi all,

This patch series adds support to run tests via kunit_tool on the
SuperH-based virtualized r2d platform.  As r2d uses the second serial
port as the console, this needs a small modification of the core
infrastructure.

Thanks for your comments!

Geert Uytterhoeven (2):
  kunit: tool: Add support for overriding the QEMU serial port
  kunit: tool: Add support for SH under QEMU

 tools/testing/kunit/kunit_kernel.py    |  3 ++-
 tools/testing/kunit/qemu_config.py     |  1 +
 tools/testing/kunit/qemu_configs/sh.py | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/kunit/qemu_configs/sh.py

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
