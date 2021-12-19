Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62AC433EF
	for <linux-sh@archiver.kernel.org>; Sun, 19 Dec 2021 10:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhLSKep (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 19 Dec 2021 05:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhLSKeo (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 19 Dec 2021 05:34:44 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EB5C061574
        for <linux-sh@vger.kernel.org>; Sun, 19 Dec 2021 02:34:44 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id u74so11166564oie.8
        for <linux-sh@vger.kernel.org>; Sun, 19 Dec 2021 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pFU92apYAvOiDgemoMKCF8lI/J5BTvrn5LAkNJ5Lc+Q=;
        b=6jyafL3WnyPHvnRov0EkqpVnS67kASRtzX3BTUeCWVpnIbYjILTsdwD/ZiNVuGq2S8
         qd+f1U5SszDNTsNOgZSwLOiAOgW6R/DcIMO9LwpKkNs9v2JfFxxsBm47QYIxi0IDunpK
         ZFc9a+U5/ZXJ68hjkFwPjebzjhkiimJ3KxYQX8fDMZvGPwCIACLvMbmksxZ39LszbjTQ
         niRDZApbbb5840Xt3112Z78RUh930C8scpv1At4jqijzA7Sm9FjOPlCW2VGiKwxir8Vd
         ohfsRKc9XLh/yzctnJyRotaTt5cvQlbO1WmQ0E9eTmiAEmGc/Y0gKcz4dB0akaRI+O+J
         Uuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pFU92apYAvOiDgemoMKCF8lI/J5BTvrn5LAkNJ5Lc+Q=;
        b=NTIUPO4JghIfNO1saF/GggL9c4BBYhCY4u0BhfWV7OsfDRAN+pODIdBlf4E7vrvffU
         KUS3OR1VI6QzBTgZtR9DfhZUpwkfmtP4ZM5IuFkVtw99vdAa3457CN0fR4EPkP/F2wrT
         IF47QHpJEdWZGWk9pqysqhKlNWhdo3RiXNmnQYYq4XVPHz2dVoHUN5hUAQ4Lq44ZjbgC
         U1b5RFQcacdF4WCgcDeshs082Jhj3ShTtIRJycXeI+MyHM7fUp5Ja6gisHENiPABpnBD
         0eqjVQaIGvW9xRX04IU6xoMqkCm8ie+FE6sUIHntruL59vTPhGwwJYxG5Ce6WjBy76+h
         cGBw==
X-Gm-Message-State: AOAM533mliD5uVvaIjggKGK3yn9xs74shIe3Ivp2rTQlgD7TRkuCwDUI
        jQd9zaxd9JnPDmm1HfhZ6YHHcloHPzCQDw==
X-Google-Smtp-Source: ABdhPJwkz64GEp/3bR0EmpxAFoR/eSwzbqJ1wNpRSWEBhu44cGdNx5YCKHDBrP8TYcAFz5rQt2XsPw==
X-Received: by 2002:a05:6808:1aa8:: with SMTP id bm40mr13294933oib.38.1639910082479;
        Sun, 19 Dec 2021 02:34:42 -0800 (PST)
Received: from [192.168.86.166] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id t3sm2677741otk.44.2021.12.19.02.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 02:34:41 -0800 (PST)
Subject: Re: [PATCH 0/3] serial: sh-sci: Clock handling improvements
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
References: <cover.1639663832.git.geert+renesas@glider.be>
From:   Rob Landley <rob@landley.net>
Message-ID: <7cbec488-01d1-1ee2-006a-a3835d42a0a7@landley.net>
Date:   Sun, 19 Dec 2021 04:35:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1639663832.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 12/16/21 8:17 AM, Geert Uytterhoeven wrote:
> 	Hi Greg, Jiri,
> 
> This patch series contains a legacy cleanup and two small improvements
> for the Renesas (H)SCI(F) serial driver.

Tested-by: Rob Landley <rob@landley.net>

By the way, did you ever figure out how to get the first serial port to work on
qemu so qemu-system-sh4 doesn't have to "-serial null -serial mon:stdio" to get
a serial console?

Rob
