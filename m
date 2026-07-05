Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969E1CAA78
	for <linux-sh@vger.kernel.org>; Sun,  5 Jul 2026 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783279733; cv=pass; b=UBPqOlv0U4sGOduXXQdFajAxzoOtKs2OLltSx4O3iqnAXHxHUI5frcpa7jGL3LoiphLjXd1Je4wB592DQisXIWeqJTIzF4kFj3B01GfH+oGjq49FN0CNNsEv20fr2vZ0iQfC2FteXzGGA64Zxd/IPscTqnIpC8n2WxGhW3H9qp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783279733; c=relaxed/simple;
	bh=VhQsGX+V9ShWrFHxkQbu1Cb0ivr/xcJBbpB4mcmpj60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muxpymU1Zi4mxq4Zx2W+YvB6V5LnvPF7TBZ9sHkuFLpgQEobju0Ra6D8eI4FrqT8GEqGSzRJ7W2Bdzh8WsbzrT/UczRk/i+pCSGS6RANqZNNSfC9lqrVLGo5Ig/Q9EfnLKEHZZxjlsKVjP3AKA8gXzWNxQgs62Z8/g2h6jXrRZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0Rz9hFh; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0Rz9hFh"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so4057477a12.1
        for <linux-sh@vger.kernel.org>; Sun, 05 Jul 2026 12:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783279730; cv=none;
        d=google.com; s=arc-20260327;
        b=b7JwXDxRNDVVn99syaculaX7KZ5JinA6vSydy0H7T1CyrksDP5+neB1VnQd0mxfM2U
         LYLEvU5mvRpX+4z07XIhqqe0nWkfmAkP+ajHWw4kCRO4t0cF+3JzhYmx/+6caeLAlYHJ
         n0rD+AVIpJNj21hdzvuu6wETKzu6qhIk29EZLsVFbUeeaTMFjfvB2GVSmiOCmvhIuyaB
         3bNvX+2S013Ad2Tu4ortFP/IiUbPndkJp3ZGizaWpDNBv+ISEtuhtdeTJcJMuAHYVhvz
         J+ZzhSG+be6q9xTWoAwKkMettzSX2eyrP7IpOTxcTIHnKU6ti8fM7DLqzhN1GDF6J7Ha
         TX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6JUnRCM2Qxk6xap+InmsyC5JjApM9odZFBQkppiWmYI=;
        fh=VT71vyalj5gkVclLmCpGznrOS8knEu480YQ4aeo5Buw=;
        b=VMWl9lHOCUZ4OTRitf9dSq4gd3XBBRfTX2+3W8vOaINHFiuLHltiICcgtLPykBqNUb
         xTdS/xqtl5bA5IG4XjZ+nt6D0F96DTag9MiK+UFo0oQdY2+ixH5TxT+78w7yo3CU/ySI
         yGR8/1yFj0q8UBP75kBIpVMJV08E0m68FloXG/9rt8qbQUwfkinNL8ztaLgdT8j+OSIs
         EC4mexI8/cTugBJIDPFVox9B03D29lFRT2e9Ze2QEqN76AWb1KKxVLor5NxdkgIp8jnX
         PclEVYx38f2J37SspeANEUVPBALAxVFrL6grpqDKTORwjNRdK8OGt3r+VZ49tydd0/eJ
         nzSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783279730; x=1783884530; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JUnRCM2Qxk6xap+InmsyC5JjApM9odZFBQkppiWmYI=;
        b=J0Rz9hFhl52b/CWkrpvzcx0Am4/EpNLTz9CsPrcTGSKcjOPscQvr7qoWyXrWBcPY3+
         KcBS7BHDEOJinM8YtJH+AKP2zbGUD9R1ltaqdvR+1xFZH4zfUeVbiUcxTc2nih0StTjF
         DWWOdK9R9UmFqHXpIhi1DWsAHCOxAKpEmN2UESspBxHehEHQho+NqhaDHwCKvz6vSQPp
         fRPMGirJzF6V2rx8OOX9+v673+O6ZW1lpqqySLNkD0niPE1hZFTG8i1TS0aZUAM7V1rb
         blztwB6yg/Ur3NEVKE4uotmQ2Tfvt6fwW5MLdDRLMJ/W/8s9/LtVZ3w0bySHcOo55wCJ
         WVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783279730; x=1783884530;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6JUnRCM2Qxk6xap+InmsyC5JjApM9odZFBQkppiWmYI=;
        b=dPPsjWsWt6jYkW9OOzZkqNG+JVnYkKQpmCotasu9SEI/T5OlPSjryQ1DU1j73uHndl
         83xFYexRt271g2ll+MzOd9pu4Vgr8xkEtYQ3noOO8/cOrpWqF3dC3WoSpb83gGFV2F6g
         Ap2lSW6JUx4xaGOBObNtSMtoecuqtD9RfaZjE7enYrobMwijE9bntArvYSc59GyDhOzO
         SIqUoFamX+Ji60HLk+FYqC7tFq7ugxbypNzoUCBmCEN5Sb9xK+YrNnZFDBvKmlb0qJSE
         Cz8pUdGvluxLXk7OasGF1CRpaPxz/cPUuMK4FOMBj3crpojzGmrIRCAbzeOg7ecyG762
         ZsWg==
