Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873323;
	b=xOXY6Gaf+4aqfBIgjtcm2F/TtflTel38LGF84uN0sYD2Rid2eUJGPqfmQkphCHJ29oBM
	 cgmO7C5jFFsfHGbBxoUqEgZBmMR55N+rU+jMSfbFptnKSQyaMCG8zxgA1b1HD1AT0rv2g
	 yWBFkt+X2+Byo74Ve+ru0m15ttddozzhPDaoU9W8AW8IuQOVHgJ3ynFFHIbs3ads+iDZp
	 B9rmPpnM+ehFnaV0O5pL2tg6o/kDbfgvh+Jbbi8HHZRlti1PrpKv4MNLaDHcnsXjiY/Cc
	 3jKsGX0cg3ecdH3TxwzAQkbqRws8jsUkzM722pYP2Q3vVAPtLeJ3MYxDZ6aoQkeX5ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873323;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
	b=By6TOpFrhNXKt8g/5lo8kpd03SqSqrAhkEWcQVU4wtwE7UV6jV014ghe//cszgmQJzEB
	 jzK7xolcHdJEisO0mBF99c9wBdUTRJh4QiPHjWf8FqohmvomHPL7dYonwP9SXfNKEoMiC
	 fd3EV9/ojQ4HG6u4inwHui40gUeVEgp4WOs8M5IDQ7gavpavPtUmvrumbU1q9guWuVUwo
	 0kRfdHIoqtOYkBMMXYXuYf3VwaMPhWgW5S9TWFIkVria1nbzR5V4PChl3i4Ar+ZAydy/o
	 Ixzskr9e+b5FoIaOrusiTcQ29VCWSzC0LOLgdRA6KZlllamhI7Q8sumWVCgMAcjZlcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0660A382F
	for <linux-sh@vger.kernel.org>; Thu,  5 Nov 2026 10:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC0660A382F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7bec5112765so1033420137.1
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793873322; x=1794478122;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z2qCIfu1coqF5CKQo/xHkFXbKW7Y+rLlNCa31RZmxiE=;
        b=HD1muN2hSoB6lWXcpJK7ZgyXbraGXb/FQZoMnCrYFGqV25Ke0bi+Gae243YeRFXX7n
         mRd5fythCHImubAcPEwD8btekhhhitNEHO5c9e5pWgdGgQt3hrsjKXbxyuW93TrZV3LK
         wtPCjKmQbUf9w3+tvKpAFoTG7nv21z33W2KiiZYrocSrJbFcR6uqSpETyNgou79OjfT5
         +etqwEv++DltIHqhMi4FObfWJ+e20nDO/QvlP0/vgzInUI/FB8dcGjkZR9K6M8a3n2tA
         9K1fPu2MTCKk50aehQbaRhHbdC2CkQogD6nI+hRhvWHrDd9BAaYgZACYfGvS6yOCLCG/
         KDxw==
X-Forwarded-Encrypted: i=1; AKwUvBw2GA5sQZAds2hOE+ut1ZencHkLeEXKpmdBuv0PrjbI/dIiL2uGiEROal4RyfEjCwv1jKXi2fJ8JA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8z56eJ0kRkVtsP0cf6xiq+Fa/vT5xlQenDLzjFN5k6r7a/9An/
	H7mUKEzu9cluWbcffEB1gKiDnguxsqUEANOfnewH2rWbPsC27CmsNJRPbadn2cYsEOY=
X-Gm-Gg: AYBFou3xdC3NVBp3n1Nwh/ZUyGvThoi3hi8V8DR30ueZPQy19DMNEtAmGjqlUP0nBiL
	0T3++NmT9lXA+1qeXRRfKzUXmTcGswSc0nJoI7uik8Qo1WZQhHv5ONCdgzKB4OEBJDAsjx+9toJ
	lzL5S8OMRaq3YbLlqWXXckdy8HfhRgPTegeiMcNgE4MsP/n0gfvbx8oFVPY/pT0Hws7nTv8Bgpg
	cAM30A1oJeR96gJ0ZBpBJWoU1q0qZfq7wIn+Wq+yFFxjQEUv6SuT7aHjv46vOEL8eOjOS9KMq3K
	YcEvRipw6KK2ybYiUybaU1uaGU8/Lvz4I/eV4xFMo+Xvr0aj9vO2U84ecxDhDWCnEJ64OfJMc16
	WBJdkxktkz5qhpg+nlXvAfjhqjENl9B/28/rRwdMiMOfBVqAXXPz75zEvxyg5dCAo1h7Uv9h+Z+
	5J3nruHONrCqdpbb6arLx4cpAH12vkkzR8Bn9MHi7CxOLRDiN9uZbQpZ0OdjRvv/+O7o94VfWnS
	gtd1rDm3lZZnuuZmCMz7Ki/s3MSQkJI7+aYQqJg8q4wbbNHSB8b71qvNjYRZetBoAnkS/Z53w8F
	cSXidTsrGTdYfWfPoOZRrghcx3sufHKkVCTaKecMHfi6+ESKjwwTN4OCzMua55nN5Ok=
