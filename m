Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF89BC7EE22
	for <linux-sh@archiver.kernel.org>; Wed,  3 May 2023 14:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjECOiS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 May 2023 10:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjECOiR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 May 2023 10:38:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6C4EC9
        for <linux-sh@vger.kernel.org>; Wed,  3 May 2023 07:38:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaed87d8bdso29957965ad.3
        for <linux-sh@vger.kernel.org>; Wed, 03 May 2023 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1683124696; x=1685716696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqmgaF6XuhoP3wVySW9wMw/5e4e5ZeEPQvDfp5gqtPc=;
        b=iS606Z5luysqGmnm8LiWHEq33H+J8gFsDpuK0cQnXPDYwlekDNMUT5maEar7AwIbEp
         PWR9gz0TKhZuJ6zPNGznrmHwGe4XYTroBbIzljyh7xvXtnzjb5fRKUHrY8FaqyePK1IW
         wa9MxIKBOr5V4whrygrCEsq8h6hbalIob7riuQ9QPD+gB+Ap3Q6Goln9CqjBPGHG6hgW
         385NRCRWVhZM6BhezJloBCcAPF+CA2rUUrDCEXIlXoOCcwID6usVdUBHwzUkfcKBojOW
         Mva/LMDi6Keq1ROfD6N24Es5HNoq8vwouy+0dh/IuQDZ5DmWy9zn04LigovB1h6cYgYS
         bUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683124696; x=1685716696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqmgaF6XuhoP3wVySW9wMw/5e4e5ZeEPQvDfp5gqtPc=;
        b=grLCt6L93Ev6KxgGuQ2oJDdSQxwxnchNpQjfOXl0oyqRE5NxctXKTbWVGuQZs8ECJ+
         +eDZ35aTi2Ga2zvDu9l9lYpaJ5SzCuG4KNFclDA3n56PUlg7R0buEpL7tlXTRgsBJLCF
         w+PLaAfbscFFe/16qjKjgSvKDUzip/rwo1YhuOyIaw7XLP1ytuk82jMdITKkIuqg0ifZ
         37dJbsAo+VZ98Lt6m1f4kJABbC/kp1081vFkziGIVgXg5zzdqwdCJ6+w8baUtSTEGncX
         AcGv1auxF1Friq8uARH6JSh1gkoyjQUr8l21Bhmz+rtt2K2wGa35o0Dxakl4hmxIZU86
         emzA==
X-Gm-Message-State: AC+VfDyamRxYFGQF2mrrwq9Bf4y1wRE7K/iKyfwuKTTppPVJvgVTkS/h
        a4PtMNsLZ6zX25ewAS4hkIiW6Q==
X-Google-Smtp-Source: ACHHUZ7LKWeDu4mNX/UGZvHWj1REv9YZWjc+UocrEOkZjtIoLd6PzrjIYhy6tzdYnU2wb98xcV7eyg==
X-Received: by 2002:a17:902:edc7:b0:1ab:220a:9068 with SMTP id q7-20020a170902edc700b001ab220a9068mr268982plk.42.1683124696040;
        Wed, 03 May 2023 07:38:16 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm21708371pls.253.2023.05.03.07.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 07:38:15 -0700 (PDT)
Message-ID: <fdcef275-c4ca-5c12-3906-ba32db1386f4@landley.net>
Date:   Wed, 3 May 2023 09:53:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Fixing "int-to-pointer-cast" warning in J2 code
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-sh <linux-sh@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, "D. Jeff Dionne" <jeff@coresemi.io>
References: <eed749a0ec500edf4f70a50578eaa50803fdaf3c.camel@physik.fu-berlin.de>
 <CAMuHMdWOJn97KMBa0YoQo+a7tGDwMTTQ8YPHT7VJ2zJjEYEV0Q@mail.gmail.com>
 <3a42b3b3da5499f1ec1e24f618dd46a75503da16.camel@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <3a42b3b3da5499f1ec1e24f618dd46a75503da16.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 5/3/23 05:50, John Paul Adrian Glaubitz wrote:
>> BTW, "jcore,cache" does not have any DT binding documentation.
> 
> Jeff or Rob should look into this.

I'm looking at Documentation/devicetree/bindings/cache... (yaml files?) but am
not as of yet enlightened. I can poke Jeff in the morning.

Rob