X-Forwarded-Encrypted: i=1; AHgh+RpXrOt2V2nW5eT/rhhOytLa1GoQ0yuOCYXAEcIwOza5CQj5y0ptiw2pjG5WXumzh/ITmpUfk3eh7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SBAgI2PbF48Q9zh2A5K2jmW3mZsffSgEZnWDBP3lfT6WflUA
	vCQv6bM+zlWkBCUVixv6ccgbWOTR93q/n644uoVIgPgUJnf4QB95rNoceBy/4syBWkfuLAnwtRc
	SjPcT8nUwHwI4+XOjs6ba27D5u+kUlno=
X-Gm-Gg: AfdE7ckqq+OLaywN/sN1UCDjbW+1K+kjRz4onLc4e8ruvNbj566einEsXS4xDDnrE86
	Gaa2HZm26/w+/ueRBpgQCO3MzfvvCOiV29BGsGWQ3j2WyODGxmOk4cCg2LFlSJ6DFF175KupgEk
	65EoA2XKn3zXs1QSwh0DSN6BD/zjj1nyYQjZ+9090YCkZNuqgOp8FQw5Xedg+0yLsKu0ao70US8
	thAMbzJ4yhDlTNsjE/0x54RZrPH80VMWB6B7I/taLdtwVNKqSx8Mf70j1Y+X+5UHu5Chu/YE/Eh
	+0qDM80Ud5R6sPf9KApgkYQuIz8nkeErDbf8OCrYwuW+1miAyRNcpT4=
X-Received: by 2002:a05:6402:1911:b0:697:5140:a146 with SMTP id
 4fb4d7f45d1cf-69a1a24e2b0mr2111550a12.5.1783279730260; Sun, 05 Jul 2026
 12:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com> <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-25-41e424964da5@gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Sun, 5 Jul 2026 20:28:39 +0100
X-Gm-Features: AVVi8Cd4RsxuBCDMTegUym6Q-WwoYX7kLkcoRLuTn30KplUiorM2f_4ETnTctuU
Message-ID: <CACwZE5RfhwhOoVSPqibM9+XaPJCf-TdnJxi_UT7Dgv71OJPsFQ@mail.gmail.com>
Subject: Re: [PATCH 25/26] Input: maplecontrol - fix style issues
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Florian Fuchs <fuchsfl@gmail.com>, linux-kernel@vger.kernel.org, 
	Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 Jul 2026 at 06:58, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Fix coding style and formatting issues reported by checkpatch.pl and
> switch to using BIT(). When reporting D-PAD events avoid conditionals.
>
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/joystick/maplecontrol.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
> index 3ef6652d40cb..457a73d91239 100644
> --- a/drivers/input/joystick/maplecontrol.c
> +++ b/drivers/input/joystick/maplecontrol.c
> @@ -35,22 +35,22 @@ static void dc_pad_callback(struct mapleq *mq)
>         buttons = ~le16_to_cpup((__le16 *)(res + 8));
>
>         input_report_abs(dev, ABS_HAT0Y,
> -               (buttons & 0x0010 ? -1 : 0) + (buttons & 0x0020 ? 1 : 0));
> +                        !!(buttons & BIT(5)) - !!(buttons & BIT(4)));
>         input_report_abs(dev, ABS_HAT0X,
> -               (buttons & 0x0040 ? -1 : 0) + (buttons & 0x0080 ? 1 : 0));
> +                        !!(buttons & BIT(7)) - !!(buttons & BIT(6)));


Maybe I have missed something but what is this !! operator?

Adrian
