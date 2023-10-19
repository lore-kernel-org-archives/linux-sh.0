Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A58CDB482
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 09:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345089AbjJSJqz (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345116AbjJSJqy (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 05:46:54 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EADC192
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 02:46:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2008:f423:365a:a88b])
        by michel.telenet-ops.be with bizsmtp
        id zlml2A00J1ooZrg06lmlMP; Thu, 19 Oct 2023 11:46:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qtPc0-006w31-Vm;
        Thu, 19 Oct 2023 11:46:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qtPc5-00D4Zs-7l;
        Thu, 19 Oct 2023 11:46:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] sh: Revive BIOS earlyprintk support
Date:   Thu, 19 Oct 2023 11:46:42 +0200
Message-Id: <cover.1697708489.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

	Hi all,

SuperH BIOS earlyprintk support was accidently disabled.
This series revives it, and records its existence in the documentation.

This was tested on landisk using "earlyprintk=bios" and
"earlyprintk=bios,keep".

Thanks for your comments!

Geert Uytterhoeven (2):
  sh: bios: Revive earlyprintk support
  Documentation: kernel-parameters: Add earlyprintk=bios on SH

 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/sh/Kconfig.debug                           | 11 +++++++++++
 2 files changed, 14 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
