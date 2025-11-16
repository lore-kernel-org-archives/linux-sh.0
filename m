Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009430DD03
	for <linux-sh@vger.kernel.org>; Sun, 16 Nov 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763315582; cv=none; b=Y5RW5g5iv3ZPO+wCegG30SCq3Fq6irFSP+C2gEGwcINvGjHc237uQFDCMu9auNRIiNJnD/cAMGLDEsZyKIGWFY2cthyy7ngce9rB177k5Yxt4JvOCapmI9sUzieziuHv7enokGusJsaQO3M7fVIHenUjYRsUGYhFSqI9moOAhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763315582; c=relaxed/simple;
	bh=wqamGJINaNN8u93l6hZi8rnYx9ok2CVYNBMYv/PtLv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn5im5DChicpRhln/YvuXRPnx8o0XyYuOML6iZDNCy7QsZKoJWU0aGi+jeZvoQ9qxb5H+Px80vQQSrCBaiuOmE91y+WG3qiSpFWX7Vqigr54cEf50+vad43bW7sT3RqrY61ibdAd/50qOSdD5WOEvO6ylCj5Q5T/7SEZz9Hj2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImWa13m8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImWa13m8"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so5122956a12.2
        for <linux-sh@vger.kernel.org>; Sun, 16 Nov 2025 09:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763315579; x=1763920379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NwlGwBbpq+uR79Q1dMxLeECsHAi7S2zrYgtJqd6kiGA=;
        b=ImWa13m8t5/Ns71DIG0hfyO95AmZeIMPMNW6WyuxrOKQP7iZUFGoGSjGGp5K1BlkPH
         7GdG8zRnLrNCk5MxaVjUmGDTfJjz9/Ig5jWqzHxzG1WgZgMtgTLkaHXJodcvhQ5Zt40t
         MPu4oesQBhOrjuyd3wQ8kc5E7j/2+dX6APjC0ZqMFbDmrNeIkpgv0IYKR82jKBolEn1F
         ktMe+sqUFp1IqFH3BErsuwcqNv5Vn24wxiFTgvMIHQm/rFlUsN6DBMnteV2Fdf/EXdoZ
         0RJ7flUysSrSM4XiIsjdux8WB7Xp/T+/5QD5FTFYEUfDDY9TL8ALL/XIu2hZlXqOLXOb
         2E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763315579; x=1763920379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwlGwBbpq+uR79Q1dMxLeECsHAi7S2zrYgtJqd6kiGA=;
        b=YcEyNaMCp1OnMVPDmhzuy+PDnEEay45K/zTkHmsY9JRtj452TzU87mCalbUNAchpfH
         5kR4eHLuB3Biw2zrQNIPkmYb35gV3QS0BbWXBVKCWeNdNPg3OPn5cl4iubH99OCgOAZ0
         2hitsfvkSHbegJCv9hDOCxd4Y9cF1g4BWQcg6MPhQXyH2A3lMnWq0un+Xgu/kLtqxOVb
         6aZMQvMxXk8fU3AiEfTjWmXv0BL8vq5sldfK91+FxMtQV7kdLaVFtTDj+CFxLcSaA59R
         Hf4V28uxTJz3TYofNOT2bnwz87VMQ7GK1r7GXdrgn6TRJ3s/iYlGEOarnOW01yx8iS+X
         J9mw==
X-Forwarded-Encrypted: i=1; AJvYcCV4lW3SH4ijJ3Ar5BALzDvC57VD0PgwzQDxumyl0wtSuBtgt0Hqs9VeCMmGC6WB+FN2QaWQb7LjIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjpfH3EAlCoHbvv1CksEaZtdJzNuKyIjWSogIeqho6hvglUKsq
	Z9DohNEyhd8NJ/qzHNOBUuuFkCpNlMrxDz23W8yU4ZETByoOSRuOZOGc1968iCA=
X-Gm-Gg: ASbGnctoFLj6nE2LLeEHIgJc8qP7GScCQ7kEpS0KekZV7uJoPEiEWG+/Jo1FtYee+oa
	Hm4/XnaTdTEx6EImGQaErI54NImOg54xwHSXxk19QCRxmbqPbKEei+KUYNmR6qLgEZa2S4U7n5B
	l/J8TtCVMDa5BgA6NJPp/bbDrfkV2DWpuqj2qMHAi+iZ/k223AX2Djx7+ynFDYp+wKzVzAoK3ZM
	C08yvXoFI0OCIghHBevk9BcnVn2HY3WFEdcGbsv41RZFFHnb1ACBgdPJJJOBPCzrOUOswX1aKi0
	CId46LGzIwm6/s8IGtth34MYI/7h8XqoaaxtV59Tv3cU24/Vc9ObWTKxpRCsYg6zQf+HfvMqPXx
	0k5CzUFd89fqYTimbWzjazGhwjDjkzV8mA7Bo3DOVPqI2EQytV3JGScJUHEk+Ft8jSUkjlGlusd
	fzjQf2RgAkj8qwC2Sh69/IAsMeWoVnmCacVmj01KNzQNK5JV7+APAn4ZoQ9ukHKQd9
