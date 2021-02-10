Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29330C433E0
	for <linux-sh@archiver.kernel.org>; Wed, 10 Feb 2021 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE66F64E87
	for <linux-sh@archiver.kernel.org>; Wed, 10 Feb 2021 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBJPGh (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 10 Feb 2021 10:06:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:14915 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231559AbhBJPGg (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Wed, 10 Feb 2021 10:06:36 -0500
IronPort-SDR: OjUBjc1I7rxLmkBhCJLhNlYmL8TrZFAX8XF/PA1AZ+t7EdyeyKWE7SRxhvqWK/al/lCN45sWdI
 UzTFkvIHIO2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="178576650"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="178576650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 07:05:54 -0800
IronPort-SDR: rvUTR4zO9Ac9wFCiTUQocCV13qof0FpfmL9rDz62UdS09OMAz7hT//IDYUybY1Dv4FczTQrnYI
 RGo8Szcvv+iA==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="396736359"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 07:05:52 -0800
From:   Rong Chen <rong.a.chen@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] scripts/recordmcount.pl: support big endian for ARCH sh
Date:   Wed, 10 Feb 2021 23:04:35 +0800
Message-Id: <20210210150435.2171567-1-rong.a.chen@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <202101261118.GbbYSlHu-lkp@intel.com>
References: <202101261118.GbbYSlHu-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The kernel test robot reported the following issue:
    CC [M]  drivers/soc/litex/litex_soc_ctrl.o
  sh4-linux-objcopy: Unable to change endianness of input file(s)
  sh4-linux-ld: cannot find drivers/soc/litex/.tmp_gl_litex_soc_ctrl.o: No such file or directory
  sh4-linux-objcopy: 'drivers/soc/litex/.tmp_mx_litex_soc_ctrl.o': No such file

The problem is that the format of input file is elf32-shbig-linux,
but sh4-linux-objcopy wants to output a file which format is elf32-sh-linux:

  $ sh4-linux-objdump -d drivers/soc/litex/litex_soc_ctrl.o | grep format
  drivers/soc/litex/litex_soc_ctrl.o:     file format elf32-shbig-linux

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-mm/202101261118.GbbYSlHu-lkp@intel.com
Signed-off-by: Rong Chen <rong.a.chen@intel.com>
---
 scripts/recordmcount.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 56c801502b9a..867860ea57da 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -265,7 +265,11 @@ if ($arch eq "x86_64") {
 
     # force flags for this arch
     $ld .= " -m shlelf_linux";
-    $objcopy .= " -O elf32-sh-linux";
+    if ($endian eq "big") {
+        $objcopy .= " -O elf32-shbig-linux";
+    } else {
+        $objcopy .= " -O elf32-sh-linux";
+    }
 
 } elsif ($arch eq "powerpc") {
     my $ldemulation;
-- 
2.20.1

