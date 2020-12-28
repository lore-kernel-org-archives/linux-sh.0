Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2564C4160E
	for <linux-sh@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCDA2222A
	for <linux-sh@archiver.kernel.org>; Mon, 28 Dec 2020 23:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgL1Wzz (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:50709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgL1VhF (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 28 Dec 2020 16:37:05 -0500
IronPort-SDR: jo512ZCnDZ9xb6+5c26R7TfOUlKZk7uSGIi0ATQkxttT5cQaFVrKtTcrHzT/qYDvFuXAiI5QCW
 rBhtMyZl8TJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="261177448"
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="261177448"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 13:35:16 -0800
IronPort-SDR: LHCwligdvZvDukXYioMH+IcDW3RANvzTZZtM4vvYDMbvzJnmuA/nEvou7Utxz0hJPp2LEqNy9b
 catKDDb2KpRw==
X-IronPort-AV: E=Sophos;i="5.78,456,1599548400"; 
   d="scan'208";a="418937996"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 13:35:14 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ku0Bb-000I7a-RQ; Mon, 28 Dec 2020 23:36:15 +0200
Date:   Mon, 28 Dec 2020 23:36:15 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Landley <rob@landley.net>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v1] sh: Drop ARCH_NR_GPIOS definition
Message-ID: <20201228213615.GF4077@smile.fi.intel.com>
References: <20201012154050.68039-1-andriy.shevchenko@linux.intel.com>
 <20201109121333.GC4077@smile.fi.intel.com>
 <10b4dc8e-db87-3f78-3ab7-e08469b9fe55@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b4dc8e-db87-3f78-3ab7-e08469b9fe55@landley.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, Nov 11, 2020 at 10:45:38AM -0600, Rob Landley wrote:
> On 11/9/20 6:13 AM, Andy Shevchenko wrote:
> > On Mon, Oct 12, 2020 at 06:40:50PM +0300, Andy Shevchenko wrote:
> >> The default by generic header is the same, hence drop unnecessary definition.
> > 
> > Any comment on this?
> 
> Acked-by: Rob Landley <rob@landley.net>

Thanks!

> It's in the stack I forwarded to Rich to look at this weekend.

Unfortunately I still do not see this in the latest Linux Next.

-- 
With Best Regards,
Andy Shevchenko


