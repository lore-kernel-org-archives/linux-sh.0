Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F61EA7F4
	for <linux-sh@vger.kernel.org>; Mon, 22 Sep 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551352; cv=none; b=aRPzMS8fbe+IlqbEqignYrWU4J2/0uHA8BoPKnkRMqYlubFrgLCss9UvoHBhb36jYqud/nrSj7HtCwA3N9OsNdo0NJj5N6vGBkJBP4Tgfgti83FnwpyxaG6rGr7EvxCJFrjBI1X9/wBLhQXYnEe5DNr2Pl2jD+eOA8eJtX1GYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551352; c=relaxed/simple;
	bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpD514qtXzOGx2bosbEUM5YYPNdb+mKbXA5L86Fv7WORuXUi8HJAZXFWTX8C53XrWRcsch4ZgzActkdwwEAoljZydW0qRLV3jW6ycMMHgtdvgie8Bh++cGOIxa6/qY8e8E3NrMd4v9c5LxvAy8b6nUVNOLK6/rStQYwjlvff0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=jZNWaBOl; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="jZNWaBOl"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so3950552e87.0
        for <linux-sh@vger.kernel.org>; Mon, 22 Sep 2025 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758551347; x=1759156147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=jZNWaBOlG0M+B6PgZYRydnhDcAaeUgyy7nflggv+R4pWzkTXHztSZokXStgRTKBBUf
         i9/568a0ZB7iPgUv0pUrs2SoMYgVLD7zPunCKA/NF1k+zfOc0lmjgv16SNccc+nTl8Gl
         ON5sgO+VavYIy0r3KbLBgIBMX70KVx9Wm9w1x7YIaXEroXH+BXaV5Bae5vGgOfcHDhTE
         7f5XCm/fzJjXloU4P8R5gRP7ba9RmcsPwBq4T6p76aaaLshJI8a3LJ4DUJjmmP99RXUz
         O14Xhq40s0kHUKk786Fks5p3If19qWT6PYuuWqJSG9HHQm9U/hbcZct69UrCNv1CrtIg
         NB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551347; x=1759156147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zds9c11i5EPuC+LW5E2qVk5slu7nHVv1cCYASY1uK64=;
        b=gn862fr1tUIpxLpvcqSq1U8kT/18C2GJy91GkeyD38MMWxtHaJAXWFpQFTc1/Vrd/b
         2pzpThDkNk1/XwQhf2QDJKJY7t2BHI/RgM5tK0aMVMetUrT3toaFHPhX0EAFAgrHtTHj
         2tVeJpMS7cxcioqc5V6DKL39RpAPk1oT7QI6QHscnuVqCGWtYfcGWEHEVe9Y8flCFc7P
         +ReyyFz/OGDePfrmx03B7h+wFu7fe2h/TElFoCShJHGOZnEDZF1dlcgvc1hFh2cjUAj5
         veo1aIvMebGyMcBXWcNRTeaxeE2NVTl1YDsBqCVJRzqDBz9tgFDG6mhCLkcliWKPPeHG
         eC2w==
X-Forwarded-Encrypted: i=1; AJvYcCV3g3k/sRy2gWgPmX6Mm1+X5mxOBrTMAQRJ4SvrFZWwxYPo+Juqh2BBFrgkQUHap6lPQ6FWkjpspA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1qq554Vns3AeXOj1hGg1mnrAf+oteME11vPZuFrAP99jWDK9
	5j7X8kOEmR4B5WSUycdmvKwo9Lchm1PyQ/ADm9fgs4Ehdv33UEgI+mIaxEVlQXboPEIag84ng7r
	yXhVnCZvNCMtSjEtHhDhLzfRpaU8pcCO3jd6rr6S6RA==
X-Gm-Gg: ASbGnctbmX8IPtoDKQNBv0NW+2iNbFIGoGluvRKYoodlPJeKfGsqOb6JqDN8GRpkFjx
	Jy7SICwyQucbLPntuz1vGKab5a6oY4uSffKhP43BMQaU6p2QkENfzLGo2b8zCy+Vx1jOerAZSFA
	aaQUaGPDXmZj+5mPjoQirb0q2kQuiJBnHYqHZInGIh7NeFS7OOikGfetu1EAUXAAQjWiHbm8jTS
	kbVGxvv5v8Q1zw=
X-Google-Smtp-Source: AGHT+IF9Kx0YHTgWZximr8IphichwJGTQ/wmiFKfxBKU7xEPIwY53K1eZ5EsUZqb+vcW1xAllqgOcQU2VEEacURTmEE=
X-Received: by 2002:a05:6512:4389:b0:57b:478b:d8a6 with SMTP id
 2adb3069b0e04-57b478be162mr3313173e87.35.1758551344116; Mon, 22 Sep 2025
 07:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com> <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
In-Reply-To: <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com>
From: Nicolas Schichan <nschichan@freebox.fr>
Date: Mon, 22 Sep 2025 16:28:52 +0200
X-Gm-Features: AS18NWBjmNA3KBj8cPrgwDAVm5OX9a5odWP7LbRlHvhoE96nP3yo2_PGoZ1JbG8
Message-ID: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending to the lists and Cc, sorry I initially replied only to Askar]

On Sat, Sep 20, 2025 at 5:55=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
> On Fri, Sep 19, 2025 at 6:25=E2=80=AFPM Nicolas Schichan <nschichan@freeb=
ox.fr> wrote:
> > Considering that the deprecation message didn't get displayed in some
> > configurations, maybe it's a bit early at the very least.
>
> I changed my opinion.
> Breaking users, who did not see a deprecation message at all,
> is unfair.
> I will send a patchset soon, which will remove initrd codepath,
> which currently contains deprecation notice. And I will put
> deprecation notice to
> other codepath.

Thanks

> Then in September 2026 I will fully remove initrd.

Is there a way to find some kind of middle ground here ?

I'm lead to believe that the main issue with the current code is that
it needs to parse the superblocks of the ramdisk image in order to get
the amount to data to copy into /dev/ram0.

It looks like it is partly because of the ramdisk_start=3D kernel
command line parameter which looks to be a remnant of the time it was
possible to boot on floppy disk on x86.

This kernel command line allows to look for a rootfs image at an
offset into the initrd data.

If we assume now that the rootfs image data starts at the beginning of
the initrd image and is the only part of the initrd image this would
indeed remove a lot of complexity.

Maybe it would be possible to remove the identify_ramdisk_image()
function and just copy the actual size of /initrd.image into
/dev/ram0. This would allow any file system to be used in an initrd
image (no just romfs, cramfs, minixfs, ext2fs and squashfs), and this
would simplify the code in init/do_mounts_rd.c greatly, with just the
function rd_load_image() and nr_blocks() remaining in this file.

I can send a patch for that but first I need to sort out my SMTP
issues from the other day.

Regards,

--=20
Nicolas Schichan
