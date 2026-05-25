Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF93E3DBE
	for <linux-sh@vger.kernel.org>; Mon, 25 May 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779699419; cv=none; b=PCxtbEmRXE61OSkt7xpmfKO3NnAtFuyJ5Ust/Fh7SqD4TWXvGyy1IV6k3je2JupxkOsy3fYceaVw/ZwZIetQIQlncOnmJDGBKQ5Vs9S446kZdpzWwR8AONoFYQLJllRsZ/9tpzb3NLqbEgybdwqX/qcJzUDYXosV4ROMEcYBojk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779699419; c=relaxed/simple;
	bh=7PvwyQllz/pjQymDAzG0DdH6jfnX3fKrrEx3IT04oDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqJDfXsrVyMUqNuFfZjTJrZqidwWgJOWWsFCAvNtz7N+2pV6TRuiIuTrGEWgSeD6NeYuO660IW/okR6dOCtgr7NDYau4ssbMlXU3pbms6ttwwGJ5AgYSiv80cRRJeOIXD3lV0VRV6r3enyAZGOyCdNQvBKXxyEfCquPTvxZKd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afX2nWbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afX2nWbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFDE1F00ADB
	for <linux-sh@vger.kernel.org>; Mon, 25 May 2026 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779699418;
	bh=7PvwyQllz/pjQymDAzG0DdH6jfnX3fKrrEx3IT04oDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=afX2nWbiFCbDz6PnnrS4+QAZf0GARg6ufmCva7Lo1C1L8uxDo/U/sJ0K+011DdNyl
	 xtlG2dpEeMpaUokvP/LNucXbYmuCGBDW+uy0xdcLkPCBPH56sYMzfB9STwCeTdTtSW
	 T2h1S6Ypb5QJNIwUtJBfC0S/ybri9K/YoiYpZ8VoMzQqFX6WKcSZcDmE09gGCGv4WL
	 1omYkY6UbeHiOg3pF1kiSSjbyCQcvc/qd37DYtGqG12maVHnWzOQmk4q+rUzoIDjU6
	 2Qhzu49q6owNlWwlMzuKaYl7YYK0gIpule4vfv6GfzL6+buWvIRQZcSQDYCeYsfPOz
	 yOQHVl3YLg5pQ==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e5fe62fc87so2615832a34.1
        for <linux-sh@vger.kernel.org>; Mon, 25 May 2026 01:56:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ82PCFjY8YV8G0dsDSJkXxULC35Jclv3QnVmiBD7hfQ3W/eTlxGUzeRbWiT8YQJ5tPzZUHZ49P1Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7IPXxlyUdhSVg/w2GfRzmQGg1Xp5hyEY2XLbfP5X+9WTCjeF
	9BvTmnCn3TyoBg1VQJP63EbVD8+BGcpgoFUPrZi1phyRfRZ0qQvl34q5l5WWzVL8/8++RwxNwAJ
	6AdzDVS2o8KyJxrLVWSf/Tle/6CGt4pU=
X-Received: by 2002:a05:6830:67eb:b0:7e3:d199:3164 with SMTP id
 46e09a7af769-7e5fedf1913mr9444576a34.11.1779699417451; Mon, 25 May 2026
 01:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
In-Reply-To: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:56:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLn5VCye-B7hFj2O+w4v2fJ+Anv20AXNpi6+gnetQ0z76g@mail.gmail.com>
X-Gm-Features: AVHnY4KcQDk0adPJPzy4UzxdMwWacFrk2st2duRbr0oE9NOwculfoeTBCKJMzrs
Message-ID: <CAD++jLn5VCye-B7hFj2O+w4v2fJ+Anv20AXNpi6+gnetQ0z76g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rsk7203: switch to using static device property,
 drop legacy gpio API
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@kernel.org>, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 7:13=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This series of patches converts rsk7203 to use static device properties
> for its devices, including gpio-keys and gpio-leds, and removing
> dependency on legacy gpio API (in favor of gpiod API).

The series:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
