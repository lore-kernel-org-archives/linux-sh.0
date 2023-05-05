Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE41C77B75
	for <linux-sh@archiver.kernel.org>; Fri,  5 May 2023 07:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjEEHPI (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 5 May 2023 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEEHPF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 5 May 2023 03:15:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6879414922
        for <linux-sh@vger.kernel.org>; Fri,  5 May 2023 00:15:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6439b410679so581410b3a.0
        for <linux-sh@vger.kernel.org>; Fri, 05 May 2023 00:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1683270904; x=1685862904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxqJcIXvhMORECzMcJaMrx244bWaRG+/vAO3MCrAr3s=;
        b=hV+MFpohuUXYauOYRYhbRaK/H+yFCvjn3wrrxLeBkK85InJEW64tFBBpwhz3eV37ep
         qvTZwXRVO6/3vN6YT5/zXMifiXeHKYfj8fr+tY4j8C5j8xu6/J/aBYA0GatF5nagMZsU
         Lqzoqb267NvMCNVuj6ckPDo29yAEMni7lYupfiTwDlMFQoEJHdOBybMDvY2MzglaqJ22
         AQ5VqiQ2OWIIdw63mR6AoU+X+mGpMiLIe98Brcjh9/r1qvZSgyEmWZkZ60fEwnXDyDdg
         2eDU0KkYyytwluF4aOFYPmU16QBQ1BQ2NkamlhILJ0MYAdh9Ii1joj6FbrcHkEQA6k9r
         jzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270904; x=1685862904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxqJcIXvhMORECzMcJaMrx244bWaRG+/vAO3MCrAr3s=;
        b=DqZEMibJ3LdnBoIhBosOM8o8HjpHkGNvERGAPX17hFKC9oQ2i7JjQBS9R6KZDw6N/Z
         EQSbCloJ4cpYLkUIxqIFsojN6S+0MFZVkQcuPU0DMRrEeiiy2l4nNk4uPW7cAKe2eV1Y
         qTG1L/kAzyYZPURzVds736I/as/587hvL6FSH/wb76SVYgZH+5EVEvSMYXKZVq28MVdJ
         CSjrFpZtcOwY9hNxgZM1QYCT8Y9P/QDyBFV8eMtut2Rg2Vd+mu+P59sDEADKrJmc9Gj7
         ZRghGgRMwdJAhZ1ScahEAuXXA20X1MQdUjl6e1oY2lATZ5r6XFgWr81qqURMmlhWgh4H
         uhfA==
X-Gm-Message-State: AC+VfDyYJodQ73rSO9Mq9Z+UbSOAAP4CIn13Bu1Wu3ufE+DZQdURJzCG
        7Ru/IsDxq/cjxrooWenqICVeCA==
X-Google-Smtp-Source: ACHHUZ6DR2XrMAEbJhlwPABhXMOpqR2Gt3GgONFwZj6rLdG0sTrrAoz7ODHnWmwzO1Xko9lmnUD3vw==
X-Received: by 2002:a17:903:18d:b0:1a9:80a0:47dc with SMTP id z13-20020a170903018d00b001a980a047dcmr593627plg.3.1683270903926;
        Fri, 05 May 2023 00:15:03 -0700 (PDT)
Received: from [192.168.11.19] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.gmail.com with ESMTPSA id c7-20020a170903234700b001aaecc0b6ffsm917827plh.160.2023.05.05.00.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:15:03 -0700 (PDT)
Message-ID: <7f6236cf-ef48-5d54-7847-fa74cb3eb2b9@landley.net>
Date:   Fri, 5 May 2023 02:30:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] sh: j2: Use ioremap() to translate device tree address
 into kernel memory
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230503125746.331835-1-glaubitz@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20230503125746.331835-1-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 5/3/23 07:57, John Paul Adrian Glaubitz wrote:
> Addresses the following warning when building j2_defconfig:

Tested-by: Rob Landley <rob@landley.net>

Rob
