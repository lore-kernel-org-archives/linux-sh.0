Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C42FC77B70
	for <linux-sh@archiver.kernel.org>; Mon, 17 Apr 2023 06:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjDQGvZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 17 Apr 2023 02:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDQGvY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 17 Apr 2023 02:51:24 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D151729;
        Sun, 16 Apr 2023 23:51:22 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id v9so4155784ybm.0;
        Sun, 16 Apr 2023 23:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681714282; x=1684306282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJYvk4q6mS1dys9tzSECyNKgl5eo32ZFDWFyFDVmtjY=;
        b=RnfTbd5H6dkXV/mD0ZC8t7VCAp3goMQ4x2Y2lM9+rkKsORuuiAzFzBciWsSjf/VIRk
         Nl8kLE5IA2czObaDz1xq6jAkf8BE3ZgjpgXvXB07sFKIBr2neTfqlo9Lr0nnE7W7IHrG
         j/78yhiNMtKN6zsuRalRifaXLwiSECwx5mehGhgmJXo+gC1DJpTqub1+ZrXIdAfmoW9+
         7qtUdKcx1kFIEvrEiSiBdzGxJZ550MiqOcNSTz2fRiRKe9xHXxqm8vbhtKI0BJ3/0pbF
         V4aKgud6uwJt0UeQkd6PJYrLN+siLcFhbi8Js1569vRLc3mcLbqCB7IvEZMzAWgjiw67
         SwWg==
X-Gm-Message-State: AAQBX9dLPOP70CSqof+xRIVUXV7nw8Xn+BX24/7hPKhbkTATbhCfMG/w
        vKEMQgAyyhgQsNrGV3PI0sltyJVx2wy2fg==
X-Google-Smtp-Source: AKy350YWz1jv13TTchreG9vqWHZmwbICSJh68YwLDY7uSb4o+t5DST05ed+03H29pUqLJq5vIrAo0A==
X-Received: by 2002:a05:6902:114d:b0:b8f:384b:4f83 with SMTP id p13-20020a056902114d00b00b8f384b4f83mr15847354ybu.33.1681714282007;
        Sun, 16 Apr 2023 23:51:22 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id h82-20020a252155000000b00b8d65899d76sm2826046ybh.47.2023.04.16.23.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 23:51:21 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-54fbb713301so165320867b3.11;
        Sun, 16 Apr 2023 23:51:21 -0700 (PDT)
X-Received: by 2002:a81:b71c:0:b0:54f:b931:adf7 with SMTP id
 v28-20020a81b71c000000b0054fb931adf7mr9260584ywh.4.1681714281276; Sun, 16 Apr
 2023 23:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <071e9f32c19a007f4922903282c9121898641400.1681671848.git.christophe.jaillet@wanadoo.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 08:51:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGgxYubHe7dcJgLa9gsZdvPdOdpBUh1ppMnJbc=VTj+Q@mail.gmail.com>
Message-ID: <CAMuHMdXGgxYubHe7dcJgLa9gsZdvPdOdpBUh1ppMnJbc=VTj+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] sh: sq: Use the bitmap API when applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sun, Apr 16, 2023 at 9:10 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Using the bitmap API is less verbose than hand writing them.
> It also improves the semantic.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
