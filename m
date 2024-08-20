Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B281C6889
	for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189822; cv=none; b=LvHqmC4orytGGZjhAmWkGosuPSTFeLP7QujlspCtBTc62uDYFwOx+/iliQaF1BMEVI0cH0ibAXsqvfS7F0SItghulONv0UAcWeRRmFNYKFAnRD7KP2zGZsNPkH304dwpE/3P6FE+PbNaYnCfpTNIuloY7ZmOrBUOiimclb7FE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189822; c=relaxed/simple;
	bh=zPen0ZDsMIGVeT7oJMVDG1CPWwqKsFrBf0fJYTWFLXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXP6NnrXjsmWIRRvcojoZ3K85IntR6bBbm6efIYZP1hUP24TUxUOtqZrUpRa4rqj00DffvPphQGT6696Kai60OpSLAKUEInp5WYrNGppuVZur8YAoOa62Hrc364/KXKOzZqZnne/36xtShc4aEEZudXZ3We9iSHqRkxDBilgb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aVGai5HE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aVGai5HE"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so5366104a12.2
        for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724189819; x=1724794619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=aVGai5HEV7c2WQ+SHCNmUqsAzybuc1+W/fualmZghGRpnVQpbr8/Ac56bAYHyVKYKq
         iHfoEtiJjSeNRduRZPz/2/FUfnG9z2jzpTswfxEyhkDzM+s/Fz0EN1Vb2/o/UksRtMbH
         e59zXJYlRjXofX9KlcSUo1iy7Qx26ES+vh/MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189819; x=1724794619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=Ibb114/zn7Mt/hikSGCS7Y7Hkf8GZOTuma4jXM/dnYTDv4uBbClJukbgUdfZ7QhPCt
         Aa5QVBjYsqAMmek/NALcgJI9cwDCRFxmwTklf/V/+HItY65YQQzqyajMQI6S4KdgramL
         zOK86xH7hvRYI1C5F8w7X0J+8F8+qFZ6ib3qokQqlFz6KbUkZFbZm/49nQtE9tivht3s
         D/S5T5tGi83AtGlzjaYOGp3fGUj2COFwXb1B+mND5fBaevbTRkHm+yvWcD2Ik4khtmHc
         hiHal8uhU/cT8l8XOCgQosmYoMOodY9a32eSdfsxmW0hUcPD70v4yHBg3dPo+o4w4Aya
         HNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSHf9ixPLo8wxjFzAzi6Y0Crh2FowArGQtMHmd6xhEJfFLuc0wEYR7QM9wf8I881JRbrSsxhKVmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1fMSRA4mfOw5WLh6GF/aDXrxGnfxryQR4/07pyhqHOmWyRyPi
	zbdTvZydZ8jhaTLNenxlwvJaIE4KB+vx+vc0OXv28EA62BN731/NmzPRXo3FUKQj/y+aAKK1w7F
	DsRNGNA==
X-Google-Smtp-Source: AGHT+IGXI4ySD+SkgGTbdY+pIWs/qtizPwb2wbD/oH//2aThKs24LXKAcoW9RBjGykSN2L8k34xUzg==
X-Received: by 2002:a17:907:7dab:b0:a7a:929f:c0ce with SMTP id a640c23a62f3a-a866f29a0f1mr25297966b.19.1724189818711;
        Tue, 20 Aug 2024 14:36:58 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394669esm821679066b.143.2024.08.20.14.36.58
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:36:58 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so4554911a12.3
        for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 14:36:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuY9SLy+5t9jxNImcAP/TDTqELC+ZffbA5UKjXUT8sUvfBnikniJENiW0FaEAxdqYgSiPP1n2ihA==@vger.kernel.org
X-Received: by 2002:a05:6402:354d:b0:5bf:b29:6eb4 with SMTP id
 4fb4d7f45d1cf-5bf1f164130mr60685a12.21.1724189483542; Tue, 20 Aug 2024
 14:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse> <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
In-Reply-To: <dff57198-7955-ec09-8909-671982834673@landley.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 14:31:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Rob Landley <rob@landley.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>
> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
> somewhere to at least smoketest...)

The '&&' is just a typo. It should obviously be just a single '&'. As
mentioned, the only testing that patch got was a x86-64 UML build
test.

Fixed locally.

               Linus
