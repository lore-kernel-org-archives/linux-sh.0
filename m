Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163DDC352A1
	for <linux-sh@archiver.kernel.org>; Sat,  3 Dec 2022 05:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLCFDF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 3 Dec 2022 00:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLCFDD (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 3 Dec 2022 00:03:03 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5156464C2
        for <linux-sh@vger.kernel.org>; Fri,  2 Dec 2022 21:03:00 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1445ca00781so1151705fac.1
        for <linux-sh@vger.kernel.org>; Fri, 02 Dec 2022 21:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1Nn0IejF+JMb672bi1DP/LFYsZ9JfhwHbgCMkdibGs=;
        b=A1pDE2FiJh8vVgfncLPd3brOpWbsojBB+ItRkg+yJ12Zs2GmUw8AhZsu0CfVL59kWl
         6L0YSHDeRLG7pC899cWYeg3ZekVLUX7JAvk6ClL05eTwF0wwR2JEgHMVtkjn9jn500H9
         x93liFmY2ZGq7GirK/A4A/U9TWvVRCdn8ZH2+F/2rL04KBXS6matWt/LaRLbUsLiMUOz
         lGfHQjalUXJ05ujK43CiYmDD5IG+N2gKFkTXwgrKoobsCArf3anpgLiiV6G6IZSEraUC
         d58hNApWFkONw0StGNVZgEnV8AEWZg8a8LjmQNuEHnfjL4ohxs0ghTVS6DSURBG8fQMh
         27RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1Nn0IejF+JMb672bi1DP/LFYsZ9JfhwHbgCMkdibGs=;
        b=TPnNUIQZV37m9i8t9N9enPNxd3+TqI81Q1G2cBE5w+FpT5gzTYr6iClpwv/xHTgLsR
         mAiXrDU05T5PHQyrOC27GdZ1dwng8v7gDYght18V8Ul10cY0DNB4xOv2KVaxDUP4a4I5
         CShmMvgFtF/Re5YqhnxLrDS6KmxcI085IcwEtgQg8jV6ZnsnUJVWXeshtjvHUeW1H38M
         dMBqX63H9rZCn4Xf9e67jTF9Jcbb3hEODfBLvbVPYLbB9s5Roppo2KBnYLzQf1W5nwox
         dXuDc9H8uDBNrH1/74BpdbUpzw036xJkHbtMa4NyuU4bhszoShSC4/bD8Lb3QQuIZVJp
         4Jsw==
X-Gm-Message-State: ANoB5pn7gg8zRr1u361/Wu7/Urhp7m0nHOnlDyEDzlGu+VIoTYNzoiXb
        jnyHrXsh9SEv5IuLVkMO0yCNWciIX/vaNX3m
X-Google-Smtp-Source: AA0mqf4WGS3bqhkJlb7VKuH56N1Cq5RlurjOnCOQ3uIlNzzKiGHvUlLk2KU0em3Yfk8ah0eiWAU6Vw==
X-Received: by 2002:a05:6870:5892:b0:132:545b:e4e2 with SMTP id be18-20020a056870589200b00132545be4e2mr31892197oab.9.1670043779714;
        Fri, 02 Dec 2022 21:02:59 -0800 (PST)
Received: from [192.168.86.220] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id o126-20020aca4184000000b003544822f725sm3973331oia.8.2022.12.02.21.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 21:02:59 -0800 (PST)
Message-ID: <2db1f326-3a3e-a311-a434-d06e9710288c@landley.net>
Date:   Fri, 2 Dec 2022 23:13:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] sh/intc: Add missing list_del(&d->list) in
 register_intc_controller
Content-Language: en-US
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, ysato@users.sourceforge.jp,
        dalias@libc.org, lethal@linux-sh.org, damm@igel.co.jp
Cc:     linux-sh@vger.kernel.org
References: <20221125011725.3287607-1-cuigaosheng1@huawei.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20221125011725.3287607-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/24/22 19:17, Gaosheng Cui wrote:
> The list_del(&d->list) should be called in the error handling in
> register_intc_controller(), otherwise, d will be freed, but d->list
> will not be removed from &intc_list, list traversal may cause UAF.
...
> Fix it by adding missing list_del(&d->list) in register_intc_controller.
> 
> Fixes: 2dcec7a988a1 ("sh: intc: set_irq_wake() support")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Acked-by: Rob Landley <rob@landley.net>

Looks right but I haven't got an obvious way to test this. (Do you have a test
case that triggers the error path?)

Rob
