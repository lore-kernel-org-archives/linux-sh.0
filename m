Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFF24022B
	for <linux-sh@vger.kernel.org>; Mon, 13 Jan 2025 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782320; cv=none; b=e+vrWVMf18duuLsh+HZYs5rg4t0pV49SAP3NG3PYFl4fdgOq4d+JE8jsgowq8rrNPiyalfOsTLHpqHOm1ehbPi+yOEaki2CxQ88Kjk+MYUwSAxfNN0+Jx/D0uGJ1Pw5LRCFXdWJuqRW8+FbFR82bQw1Ypygx0yxPg3dWCzqAWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782320; c=relaxed/simple;
	bh=mvpUKblQy8XIPdlWHCLH8X7FWaiWEVy9c2RgcGTYsnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lM7UKgtUiuCrjV68P4q4jMB45we3wi66RE7kjj8+Y6XARiPZYrxLqIk2l9jo2n8RxZh2zIFzTpqGQZ9R5I+aBUnpWG1h+V3N+t4TKdoc1E1Q6E+RZuCJEhvU8XkNOeKEzX3SRTSpKP2PZFeWq2YZnHNVhd5Ye2b7ocTQuW0LScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVtRCE42; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVtRCE42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736782316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SZj62Px2ZKn8iOzamvEwo+3QljL+SdLMxOZ/y0XMPLY=;
	b=LVtRCE42cYTXtul0GJf5msuYGuay5DSwXJp5Rz8KQn5Umj2AKdWt5OnDcmB2WlrSnLIf1p
	u6sQgmgZclG42XmMzyOcaCME+5V0Cpksi74rJtXfyv4HrjEBYKxlT4bIBrXen+kAUYiH/k
	SI6MSYfmXBXirqd2oaqw3wCoAPWkW14=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-9C8SfsWEOeWUhEjMHX3xbA-1; Mon, 13 Jan 2025 10:31:55 -0500
X-MC-Unique: 9C8SfsWEOeWUhEjMHX3xbA-1
X-Mimecast-MFC-AGG-ID: 9C8SfsWEOeWUhEjMHX3xbA
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aaf5ca740aeso384370166b.2
        for <linux-sh@vger.kernel.org>; Mon, 13 Jan 2025 07:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782314; x=1737387114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZj62Px2ZKn8iOzamvEwo+3QljL+SdLMxOZ/y0XMPLY=;
        b=ab3pp23sa3yJw1cSqYPOFmR+vQ+9VXnSAfWqsZMYVzsf134xmqQKGEWesLQc3pkTIa
         FX+stG9LmC1THiBARczXPkuD6pVZU/ZO5xtrTmARpBK3qeqoOVlPzMP1ECGjpilqTh6Q
         R97AEIU562gxCbogPHyKCslp2OxSAU2U6LFP6NjDO+Ivoi9vlEJUvL0yxvdQ3ofPuO8j
         5DaRxnozxeII5PIsPrauT2VWOehMY5cmMd7U8nZ4Uxkm5xSyy4F1srq5rzCaQvhXd5g3
         U0L0ENyz3nJMXr8RUIa4Mf+TyvuPyOYay1/U874o1zl+jxBYANRkvF6uTw+FgoSXM2aQ
         TGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdUzbTubKzEIb12QrHHnHyzTNu4vETnXZ3ubFzbjg/7oIiEdlOGQ3OnVVuKnDU+jYECkxft46z5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzG575M4QYsbDdBlbcT+iJjGFluehn8z8MEcH7mQLDZmpMkWExl
	m8C3xKIK5Unj3hyt37CqmG6G7ubnH9pYYLVbJUJvcvDGYRDbk2VLCG54Gz1PQ9uNph29oEDwlzX
	mJCjwX9bzyHHgyN9VKyph6bl69WQIfxVsA/1CDiXtbjhbGMMUkAtKIqw=
X-Gm-Gg: ASbGncvoNL5nb/k2tHgR5BWZDKKC6eMdfL34MZG/OS18rm7L5ZMJur6swvrUHk1FIyi
	UubK66TzeifPqARi049/H7HqkSkqnqyAzzvBi4oNXuzKWOvBWeHPnR/VKXHjHCl3qcr0D7UL2Xq
	tIwZDmtmG0IyMhfx5KAR/8+OKbVn8ZSRUORYkE1WdO9869jfKJ3BZhoxm+45p+NFQ1gm58iD5ki
	IW6rCgBOk07CxNJe++03evfbkPAcCviuc+/UMymBCAmJVUPjGEcZOpCC6hGpcvhqyGy10SeQ+3O
X-Received: by 2002:a17:907:6d0e:b0:aaf:5c9:19f9 with SMTP id a640c23a62f3a-ab2ab6f3455mr1962696366b.27.1736782313764;
        Mon, 13 Jan 2025 07:31:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN9M8ywOrQBK6gF/5ntK43MmcNBbwRSFgySYURvnN/eomPTMHRMQ8vdhj//eDu8N4Cy9JGfg==
X-Received: by 2002:a17:907:6d0e:b0:aaf:5c9:19f9 with SMTP id a640c23a62f3a-ab2ab6f3455mr1962689566b.27.1736782313218;
        Mon, 13 Jan 2025 07:31:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9060b9dsm516473166b.4.2025.01.13.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:31:52 -0800 (PST)
