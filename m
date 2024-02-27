Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E4145FF8
	for <linux-sh@vger.kernel.org>; Tue, 27 Feb 2024 18:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057251; cv=none; b=HqbxKCdywxJUsKGqhfhemue0j6yc4Bah81/L8hBwsM6tJi+dNw0z9H1ifx6z2Zi2zXo9mJlg7WEh0aB4osPwcQvNhkkm7sWx3+Bg1zOu4HtDsEHcktwFOtvvj93i/pK+7ce50varzlaVrqGpiHWLg9le+pT5MBxvYFbjnjtHFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057251; c=relaxed/simple;
	bh=hDsO9qgv2V890oQySpFfqyCZWrqkIn/rAE/+zRviBYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgs3yINWTmNSucRm7dbTkSfdWDXzCQjUlSKs+BQuXofMxm4PzVs1aQmxfQkep5QJpU18rR8qPuONuDlCTDhlIitOpxMjQVWFfCGeSAFKIjHb4nMP+55f3e/M1+ZL+ifBddcNjUR50Z5uf45UizEfjj9ScQIlQAaVHLpBFgFRRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d+iQnuXL; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+iQnuXL"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c7964d109aso174070639f.2
        for <linux-sh@vger.kernel.org>; Tue, 27 Feb 2024 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709057248; x=1709662048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mgrI9FN30eAJ2XZAfY9sJBg3TkLiivRBpbDR17SPpEo=;
        b=d+iQnuXLgKZDLaXx97j3ZKk+HiTOuQlqJBwLJEYO9svRMD4/QqZkaA9oMup/6e+RJ8
         tj+8l3QfTp2EGhMAEuxGkM8V8y4ixD2Msf+7eCEOi9siXYV9WxIwItMnFGqXWwtT4LAx
         VPJFJDLg4jyshNCHJX13Ew+uPZlcUwwIXdT4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709057248; x=1709662048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgrI9FN30eAJ2XZAfY9sJBg3TkLiivRBpbDR17SPpEo=;
        b=vezeXYrTTdhJI7AUDCLHFtkP852u+diQYZCRVvCXULxVYWVgFQkuphlw48HTeOcNe9
         Y1wSFAgpK+7OK/g0NzNRGsAPQYrOSSCeuC8+OMKG2g8V2A+2+Jmkxp5OvQQ6QPENdxdo
         UjBHu4V46auLe2adXofyry/KF6S6xW9tO008PB+mOa9ryHdJYxwe5COU4c5+nGI4bLlG
         ekJH8LnHe0/moWuaRUhawrn31WpT3enQL4IWRhp86neoJ9saNqRy9JeNywVKTTAq5eND
         N+2BbrlmnDTOZVCMTZaFL6wQaisoUvRgK/cJq5W8Re9OURgP+5PgiKAq8DtP3nRSeuQu
         mT0A==
X-Forwarded-Encrypted: i=1; AJvYcCUh9ynKgO+uHTT7NPZNRnsEhE8N9FD4RTJs1Ip4SiVc5PyIPCpo4QI4z9JKaXWvfTafWtOGVg/sitYsfYQZE478Dqsd587tCRI=
X-Gm-Message-State: AOJu0YwEEy+GN9jdX3qnFJ2kD8ctnL8WjMTvMUcrqHo33+yhRrlke33J
	KeiJVA7Ao/lsvj60LCd7TMHyWvbdgAy9h7tKFYAI62yr3+JahE4TbcpJF4B+XQ==
X-Google-Smtp-Source: AGHT+IFpahrVJDe+RkqjDhxBgm48d+nhk6O3nvQnCIgFv/bhnbFyY12knPOFjwYUx9hP01B6x+R36g==
X-Received: by 2002:a05:6e02:522:b0:363:bb5a:3329 with SMTP id h2-20020a056e02052200b00363bb5a3329mr11593022ils.1.1709057247927;
        Tue, 27 Feb 2024 10:07:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fa42-20020a056a002d2a00b006e55b674e66sm10411pfb.171.2024.02.27.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:07:27 -0800 (PST)
Date: Tue, 27 Feb 2024 10:07:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Message-ID: <202402271004.7145FDB53F@keescook>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
 <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
 <94a2b919-e03b-4ade-b13e-7774849dc02b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a2b919-e03b-4ade-b13e-7774849dc02b@csgroup.eu>

On Tue, Feb 27, 2024 at 07:02:59AM +0000, Christophe Leroy wrote:
> 
> 
> Le 26/02/2024 à 20:09, Rick Edgecombe a écrit :
> > Future changes will need to add a field to struct vm_unmapped_area_info.
> > This would cause trouble for any archs that don't initialize the
> > struct. Currently every user sets each field, so if new fields are
> > added, the core code parsing the struct will see garbage in the new
> > field.
> > 
> > It could be possible to initialize the new field for each arch to 0, but
> > instead simply inialize the field with a C99 struct inializing syntax.
> 
> Why doing a full init of the struct when all fields are re-written a few 
> lines after ?

It's a nice change for robustness and makes future changes easier. It's
not actually wasteful since the compiler will throw away all redundant
stores.

> If I take the exemple of powerpc function slice_find_area_bottomup():
> 
> 	struct vm_unmapped_area_info info;
> 
> 	info.flags = 0;
> 	info.length = len;
> 	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
> 	info.align_offset = 0;

But one cleanup that is possible from explicitly zero-initializing the
whole structure would be dropping all the individual "= 0" assignments.
:)

-- 
Kees Cook
