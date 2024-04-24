Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BC15AAB1
	for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960328; cv=none; b=RgBSZbrU1P1HAok3/GDrVFurbwQTnZEG2JADx44/QX98WBnNhUXQX/MoK0tkTz4S4H8FG+2p3kIJ9mHRVPMUpiMw2wISHnV2lxpqboy5ZCmx03mqpHLGObrcoPMGPtSkwIIZMmtOEgFi9VU5XL5ROpAfUG/0duZ7lKm0XRivMbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960328; c=relaxed/simple;
	bh=9UM4iGKiB2NyiGN7Qw/hLObNC65imW+ASsj696wnrvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxKeNchlHqJ2ZaVqZKVGFTEtdN/qJao4qBV6PF4qilXH6T83xjVEBL4e8MPE/DphwadurjvR5KZtlm4Ow7uLb8dbpasiG/xfP03ti7KYBI9kG+1wbUHQiSyxd/UALrSZhixMPUgu/+SgAuCyq0vHGsjmx6rEV/1afE5WAWw/7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de54b28c41eso2195054276.0
        for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 05:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960322; x=1714565122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XV03de7We9x8LeV5vg9UhXU3HnB+gyBGStDmY6jLL0=;
        b=g8BmRoZSwx58NrUrZz/puMvfp0wt9UVmDmLk5AVTOdJP7aHE9Ss9TTBrZXCMbnHL0f
         XNIWHPN0cNstvS+bcKASE5+zO//Q/itv+0MTI/tJArpmspHuYNtG5GWlRmt3oBh4Ptn3
         cjSV+1yCz1wndoy7DPzugkN+YEcvPxJ4PeR5LF+4BzKdq8C2JuFJn0hMaJ2ZdP9Lrhiw
         04I27eCK1B9WiDCB9p9hFQHTN7PEY2nlJJWhMEUAOER0NtzvPK0ubFMaU5HcWzIYbA+b
         8yYHq6ojGUmKEzPuBHFt4ntxr2aQB52Cdc71cv+BmM6RJeRQFbqDJxJUAlj8Uf3Y6yxD
         D71A==
X-Gm-Message-State: AOJu0YxU9hJehMN1K/bPQtxN7/dbej3gZX/4tH91mUrmEIJnGoDt7rZ8
	0nUBAO6z0+senkv/SsWQ26E8KX7NW+bRuG7JAckiwtOh0pbWjw7G1n//8w0J
X-Google-Smtp-Source: AGHT+IH9A0AOF8ve+bqVgDICCOG7vI5GEf4XNsGCaxBdjLwTJsxlNCYKhCQwWoeubJIbLKCzZe2ANw==
X-Received: by 2002:a25:680f:0:b0:de4:6e64:ea7e with SMTP id d15-20020a25680f000000b00de46e64ea7emr2264212ybc.31.1713960322251;
        Wed, 24 Apr 2024 05:05:22 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id d63-20020a256842000000b00dcb02a7e071sm3185714ybc.35.2024.04.24.05.05.21
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:05:22 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de54b28c41eso2194939276.0
        for <linux-sh@vger.kernel.org>; Wed, 24 Apr 2024 05:05:21 -0700 (PDT)
X-Received: by 2002:a05:6902:1b02:b0:dcf:411a:3d22 with SMTP id
 eh2-20020a0569021b0200b00dcf411a3d22mr2423576ybb.60.1713960321509; Wed, 24
 Apr 2024 05:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709326528.git.geert+renesas@glider.be>
In-Reply-To: <cover.1709326528.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 14:05:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWug+QyJcwiCdo1b1reL2KU700cwkxmyNFHq-TfLYZ9pA@mail.gmail.com>
Message-ID: <CAMuHMdWug+QyJcwiCdo1b1reL2KU700cwkxmyNFHq-TfLYZ9pA@mail.gmail.com>
Subject: Re: [PATCH 00/20] sh: Fix missing prototypes
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(reducing the audience)

On Fri, Mar 1, 2024 at 10:02=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series fixes several "no previous prototype for <foo>"
> warnings when building a kernel for SuperH.

This series is still valid, except for [PATCH 08/20][1], which got a v2[2].
Please let me know if you want me to resend a v2 of the full series.

Thanks!

[1] "[PATCH 08/20] sh: boot: Add proper forward declarations"
    https://lore.kernel.org/r/2614d991c816ece903ef47c715bcc53881d34f3f.1709=
326528.git.geert+renesas@glider.be

[2] "[PATCH v2] sh: boot: Add proper forward declarations"
    https://lore.kernel.org/r/b7ea770a3bf26fb2a5f59f4bb83072b2526f7134.1713=
959841.git.geert+renesas@glider.be

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
