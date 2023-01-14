Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDBC3DA78
	for <linux-sh@archiver.kernel.org>; Sat, 14 Jan 2023 23:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjANXdx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Jan 2023 18:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjANXdw (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Jan 2023 18:33:52 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0FD86BA
        for <linux-sh@vger.kernel.org>; Sat, 14 Jan 2023 15:33:50 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id r1-20020a4a3701000000b004f2b4f8200eso599121oor.7
        for <linux-sh@vger.kernel.org>; Sat, 14 Jan 2023 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVa7tSg34V82zc9uv/ppXuqPU5ZR9rqfF3JA312hlp4=;
        b=0nOK1+r/a//WJZYFo1KepaU9LsjzllNZfU6wFeBZeH2Iz9q234acLX0cO62/wpFrZn
         W3Pz1fIHC5ndFaS/pnzQdU9xQbpYbmlS5sfMr/E/34MBRgfE+q0Tihq/O/Ul9mUtOKDr
         hLp1iWNpB6cAky0tXXxbAP7MOBkB0uahINERuAST32jEVSvzkTk2LOawn403UPcqjvB8
         YaaZDBL6btMGnrDAlLSv6ZlXTigaPHh+b9wyYFRzTvlBXeYe1JPvEfoqK9hze81Ax108
         oylQHqb26hucx+iiK59iUAdTZcr1pS2smwOtXHgYCkBOa3Ljpudgdb4GsfBCSLaqRNT1
         AkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVa7tSg34V82zc9uv/ppXuqPU5ZR9rqfF3JA312hlp4=;
        b=q64gBZzHlbTRv5MD4JBBdZWWr5g2PlVZ4D6k51+3n/gpqa0WjhcAnVtOAALmkZzKZI
         o9FOWGo08H0DZFw7zx1RMUCYOEd0fpF9dzhpWBbsSJlimDijA9VJ3o5fa5CZwQiIFuX5
         RI5fK+s/It8cHaDoHiuV+Bzw5PO3tG8sRgGDLhwO1jcUpk5YW5VnYye/OdndXaTTQhWT
         e45IC/RPdCHsn9dzQFzKnRF0KkNwmsDggP1OdmUfFpRbfqsJR6rGIryqgwlW+FEWy0PZ
         1emdE6EBQrR+JdzSjlGpfNUzyyBv9bu/eIfrHekrq+SEOAo3d32mUktYs9P+rOs1EsFE
         qWrA==
X-Gm-Message-State: AFqh2krFdQzBdcBqZv+UtjTIPbdvmO871Huj2nllh3z8JiZ+MM/KE2Tl
        LhvaZCLT0O0mpvMwoqLfwQEU39LpO5xjY8SmAow=
X-Google-Smtp-Source: AMrXdXs/Kns4HT9KFpy3hijA+mJsCvDdjv2Pt3sAGW1afqj/X9X0Q2SN6FycBE9luLkcBBrJY0zLpg==
X-Received: by 2002:a4a:a845:0:b0:4a3:bcce:5b56 with SMTP id p5-20020a4aa845000000b004a3bcce5b56mr41919914oom.3.1673739229264;
        Sat, 14 Jan 2023 15:33:49 -0800 (PST)
Received: from [192.168.86.224] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id g31-20020a4a8962000000b004a8eb1d8f1bsm6770438ooi.39.2023.01.14.15.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 15:33:48 -0800 (PST)
Message-ID: <15573018-32df-b67f-fc37-44da0ed7afde@landley.net>
Date:   Sat, 14 Jan 2023 17:45:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <961f3b42-1522-79d5-7012-1533b568696f@omp.ru>
 <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/13/23 12:38, John Paul Adrian Glaubitz wrote:
>>> The patch is against Linus Torvalds' 'linux.git' repo.
>> 
>>   So, this patch hasn't been merged... may I ask why? :-(
> 
> The SH maintainers have been MIA which is why the other maintainers want to kill the architecture again.

To clarify: Sato-san was only ever assisting Rich, as in promising to answer
questions when Rich didn't understand something. (That may not have been
represented in MAINTAINERS but that was what Sato-san agreed to when we all had
lunch together in tokyo however many years ago that was.)

> I’m seriously considering adopting the architecture.
> 
> Not sure whether Linus would grant that though.

I'll happily endorse you for maintainer if that would help.

Rob