X-Received: by 2002:a05:6102:4422:b0:7c3:7286:c291 with SMTP id ada2fe7eead31-7d072c3e082mr9102878137.19.1793873322189;
        Thu, 05 Nov 2026 02:08:42 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af4fcsm3869400241.2.2026.11.05.02.08.36
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:08:38 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1046502137.0
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:08:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxNG5RVL/SuKvP3CTmc5YPUBKVOUsPW7GtSA1DCPqfxAxXf1bz2UMC7NTMov0QmbRvbkLQDru3TPg==@vger.kernel.org
X-Received: by 2002:a05:6102:5494:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7d072bb3829mr8787869137.11.1793873316184; Thu, 05 Nov 2026
 02:08:36 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org> <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
In-Reply-To: <20261104-work-procfs-core-v2-16-76ace653a773@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 11:08:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
X-Gm-Features: AclHuK_D2R6ZzQFy7DOLUQHC3VotRoglnOuhbtIFU-Oniz4UMRG_6kQUnblEqeo
Message-ID: <CAMuHMdXAk9CwoXpak8+EQjdvJ2Ab9fo1bvj_D5GqBzXB7urEUQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 16/23] proc: let procfs copy out reads that
 don't go through seq_file
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

On Wed, 4 Nov 2026 at 20:33, Christian Brauner <brauner@kernel.org> wrote:
> proc_reg_read() and proc_reg_read_iter() pin the entry and call
> ->proc_read() or ->proc_read_iter() which copy to userspace
> themselves. Like for seq_file reads and for writes, a reader can make
> a page fault in that copy take as long as it wants and
> remove_proc_entry() waits for it.
>
> So do what kernfs does for these reads as well. An entry that implements
> ->proc_read_buf() fills a kernel buffer of at most ->proc_read_size
> bytes, a page if the entry doesn't care, and procfs copies it to
> userspace after unpinning the entry. The entry moves the position like
> it did for ->proc_read() but that only sticks if the copy to userspace
> worked, like in kernfs_file_read_iter(). If the copy fails halfway the
> read fails with -EFAULT and the position stays, where
> simple_read_from_buffer() returned what it had copied until then.
> procfs remembers ->proc_read_size in the entry like ->proc_write_size.
>
> Larger reads come up short, like with kernfs. An entry whose readers
> want all of a large file in one read asks for PROC_ENTRY_FULL_READS and
> procfs fills the read in pieces of ->proc_read_size, unpinning the entry
> in between. A piece whose copy fails ends the read with what the pieces
> before it returned. kexec-tools treats any short read of /proc/vmcore
> as fatal for example (cf. [1]).
>
> These entries are read through ->read_iter() so readv(), splice(), aio,
> the RWF flags, kernel_read() and io_uring work for them like for the
> ->proc_read_iter() ones. io_uring's nonblocking attempt gets -EAGAIN
> though, like loop_rw_iter() gave it for ->proc_read() entries. Neither
> the allocation nor the entry can honor IOCB_NOWAIT, and io_uring would
> take a short read of a record file for an unfinished one and glue the
> next record to it. So it retries from a worker like before.
>
> An entry that implements ->proc_read_buf() and also declares a seq_file
> or one of the other read methods fails to register.
>
> No users yet.
>
> [1]: https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Thanks for your patch!

> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h

> @@ -84,6 +91,15 @@ struct proc_ops {
>          */
>         ssize_t (*proc_write_buf)(struct file *, char *, size_t, loff_t *);
>         unsigned int proc_write_size;
> +       /*
> +        * procfs calls ->proc_read_buf() to fill a kernel buffer of at most
> +        * ->proc_read_size bytes, PAGE_SIZE if that's 0, and copies it to
> +        * userspace afterwards. Larger reads come up short unless the entry
> +        * asks for PROC_ENTRY_FULL_READS. The position the entry moves to only
> +        * sticks if the copy works.
> +        */
> +       ssize_t (*proc_read_buf)(struct file *, char *, size_t, loff_t *);

As for proc_write_buf, I think it would be good to use this conversion
as an opportunity to replace "char *" by "void *", which will probably
let you drop several casts from users.

> +       unsigned int proc_read_size;
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
