Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01008C77B7A
	for <linux-sh@archiver.kernel.org>; Tue, 13 Jun 2023 10:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbjFMKhh (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 13 Jun 2023 06:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbjFMKhg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 13 Jun 2023 06:37:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F8B124
        for <linux-sh@vger.kernel.org>; Tue, 13 Jun 2023 03:37:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f655293a38so6172036e87.0
        for <linux-sh@vger.kernel.org>; Tue, 13 Jun 2023 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686652653; x=1689244653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcIqiwGu4sLEkTe056TBYKLsIuMHS5/22uZLcaXmrIg=;
        b=q38P38oFNz436rbtz93StwiYL/vFP7MMNqPeNIqejeYdXIrrCA3boHSyNWjxCLq+yT
         dL/m53B2SwFPNECbkZSRBytuIDffRItcWoVo+WlXh39G5Czhu9zYzZNMndOPjJyGARt5
         kbl072mpM6tDiMEqdz247ltufPd3+4qHo6Oeg9xmLT5SlA1fjzpla2uhD6mm/axrTWYJ
         izBLn9ywFt38UPfmPSDd7ZYJOXCxjbaWU5b05peQOck/vQznRpGC6CifT0xizIH1bxmu
         Tgoj9P9zSDjP2ZN4rY88dTvxN0xd364jYAjGfSlb2E2YQE15gsbGsvyx1gRL5t7XbU0j
         m4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652653; x=1689244653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcIqiwGu4sLEkTe056TBYKLsIuMHS5/22uZLcaXmrIg=;
        b=Q/6nyiQuknVnduNKMH7zG1ii3QEKEsgDTRMj124g5dO6hCOaomB0AwQy2o1uwMBqMG
         F9jMnUb9JpBmwoUH1oH5gO2ofnn2cqY+KZIYl1LY1uPg1wPqo8mWOmkMSwgDQS+MTXvO
         fcIUqPBSjGHDlVyYyWrWE/zo5Ke0HIxNbJaHYEBJsfkALQFQRmIHm4espuntVW/jfyH+
         Km2iroaT4L9BuP8Cy4w0Rvyv8DJy0d07MrUmYd0ObxdkJ/D8FvT9ZCufMVAoKkMTqMVP
         PEeuk6DYNriCsGMRbfS8e2kv1WD9iNIdZqglFgKlaQhAB+hhfJe1MJ3wl+0vcq6HkUgh
         HXHA==
X-Gm-Message-State: AC+VfDyWTmEGll3LqTk16P21O0dE2JCi2kImZUPYTIlI6YbFbgBczKQ4
        oyU8q6/jRW+8RJuUlQK/M6NX1hZrYlfptlnKcIfEGw==
X-Google-Smtp-Source: ACHHUZ75Fs8dPw0U408VxzYcAqvN1dg4+0El4azN/49u3r8xhE324PvUci35OMNH6AhJBTgTqhwkRg==
X-Received: by 2002:a19:2d4e:0:b0:4f3:93d6:377b with SMTP id t14-20020a192d4e000000b004f393d6377bmr4733972lft.37.1686652652707;
        Tue, 13 Jun 2023 03:37:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id k9-20020a7bc409000000b003f6050d35c9sm13973436wmi.20.2023.06.13.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:37:32 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:37:30 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        jingoohan1@gmail.com, dan.carpenter@linaro.org,
        michael.j.ruhl@intel.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 01/38] backlight/bd6107: Compare against struct
 fb_info.device
Message-ID: <20230613103730.GA169438@aspen.lan>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612141352.29939-2-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141352.29939-2-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, Jun 12, 2023 at 04:07:39PM +0200, Thomas Zimmermann wrote:
> Struct bd6107_platform_data refers to a platform device within
> the Linux device hierarchy. The test in bd6107_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
>
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
>
> v2:
> 	* move renames into separate patch (Javier, Sam, Michael)
>
> Fixes: 67b43e590415 ("backlight: Add ROHM BD6107 backlight driver")
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v3.12+
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

PS Please don't treat this as an Acked-by, if you want to land this
   patchset via a single tree please coordinate with Lee Jones!
