Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05017C54EBD
	for <linux-sh@archiver.kernel.org>; Fri, 13 Jan 2023 16:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjAMQBU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjAMQAm (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 13 Jan 2023 11:00:42 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6E983FD
        for <linux-sh@vger.kernel.org>; Fri, 13 Jan 2023 07:51:33 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id v127so18236326vsb.12
        for <linux-sh@vger.kernel.org>; Fri, 13 Jan 2023 07:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5mLrAHoyJ5nE/w7T6hV9jO9ho9i+v76675RNWbUbP0=;
        b=yHRJb87NukQWnDBcg5WdqZfZ07lI6u6ys4J9MZyzZjGgWFD6i1KYUG5iukGhsbMBL4
         WPiiQagmylt6A5MJKZg40yDFd8qZ8ccY+6eMWL11aY4WIEGBXd/dqGBzZKRyMDOxqnPV
         HlQTyavSGQRfJrqVQ6wJTz+FSi7AQkTYovL2goYaAHH0dhm4QHhMabwof0unFZR7NqqK
         gUt1LFGzuwOgeO/eCmOJpww2XN1XsvqNGIJIMmVJuXLBFR9C8kmaS92T3u6hy41Z2Imp
         tldehpMR1TNgEDawB0c5upbO5pr+85OSL7ix7y/PoWI/EmHGpIFYdWyjiVMtq12T9Dpf
         K3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5mLrAHoyJ5nE/w7T6hV9jO9ho9i+v76675RNWbUbP0=;
        b=VUeKW+S3NhAYTez61Gr2TKcpTIfTw+TFJWg/zr9+7ehgZhDR/b9OxfvOrBx7CtSMPS
         SPcEayGGCasNKveW/reFkHHuPzP1SCMtortJJClnIeSFVSHUqPa0MtMjXjOPMC6qPUjh
         MLjVOAJcElkFItKPge8z2SUAWIngMFYVs2UgY0UGyEuH0V8OBpGcoL8stDrhPk5+kTMI
         mXwa0ERcszKFpRl8obPn9oK0ds4XdXc8dgJdcrMGsFhg9/l9FgBFPejAmINTm+160o92
         33UA5kDgRx2AgAWx06f3R+qJYU9hmoVOSuQj8zysR40qUOBWmPwISTKrW4gbyjggoWYz
         qCaQ==
X-Gm-Message-State: AFqh2kpN4iRSBEEcpOtVxCjpR6PgoDWFrDPWIBCFN7gdJvM3X0u6LlaD
        0vWjuIxkH7p7KrVcS9BNx+YDlqoxvI0/Cxlf2N4MMA==
X-Google-Smtp-Source: AMrXdXsI3EMIQ7TOoOD/7p0LcC17cwRylvVtksQiQePxKwv+hwJDZMXOmlYE3f0gqSJLKso5mPtLAUlUwQRbqnkLpEw=
X-Received: by 2002:a67:df09:0:b0:3ce:88b3:d7da with SMTP id
 s9-20020a67df09000000b003ce88b3d7damr7008535vsk.62.1673625092385; Fri, 13 Jan
 2023 07:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Jan 2023 16:51:21 +0100
Message-ID: <CAMRc=McWPrODnwqHnKHx4V3buyWduMROnHpP1_jd3e-8EoU3tA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused and obsoleted irq_to_gpio()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Jan 12, 2023 at 2:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> irq_to_gpio() is legacy and unused API, remove it for good.
>
> This leaves gpio_to_irq() as it's used yet in many places.
> Nevertheless, removal of its counterpart is a good signal
> to whoever even trying to consider using them that do not.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
