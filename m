Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D481C433EF
	for <linux-sh@archiver.kernel.org>; Mon, 11 Jul 2022 03:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGKD6x (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 10 Jul 2022 23:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGKD6w (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 10 Jul 2022 23:58:52 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F163E4
        for <linux-sh@vger.kernel.org>; Sun, 10 Jul 2022 20:58:47 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10c0052da61so5381533fac.12
        for <linux-sh@vger.kernel.org>; Sun, 10 Jul 2022 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dlud7CB47gCabKjEExf+HYa3YTKclAPN+orOFIYlRIE=;
        b=DEdE0gDI/2aD+gKoVcFxKQuNiru516qZrr1cVmiWItHX6g6RDERrYHJnXsBnizUmrZ
         T5+d31onfEsQB5q7gUwsZpSVuBq7VrUa9rKzyAcyD6mAtQ3AgQj90aNvlOzbBWI9lhZh
         KbqQ3asf/G8pyq2v6S016dWIZF2YcgeydrcfijUAOxAHCscwihLUA6IZkaQSPP86NHun
         yucoCD3iIbg5DHJRasGIKRla0ltuQGKrTUgp8N9Bm+rGpozbkOA20IZuvuw5vRnUICU7
         wR9dqdIuSaoaLlOpoFIQ50fLxLDOiDN9XoCVjuHx4WtjumCSen8kbwlXEgrGONSxDNB6
         AWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dlud7CB47gCabKjEExf+HYa3YTKclAPN+orOFIYlRIE=;
        b=zBH5PfniK0AdrsTvcHt7G519tf7c9AqOOgPQaeURFAKT2BhLQlyRKhTQXoXk1yqqbP
         gLqrI/IfwcGyVMWw46dsXdJJSxQC9ugxpCZ9jzDuU6+qQ4SwwlJjVJN8o6IGrseW8ZnL
         vdOgKB5H0FflQojRq5oj0xLoIQOkLuH0pc6t7rvPbAqF0aZ7z47abUTEpG61xOtUnrZs
         EUWMgV71FW8ZCjKUhGqDPNnSWAXcbReZ639KFwIPlirsxl8Qy/3iC159RRTdzgMSgkmn
         oae/hrkgqWUXTs1yGAeoEqnTaBHl/jvqSoCsLrYvzVMFcaq7RIa/chihegFKnEh/Zart
         VR+A==
X-Gm-Message-State: AJIora9yM6hbmxersQFGXrRVlQ4J8tRG1RZcsFnHA2EssdiokIuHvCJZ
        R3ultA+TnUVZ4RdqZc0/Pa+puYlaExUnaw==
X-Google-Smtp-Source: AGRyM1vYVm/8VsHDAczHdV7I35n0zTiZQ+xe9DymyaZm5eaVbtd15926zyql42QolwGN581WdC/ePg==
X-Received: by 2002:a05:6870:15c3:b0:ed:9980:db99 with SMTP id k3-20020a05687015c300b000ed9980db99mr6865844oad.154.1657511926920;
        Sun, 10 Jul 2022 20:58:46 -0700 (PDT)
Received: from [192.168.86.208] ([136.62.38.22])
        by smtp.gmail.com with ESMTPSA id i3-20020a056808054300b00339fb4fe4dfsm1167707oig.52.2022.07.10.20.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 20:58:46 -0700 (PDT)
Message-ID: <85e1a896-733e-64db-ca55-bd6919b7d9c5@landley.net>
Date:   Sun, 10 Jul 2022 23:05:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] sh: clk: Extend valid clk ptr checks using
 IS_ERR_OR_NULL
Content-Language: en-US
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220708104347.13462-1-phil.edworthy@renesas.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <20220708104347.13462-1-phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 7/8/22 05:43, Phil Edworthy wrote:
> We want to allow all drivers to call clk_disable_unprepare() with a
> clock pointer that could be a valid IS_ERR() condition containing
> errno, as this will simplify driver code.
> 
> Therefore, ensure we check not only that the clock pointer is not
> NULL, but also is not an error value before using it.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Note this has not been tested at all, I don't have any SH boards.

Tested-by: Rob Landley <rob@landley.net>

Rob
