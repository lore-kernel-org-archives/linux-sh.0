Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873632;
	b=WpVIm0bSZwgsOZEYRP/WrKhQgON7l6K730VbKRB9vsYgEZqXHUi4C8E0OYcV4x+Zv4aX
	 wmkIw9ITpWXbOS1sUGXr4Bzo6WGAQ1jovy9lSZJpLZpl5r8f06cOowa3rJ7Wn7CDsQbdZ
	 N3m0S4pbIQKAvd3IP9OfWj2NhHy79UtAM2Qx4387aRhO1U51UW4A2noLPfmVVM9AtNITz
	 Z3RkJyq7bBgXyKobRpAkNS2QEXl6m3ut9gwq4LQNiYOcPeM3eumvInWH9uAygq7Qs5Thr
	 Xlb/q802v6OHVv1QLVEV+42JB58uKcXYysEtLoPIgEagL3KDv6PtAY5bYrlcSFRpdoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873632;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
	b=r1SvY/aXVx2OEYigJZBfoYQ9Hqjhg3kAgsUMY8kCO38EJGv3sa/fpH4EB/lsMaxaZm5e
	 jeG94/9pcl7FSkXCpidQMVuKxWJHd/3h2+J+oN3mOTAoErGxF5/pfPFa8S4maB8itAHwL
	 j24NqD5MrARu4h9MnCjN/VkKqhhQzqcMUH29+VAo5iNfPxOqPAD3fFQG/qZxl5a2ETEPL
	 TQUbIVAt4SuLRcJWXGijDzRt+PgsXJSp+nMDp/6+TINrj3j/qDkvUIxoGO/EylKG8TfCF
	 jzUmokLrCQhNKx5FAxs2xiO8uHVP2nDnrKCn3Msd+EmE9XUV2ydxc/J094qI8I02fHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A7606A335
	for <linux-sh@vger.kernel.org>; Thu,  5 Nov 2026 10:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 535A7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-54d9ac78f2eso326841cf.0
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873631; x=1794478431;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HRfPjQi/EPajP85bp44Mrjs4W2fVG4O74jaEjdHYdtc=;
        b=McRbwFZFRV5IdLiTwjHyJ0V9XDeYXB5/eLhvuTqGK7xOUETglid/lxwB3KF73xNDl9
         SE32NPFqnSZudo43jlvkF+tT7v8ijKcZRsf+iP7gVmWkC8iZmcM3yzgRQ/eus15smpdN
         vp7zNA4SsnWa2bLOOf8b0+9OTe/mkgF2DrkQOdvDz6F6b36JYAv6VJ7DhHR7jxcIFeTz
         SYxnbwewDYjRxjHaQnSTX0mp8uJB3Z8L+n6xZCR2Gg0J1fflCkOCHah9435lV1h8m/xr
         +GHiqnvMa4ronfFt/plLHAenIq17Y38WrOzQJ6qZyjWRo/Ih0lO2RiYWfMr6rEH0dnoI
         KwUw==
X-Forwarded-Encrypted: i=1; AKwUvBzWqwuJoUijobmsEaBwBLyvPvhMVqx6exyM1a9rSStE8EF4hGpfAl2UnEeiFAV51v2j3EdVKmgIzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8PK23+W7q1x0azSPpMBhXBdCbgAnVyG9pa79rHIZcRu9+sYesz
	6JhUAr6D57T9gVcXA4ZbGz4dGzPQQl47wtWl0UbSXqHzgDeuyXjsyjkjoZE+IkMhWWM=
