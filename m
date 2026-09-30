Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BF35A39F;
	Wed, 30 Sep 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753038; cv=none; b=c//0TttwnGtD41tfJDzh6IZYgsIe5qLA7WBE2AOROOhss1OXnA5WWKaUKcxWQG+Uu2egjG7fRx0L76VRG3j6LsQu2aEQZpwYW0TDG6d9YYoNsvKz1W9fYC1MRCCBzUdBBmoxQFNeZh+iGyxuMCxYvf6GNuYD8PjVPZcR8k1BkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753038; c=relaxed/simple;
	bh=8ovQOQFomO670I1SSxlwhAd7XXPAPJRNzMsRd+Njyrw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RtBVywzLAqVGZ4tcy8KocHwLeJX9COcUSUZE7xAB/QL62aRWEgjX9JiXaJ5Mpo4Gm/Gxgiv1S8k+6RmBHyHJadZ5wHZf1d0wh+WRYJcyQPuYz+0Mfz1+LC2WtApUhqpfwe+bBL3JOrsBS7+WUd8T75+4pNn0mXAiXD+Qpivcz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkyE0HsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkyE0HsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93001F000FF;
	Wed, 30 Sep 2026 07:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790753036;
	bh=cr/9LDksl3pKOtz+kT5jzTq+mDMuvbziSeLAOVrtDYg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EkyE0HsGbpRfHw6YDFSO8SiO4E9KXyWnu+n2AO2NSA3UhSy3w9Am6ZZkz1ylkvPvb
	 2uT82/pEZODNHWy8B+sWY42snzepfuf9ZndSnVFWJtVvIMlvexVQ/uABHlEG4vAcWG
	 BkduXhrEOhoHRKEO8TpZomNxYyhx0FKmzhK2NrK6D777Dhpu9nIe7Neq2GJpzNm2LR
	 hqPXa5IR05Bak4yPqn1jBRfBecZs6Eklnl7sL2w9MJNJp9zVrYvfnpdQznpRXX8GhN
	 JeaNOPw5awPmM9rnbdQwNgDUQpk9E9034gZIUsD9CWIuQ/jkS9tuY7kQ76lLLQP7/j
	 KmCYR6QktB30Q==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 058721980047;
	Wed, 30 Sep 2026 03:23:54 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 30 Sep 2026 03:23:54 -0400
X-ME-Sender: <xms:B7m8arn74lgOCxu6FXOVKWiWOnyUvys5aubXdnX_eQc20TaCYL-0SA>
    <xme:B7m8apo36B5PE7W5D-44IlqhK8n74WCjSgSvtv2t0qB7nGTZDURNM_OuXbL4YIXRl
    QsNgwWtwnECXBPHWzCr1moN7AuiQvXBtm6ag310k5XIei4jRRGXhR3O>
X-ME-Proxy-Cause: dmFkZTFMDVMhJEQ7J1ew9e5PwLvolqMVIYEh3QICZKpARowJS0MkFY0pIRzQhMxMJ6kLIl
    QckxKCguSItFlX1qpSuXiq6C8zIQfWDtJXSaS3LR/Y9LucCR6MwyCutc7jXmXvzGNo/NkI
    6eZzHAPt4FaBaCIhCKT07SbWIVSAQtN7caoBEaFMxWJvUJL5QfnyK1PdrynQO4eJvIeHDZ
    Z84ZKkE1u0EAoPfDAQnV2NrEPBxD2CV49a3gUFowFkeLRPiaKwZQ6V8ay+fePP9Bp3ImGJ
    yjAbM9teHQPng2gwuZwlglLWlJbsF44UeuktAjisrqw9HmxSPKPTmQ2Q7ImTf3mx1TAntR
    BrZE+IgqCIqsJVftswzBW3O2J93DKgfcKw+ksYXOLBAwhOL2GsZsOZm+ou0/vb5nUQ5LfZ
    ToeLaI407ekVaIK+14zksQzIBkTryd8JL39GVV0vqNOl5+LjagPXUSG4dso2AXxSaEV7wn
    GcobcDlTSr8RIkSYmkXrBNacWcJFrebuX3U0DIDTk4zcQUWOx4PaYkmDicN4UoCxvgknEM
    f6/7MSv8vt1qeYsPA2/oCNIwtzN7MWqjmi+VvF84vmwK2wn9GZtrh79DFA+zlPCkRc1Lfz
    xN7oCAP2TRJIO8XXbRFrOUatZaHZLuUPga8LngRN3qLUeEJfqlw9VCtBvDow
X-ME-Proxy: <xmx:Cbm8avhHWT_T6en8ejsvNshgtxSV131vxA6mZcylH1A-FkgdC5VBcw>
    <xmx:Crm8areYs7PfCn6Ho2oJAjzeiDcVFUlv0M7YOyDNhFGuYYb9heXbog>
    <xmx:Crm8agJ1i-2ov4bBAj6FtKGVgZrFuggL_A7VRA8KUBc36jDdbgtTHA>
    <xmx:Crm8agkRAz1-3WvEhUPsehnbKx6xUhBM--fuHg0lqcNK6aeXtnkGlw>
    <xmx:Crm8agfHy55Uzk8wVG0oK1XfPZyFnv1Z5fCRTxPIu2shR7fN1G_Oeh5H>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 7167C32A008E; Wed, 30 Sep 2026 03:23:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1EAYUxGQhrR
Date: Wed, 30 Sep 2026 09:23:21 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>
Cc: "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Message-Id: <3a51385d-9649-4bd7-87b3-0caf9e462b2e@app.fastmail.com>
In-Reply-To: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
Subject: Re: [PATCH v3 0/5] sh: mach-rsk: rsk7203: switch to using static device
 property, drop legacy gpio API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 30, 2026, at 06:57, Dmitry Torokhov wrote:
> This series of patches converts rsk7203 to use static device properties
> for its devices, including gpio-keys and gpio-leds, and removing
> dependency on legacy gpio API (in favor of gpiod API).

The patches look good to me. I have build-tested this with the snippet
below and my series from
https://lore.kernel.org/all/20260907090956.2825703-2-arnd@kernel.org/
to check that no use of the legacy interfaces remain.
You can probably fold my one-liner into your last patch.

There is a trivial conflict between your series and my patch 2/2
"gpiolib: remove linux/gpio.h", but if yours gets merged, I can
resend mine without that line.

> To configure pin functions the board is switched to use gpio-hogs, as
> doing full conversion to pinmux is too challenging without access to
> hardware.

I would guess even with access to hardware testing is going to be
challenging, I noticed that the defconfig kernel does not fit on the
4MB flash any more (even without rootfs), and the USB support was
never added for rsk7203, only for 7264/7269.

     Arnd

--- a/arch/sh/boards/mach-rsk/Kconfig
+++ b/arch/sh/boards/mach-rsk/Kconfig
@@ -12,7 +12,6 @@ config SH_RSK7201
 config SH_RSK7203
        bool "RSK7203"
        select GPIOLIB
-       select GPIOLIB_LEGACY
        depends on CPU_SUBTYPE_SH7203
 
 config SH_RSK7264
