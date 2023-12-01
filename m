Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7EC10F9;
	Fri,  1 Dec 2023 01:48:16 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5d4f71f7e9fso2523777b3.0;
        Fri, 01 Dec 2023 01:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701424095; x=1702028895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsfboZkfhqktBfIu4wv+2D4aDy9AZlINafvD6AXCGg8=;
        b=pKwTF72s9gnGjzukaRyc2BshiUOk7pMAp57UyIcnyCpCQIKeqBPwQBIK2623ny+0Hw
         4B8JxvM2ENRvdWIKYrf3e/RUVvRtIut4wFpm/9OtCUfh6C3znYAmr1McERcmHhRZe7Ha
         0hp0uHVUzn9vly5LVsk7dxdEvrQ1RpxA0xc/2swnyKhAa78P1fyZXRXFzc+sknwy2mtx
         ba5Ce/cBmsOOBfnnTMO271efp4bq74hXZ1Ac6GLW24ZVy1RWGauvlyjU78Tl0PI+ynZ8
         QliEeZzn4F1Jogt0GKf0Grw4TdFiitJL8tW03OqylTlOjW1sRWv38aByKijygCWyBWZt
         N2ow==
X-Gm-Message-State: AOJu0Ywt7eV4V0q8Khxpo+1ig2Pn1EHtZVIU75KemJ9lbLAeiyX8EeAC
	32Dfj5hw0n8M5uOlWXekb2rL4fHrcqiLxA==
X-Google-Smtp-Source: AGHT+IE2ra4LS2JpCt82GK8knKLoEo0RFfsc18nNLC1PErZMMlNcDkTPfRHSAfjvW3tO9fbKyQ12PQ==
X-Received: by 2002:a81:a786:0:b0:5d0:6e91:d6bf with SMTP id e128-20020a81a786000000b005d06e91d6bfmr15487746ywh.21.1701424095325;
        Fri, 01 Dec 2023 01:48:15 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id b123-20020a0df281000000b005d3f531a37asm442709ywf.85.2023.12.01.01.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 01:48:15 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5d4f71f7e9fso2523487b3.0;
        Fri, 01 Dec 2023 01:48:14 -0800 (PST)
X-Received: by 2002:a0d:f687:0:b0:5ca:eca:700b with SMTP id
 g129-20020a0df687000000b005ca0eca700bmr22443542ywf.52.1701424094073; Fri, 01
 Dec 2023 01:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129063730.31184-1-liuhaoran14@163.com>
In-Reply-To: <20231129063730.31184-1-liuhaoran14@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Dec 2023 10:48:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUjo_tUu6G6q3ww_UeJxzwtDBieMwFARTAJf4Emhej-YA@mail.gmail.com>
Message-ID: <CAMuHMdUjo_tUu6G6q3ww_UeJxzwtDBieMwFARTAJf4Emhej-YA@mail.gmail.com>
Subject: Re: [PATCH] [sh/highlander] psw: Add error handling in psw_irq_handler
To: Haoran Liu <liuhaoran14@163.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haoran,

On Wed, Nov 29, 2023 at 7:38=E2=80=AFAM Haoran Liu <liuhaoran14@163.com> wr=
ote:
> This patch adds error handling for the platform_get_drvdata call
> within the psw_irq_handler function in
> arch/sh/boards/mach-highlander/psw.c. Previously, the absence of
> error checking could lead to unexpected behavior if
> platform_get_drvdata returned a null pointer.

Can you please tell me how you detected this issue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
