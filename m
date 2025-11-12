Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3435CBA9
	for <linux-sh@vger.kernel.org>; Wed, 12 Nov 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987607; cv=none; b=e7mX0xzod1r4KLV9hU9fCCmdwFMxy29tEah6BCx8zcoS+8yUodgm9OOUZ6hRNhLT6A69/gpg4JpWeiINuH5XsvsdZIfVRd6o2/e6oDeIktSiWcyi5VwxtopvtAoDlWuZ2aG21r8UlAZk3gZ2FXccO5pykmfDN5V+mn9KXHqZAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987607; c=relaxed/simple;
	bh=BhI42m5/V/YPwRzNwHA5N3q5IkiYtrcBIaW/cRAyGnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbSGTyiFjWH0rAS8KAGy+Jv2UzzZj3ecROR0ERQRJ4wLa4OIZZKYWPleEmgpx8SRuZAXLU3TbIFBLccBE5TiFZXSM7a9p5S3fSx4lWD5kVG6vzwFf/0Lz7Y9rMdpuCFBQerAj9hBnm3ksLfKaCTCJGTF09BMmFvvxYz1JntmTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NIR7J83W; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIR7J83W"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so326062a12.0
        for <linux-sh@vger.kernel.org>; Wed, 12 Nov 2025 14:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762987604; x=1763592404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GUuBbxCl6I1CdWQKU2N/XRDL+CV1L2620AB2tNocDyk=;
        b=NIR7J83WMo/S9HC3JWrx+YXrBgO52E+8AkjUuX/FwYrYZyr4r6DkvKgqBVG+YQYSAL
         rjhcPbmYI26Ho+Iiw0tYNqdBGzifNBcBS/Va/DDdw9mR0ZV+JYdLU9ur/B2aBftQqlPq
         ZewiR+epQ1+UC6C4eFpR1g8c+U4BBKTEUR6NrcNuzE7u5CM5HhYkViqvVpUBCm8wkm6s
         hoO9jOBRMr4R9xWp/1XscAgA+fa5hSvnLw9/m3ujRLxVRETT3enkUzzZlZK88LY6R5XS
         c1EL4Qqka9OKZ36z8C3ezpz40zIDxo472Z/IL0XYTYDSF4BlAwRfCruZzdDOGiifpJmG
         OuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987604; x=1763592404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUuBbxCl6I1CdWQKU2N/XRDL+CV1L2620AB2tNocDyk=;
        b=iEJKJk5DoqfxIA5q54AKWPzncMT+WQs5RtGAMn1R1jQYKz/LxnJ1//PvGfcugcCmfF
         fVmsy9/8/XuqQN1OM5RtUA+TDDnDwBykDRRU4LLO4YShmkvgKucvkbs1xVl9s5RXqKbI
         yWaDVGlWyWvD6A9lJ5OMAjsBiJzqNqbfCRxGeH5bWpVPykvT6gFAyzdZoRKL/AMPt0GE
         C3BsLehwoH2MyCS7297lCqrMNDBXuE2f5C1qsgfGxIIqKB3MURuwszilQmOBiubErPCz
         uF2VlN/k2GPI7mcBccfgWgnvTuBlelZ6J7rzoSNaRHR4Nd8ANquuTWflcBM0FE+JRsnU
         /JHA==
X-Forwarded-Encrypted: i=1; AJvYcCUmkwd9o5ChYSBJ3WGFQ1S8bmQuqzFVYr5wLgG5nC6vJVtJDCxeAcji7jPcSvTUenoKdQQQfRU3RA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKgU33F8GyyFB8Jy5jIQ8r5QLwRmWjJNjrPnboaR3uF8J7YtV
	zOJ7N1SEMCXLbTFAnfhTqgUHvRgpNjF6pZMyowlVndCQJ6VCvKjeK2q9lXifDTk=
