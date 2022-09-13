Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A500BC54EE9
	for <linux-sh@archiver.kernel.org>; Tue, 13 Sep 2022 18:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiIMSVN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiIMSU7 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 13 Sep 2022 14:20:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF66792FC
        for <linux-sh@vger.kernel.org>; Tue, 13 Sep 2022 10:34:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c24so11969311pgg.11
        for <linux-sh@vger.kernel.org>; Tue, 13 Sep 2022 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uO/mhGpBvAVk5S3pHCn4SwusJy9TfgShbx1qBp7awcQ=;
        b=k/MI1AT0ciC5+jhj+8ehW3cp31w7klZqC7ECHlSIkEkVsC8dqaTetBsJ1v3MM4FloS
         EEvDWS5FWDd3j72+R/FUdhnA6ATiC8tWW1q1W9UW94s329RU5iXplH0kW8G5bnhIoF8G
         YDWAXh5UPyICfERQwKg09SK+24quBJfkWjMIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=uO/mhGpBvAVk5S3pHCn4SwusJy9TfgShbx1qBp7awcQ=;
        b=lhNwMTVC0gGMwavFDySjLP25Tqx5qNaikIDTQfRLUh2QqlDnVVCyDZJMbfA5XYQ0gU
         FmsZvUjv14f/OsyhZJ6gM5hk3VBn8eF5+eGDGDfhmf5mEgtKQDsun0rkifWgSVPY0cDb
         oj+rc+/au5Bp8CP7XVLDFhS5JYhJRpIY+BT/WG2usuFa8+s07bSiYu4FYFxSf/A0nEI0
         dEtFdNoM/MgjTXEYrKOp4iSnWsjTXjDLoIXmVQVZZGNnicI0nYRsHHzTXYXOgB5NGhPZ
         zKsYBFgmyZihSd98fb1/II/U5rBjW8SB7pmrQkJcidBPSQaIXWZgDJi4KLg6I0UUujL3
         lCcw==
X-Gm-Message-State: ACgBeo33D7NH+KsXSDc7IyA33klZ6VWtU5VsR294HW885/YWmdRwANNq
        dk5lK8BzhkRqCSf0/Lw8LerXuw==
X-Google-Smtp-Source: AA6agR5C3NZU0uYQLHCaS9tlgX4IKdBEgEFeMfYXwB1Fo0OfkDNNHX703H7ospZYi7j/VRaq8UvXEQ==
X-Received: by 2002:a05:6a00:1695:b0:53b:2f0c:4d33 with SMTP id k21-20020a056a00169500b0053b2f0c4d33mr34131043pfc.7.1663090463663;
        Tue, 13 Sep 2022 10:34:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b00176cdd7e4c6sm8742032pln.50.2022.09.13.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:34:22 -0700 (PDT)
Date:   Tue, 13 Sep 2022 10:34:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sh: machvec: Use char[] for section boundaries
Message-ID: <202209131033.EDED655DA4@keescook>
References: <20220907234345.96798-1-keescook@chromium.org>
 <20220908221538.GD8773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908221538.GD8773@brightrain.aerifal.cx>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Thu, Sep 08, 2022 at 06:15:39PM -0400, Rich Felker wrote:
> On Wed, Sep 07, 2022 at 04:43:45PM -0700, Kees Cook wrote:
> > As done for other sections, define the extern as a character array,
> > which relaxes many of the compiler-time object size checks, which would
> > otherwise assume it's a single long. Solves the following build error:
> > 
> > arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33
> 
> LGMT. This is the approach I recommend for this general type of
> mechanism. So,
> 
> Acked-by: Rich Felker <dalias@libc.org>
> 
> Since I haven't been on top of collating patches for upstreaming, I'd
> be happy if anyone else wants to take this in their tree before I get
> back to it.

Great; thanks! I'll take it via my tree. :)

-Kees

-- 
Kees Cook
