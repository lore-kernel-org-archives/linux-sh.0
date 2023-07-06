Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACECEB64D9
	for <linux-sh@archiver.kernel.org>; Thu,  6 Jul 2023 15:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGFPR0 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 6 Jul 2023 11:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFPRZ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 6 Jul 2023 11:17:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE64C173F;
        Thu,  6 Jul 2023 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=h7r9TfPQc3eLtstTBRhHVXgqEs3WPGyFsX8wAUte2AI=; b=b2bso8W40HKnZb9jOzWxH9qmgF
        yboDtFNU4H1GqQcqGFi1nxtKbaEEaGkS3qWOmN41k1YxJ8E9DyJt/SykuBj8iTbrZBog7uGn2EWkS
        939wg3pbvB7+ccqwtmqTmkItEJ6n5UMFZ63DfLs/x8uekyyMoEUxTFlxu/bMPhIBV/VcyEKNHltln
        haB8OWvPuwZ16tz/HoFw8RUDf/M5YZXMNMeThzPuLspcnti/r28VzHqg6q9/G8e1rcpCKbqeCN7oR
        DJE7oBeUnIn+YhMNkRRA3yJQi9XpeZsdKz49rpoCVIm+xnyky4rRq22HEttVP69Codlm0or5mk1J9
        xi2v2zOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQiw-001yxB-01;
        Thu, 06 Jul 2023 15:16:50 +0000
Date:   Thu, 6 Jul 2023 08:16:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sh updates for v6.5
Message-ID: <ZKba4SLzjjhHgOEs@infradead.org>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi John,

thanks for taking up the sh maintainership!

Any chance you could do an inventoy on which arch/sh/ platforms are
currently working and maintained and which are just bitrot?

sh still has a lot of platform specific code that feels іt is rotting,
but some of that might just have been due to the lack of active
maintainance.

Once platform that I'm particulary interested in is dreamcast, which has
a rather oddball block driver (gdrom) and some very odd interaction with
the dma-mapping code.

