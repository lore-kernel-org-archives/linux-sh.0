Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C993AB460
	for <linux-sh@vger.kernel.org>; Sat,  3 Oct 2026 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021068; cv=none; b=d8y+Yok/pUfhNQq1RWz3ibHbPj2KamSUOlPRVK0PV7bjr2TIvNST2+Ft+GkTtATnUArqvTeIhYuyNuxcByvmVv8544/UJ3C1swDR+vW/mm4aiNhAthNLOAiRhnGZF1tLv280OsV/uiWauoBCugtLQIBBgA2N5Mv3ftGiA00dzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021068; c=relaxed/simple;
	bh=2LbseY8Li50TR6rDmKPlbnzBHn4spOvnRLGc5EbwpoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0Z7aTto1b67rAwa/BfA/QzxpNMo/7zXVtGk5cmP0j3D5nvgvGIvzSATxLm9DV4NsEc0PCfoABfZ8fwgusjD4sS9MLs4FjHLKXjYdPwTyJ50rMOEcN9mn+Y0xOCiHEEyGkYS5MiMU+Rk/fSrD8/Qj3iL99Tyn4eUcTxtfwPvA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAbgGjXt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAbgGjXt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso144670f8f.1
        for <linux-sh@vger.kernel.org>; Sat, 03 Oct 2026 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791021065; x=1791625865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rxF/3AxLSPoXIJFdNjU2f7u8Roc3pXcYGxMID4pJMyw=;
        b=pAbgGjXtYT9/PZNqw/lunpreIij23GmKcD5tfqC1NT77Cwrm1dZf98J03zT/1uifrO
         S30O9HJSN4aUISetucqueW1CQ5bhsnnHoUGuE5LWkNagCoLwpJmXzCeioHUj/KXRFPui
         poYzcXMJR1SwPyvdDeUKODdzIrBCRhxkE7THNmW4tsg7EKjzI9J3VGf5NrZNNBMaWmPw
         Dre6oi72Iol0pwipeB8kwZ41qtnmI6fTHCJhu3Tq98RSAUdF2uvBVvsRTsWbrf8NzeI8
         RX6ERo1n/7RRFv+ejrQ7zIiRkCAhLwz2JfvC2WcVhjR7MgCadBc+qNtcNJaSmCkumfyj
         EEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021065; x=1791625865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxF/3AxLSPoXIJFdNjU2f7u8Roc3pXcYGxMID4pJMyw=;
        b=dcROn+HdHJ5ZHqPbCwskWZFo55wFegikvqOANlU20tdmos1OvKATCnVudy9AM2w/o6
         s62biTNeG4vpiPt8acFHqdIyo80hAOURr51TMo21FcW9LoN4MND9ubD2ITShY0i/HKk+
         Z+rgXqa4O7mK7wU3QCwM8HAXl4hG2vPEg0UgIHuaM0oojArhLoG1yyzJ36grBNfnbwPq
         173C0Rxk6SHctd3XQ9NTfsDhHsVVBJ4s5SLjuwFGhxQy95MzJ0lCQeBU4CcZz8f3uVLM
         Arm3yJIUYPo3a6O8wxAJKZdQCGud/hnMB8o9OZIn29g12vNkLY5UYUGNHM4w4FRzGSrh
         Yfrg==
X-Forwarded-Encrypted: i=1; AKwUvBxOmGupI/uUyMt6SUCCVgQc40afnAaUdNXsb/rfIp7CPU/4Giy3dqFexBLPFSTBWqitqszjNbQZEQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIX8W5YWjCBjtYTQdPWEvQ0znKMP2tV3f25CRJWNsjW4pyp+tiw
	AtVMQTnvBOe3U/2+iPa2tHSzGGRomJl/7e+VWT6Iv0F/v511rNOIvlNG
X-Gm-Gg: AYBFou2idvJutt/CXQKT5w6M7/1AIB+NDyDGsr5c0r/JfdL1yGu0X+26Xy6ZO9Oi2AT
	I+C+G1rMzGJKBQJcc0dkeTF5UJZ+xui7bCx70cOVVUJyCc8wLqVkrp9gCmFhQWj7qGHUATbMTCs
	O6XNbQc4unH2oZ+sqALsfGos+xEMyM3G4isqKoAT4HjtkWHZxfm9ESpS3TRiJj2CPJWgxscTpeZ
	8cZOv6M009STEggfV5wQurAfEvEtKN6ThgLk6fL/oueOsKwxWgeL37vPpFj+Enn15XjhMxF5qCk
	VUG24+TfiQTYDIlnZQCq64+P61FXbqCX6+0NdI17NmNfEchwmUX4JvG6rW8NJrgyhtvRwzxDIyq
	tdFGpmte2fFy6wY/aaQ+4Akhd4LWlMu1XPHLX6E9vWMeEip3V81rGZ4VrS7FKcJ++hi+8GvpsQs
	ZkNwmfXA2G9NcvQsJSzfLJeWdpGOaX/3QCISGQiScDjm5515fe6x+mF/mGO/+a1pc1R16Qds/Vg
	FX/3HkHaZsBVB8SPnD/Pj75D8aW6BhszpPwCHnkmIoxF7mLcdkaNWzwr+WreGgqtpiqscBzzQ/x
	g9a89dGj/PwyYibelwrF1ms7w8qxi+Is32uH3nSorTb//Yxh5tipODirlyt1KH5k2CQJayvNwC6
	qz2avRA==
X-Received: by 2002:a5d:6f01:0:b0:487:40d:af29 with SMTP id ffacd0b85a97d-48c47ff2919mr2908911f8f.36.1791021064393;
        Sat, 03 Oct 2026 02:51:04 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b2e2-2001-c47f-5a89-3d9a-cd2d.310.pool.telefonica.de. [2a02:3100:b2e2:2001:c47f:5a89:3d9a:cd2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380fada5sm10811991f8f.24.2026.10.03.02.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:51:04 -0700 (PDT)
Date: Sat, 3 Oct 2026 11:51:03 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: sh7785lcr: register the PCA9564 as I2C bus 0
Message-ID: <asDOl5bvtlbauh9x@gmail.com>
References: <20261003082833.21511-1-kmehltretter@gmail.com>
 <a4dcd9e615dc4e3c98c00e75cdd0c7fdeef02254.camel@physik.fu-berlin.de>
 <e3c88969f18c493859f7c382db7ed2afeb15b4fa.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3c88969f18c493859f7c382db7ed2afeb15b4fa.camel@physik.fu-berlin.de>

On Sat, Oct 03, 2026 at 11:38:43AM +0100, John Paul Adrian Glaubitz wrote:
> > Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> I have to admit though I don't fully understand the description of this
> patch. Either I don't have enough coffee or it's not precise enough.
> 

Thanks for testing and reviewing! I agree the changelog doesn't explain
why -1 is wrong and 0 is right for this board very clearly. I'll give it
a day or so to step back and submit a v2 with your tags and a better
changelog.

Karl