Date: Mon, 13 Jan 2025 16:31:50 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	monstr@monstr.eu, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, arnd@arndb.de, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <cwz2kun2mm55um3hycrd4mkxrgm43zorty5kdxacksmseo34n3@dc3bd4x6cibd>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <doha6zamxgmqapwx4r6ehzbatzar4dcep33zehunonqforjzf5@lxpidn37tdjh>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <doha6zamxgmqapwx4r6ehzbatzar4dcep33zehunonqforjzf5@lxpidn37tdjh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7j7DCYnoSlM9yFDVfWS-PJEPUeY5ysep5PcBPBVvz0A_1736782314
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2025-01-13 12:19:36, Jan Kara wrote:
> On Thu 09-01-25 18:45:40, Andrey Albershteyn wrote:
> > From: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > Introduce getfsxattrat and setfsxattrat syscalls to manipulate inode
> > extended attributes/flags. The syscalls take parent directory FD and
> > path to the child together with struct fsxattr.
> > 
> > This is an alternative to FS_IOC_FSSETXATTR ioctl with a difference
> > that file don't need to be open. By having this we can manipulated
> > inode extended attributes not only on normal files but also on
> > special ones. This is not possible with FS_IOC_FSSETXATTR ioctl as
> > opening special files returns VFS special inode instead of
> > underlying filesystem one.
> > 
> > This patch adds two new syscalls which allows userspace to set
> > extended inode attributes on special files by using parent directory
> > to open FS inode.
> > 
> > Also, as vfs_fileattr_set() is now will be called on special files
> > too, let's forbid any other attributes except projid and nextents
> > (symlink can have an extent).
> > 
> > CC: linux-api@vger.kernel.org
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Couple of comments below:
> 
> > @@ -2953,3 +2956,105 @@ umode_t mode_strip_sgid(struct mnt_idmap *idmap,
> >  	return mode & ~S_ISGID;
> >  }
> >  EXPORT_SYMBOL(mode_strip_sgid);
> > +
> > +SYSCALL_DEFINE4(getfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr *, fsx, int, at_flags)
> 				       ^^^ at_flags should be probably
> unsigned - at least they seem to be for other syscalls.

sure

> 
> > +{
> > +	struct fd dir;
> > +	struct fileattr fa;
> > +	struct path filepath;
> > +	struct inode *inode;
> > +	int error;
> > +
> > +	if (at_flags)
> > +		return -EINVAL;
> 
> Shouldn't we support basic path resolve flags like AT_SYMLINK_NOFOLLOW or
> AT_EMPTY_PATH? I didn't put too much thought to this but intuitively I'd say
> we should follow what path_setxattrat() does.

Hmm, yeah, you are right these two can be passed. I thought about
setting AT_SYMLINK_NOFOLLOW by default (which is also missing here),
but adding allowing passing these seems to be fine.

> 
> > +
> > +	if (!capable(CAP_FOWNER))
> > +		return -EPERM;
> 
> Why? Firstly this does not handle user namespaces at all, secondly it
> doesn't match the check done during ioctl, and thirdly vfs_fileattr_get()
> should do all the needed checks?

Sorry, miss-understood how this works, I will remove this from both
get/set. get*() doesn't need it and set*() checks capabilities in
vfs_fileattr_set(). Thanks!

> 
> > +
> > +	dir = fdget(dfd);
> > +	if (!fd_file(dir))
> > +		return -EBADF;
> > +
> > +	if (!S_ISDIR(file_inode(fd_file(dir))->i_mode)) {
> > +		error = -EBADF;
> > +		goto out;
> > +	}
> > +
> > +	error = user_path_at(dfd, filename, at_flags, &filepath);
> > +	if (error)
> > +		goto out;
> 
> I guess this is OK for now but allowing full flexibility of the "_at"
> syscall (e.g. like setxattrat() does) would be preferred. Mostly so that
> userspace programmer doesn't have to read manpage in detail and think
> whether the particular combination of path arguments is supported by a
> particular syscall. Admittedly VFS could make this a bit simpler. Currently
> the boilerplate code that's needed in path_setxattrat() &
> filename_setxattr() / file_setxattr() is offputting.
> 
> > +
> > +	inode = filepath.dentry->d_inode;
> > +	if (file_inode(fd_file(dir))->i_sb->s_magic != inode->i_sb->s_magic) {
> > +		error = -EBADF;
> > +		goto out_path;
> > +	}
> 
> What's the motivation for this check?

This was one of the comments on the ioctl() patch, that it doesn't
make much sense to allow ioctl() to be called over different
filesystems. But for syscall this is probably make less sense to
restrict it like that. I will drop it.

> 
> > +
> > +	error = vfs_fileattr_get(filepath.dentry, &fa);
> > +	if (error)
> > +		goto out_path;
> > +
> > +	if (copy_fsxattr_to_user(&fa, fsx))
> > +		error = -EFAULT;
> > +
> > +out_path:
> > +	path_put(&filepath);
> > +out:
> > +	fdput(dir);
> > +	return error;
> > +}
> > +
> > +SYSCALL_DEFINE4(setfsxattrat, int, dfd, const char __user *, filename,
> > +		struct fsxattr *, fsx, int, at_flags)
> > +{
> 
> Same comments as for getfsxattrat() apply here as well.
> 
> > -static int copy_fsxattr_from_user(struct fileattr *fa,
> > -				  struct fsxattr __user *ufa)
> > +int copy_fsxattr_from_user(struct fileattr *fa, struct fsxattr __user *ufa)
> >  {
> >  	struct fsxattr xfa;
> >  
> > @@ -574,6 +573,7 @@ static int copy_fsxattr_from_user(struct fileattr *fa,
> >  
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL(copy_fsxattr_from_user);
> 
> I guess no need to export this function? The code you call it from cannot
> be compiled as a module.

Yes, that's true, I added this because copy_fsxattr_to_user() also
is exported (same as many other functions). I will drop this.

-- 
- Andrey

