Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09658C2D0E4
	for <linux-sh@archiver.kernel.org>; Thu, 19 Nov 2020 10:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F958246EE
	for <linux-sh@archiver.kernel.org>; Thu, 19 Nov 2020 10:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="y3EZunU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKSKrg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKSKrg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Nov 2020 05:47:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC72C0613CF
        for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2020 02:47:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y22so2725517plr.6
        for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2020 02:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M2ATg7i8d9yISnkdOSJ04PkdpomXVhioWoON2UYE9Rk=;
        b=y3EZunU1Zk6z/5Rsf13mMV59VDd6BPejMpEuGobU/Ck2PGPHRlPwinJua/wbEmtHqe
         uonRNiQ9G318OHeHWga+sXfm9lM6TZs9pGJPNmhvXhszwom9Mzp9Nkofv1Cu5Fov7lOp
         3cdpmHQc/93Z2o/xMFvHeAhtrfHrztBzzT7N+YzjMe4+pgA2Nxm1L0nade17vhDkCSgl
         pxvtj0rhpsBGk04Wf2/nvk9pdvMTO0zoU/WJ0QqZV8KH4lYHrnO3XHkwFxJx0l150INs
         oDb8XX3pVGxoeDB7PTd4fQ89ULsucSQHQglX2/FL7V6hxy9reGjge3H2q6GeEQAD7/Fh
         0GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M2ATg7i8d9yISnkdOSJ04PkdpomXVhioWoON2UYE9Rk=;
        b=GmR/15dA4meiWfskH+f00YeSItVQOKG0rRqJGHT+pEzloarmF9yzaqjlwphDoSEc6G
         zwmlNPVrpF+mCO8kbZNjB035ZBa/K3Ku/LpcuVir0Y9WXvm5VJSLkU5wyG3AjZEXyNun
         v0oRU+QEqGeqP8eRJZxCZEt2/HHAKFboBUr9BcyZEAwNvU//0UK2/0392vH+XECiY9zV
         ko5gwD6ogbhmJOiCTUN5qsTv4OTUXrrgMo3qAE0zqEmmy/hdv7OS9jZtc7+JG2n/Ozop
         Mdh6fKcU0b2Q6eSJRvs7bvyJIyD+Jh3iZjL0qT90JQc/VzmVGz9FbTJHQxtuspkisVHX
         +Edw==
X-Gm-Message-State: AOAM531vwxx0X3VLq0aNQK7z5R6sKBtU2bTC1+TWFPll5EisWJMkMbBI
        W9kBMD1rHo73ueNqPfSjSd4xKUiRxzd6dynz
X-Google-Smtp-Source: ABdhPJzL/lHdLrSUjoXzQSXA4HvF99y/G77wISMHdSDMvY5HaGJ1OCCN242Y/nD0m0rld+22MS6xDw==
X-Received: by 2002:a17:902:9f89:b029:d8:e29f:b78c with SMTP id g9-20020a1709029f89b02900d8e29fb78cmr8427151plq.24.1605782853557;
        Thu, 19 Nov 2020 02:47:33 -0800 (PST)
Received: from [192.168.11.16] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id t5sm26151348pgt.15.2020.11.19.02.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 02:47:32 -0800 (PST)
Subject: Re: Kernel crash when syncing to usb-storage
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>
References: <d89a074e-c0ed-5d8b-a58e-ce3d420f579e@physik.fu-berlin.de>
 <3a807d90-44c6-7c97-ae1d-89a3f3414baf@landley.net>
 <0133c4fc-81a9-7d8a-8aee-3756bd6d34a2@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <ede2a799-ce5f-4331-63f8-51f6a17427d7@landley.net>
Date:   Thu, 19 Nov 2020 04:58:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0133c4fc-81a9-7d8a-8aee-3756bd6d34a2@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/18/20 4:09 AM, John Paul Adrian Glaubitz wrote:
> Hi Rob!
> 
> On 11/18/20 11:11 AM, Rob Landley wrote:
>>> Recently, I have started to see crashes when I try to sync a FAT filesystem
>>> on a USB pen drive. The crash is reproducible and seems to have been introduced
>>> in the 5.10 development cycle. I have not bisected the issue yet.
>>
>> Which board is this on? (Kernel config?)
> 
> SH-7785LCR, I'm attaching the kernel configuration for 5.9. I don't have the one
> for 5.10 at hand right now, but I used the same configuration for 5.9 and 5.10.
> 
>> Is it immediate or a ways into the backup?
> 
> It happens the moment the kernel tries to write the data to the USB drive.

Smells like an incorrectly initialized field in the interrupt state. Let's see...

# IRQ chip support
#
# end of IRQ chip support

# Interrupt controller options
#
CONFIG_INTC_USERIMASK=y
# CONFIG_INTC_MAPPING_DEBUG is not set
# end of SuperH / SH-Mobile Driver Options
# end of Kernel features

Very helpful.

CONFIG_IRQ_FORCED_THREADING=y
CONFIG_IRQ_WORK=y

I wonder what those do? I don't remember either...

> 5.9 is not affected, so it must be a regression with 5.10. I will bisect later
> this week.

There are many irq patches to choose from. And the DMA patches have potential
IRQ impact too (CONFIG_SH_DMA_IRQ_MULTI=y).

>> The stack trace says the idle tasks is handling an interrupt and crashing in the
>> interrupt controller code? Let's see...
>>
>> git log --no-merges v5.9..master arch/sh drivers/irqchip drivers/sh drivers/dma/sh
>>
>> This may not be a fat OR usb issue, there were some plumbing changes recently in
>> IRQ controllers and such, ala b388bdf2bac7 and f9ac7bbd6e45 and a7480c5d725c and
>> a00e85b581fd and 57733e009f0c and...
> 
> I will report back once I have found the culprit. I haven't had the time for bisecting
> yet.

Thanks.

I'm in Tokyo this month far _far_ away from my little blue board, and it's been
long enough since I've re-kerneled that I don't actually remember how anyway. (I
should poke you for a walkthrough over christmas...)

> Adrian
Rob
