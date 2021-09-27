Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9AC433EF
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 08:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8861165
	for <linux-sh@archiver.kernel.org>; Mon, 27 Sep 2021 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhI0IM5 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:12:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12842 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhI0IM4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 27 Sep 2021 04:12:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HHwFr6XVnz8ypH;
        Mon, 27 Sep 2021 16:06:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 16:11:17 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 27 Sep 2021 16:11:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/3] Cleanup MAY_HAVE_SPARSE_IRQ
Date:   Mon, 27 Sep 2021 16:13:59 +0800
Message-ID: <20210927081402.191717-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Most ARCHs support SPARSE_IRQ, and MAY_HAVE_SPARSE_IRQ is useless, and
only sh and csky select it, but the could use SPARSE_IRQ too, let's
kill MAY_HAVE_SPARSE_IRQ, also cleanup the kernel/irq/Kconfig a little.

Kefeng Wang (3):
  sh: Cleanup about SPARSE_IRQ
  csky: Use SPARSE_IRQ
  genirq: Cleanup Kconfig

 arch/csky/Kconfig         |  2 +-
 arch/sh/Kconfig           |  1 -
 arch/sh/include/asm/irq.h |  9 -------
 kernel/irq/Kconfig        | 50 ++++++++++++++++-----------------------
 4 files changed, 21 insertions(+), 41 deletions(-)

-- 
2.26.2

