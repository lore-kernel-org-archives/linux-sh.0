Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06061C77B75
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 01:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDRB6Y (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 17 Apr 2023 21:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDRB6X (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 17 Apr 2023 21:58:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B32729F
        for <linux-sh@vger.kernel.org>; Mon, 17 Apr 2023 18:57:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a6bc48aec8so3560515ad.2
        for <linux-sh@vger.kernel.org>; Mon, 17 Apr 2023 18:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1681783069; x=1684375069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7vLZY5J50FSt8lwsCIHqb0KqBwYt8YdqEgV1/N0h/I=;
        b=NOiNaHH5RvWGgDQE3cwC4NK+sGVh4LMa60CHcMcMk0Ns8/Yq5MGld5dWUjwTse7vyl
         sKC5+TdqTJ0g1DA3AJel0DSxVVoIfHlh6fzn60kvCJygfZLA3ZNhsNlH90HskcfW8wyr
         aEM0bRz+roJWmD5kJK1PECX7UrfFX9MGO6zUqJiSiv6N3eBLNsftiuRiFL/zWvI75fC+
         oZ7uEWVRwepxdfHNbdJIMcfw1NY97WRjW4XrMM06UeI+bfDM4s9VuKIC+wiCKVhur8qy
         qgcsF5dR0mHZLPLlOBV3tsbo+zGRrlytO+pk1VNiCHWtagqs7/gi0BKWFu2SiZdVeUK9
         tu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681783069; x=1684375069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7vLZY5J50FSt8lwsCIHqb0KqBwYt8YdqEgV1/N0h/I=;
        b=Arh+Xuw9LEeMf1CS4dGO12gcmma1hbGKvTrYZug/g0/zHTHePsE4PM5QisaoPX3QSB
         5jqCIf1KttYNmeUatIfRLjV5JdxRD3kRmKp1qsPLYdXHuYhgYQ9xQXfifhDJoM600UCs
         YFxtjVKLE3dLtK+G2352yTYUc3EzcNV132AtaeRvbnf3oyKazY14GxIMMWFKz9phLVV0
         rUAEjQb572fnsOsuyKTcofJ+s+ZhsME7hNmtcXV/y4M61y7QUf7aBUFMGxqZsZZdKcLt
         u29wHYG6NZafV6P8Wq3XsfSBXQqtDQZTSUXm8U7v2UUNpQRhET/p4Nrw4M2ipBXD5NrL
         FCVQ==
X-Gm-Message-State: AAQBX9eghPRkwVe68x+42QkjnX0HzEWZj62kBJ6DwN4EUc2HKGjirQEC
        5d89yNGI0FSc32W8Lw/SWLsnaA==
X-Google-Smtp-Source: AKy350aHPlYlChJxF4HQlAb3s/ccQQXKkLuj/0YwpGffvcRq+tpfEP9ObhroKMearnzP07TrPYVfAw==
X-Received: by 2002:a17:903:230c:b0:1a6:b78e:de0f with SMTP id d12-20020a170903230c00b001a6b78ede0fmr590735plh.51.1681783069405;
        Mon, 17 Apr 2023 18:57:49 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id jf7-20020a170903268700b001a2135e7eabsm8342694plb.16.2023.04.17.18.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 18:57:49 -0700 (PDT)
Message-ID: <4e5a887d-1c8a-5592-9dcc-fcc85ec7e319@landley.net>
Date:   Mon, 17 Apr 2023 21:13:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-sh@vger.kernel.org
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 4/16/23 14:05, Christophe JAILLET wrote:
> Using the bitmap API is less verbose than hand writing them.
> It also improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Tested-by: Rob Landley <rob@landley.net>

It booted and ran for me.

Rob