X-Gm-Gg: ASbGncvnxAOsySpOge8vPdo8SsbGYvT/f5470sMnp+81jGwtR1we2m4yNVrbQuve3Dj
	rpbtidrMHnQ2To/pP8M3nWkybpdFdFreNac3FwDOHzyRU4PIo9zrB3xL/rxw07D1eQB0aX45We8
	5k9HGlBtCi2Jwy/VsUg58cBHp3pHCcO/gfs6Om0MBLSqMBQkFFyRA89jNp2pPy+Q70sep1g5ng+
	6xw/ggmCCAzH+ayEErivGDOYWtTSuoTCT2LyuRrvEJFd6+rk1frzYLVaD8iUkoNoz/3AnpSy9o1
	gamnr3fLD34eee27RMQYsxKWKCy+9KN1hez3ddwJpwi+F5ytzoMkgPU2P0qG57Lc8V2q13L7d1F
	FYmg+qxgI6mRo9Llm34PDAW2LOELMsMec6o7qQZDokDC2nYY3yVzku5B7vXtskJ9FoQRRYa3eHi
	a1pVj2D3lzOVOj/fOebc63sHWp/XQxUKJivZLutY054PkCxRNDvFiR
X-Google-Smtp-Source: AGHT+IHcrF95A8IttbQd220KZ+XN8Onx1zyj/j88oCP/XalZVeCxgeiqMBCbWsP6NPGRO0Eqy0luzg==
X-Received: by 2002:a05:6402:50d4:b0:639:f7b5:9c2d with SMTP id 4fb4d7f45d1cf-6431a4dc7e5mr4148506a12.9.1762987603798;
        Wed, 12 Nov 2025 14:46:43 -0800 (PST)
Received: from lithos ([2a02:810d:4a94:b300:ec52:7cf5:e31:cdb7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f96e2sm71050a12.16.2025.11.12.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:46:43 -0800 (PST)
Date: Wed, 12 Nov 2025 23:46:37 +0100
From: Florian Fuchs <fuchsfl@gmail.com>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: maple: fix empty port handling
Message-ID: <aRUOTfCJtqnNBjU3@lithos>
References: <20251112190444.3631533-1-fuchsfl@gmail.com>
 <4f70a38490b12d13858f45f3e7a531bf5dc2162d.camel@physik.fu-berlin.de>
 <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <999e3970e1580def5ddbf1921a9ef4a4@artur-rojek.eu>

Hi Artur,
thank you so much for fixing the DC boot on linux again!
Adrian, thank you for looking at it!

On 12 Nov 22:46, Artur Rojek wrote:
> thanks for the patch! Can this be tested with just regular controllers?

Yes, indeed you can test it with the controller, when you compile with
joystick support, like:

	CONFIG_MAPLE=y
	CONFIG_INPUT=y
	CONFIG_INPUT_JOYDEV=y
	CONFIG_INPUT_EVDEV=y
	CONFIG_INPUT_JOYSTICK=y
	CONFIG_JOYSTICK_MAPLE=y

You should not put a VMU in though, as thats currently broken (I have a
patch ready).

Then you can directly read from the evdev and listen for the button
presses:
	bash-5.3# cat /dev/input/event2 | xxd

You need to press a button for 20-30 times, as it seems to buffer the
events and outputs it in batches.

Then, you should see the following outputs for the buttons:

Button A:
	00000000: 7800 0000 94c3 0d00 0100 3001 0000 0000  x.........0.....
Button B:
	000001e0: 7800 0000 94c3 0d00 0100 3101 0100 0000  x.........1....
Button X:
	000003b0: 7800 0000 94c3 0d00 0100 3301 0100 0000  x.........3.....
Button Y:
	00000900: 7800 0000 94c3 0d00 0100 3401 0100 0000  x.........4.....

The Joystick should be detected like this:
	/ # dmesg|grep maple
	maple: bus core now registered
	maple (null): detected Dreamcast Controller: function 0x1: at (2, 0)
	maple (null): no driver found
	input: Dreamcast Controller as /devices/maple/2:00.1/input/input2

Another indicator is the dmesg log for empty ports:
	maple (null): no devices to port 3

These messages were previously not there, as the empty ports were never
detected.

btw, I have also a cdi file, that boots for me, although I heard there
were issues on the NTSC-U devices, if helpful:
https://github.com/foxdrodd/dreamcast-linux/releases/download/6.17.7/linux6177-joystick.cdi

Thank you for your efforts,
Florian