X-Gm-Gg: AYBFou3MhBC74I9vhI2VBsJ6O3dlwCJXSg7dT5rVEnwRx9Wz+xBxk2wpcFjQO4L8O7p
	hR/1Ag0hAlv+Zf0rQ0usOowMfn5/6SMVdlWXciuM99DhW7wQl0keToHpoQlrNTMh9bo+SwxwgbT
	GEGDULpiUjbGSqPplzIvwn7f/oOko51Sayq2iRNyFYnTlzm6BKPB7Wx2XFUrdtES3EEZRCfFdyb
	CSzeNZ35cHhM9Uy68rfHd8mEigiFmjlodMZNjE5eoI5bX44bdun+AGI7ZBCtRnrEPtKG67N1KO7
	jyWj/KWQ36XenQodK7eeEZ8d0sKxqtc2U6eAcTmh+2yU9GIFki9WMMhGrr87YqQ4VXONL4QenN7
	8CgeGiAVLg+FZCiReheW1jHXULc1NcEYqbjA9MgEOlpsA4RLxvFtFm5lgsX8hCOUm+DZqR5Or6Q
	teOd/r4atpw0KzYaYmsN0N3z2vz3Oy3maqscIWTP0f6H0VaKs5dYSv7Aybr/0dhtoA0SpgtSHBl
	IKbfy84NQOTqR/Vqg6qapdcVbWpsivXBTQHjalxT0p2qBXDIuX7Tviq4euEqLr3t6R0reT4JREJ
	0HAF/qE/CuTtF9viLDdEbFs63+6ZynXRFAmgawrxOWNiN7sXcdsbnzgQ029vKGR3I4w=
X-Received: by 2002:ac8:6908:0:b0:536:71f5:5361 with SMTP id d75a77b69052e-542b3e68739mr294782751cf.11.1793873631054;
        Thu, 05 Nov 2026 02:13:51 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4c4f3sm48313721cf.22.2026.11.05.02.13.50
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:13:50 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c719669a8so17273466d6.0
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:13:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzu0ibDN7ynIVZFnFRbZLIag4yXxEZVwkD3zPWewdJu54E6zamJo3PruCOJXswGJSmHPcpW24a6Rw==@vger.kernel.org
X-Received: by 2002:a05:6102:374c:b0:7cc:1a41:20e8 with SMTP id
 ada2fe7eead31-7d07227a940mr8060714137.5.1793873263361; Thu, 05 Nov 2026
 02:07:43 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:07:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
X-Gm-Features: AclHuK9naqg5CZQ7lhJVrMhg9TNH44f-SpA5WbUGCGBsAlcoOw2midTd7doJSmk
Message-ID: <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

On Wed, 4 Nov 2026 at 20:32, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_write() pins the entry and calls ->proc_write() which copies
> from userspace itself. A page fault in that copy can take as long as
> the writer wants, just like the copy to userspace of a read, and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for writes as well. An entry that implements
> ->proc_write_buf() gets a NUL-terminated kernel copy of what was
> written. procfs makes that copy before it pins the entry. The copy is
> capped at ->proc_write_size bytes, or at PAGE_SIZE - 1 like
> proc_simple_write() if the entry doesn't care. Larger writes fail with
> -EINVAL. The proc_ops go away with the entry, so procfs remembers the
> limit in the entry when it is registered, like the size of the seq_file
> state, instead of pinning the entry just to look up a number.
>
> Entries that take binary data in pieces, like the PCI config space,
> ALSA's data entries or a firmware image, can ask for
> PROC_ENTRY_SHORT_WRITES instead. procfs then copies in the first
> ->proc_write_size bytes and the write comes up short.
>
> ->proc_write_buf() gets the position like ->proc_write() so entries
> that write at an offset keep working.
>
> Note that procfs copies in the whole write before the entry looks at any
> of it. So a write that is too large or whose buffer can't be read fails
> before the entry's own checks run, permission checks included, even
> where the entry only ever looked at the first few bytes.
>
> An entry that implements ->proc_write_buf() and still has a
> ->proc_write() fails to register.
>
> No users yet.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -67,6 +74,16 @@ struct proc_ops {
>         const struct seq_operations *proc_seq_ops;
>         int     (*proc_show)(struct seq_file *, void *);
>         unsigned int proc_state_size;
> +       /*
> +        * procfs copies what is written into a kernel buffer and calls
> +        * ->proc_write_buf() with it. The buffer is NUL-terminated and holds
> +        * at most ->proc_write_size bytes, PAGE_SIZE - 1 if that's 0. Larger
> +        * writes fail with -EINVAL unless the entry asks for
> +        * PROC_ENTRY_SHORT_WRITES. The position is NULL for a stream, like
> +        * for ->write().
> +        */
> +       ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);

"const char *"?

Seems like you have to drop several const attributes during the
conversion from "const char __user *buf" to "char *buf".

While at it, I think it would be good to use this conversion as an
opportunity to replace "char *" by "void *", which will probably let
you drop several casts from users.

> +       unsigned int proc_write_size;
>  } __randomize_layout;
>
>  /* definitions for hide_pid field */
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