X-Google-Smtp-Source: AGHT+IGGKgYhMd0svVSFAfxWolFuLgdDkC11kJzhIf0QE+33E0NawE2RHkSBmBG+Fqlx4fZkYELcEw==
X-Received: by 2002:a05:6402:270e:b0:640:b978:efdb with SMTP id 4fb4d7f45d1cf-64350eab173mr9437892a12.25.1763315578802;
        Sun, 16 Nov 2025 09:52:58 -0800 (PST)
Received: from lithos ([2a02:810d:4a94:b300:b0de:db6e:6107:3313])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f880fsm8194796a12.11.2025.11.16.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:52:58 -0800 (PST)
Date: Sun, 16 Nov 2025 18:52:56 +0100
From: Florian Fuchs <fuchsfl@gmail.com>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] sh: maple: fix empty port handling
Message-ID: <aRoPeNu7UZog0srr@lithos>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
 <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
 <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu>
 <aRUOTfCJtqnNBjU3@lithos>
 <d25d9c581f5b4f22c9b94761972aa0fe@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d25d9c581f5b4f22c9b94761972aa0fe@artur-rojek.eu>

On 16 Nov 13:34, Artur Rojek wrote:
> On 2025-11-12 23:46, Florian Fuchs wrote:
> > Hi Artur,
> > thank you so much for fixing the DC boot on linux again!
> > Adrian, thank you for looking at it!
> > 
> > On 12 Nov 22:46, Artur Rojek wrote:
> > > thanks for the patch! Can this be tested with just regular
> > > controllers?
> > 
> > Yes, indeed you can test it with the controller, when you compile with
> > joystick support, like:
> > 
> > 	CONFIG_MAPLE=y
> > 	CONFIG_INPUT=y
> > 	CONFIG_INPUT_JOYDEV=y
> > 	CONFIG_INPUT_EVDEV=y
> > 	CONFIG_INPUT_JOYSTICK=y
> > 	CONFIG_JOYSTICK_MAPLE=y
> > 
> > You should not put a VMU in though, as thats currently broken (I have a
> > patch ready).
> > 
> > Then you can directly read from the evdev and listen for the button
> > presses:
> > 	bash-5.3# cat /dev/input/event2 | xxd
> > 
> > You need to press a button for 20-30 times, as it seems to buffer the
> > events and outputs it in batches.
> > 
> > Then, you should see the following outputs for the buttons:
> > 
> > Button A:
> > 	00000000: 7800 0000 94c3 0d00 0100 3001 0000 0000  x.........0.....
> > Button B:
> > 	000001e0: 7800 0000 94c3 0d00 0100 3101 0100 0000  x.........1....
> > Button X:
> > 	000003b0: 7800 0000 94c3 0d00 0100 3301 0100 0000  x.........3.....
> > Button Y:
> > 	00000900: 7800 0000 94c3 0d00 0100 3401 0100 0000  x.........4.....
> > 
> > The Joystick should be detected like this:
> > 	/ # dmesg|grep maple
> > 	maple: bus core now registered
> > 	maple (null): detected Dreamcast Controller: function 0x1: at (2, 0)
> > 	maple (null): no driver found
> > 	input: Dreamcast Controller as /devices/maple/2:00.1/input/input2
> > 
> > Another indicator is the dmesg log for empty ports:
> > 	maple (null): no devices to port 3
> > 
> > These messages were previously not there, as the empty ports were never
> > detected.
> 
> Hey Florian,
> 
> Before applying this patch, no input on a maple port is being registered
> until all 4 maple ports are populated (in my case by four controllers).
> Once all 4 are plugged in, I can register input on either of them by
> cat-ing their respective char devs.
> 
> After applying the patch, I confirm that input can be read immediately
> for the present devices, even if the other ports are unpopulated.
> 
> However, this patch also breaks hotplug on maple ports - I can no longer
> plug in additional controllers at runtime and have them show up.
> 
> I think we need to hold off on this patch until the hotplug issue is
> addressed.
> 

Thank you for taking the time to test it! And sorry for the obvious issue,
I think my testing was wrong as I just removed and plugged in an already
registered device, and missed it with a new one.

Regards,
Florian
