Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C793A1682
	for <linux-sh@vger.kernel.org>; Mon, 20 Apr 2026 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688176; cv=pass; b=en3q+2/oqmurjztXW7lT1m9hgQpgSkWU4MPblpsDedO/Y1HACFN0iTbKQ/p1B1/qQyY4XUqLjmKOKWGJiyq9+sH5rQGNJqGSFafGx2AWKpuIw56UrbgmrtzzNM9y0T066goOow1hBzt5KiWlSBa7eaVvCy8qVyg6VpXePjS5h5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688176; c=relaxed/simple;
	bh=iRX9LnLt4l5zNmdZzU0XVrMpvF4zu4dRaargVib9eEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzfHT30y2tQxC6dxt83wzBANnD2TR1pVPU4KuM2wxIh1cpceIAhfEOW5Xp/CPWC6Zx2AVJ6gCSpVdKU0FzqM8NYtFMKNuvRkRbv1xZ99YICmiuyV6LT6eL6gEQcPCUFvwDXvKVYIdNu6v7mVMKzuiPOzKTa/R48L7b23kIMixJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDRHVWWk; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDRHVWWk"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b936331786dso372983266b.3
        for <linux-sh@vger.kernel.org>; Mon, 20 Apr 2026 05:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776688173; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/DWXrfmtc8YO2XWPNN7jPIEbVr6gmcNQWTSTuGg23tJthr1jjEa98LVUAO8alkAej
         VTZ3AfCMqDEPNzXMORf6pynPOT1qTLAsqg8pP96cM2p6mkTNzlmguz8w2E8dKX63MQoS
         lFKi3yF/8MfX/8bj3Ag9ZSdeKZnpu2l+N3VzfQXjZSDvYsS+bz18vXwyEg82wW9qO4th
         2WeW/zGltP23VwLLI3tUdXg5wM5rGhEWcmngpu/kaH+Byci1e6KIDIzf593oTbG1NtbA
         5fni0m44Y6Z7y54SkVQpQP7cqc/ddr9U+EWJVzy2KH0Qh8gee31iXaVZJLTYfMxskH1X
         TwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iRX9LnLt4l5zNmdZzU0XVrMpvF4zu4dRaargVib9eEY=;
        fh=T7yRQISD0yERY0gXvmjYvSbtZGnWtgsippBK2HCeEXc=;
        b=S6QH5tOR5mcyLfrtc3UEZ4gMU5uvdVU0Mw9VjsmRVuqbCnNX6/5CeE7gTD7kYSTEWr
         WukLnxhyuzn/u9dRG4BJHKnTxaMebMdF5xrW69l8QAjSARLKzKLlweurQhVl3+bKhwca
         nwFkFqJqQ7xDky3LgFhgnIGmOcnQAQMBj4Gv3S2s3NCpk+gBaAqi9CvUkXEtYMdY37V4
         Az+a7A2H1jBM8HlrSXVI8HhKJLvKZzxnHycJ/sX0Pe8XBZ89lJ0ChSxNqZcOjaMRHu2n
         VRjOFDCicyq9DpBp/dIQ0OELOQBnZdBTkVzkF05BNhoHp4dRLggpaKFGB6isv6mVo4iG
         0W0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776688173; x=1777292973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRX9LnLt4l5zNmdZzU0XVrMpvF4zu4dRaargVib9eEY=;
        b=VDRHVWWkgFLina+rkYh1Z43MgSVjyxNu/jE69miyd599ELmqBIEgGNsmAMWZJ4Mcf1
         iWwPFO89s9Kc/6AxhUJGKtO99QBUr8zZjzboufFVub8eeBvSoXfzG7Hwk1M1AZFRhQVF
         at0ZNF+7I8oAVdaa+XsN90la1kJrN9alw8XWOIAFyrPt1DxrMKmotHnRGf+RkC2vn/4e
         7HZrm6T+qkWRy/zfT70mIpK0MH0s4gEG6k0SMX0MpWWHHdGL3enS8yEPQR2eqmJmGfeu
         sP+xo/i81PiJoP3grYfQ3Kct978cNG9DpVvGeUZOq/MN8a/frQ5QYSvWIghAE8AZ8Zv5
         8/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688173; x=1777292973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRX9LnLt4l5zNmdZzU0XVrMpvF4zu4dRaargVib9eEY=;
        b=Mut1B07I88vCPZyITT0XIBU3lHpgMMc4QDPCE/fUp/dpDrZEMFv+pp6EJ04L6AF9TK
         rKHBOr7ZS5wkHGx9fghXvMmSwlvNEkbdQn3Jrbouxho6LzVasR4jKPwl1V0NIfoRur1U
         xHcKJ09AYPe6toYIA4TeSjnHCJ33EopdUMD3AzPaeUjVrTZKTB2SGCnTIo8OyA4IiG9X
         a5jZhVdpWZllPUnsdkeb9vYADKYOoM/8oJ5FOV0gVTKZH9N0t7vNlpySGxH2lU2ZzOD2
         aLf2PMz/SreWvs1G1lpKR/omdPrcJJ6uefVspGWMiHDpcvkGnvhZTbBA6N6yT2thTWSd
         ToeQ==
X-Gm-Message-State: AOJu0YydJTWucJPSzQo0qaoic66/JmAb5EU8rCsKjgGi5OXhrDQT/DlY
	GoAUQs4/0Sb4zep8MjjkEEm3Nboes/MV9ZuPNcd1kmFtKmcu8GZPYSN4MQxmAtsXcY+0plIOgPF
	dYMurT13xIqH1qOj3RGlGeGcuqkpLVdQ=
X-Gm-Gg: AeBDiesFWAW1vNXKxQKaBpJ3JRsTDmeMtqG3S8krYnubCMYTVjLMUKlXlI8DR/jaZB8
	IiRF1OeVyroEOcoO/tSVpdD5/w+O1d0AvP4f2wunXFN96Qt4Wm/7ZwpxvYr+FBxgyOtpb+aBwJ4
	W3UsyIbsA0BXMUTI/GBZsplQ+15TXco6yU8WDLljKc26MMhw+0r57ep4xpzhIAxk1Shw+EL26oo
	ITfYUHoh0oWtBEFpyQBuHAMhrwLmh1/NmNqqWPiPG8MH8xVnMPkx0qtdy7Ypu7gTxLTtXPlCADL
	azcdwGQihWkeQfHtPuIZUKy/xVpPTUR6phuXarRjQ5eCo13Raiwm0D3lcSYtjfptDA==
X-Received: by 2002:a17:907:86a1:b0:b8f:848b:4456 with SMTP id
 a640c23a62f3a-ba418e86492mr644581566b.13.1776688172413; Mon, 20 Apr 2026
 05:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419162823.2829286-1-fuchsfl@gmail.com> <20260419162823.2829286-2-fuchsfl@gmail.com>
In-Reply-To: <20260419162823.2829286-2-fuchsfl@gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Mon, 20 Apr 2026 13:29:20 +0100
X-Gm-Features: AQROBzAPMQWVv7OYLTIFl9mf0DsPBr8ecPvSSvDAWjBFFLgbsWn2dgdvBiqxn84
Message-ID: <CACwZE5RhZ9COO=J=vix+k191OLGmS2YU=pUupL5nNUGJW=Dvhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cdrom: gdrom: replace port I/O with MMIO accessors
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 17:29, Florian Fuchs <fuchsfl@gmail.com> wrote:
>
This patch addresses the bug and is logically correct and so looks good to me.

Reviewed-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
